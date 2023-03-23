package kube

import "strings"

k: HelmRelease: "smartctl-exporter": spec: {
	chart: spec: {
		chart:   "prometheus-smartctl-exporter"
		version: "0.3.1"
		sourceRef: name: "prometheus-community"
	}
	values: {
		serviceMonitor: enabled:  true
		prometheusRules: enabled: true
	}

	postRenderers: [{
		kustomize: patchesStrategicMerge: [{
			apiVersion: "apps/v1"
			kind:       "DaemonSet"
			spec: template: spec: containers: [{
				name:        "main"
				hostNetwork: false
			}]
		}]
	}]
}

k: DaemonSet: "systemd-exporter": {
	spec: {
		selector: matchLabels: "k8s-app": "systemd-exporter"
		template: {
			metadata: {
				labels: "k8s-app": "systemd-exporter"
				annotations: {
					"prometheus.io/scrape": "true"
					"prometheus.io/path":   "/metrics"
					"prometheus.io/port":   "9558"
				}
			}
			spec: {
				hostPID: true
				containers: [{
					image: "quay.io/prometheuscommunity/systemd-exporter:main"
					securityContext: {
						runAsUser:                0
						runAsGroup:               0
						privileged:               true
						allowPrivilegeEscalation: true
					}
					args: [
						"--log.level=info",
						"--systemd.collector.unit-exclude=" + strings.Join([
							"crio-.+\\.scope",
							"kubepods-.+\\.slice",
							"run-containers-storage-btrfs.+\\.mount",
							"run-ipcns-.+\\.mount",
							"run-netns-.+\\.mount",
							"run-utsns-.+\\.mount",
							"var-lib-kubelet-.+\\.mount",
							"var-lib-containers-storage-.+\\.mount",
							".+\\.device",
						], "|"),
					]
					ports: [{
						name:          "metrics"
						containerPort: 9558
						hostPort:      9558
					}]
					volumeMounts: [{
						name:      "proc"
						mountPath: "/host/proc"
						readOnly:  true
					}, {
						name:      "systemd"
						mountPath: "/run/systemd"
						readOnly:  true
					}]
					resources: {
						limits: memory: "100Mi"
						requests: {
							cpu:    "10m"
							memory: "100Mi"
						}
					}
				}]
				volumes: [{
					name: "proc"
					hostPath: path: "/proc"
				}, {
					name: "systemd"
					hostPath: path: "/run/systemd"
				}]
			}
		}
	}
}

k: PodMonitor: "systemd-exporter": spec: {
	podMetricsEndpoints: [{
		port:     "metrics"
		interval: "60s"
	}]
	selector: matchLabels: "k8s-app": "systemd-exporter"
}
