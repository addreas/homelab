package manifests

nodeExporter: {
	ClusterRole: "node-exporter": {
		apiVersion: "rbac.authorization.k8s.io/v1"
		kind:       "ClusterRole"
		metadata: {
			labels: {
				"app.kubernetes.io/component": "exporter"
				"app.kubernetes.io/name":      "node-exporter"
				"app.kubernetes.io/part-of":   "kube-prometheus"
				"app.kubernetes.io/version":   "1.3.1"
			}
			name:      "node-exporter"
			namespace: "monitoring"
		}
		rules: [{
			apiGroups: ["authentication.k8s.io"]
			resources: ["tokenreviews"]
			verbs: ["create"]
		}, {
			apiGroups: ["authorization.k8s.io"]
			resources: ["subjectaccessreviews"]
			verbs: ["create"]
		}]
	}
	ClusterRoleBinding: "node-exporter": {
		apiVersion: "rbac.authorization.k8s.io/v1"
		kind:       "ClusterRoleBinding"
		metadata: {
			labels: {
				"app.kubernetes.io/component": "exporter"
				"app.kubernetes.io/name":      "node-exporter"
				"app.kubernetes.io/part-of":   "kube-prometheus"
				"app.kubernetes.io/version":   "1.3.1"
			}
			name:      "node-exporter"
			namespace: "monitoring"
		}
		roleRef: {
			apiGroup: "rbac.authorization.k8s.io"
			kind:     "ClusterRole"
			name:     "node-exporter"
		}
		subjects: [{
			kind:      "ServiceAccount"
			name:      "node-exporter"
			namespace: "monitoring"
		}]
	}
	DaemonSet: "node-exporter": {
		apiVersion: "apps/v1"
		kind:       "DaemonSet"
		metadata: {
			labels: {
				"app.kubernetes.io/component": "exporter"
				"app.kubernetes.io/name":      "node-exporter"
				"app.kubernetes.io/part-of":   "kube-prometheus"
				"app.kubernetes.io/version":   "1.3.1"
			}
			name:      "node-exporter"
			namespace: "monitoring"
		}
		spec: {
			selector: matchLabels: {
				"app.kubernetes.io/component": "exporter"
				"app.kubernetes.io/name":      "node-exporter"
				"app.kubernetes.io/part-of":   "kube-prometheus"
			}
			template: {
				metadata: {
					annotations: "kubectl.kubernetes.io/default-container": "node-exporter"
					labels: {
						"app.kubernetes.io/component": "exporter"
						"app.kubernetes.io/name":      "node-exporter"
						"app.kubernetes.io/part-of":   "kube-prometheus"
						"app.kubernetes.io/version":   "1.3.1"
					}
				}
				spec: {
					automountServiceAccountToken: true
					containers: [{
						args: ["--web.listen-address=127.0.0.1:9100", "--path.sysfs=/host/sys", "--path.rootfs=/host/root", "--no-collector.wifi", "--no-collector.hwmon", "--collector.filesystem.mount-points-exclude=^/(dev|proc|sys|run/k3s/containerd/.+|var/lib/docker/.+|var/lib/kubelet/pods/.+)($|/)", "--collector.netclass.ignored-devices=^(veth.*|[a-f0-9]{15})$", "--collector.netdev.device-exclude=^(veth.*|[a-f0-9]{15})$"]
						image: "quay.io/prometheus/node-exporter:v1.3.1"
						name:  "node-exporter"
						resources: {
							limits: {
								cpu:    "250m"
								memory: "180Mi"
							}
							requests: {
								cpu:    "102m"
								memory: "180Mi"
							}
						}
						securityContext: {
							allowPrivilegeEscalation: false
							capabilities: {
								add: ["CAP_SYS_TIME"]
								drop: ["ALL"]
							}
							readOnlyRootFilesystem: true
						}
						volumeMounts: [{
							mountPath:        "/host/sys"
							mountPropagation: "HostToContainer"
							name:             "sys"
							readOnly:         true
						}, {
							mountPath:        "/host/root"
							mountPropagation: "HostToContainer"
							name:             "root"
							readOnly:         true
						}]
					}, {
						args: ["--logtostderr", "--secure-listen-address=[$(IP)]:9100", "--tls-cipher-suites=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256,TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256,TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384,TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384,TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305,TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305", "--upstream=http://127.0.0.1:9100/"]
						env: [{
							name: "IP"
							valueFrom: fieldRef: fieldPath: "status.podIP"
						}]
						image: "quay.io/brancz/kube-rbac-proxy:v0.11.0"
						name:  "kube-rbac-proxy"
						ports: [{
							containerPort: 9100
							hostPort:      9100
							name:          "https"
						}]
						resources: {
							limits: {
								cpu:    "20m"
								memory: "40Mi"
							}
							requests: {
								cpu:    "10m"
								memory: "20Mi"
							}
						}
						securityContext: {
							allowPrivilegeEscalation: false
							capabilities: drop: ["ALL"]
							readOnlyRootFilesystem: true
							runAsGroup:             65532
							runAsNonRoot:           true
							runAsUser:              65532
						}
					}]
					hostNetwork: true
					hostPID:     true
					nodeSelector: "kubernetes.io/os": "linux"
					securityContext: {
						runAsNonRoot: true
						runAsUser:    65534
					}
					serviceAccountName: "node-exporter"
					tolerations: [{
						operator: "Exists"
					}]
					volumes: [{
						hostPath: path: "/sys"
						name: "sys"
					}, {
						hostPath: path: "/"
						name: "root"
					}]
				}
			}
			updateStrategy: {
				rollingUpdate: maxUnavailable: "10%"
				type: "RollingUpdate"
			}
		}
	}
	PrometheusRule: "node-exporter-rules": {
		apiVersion: "monitoring.coreos.com/v1"
		kind:       "PrometheusRule"
		metadata: {
			labels: {
				"app.kubernetes.io/component": "exporter"
				"app.kubernetes.io/name":      "node-exporter"
				"app.kubernetes.io/part-of":   "kube-prometheus"
				"app.kubernetes.io/version":   "1.3.1"
				prometheus:                    "k8s"
				role:                          "alert-rules"
			}
			name:      "node-exporter-rules"
			namespace: "monitoring"
		}
		spec: groups: [{
			name: "node-exporter"
			rules: [{
				alert: "NodeFilesystemSpaceFillingUp"
				annotations: {
					description: "Filesystem on {{ $labels.device }} at {{ $labels.instance }} has only {{ printf \"%.2f\" $value }}% available space left and is filling up."
					runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/node/nodefilesystemspacefillingup"
					summary:     "Filesystem is predicted to run out of space within the next 24 hours."
				}
				expr: """
					(
					  node_filesystem_avail_bytes{job="node-exporter",fstype!=""} / node_filesystem_size_bytes{job="node-exporter",fstype!=""} * 100 < 20
					and
					  predict_linear(node_filesystem_avail_bytes{job="node-exporter",fstype!=""}[6h], 24*60*60) < 0
					and
					  node_filesystem_readonly{job="node-exporter",fstype!=""} == 0
					)

					"""
				for: "1h"
				labels: severity: "warning"
			}, {
				alert: "NodeFilesystemSpaceFillingUp"
				annotations: {
					description: "Filesystem on {{ $labels.device }} at {{ $labels.instance }} has only {{ printf \"%.2f\" $value }}% available space left and is filling up fast."
					runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/node/nodefilesystemspacefillingup"
					summary:     "Filesystem is predicted to run out of space within the next 4 hours."
				}
				expr: """
					(
					  node_filesystem_avail_bytes{job="node-exporter",fstype!=""} / node_filesystem_size_bytes{job="node-exporter",fstype!=""} * 100 < 15
					and
					  predict_linear(node_filesystem_avail_bytes{job="node-exporter",fstype!=""}[6h], 4*60*60) < 0
					and
					  node_filesystem_readonly{job="node-exporter",fstype!=""} == 0
					)

					"""
				for: "1h"
				labels: severity: "critical"
			}, {
				alert: "NodeFilesystemAlmostOutOfSpace"
				annotations: {
					description: "Filesystem on {{ $labels.device }} at {{ $labels.instance }} has only {{ printf \"%.2f\" $value }}% available space left."
					runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/node/nodefilesystemalmostoutofspace"
					summary:     "Filesystem has less than 5% space left."
				}
				expr: """
					(
					  node_filesystem_avail_bytes{job="node-exporter",fstype!=""} / node_filesystem_size_bytes{job="node-exporter",fstype!=""} * 100 < 5
					and
					  node_filesystem_readonly{job="node-exporter",fstype!=""} == 0
					)

					"""
				for: "30m"
				labels: severity: "warning"
			}, {
				alert: "NodeFilesystemAlmostOutOfSpace"
				annotations: {
					description: "Filesystem on {{ $labels.device }} at {{ $labels.instance }} has only {{ printf \"%.2f\" $value }}% available space left."
					runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/node/nodefilesystemalmostoutofspace"
					summary:     "Filesystem has less than 3% space left."
				}
				expr: """
					(
					  node_filesystem_avail_bytes{job="node-exporter",fstype!=""} / node_filesystem_size_bytes{job="node-exporter",fstype!=""} * 100 < 3
					and
					  node_filesystem_readonly{job="node-exporter",fstype!=""} == 0
					)

					"""
				for: "30m"
				labels: severity: "critical"
			}, {
				alert: "NodeFilesystemFilesFillingUp"
				annotations: {
					description: "Filesystem on {{ $labels.device }} at {{ $labels.instance }} has only {{ printf \"%.2f\" $value }}% available inodes left and is filling up."
					runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/node/nodefilesystemfilesfillingup"
					summary:     "Filesystem is predicted to run out of inodes within the next 24 hours."
				}
				expr: """
					(
					  node_filesystem_files_free{job="node-exporter",fstype!=""} / node_filesystem_files{job="node-exporter",fstype!=""} * 100 < 40
					and
					  predict_linear(node_filesystem_files_free{job="node-exporter",fstype!=""}[6h], 24*60*60) < 0
					and
					  node_filesystem_readonly{job="node-exporter",fstype!=""} == 0
					)

					"""
				for: "1h"
				labels: severity: "warning"
			}, {
				alert: "NodeFilesystemFilesFillingUp"
				annotations: {
					description: "Filesystem on {{ $labels.device }} at {{ $labels.instance }} has only {{ printf \"%.2f\" $value }}% available inodes left and is filling up fast."
					runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/node/nodefilesystemfilesfillingup"
					summary:     "Filesystem is predicted to run out of inodes within the next 4 hours."
				}
				expr: """
					(
					  node_filesystem_files_free{job="node-exporter",fstype!=""} / node_filesystem_files{job="node-exporter",fstype!=""} * 100 < 20
					and
					  predict_linear(node_filesystem_files_free{job="node-exporter",fstype!=""}[6h], 4*60*60) < 0
					and
					  node_filesystem_readonly{job="node-exporter",fstype!=""} == 0
					)

					"""
				for: "1h"
				labels: severity: "critical"
			}, {
				alert: "NodeFilesystemAlmostOutOfFiles"
				annotations: {
					description: "Filesystem on {{ $labels.device }} at {{ $labels.instance }} has only {{ printf \"%.2f\" $value }}% available inodes left."
					runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/node/nodefilesystemalmostoutoffiles"
					summary:     "Filesystem has less than 5% inodes left."
				}
				expr: """
					(
					  node_filesystem_files_free{job="node-exporter",fstype!=""} / node_filesystem_files{job="node-exporter",fstype!=""} * 100 < 5
					and
					  node_filesystem_readonly{job="node-exporter",fstype!=""} == 0
					)

					"""
				for: "1h"
				labels: severity: "warning"
			}, {
				alert: "NodeFilesystemAlmostOutOfFiles"
				annotations: {
					description: "Filesystem on {{ $labels.device }} at {{ $labels.instance }} has only {{ printf \"%.2f\" $value }}% available inodes left."
					runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/node/nodefilesystemalmostoutoffiles"
					summary:     "Filesystem has less than 3% inodes left."
				}
				expr: """
					(
					  node_filesystem_files_free{job="node-exporter",fstype!=""} / node_filesystem_files{job="node-exporter",fstype!=""} * 100 < 3
					and
					  node_filesystem_readonly{job="node-exporter",fstype!=""} == 0
					)

					"""
				for: "1h"
				labels: severity: "critical"
			}, {
				alert: "NodeNetworkReceiveErrs"
				annotations: {
					description: "{{ $labels.instance }} interface {{ $labels.device }} has encountered {{ printf \"%.0f\" $value }} receive errors in the last two minutes."
					runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/node/nodenetworkreceiveerrs"
					summary:     "Network interface is reporting many receive errors."
				}
				expr: """
					rate(node_network_receive_errs_total[2m]) / rate(node_network_receive_packets_total[2m]) > 0.01

					"""
				for: "1h"
				labels: severity: "warning"
			}, {
				alert: "NodeNetworkTransmitErrs"
				annotations: {
					description: "{{ $labels.instance }} interface {{ $labels.device }} has encountered {{ printf \"%.0f\" $value }} transmit errors in the last two minutes."
					runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/node/nodenetworktransmiterrs"
					summary:     "Network interface is reporting many transmit errors."
				}
				expr: """
					rate(node_network_transmit_errs_total[2m]) / rate(node_network_transmit_packets_total[2m]) > 0.01

					"""
				for: "1h"
				labels: severity: "warning"
			}, {
				alert: "NodeHighNumberConntrackEntriesUsed"
				annotations: {
					description: "{{ $value | humanizePercentage }} of conntrack entries are used."
					runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/node/nodehighnumberconntrackentriesused"
					summary:     "Number of conntrack are getting close to the limit."
				}
				expr: """
					(node_nf_conntrack_entries / node_nf_conntrack_entries_limit) > 0.75

					"""
				labels: severity: "warning"
			}, {
				alert: "NodeTextFileCollectorScrapeError"
				annotations: {
					description: "Node Exporter text file collector failed to scrape."
					runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/node/nodetextfilecollectorscrapeerror"
					summary:     "Node Exporter text file collector failed to scrape."
				}
				expr: """
					node_textfile_scrape_error{job="node-exporter"} == 1

					"""
				labels: severity: "warning"
			}, {
				alert: "NodeClockSkewDetected"
				annotations: {
					description: "Clock on {{ $labels.instance }} is out of sync by more than 300s. Ensure NTP is configured correctly on this host."
					runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/node/nodeclockskewdetected"
					summary:     "Clock skew detected."
				}
				expr: """
					(
					  node_timex_offset_seconds > 0.05
					and
					  deriv(node_timex_offset_seconds[5m]) >= 0
					)
					or
					(
					  node_timex_offset_seconds < -0.05
					and
					  deriv(node_timex_offset_seconds[5m]) <= 0
					)

					"""
				for: "10m"
				labels: severity: "warning"
			}, {
				alert: "NodeClockNotSynchronising"
				annotations: {
					description: "Clock on {{ $labels.instance }} is not synchronising. Ensure NTP is configured on this host."
					runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/node/nodeclocknotsynchronising"
					summary:     "Clock not synchronising."
				}
				expr: """
					min_over_time(node_timex_sync_status[5m]) == 0
					and
					node_timex_maxerror_seconds >= 16

					"""
				for: "10m"
				labels: severity: "warning"
			}, {
				alert: "NodeRAIDDegraded"
				annotations: {
					description: "RAID array '{{ $labels.device }}' on {{ $labels.instance }} is in degraded state due to one or more disks failures. Number of spare drives is insufficient to fix issue automatically."
					runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/node/noderaiddegraded"
					summary:     "RAID Array is degraded"
				}
				expr: """
					node_md_disks_required - ignoring (state) (node_md_disks{state="active"}) > 0

					"""
				for: "15m"
				labels: severity: "critical"
			}, {
				alert: "NodeRAIDDiskFailure"
				annotations: {
					description: "At least one device in RAID array on {{ $labels.instance }} failed. Array '{{ $labels.device }}' needs attention and possibly a disk swap."
					runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/node/noderaiddiskfailure"
					summary:     "Failed device in RAID array"
				}
				expr: """
					node_md_disks{state="failed"} > 0

					"""
				labels: severity: "warning"
			}, {
				alert: "NodeFileDescriptorLimit"
				annotations: {
					description: "File descriptors limit at {{ $labels.instance }} is currently at {{ printf \"%.2f\" $value }}%."
					runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/node/nodefiledescriptorlimit"
					summary:     "Kernel is predicted to exhaust file descriptors limit soon."
				}
				expr: """
					(
					  node_filefd_allocated{job="node-exporter"} * 100 / node_filefd_maximum{job="node-exporter"} > 70
					)

					"""
				for: "15m"
				labels: severity: "warning"
			}, {
				alert: "NodeFileDescriptorLimit"
				annotations: {
					description: "File descriptors limit at {{ $labels.instance }} is currently at {{ printf \"%.2f\" $value }}%."
					runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/node/nodefiledescriptorlimit"
					summary:     "Kernel is predicted to exhaust file descriptors limit soon."
				}
				expr: """
					(
					  node_filefd_allocated{job="node-exporter"} * 100 / node_filefd_maximum{job="node-exporter"} > 90
					)

					"""
				for: "15m"
				labels: severity: "critical"
			}]
		}, {
			name: "node-exporter.rules"
			rules: [{
				expr: """
					count without (cpu, mode) (
					  node_cpu_seconds_total{job="node-exporter",mode="idle"}
					)

					"""
				record: "instance:node_num_cpu:sum"
			}, {
				expr: """
					1 - avg without (cpu) (
					  sum without (mode) (rate(node_cpu_seconds_total{job="node-exporter", mode=~"idle|iowait|steal"}[5m]))
					)

					"""
				record: "instance:node_cpu_utilisation:rate5m"
			}, {
				expr: """
					(
					  node_load1{job="node-exporter"}
					/
					  instance:node_num_cpu:sum{job="node-exporter"}
					)

					"""
				record: "instance:node_load1_per_cpu:ratio"
			}, {
				expr: """
					1 - (
					  (
					    node_memory_MemAvailable_bytes{job="node-exporter"}
					    or
					    (
					      node_memory_Buffers_bytes{job="node-exporter"}
					      +
					      node_memory_Cached_bytes{job="node-exporter"}
					      +
					      node_memory_MemFree_bytes{job="node-exporter"}
					      +
					      node_memory_Slab_bytes{job="node-exporter"}
					    )
					  )
					/
					  node_memory_MemTotal_bytes{job="node-exporter"}
					)

					"""
				record: "instance:node_memory_utilisation:ratio"
			}, {
				expr: """
					rate(node_vmstat_pgmajfault{job="node-exporter"}[5m])

					"""
				record: "instance:node_vmstat_pgmajfault:rate5m"
			}, {
				expr: """
					rate(node_disk_io_time_seconds_total{job="node-exporter", device=~"mmcblk.p.+|nvme.+|rbd.+|sd.+|vd.+|xvd.+|dm-.+|dasd.+"}[5m])

					"""
				record: "instance_device:node_disk_io_time_seconds:rate5m"
			}, {
				expr: """
					rate(node_disk_io_time_weighted_seconds_total{job="node-exporter", device=~"mmcblk.p.+|nvme.+|rbd.+|sd.+|vd.+|xvd.+|dm-.+|dasd.+"}[5m])

					"""
				record: "instance_device:node_disk_io_time_weighted_seconds:rate5m"
			}, {
				expr: """
					sum without (device) (
					  rate(node_network_receive_bytes_total{job="node-exporter", device!="lo"}[5m])
					)

					"""
				record: "instance:node_network_receive_bytes_excluding_lo:rate5m"
			}, {
				expr: """
					sum without (device) (
					  rate(node_network_transmit_bytes_total{job="node-exporter", device!="lo"}[5m])
					)

					"""
				record: "instance:node_network_transmit_bytes_excluding_lo:rate5m"
			}, {
				expr: """
					sum without (device) (
					  rate(node_network_receive_drop_total{job="node-exporter", device!="lo"}[5m])
					)

					"""
				record: "instance:node_network_receive_drop_excluding_lo:rate5m"
			}, {
				expr: """
					sum without (device) (
					  rate(node_network_transmit_drop_total{job="node-exporter", device!="lo"}[5m])
					)

					"""
				record: "instance:node_network_transmit_drop_excluding_lo:rate5m"
			}]
		}]
	}
	Service: "node-exporter": {
		apiVersion: "v1"
		kind:       "Service"
		metadata: {
			labels: {
				"app.kubernetes.io/component": "exporter"
				"app.kubernetes.io/name":      "node-exporter"
				"app.kubernetes.io/part-of":   "kube-prometheus"
				"app.kubernetes.io/version":   "1.3.1"
			}
			name:      "node-exporter"
			namespace: "monitoring"
		}
		spec: {
			clusterIP: "None"
			ports: [{
				name:       "https"
				port:       9100
				targetPort: "https"
			}]
			selector: {
				"app.kubernetes.io/component": "exporter"
				"app.kubernetes.io/name":      "node-exporter"
				"app.kubernetes.io/part-of":   "kube-prometheus"
			}
		}
	}
	ServiceAccount: "node-exporter": {
		apiVersion:                   "v1"
		automountServiceAccountToken: false
		kind:                         "ServiceAccount"
		metadata: {
			labels: {
				"app.kubernetes.io/component": "exporter"
				"app.kubernetes.io/name":      "node-exporter"
				"app.kubernetes.io/part-of":   "kube-prometheus"
				"app.kubernetes.io/version":   "1.3.1"
			}
			name:      "node-exporter"
			namespace: "monitoring"
		}
	}
	ServiceMonitor: "node-exporter": {
		apiVersion: "monitoring.coreos.com/v1"
		kind:       "ServiceMonitor"
		metadata: {
			labels: {
				"app.kubernetes.io/component": "exporter"
				"app.kubernetes.io/name":      "node-exporter"
				"app.kubernetes.io/part-of":   "kube-prometheus"
				"app.kubernetes.io/version":   "1.3.1"
			}
			name:      "node-exporter"
			namespace: "monitoring"
		}
		spec: {
			endpoints: [{
				bearerTokenFile: "/var/run/secrets/kubernetes.io/serviceaccount/token"
				interval:        "15s"
				port:            "https"
				relabelings: [{
					action:      "replace"
					regex:       "(.*)"
					replacement: "$1"
					sourceLabels: ["__meta_kubernetes_pod_node_name"]
					targetLabel: "instance"
				}]
				scheme: "https"
				tlsConfig: insecureSkipVerify: true
			}]
			jobLabel: "app.kubernetes.io/name"
			selector: matchLabels: {
				"app.kubernetes.io/component": "exporter"
				"app.kubernetes.io/name":      "node-exporter"
				"app.kubernetes.io/part-of":   "kube-prometheus"
			}
		}
	}
}
