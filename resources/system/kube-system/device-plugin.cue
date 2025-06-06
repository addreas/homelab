package kube

import "encoding/json"

k: ConfigMap: "hostdevice-plugin-config": data: "config.json": json.Marshal({
	socketPrefix: "hostdevice-plugin"
	devices: {
		"addem.se/dev_deconz_conbee": {
			containerPath: "/dev/deconz-conbee"
			permissions:   "rw"
			matchProperties: {
				SUBSYSTEM: "tty"
				ID_VENDOR: "FTDI"
				ID_MODEL:  "FT230X_Basic_UART"
			}
		}
		"addem.se/dev_deconz_conbee_ii": {
			containerPath: "/dev/deconz-conbee-ii"
			permissions:   "rw"
			matchProperties: {
				SUBSYSTEM: "tty"
				ID_VENDOR: "dresden_elektronik_ingenieurtechnik_GmbH"
				ID_MODEL:  "ConBee_II"
			}
		}
		"addem.se/dev_aeotec_zstick": {
			containerPath: "/dev/aeotec-z-stick"
			permissions:   "rw"
			matchProperties: {
				SUBSYSTEM: "tty"
				ID_VENDOR: "0658"
				ID_MODEL:  "0200"
			}
		}
	}
})

k: DaemonSet: "hostdevice-plugin-daemonset": spec: {
	selector: matchLabels: app: "hostdevice-plugin"
	template: {
		metadata: labels: app: "hostdevice-plugin"
		spec: {
			// Mark this pod as a critical add-on; when enabled, the critical add-on scheduler
			// reserves resources for critical add-on pods so that they can be rescheduled after
			// a failure.  This annotation works in tandem with the toleration below.
			priorityClassName: "system-node-critical"
			tolerations: [{
				// Allow this pod to be rescheduled while the node is in "critical add-ons only" mode.
				// This, along with the annotation above marks this pod as a critical add-on.
				key:      "CriticalAddonsOnly"
				operator: "Exists"
			}]
			securityContext: fsGroup: 0
			hostNetwork: true
			containers: [{
				image: "ghcr.io/addreas/k8s-hostdevice-plugin:a379a410e09679892baac49b6286c13820f7cebc"
				name:  "plugin"
				securityContext: {
					runAsUser:  0
					runAsGroup: 0
				}
				volumeMounts: [{
					name:      "device-plugin"
					mountPath: "/var/lib/kubelet/device-plugins"
				}, {
					name:      "run-udev"
					mountPath: "/run/udev"
				}, {
					name:      "config"
					mountPath: "/k8s-hostdevice-plugin"
				}]
				resources: limits: {
					cpu:    "10m"
					memory: "64Mi"
				}
			}]
			volumes: [{
				name: "device-plugin"
				hostPath: path: "/var/lib/kubelet/device-plugins"
			}, {
				name: "run-udev"
				hostPath: path: "/run/udev"
			}, {
				name: "config"
				configMap: name: "hostdevice-plugin-config"
			}]
		}
	}
}
