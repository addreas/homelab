package kube

import json656e63 "encoding/json"

k: ConfigMap: "hostdevice-plugin-config": {
	metadata: namespace: "kube-system"
	data: {
		"config.json": json656e63.Marshal(_cue_config_json)
		let _cue_config_json = {
			socketPrefix: "hostdevice-plugin"
			devices: {
				"addem.se/dev_yanzi_serial_radio": {
					containerPath: "/dev/yanzi-serial-radio"
					permissions:   "rw"
					matchProperties: {
						SUBSYSTEM: "tty"
						ID_VENDOR: "Texas_Instruments"
						ID_MODEL:  "Yanzi_Serial_Radio"
					}
				}
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
		}
	}
}

k: DaemonSet: "hostdevice-plugin-daemonset": {
	metadata: namespace: "kube-system"
	spec: {
		selector: matchLabels: app: "hostdevice-plugin"
		template: {
			metadata: {
				labels: app: "hostdevice-plugin"
				// Mark this pod as a critical add-on; when enabled, the critical add-on scheduler
				// reserves resources for critical add-on pods so that they can be rescheduled after
				// a failure.  This annotation works in tandem with the toleration below.
				annotations: {
					"scheduler.alpha.kubernetes.io/critical-pod": ""
				}
			}
			spec: {
				tolerations: [{
					// Allow this pod to be rescheduled while the node is in "critical add-ons only" mode.
					// This, along with the annotation above marks this pod as a critical add-on.
					key:      "CriticalAddonsOnly"
					operator: "Exists"
				}]
				containers: [{
					image: "ghcr.io/addreas/k8s-hostdevice-plugin:latest"
					name:  "plugin"
					securityContext: {
						allowPrivilegeEscalation: false
						capabilities: drop: ["ALL"]
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
}
