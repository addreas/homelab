package kube

import (
	"crypto/md5"
	"encoding/hex"
	"encoding/yaml"
)

let _cue_agent_yaml = {
	data_dir: "/vector-data-dir"
	sources: {
		kubernetes_logs: type: "kubernetes_logs"
		journald_logs: {
			type:            "journald"
			journalctl_path: "/host/run/current-system/sw/bin/journalctl"
		}
		host_metrics: {
			filesystem: {
				devices: excludes: ["binfmt_misc"]
				filesystems: excludes: ["binfmt_misc"]
				mountPoints: excludes: ["*/proc/sys/fs/binfmt_misc"]
			}
			type: "host_metrics"
		}
		internal_metrics: type: "internal_metrics"
	}
	sinks: {
		prom_exporter: {
			type: "prometheus_exporter"
			inputs: ["host_metrics", "internal_metrics"]
			address: "0.0.0.0:9090"
		}
		loki_kubernetes: {
			type: "loki"
			inputs: ["kubernetes_logs"]
			encoding: codec: "raw_message"
			endpoint:            "http://loki.monitoring.svc.cluster.local:3100"
			out_of_order_action: "drop"
			remove_label_fields: true
			labels: {
				job:       "vector/kubernetes"
				filename:  "{{ file }}"
				stream:    "{{ stream }}"
				pod:       "{{ kubernetes.pod_name }}"
				container: "{{ kubernetes.container_name }}"
				namespace: "{{ kubernetes.pod_namespace }}"
			}
		}
		loki_journald: {
			type: "loki"
			inputs: ["journald_logs"]
			encoding: codec: "json"
			endpoint:            "http://loki.monitoring.svc.cluster.local:3100"
			out_of_order_action: "drop"
			labels: {
				job:  "vector/journald"
				host: "{{ host }}"
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
	}]
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
				}]
			}
		}
	}
}
