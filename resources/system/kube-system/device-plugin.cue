package kube

import "encoding/json"

k: ConfigMap: "hostdevice-plugin-config": data: "config.json": json.Marshal({
	socketPrefix: "hostdevice-plugin"
	devices: {
		"addem.se/dev_thread_rcp": {
			containerPath: "/dev/thread-rcp"
			permissions:   "rw"
			matchProperties: {
				SUBSYSTEM: "tty"
				ID_VENDOR: "Nordic_Semiconductor_ASA"
				ID_MODEL:  "Thread_Co-Processor"
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
			}, {
				key:      "node-role.kubernetes.io/control-plane"
				operator: "Exists"
				effect:   "NoSchedule"
			}]
			securityContext: fsGroup: 0
			hostNetwork: true
			containers: [{
				image: "ghcr.io/addreas/k8s-hostdevice-plugin:986abd80beca8e18176e66472a09032feb11ab53"
				name:  "plugin"
				securityContext: {
					runAsUser:    0
					runAsGroup:   0
					runAsNonRoot: false
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
