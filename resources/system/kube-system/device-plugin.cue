package kube

import "encoding/json"

k: ConfigMap: "generic-device-plugin-config": data: "config.json": json.Marshal({
	domain: "addem.se"
	devices: [{
		name: "dev-thread-rcp"
		groups: [{
			paths: [{
				path:        "/dev/serial/by-id/usb-Nordic_Semiconductor_ASA_Thread_Co-Processor_*"
				mountPath:   "/dev/thread-rcp"
				permissions: "rw"
			}]
		}]
	}, {
		name: "dev-deconz-conbee"
		groups: [{
			paths: [{
				path:        "/dev/serial/by-id/usb-FTDI_FT230X_Basic_UART_*"
				mountPath:   "/dev/deconz-conbee"
				permissions: "rw"
			}]
		}]
	}, {
		name: "dev-deconz-conbee-ii"
		groups: [{
			paths: [{
				path:        "/dev/serial/by-id/usb-dresden_elektronik_ingenieurtechnik_GmbH_ConBee_II_*"
				mountPath:   "/dev/deconz-conbee-ii"
				permissions: "rw"
			}]
		}]
	}, {
		name: "dev-aeotec-zstick"
		groups: [{
			paths: [{
				path:        "/dev/serial/by-id/usb-0658_0200*"
				mountPath:   "/dev/aeotec-z-stick"
				permissions: "rw"
			}]
		}]
	}, {
		name: "dev-dri"
		groups: [{
			paths: [{
				path: "/dev/dri/card*"
			}, {
				path: "/dev/dri/renderD*"
			}]
		}]
	}, {
		name: "fuse"
		groups: [{
			count: 10
			paths: [{
				path: "/dev/fuse"
			}]
		}]
	}]
})

k: DaemonSet: "generic-device-plugin": spec: {
	selector: matchLabels: app: "generic-device-plugin"
	template: {
		metadata: labels: app: "generic-device-plugin"
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
			}, {
				key:      "node-role.kubernetes.io/control-plane"
				operator: "Exists"
				effect:   "NoSchedule"
			}]
			securityContext: fsGroup: 0
			automountServiceAccountToken: false
			containers: [{
				image: "squat/generic-device-plugin:0.2.0"
				name:  "generic-device-plugin"
				args: ["--config", "/config/config.json"]
				securityContext: {
					allowPrivilegeEscalation: false
					capabilities: drop: ["ALL"]
					readOnlyRootFilesystem:   true
					runAsUser:                0
					runAsGroup:               0
					runAsNonRoot:             false
				}
				volumeMounts: [{
					name:      "device-plugin"
					mountPath: "/var/lib/kubelet/device-plugins"
				}, {
					name:      "dev"
					mountPath: "/dev"
				}, {
					name:      "config"
					mountPath: "/config"
				}]
				resources: limits: {
					cpu:    "50m"
					memory: "64Mi"
				}
			}]
			volumes: [{
				name: "device-plugin"
				hostPath: path: "/var/lib/kubelet/device-plugins"
			}, {
				name: "dev"
				hostPath: path: "/dev"
			}, {
				name: "config"
				configMap: name: "generic-device-plugin-config"
			}]
		}
	}
}
