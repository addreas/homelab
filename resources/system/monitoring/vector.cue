package kube

import (
	"strings"
	"crypto/md5"
	"encoding/hex"
	"encoding/yaml"
)

let _cue_agent_yaml = {
	data_dir: "/vector-data-dir"
	sources: {
		kubernetes_logs: type: "kubernetes_logs"
		haproxy_logs: {
			type:    "syslog"
			address: "0.0.0.0:9514"
			mode:    "udp"
		}
		journald_logs: {
			type:            "journald"
			journalctl_path: "/host/run/current-system/sw/bin/journalctl"
		}
		host_metrics: {
			filesystem: {
				devices: excludes: ["binfmt_misc"]
				filesystems: excludes: [
					"binfmt_misc",
					"bpf",
					"cgroup2",
					"configfs",
					"debugfs",
					"fusectl",
					"nsfs",
					"proc",
					"ramfs",
					"securityfs",
					"tmpfs",
				]
				mountPoints: excludes: ["*/proc/sys/fs/binfmt_misc"]
			}
			type: "host_metrics"
		}
		// kube_controller_manager_metrics: {
		// 	type: "prometheus_scrape"
		// 	endpoints: ["https://127.0.0.1:10257/metrics"]
		// 	instance_tag: "instance"
		// 	auth: strategy: "bearer"
		// 	auth: token:    "/var/run/secrets/kubernetes.io/serviceaccount/token"
		// 	tls: ca_file:   "/var/run/secrets/kubernetes.io/serviceaccount/ca.crt"
		// }
		// kube_scheduler_metrics: {
		// 	type: "prometheus_scrape"
		// 	endpoints: ["https://127.0.0.1:10259/metrics"]
		// 	instance_tag: "instance"
		// 	auth: strategy: "bearer"
		// 	auth: token:    "/var/run/secrets/kubernetes.io/serviceaccount/token"
		// 	tls: ca_file:   "/var/run/secrets/kubernetes.io/serviceaccount/ca.crt"
		// }
		internal_metrics: type: "internal_metrics"
	}
	transforms: {
		haproxy_logs_parsed: {
			inputs: ["haproxy_logs"]
			type:   "remap"
			source: ".message = parse_json!(.message) ?? .message"
		}
	}
	sinks: {
		prom_exporter: {
			type: "prometheus_exporter"
			inputs: [ for key, _ in sources if strings.HasSuffix(key, "_metrics") {key}]
			address: "0.0.0.0:9090"
		}

		let loki = {
			type: "loki"
			encoding: codec: _ | *"raw_message"
			endpoint:            "http://loki.monitoring.svc.cluster.local:3100"
			out_of_order_action: "drop"
		}
		loki_kubernetes: loki & {
			inputs: ["kubernetes_logs"]
			labels: {
				job:       "vector/kubernetes"
				filename:  "{{ file }}"
				stream:    "{{ stream }}"
				pod:       "{{ kubernetes.pod_name }}"
				container: "{{ kubernetes.container_name }}"
				namespace: "{{ kubernetes.pod_namespace }}"
			}
		}
		loki_haproxy: loki & {
			inputs: ["haproxy_logs_parsed"]
			encoding: codec: "json"
			labels: {
				job: "vector/haproxy"
			}
		}
		loki_journald: loki & {
			inputs: ["journald_logs"]
			labels: {
				job:               "vector/journald"
				host:              "{{ host }}"
				boot_id:           "{{ _BOOT_ID }}"
				systemd_unit:      "{{ _SYSTEMD_UNIT }}"
				stream:            "{{ _TRANSPORT }}"
				exe:               "{{ _EXE }}"
				syslog_identifier: "{{ SYSLOG_IDENTIFIER }}"
			}
		}
	}
}

let vectorLabels = {
	"app.kubernetes.io/component": "Agent"
	"app.kubernetes.io/instance":  "vector"
	"app.kubernetes.io/name":      "vector"
}

