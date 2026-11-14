package kube

import "encoding/yaml"

// renovate: registryUrl=https://prometheus-community.github.io/helm-charts
k: HelmRelease: "smartctl-exporter": spec: {
	chart: spec: {
		chart:   "prometheus-smartctl-exporter"
		version: "0.19.1"
		sourceRef: name: "prometheus-community"
	}
	values: serviceMonitor: {
		enabled:  true
		interval: "120s"
	}
	postRenderers: [{
		kustomize: patches: [{
			patch: yaml.Marshal({
				apiVersion: "apps/v1"
				kind:       "DaemonSet"
				metadata: name: "smartctl-exporter-prometheus-smartctl-exporter-0"
				spec: template: spec: {
					containers: [{
						name:    "main"
						command: ["/bin/sh", "/etc/smartctl/discover.sh"]
						volumeMounts: [{
							name:      "discover"
							mountPath: "/etc/smartctl"
						}]
					}]
					volumes: [{
						name: "discover"
						configMap: {
							name:        "smartctl-discover"
							defaultMode: 0o755
						}
					}]
				}
			})
		}]
	}]
}

k: ConfigMap: "smartctl-discover": data: "discover.sh": """
	devs=""
	for c in /sys/class/nvme/nvme*; do
		case "$(readlink -f "$c/device")" in *virtual*) continue ;; esac
		devs="$devs --smartctl.device=/dev/$(basename "$c")"
	done
	for d in /sys/block/sd*; do
		[ -e "$d/device/model" ] && devs="$devs --smartctl.device=/dev/$(basename "$d")"
	done
	exec /bin/smartctl_exporter $devs "$@"
	"""

k: PrometheusRule: "smartctl": {
	metadata: labels: ruler: "metrics"
	spec: groups: [{
		name: "smartctl.rules"
		rules: [{
			alert: "SmartctlMediaErrors"
			annotations: {
				description: "{{ $labels.device }} on {{ $labels.instance }} reports {{ $value }} media/integrity errors."
				summary:     "Disk has media errors."
			}
			expr: "smartctl_device_media_errors > 0"
			for:  "5m"
			labels: severity: "critical"
		}, {
			alert: "SmartctlCriticalWarning"
			annotations: {
				description: "{{ $labels.device }} on {{ $labels.instance }} has a non-zero SMART critical warning."
				summary:     "Disk reports a critical warning."
			}
			expr: "smartctl_device_critical_warning > 0"
			for:  "5m"
			labels: severity: "critical"
		}, {
			alert: "SmartctlSpareBelowThreshold"
			annotations: {
				description: "{{ $labels.device }} on {{ $labels.instance }} has {{ $value }}% spare left, at or below its own threshold."
				summary:     "Disk available spare is below threshold."
			}
			expr: "smartctl_device_available_spare < smartctl_device_available_spare_threshold"
			for:  "5m"
			labels: severity: "warning"
		}, {
			alert: "SmartctlWearHigh"
			annotations: {
				description: "{{ $labels.device }} on {{ $labels.instance }} has consumed {{ $value }}% of its rated endurance."
				summary:     "Disk endurance is mostly consumed."
			}
			expr: "smartctl_device_percentage_used > 80"
			for:  "1h"
			labels: severity: "warning"
		}, {
			alert: "SmartctlReallocatedSectors"
			annotations: {
				description: "{{ $labels.device }} on {{ $labels.instance }} has {{ $value }} reallocated sectors."
				summary:     "Disk has reallocated sectors."
			}
			expr: "smartctl_device_attribute{attribute_name=\"Reallocated_Sector_Ct\", attribute_value_type=\"raw\"} > 0"
			for:  "5m"
			labels: severity: "warning"
		}, {
			alert: "SmartctlTemperature"
			annotations: {
				description: "{{ $labels.device }} on {{ $labels.instance }} is at {{ $value }} celsius."
				summary:     "Disk is running hot."
			}
			expr: "smartctl_device_temperature{temperature_type=\"current\"} > 70"
			for:  "15m"
			labels: severity: "warning"
		}, {
			alert: "SmartctlExporterDown"
			annotations: {
				description: "No smartctl device metrics at all - the exporter DaemonSet or its scrape is gone."
				summary:     "SMART metrics are missing."
			}
			expr: "absent(smartctl_device)"
			for:  "15m"
			labels: severity: "warning"
		}]
	}]
}