k: ServiceAccount: vector: {
	automountServiceAccountToken: true
	metadata: labels: vectorLabels
}
k: ClusterRole: vector: {
	metadata: labels: vectorLabels
	rules: [{
		apiGroups: [""]
		resources: [
			"namespaces",
			"nodes",
			"pods",
		]
		verbs: ["get", "list", "watch"]
	}]
}
k: ClusterRoleBinding: vector: {
	metadata: labels: vectorLabels
	roleRef: {
		apiGroup: "rbac.authorization.k8s.io"
		kind:     "ClusterRole"
		name:     "vector"
	}
	subjects: [{
		kind:      "ServiceAccount"
		name:      "vector"
		namespace: k.ServiceAccount.vector.metadata.namespace
	}]
}

k: ConfigMap: vector: {
	data: "agent.yaml": yaml.Marshal(_cue_agent_yaml)
	metadata: labels:   vectorLabels
}

k: PodMonitor: vector: spec: {
	selector: matchLabels: vectorLabels
	podMetricsEndpoints: [{
		port: "prom-exporter"
		relabelings: [{
			action: "replace"
			sourceLabels: ["__meta_kubernetes_pod_node_name"]
			targetLabel: "node"
		}]
		metricRelabelings: [{
			action: "labeldrop"
			regex:  "host"
		}]
	}]
}

k: Service: vector: spec: {
	selector: vectorLabels
}

k: DaemonSet: vector: {
	metadata: labels: vectorLabels
	spec: {
		selector: matchLabels: vectorLabels
		template: {
			metadata: labels: vectorLabels & {
				"vector.dev/exclude": "true"
				"config-hash":        hex.Encode(md5.Sum(k.ConfigMap.vector.data["agent.yaml"]))
			}
			spec: {
				securityContext: fsGroup: 0
				dnsPolicy:                     "ClusterFirst"
				serviceAccountName:            "vector"
				terminationGracePeriodSeconds: 60
				containers: [{
					args: [
						"--config-dir",
						"/etc/vector/",
					]
					env: [{
						name: "VECTOR_SELF_NODE_NAME"
						valueFrom: fieldRef: fieldPath: "spec.nodeName"
					}, {
						name: "VECTOR_SELF_POD_NAME"
						valueFrom: fieldRef: fieldPath: "metadata.name"
					}, {
						name: "VECTOR_SELF_POD_NAMESPACE"
						valueFrom: fieldRef: fieldPath: "metadata.namespace"
					}, {
						name:  "PROCFS_ROOT"
						value: "/host/proc"
					}, {
						name:  "SYSFS_ROOT"
						value: "/host/sys"
					}]
					image: "timberio/vector:0.29.1-distroless-libc"
					ports: [{
						containerPort: 9090
						name:          "prom-exporter"
					}, {
						containerPort: 9514
						name:          "haproxy-syslog"
						protocol:      "UDP"
					}]
					securityContext: {
						runAsUser:    0
						runAsGroup:   0
						runAsNonRoot: false
					}
					volumeMounts: [{
						mountPath: "/vector-data-dir"
						name:      "data"
					}, {
						mountPath: "/etc/vector/"
						name:      "config"
						readOnly:  true
					}, {
						mountPath: "/var/log/"
						name:      "var-log"
						readOnly:  true
					}, {
						mountPath: "/var/lib"
						name:      "var-lib"
						readOnly:  true
					}, {
						mountPath: "/host/proc"
						name:      "procfs"
						readOnly:  true
					}, {
						mountPath: "/host/sys"
						name:      "sysfs"
						readOnly:  true
					}, {
						mountPath: "/nix"
						name:      "nix"
						readOnly:  true
					}, {
						mountPath: "/host/run"
						name:      "run"
						readOnly:  true
					}, {
						mountPath: "/etc/machine-id"
						name:      "machine-id"
						readOnly:  true
					}]
				}]
				volumes: [{
					name: "config"
					projected: sources: [{
						configMap: name: "vector"
					}]
				}, {
					hostPath: path: "/var/lib/vector"
					name: "data"
				}, {
					hostPath: path: "/var/log/"
					name: "var-log"
				}, {
					hostPath: path: "/var/lib/"
					name: "var-lib"
				}, {
					hostPath: path: "/proc"
					name: "procfs"
				}, {
					hostPath: path: "/sys"
					name: "sysfs"
				}, {
					hostPath: path: "/nix"
					name: "nix"
				}, {
					hostPath: path: "/run"
					name: "run"
				}, {
					hostPath: path: "/etc/machine-id"
					name: "machine-id"
				}]
			}
		}
	}
}
