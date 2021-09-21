package kube

// helm template cert-manager-csi-driver cert-manager/cert-manager-csi-driver  > csi.yaml
// cue import -p kube -l '"k"' -l 'kind' -l metadata.name -f csi.yaml
// cue trim -s
// runAsUser: 0

k: ServiceAccount: "cert-manager-csi-driver": {}

k: CSIDriver: "csi.cert-manager.io": {
	spec: {
		podInfoOnMount: true
		volumeLifecycleModes: ["Ephemeral"]
	}
}

k: DaemonSet: "cert-manager-csi-driver": {
	spec: template: spec: {
		serviceAccountName: "cert-manager-csi-driver"
		containers: [{
			name:  "node-driver-registrar"
			securityContext: {
				runAsUser: 0
				runAsGroup: 0
			}
			image: "quay.io/k8scsi/csi-node-driver-registrar:v2.1.0"
			lifecycle: preStop: exec: command: ["/bin/sh", "-c", "rm -rf /registration/cert-manager-csi-driver /registration/cert-manager-csi-driver-reg.sock"]
			args: [
				"-v=1",
				"--csi-address=/plugin/csi.sock",
				"--kubelet-registration-path=/var/lib/kubelet/plugins/cert-manager-csi-driver/csi.sock",
			]
			env: [{
				name: "KUBE_NODE_NAME"
				valueFrom: fieldRef: fieldPath: "spec.nodeName"
			}]
			volumeMounts: [{
				name:      "plugin-dir"
				mountPath: "/plugin"
			}, {
				name:      "registration-dir"
				mountPath: "/registration"
			}]
		}, {
			name: "cert-manager-csi-driver"
			securityContext: {
				runAsUser: 0
				runAsGroup: 0
				privileged: true
				capabilities: add: ["SYS_ADMIN"]
				allowPrivilegeEscalation: true
			}
			image:           "quay.io/jetstack/cert-manager-csi-driver:v0.1.0"
			imagePullPolicy: "IfNotPresent"
			args: [
				"--log-level=1",
				"--driver-name=csi.cert-manager.io",
				"--node-id=$(NODE_ID)",
				"--endpoint=$(CSI_ENDPOINT)",
				"--data-root=csi-data-dir",
				"--use-token-request=false",
			]
			env: [{
				name: "NODE_ID"
				valueFrom: fieldRef: fieldPath: "spec.nodeName"
			}, {
				name:  "CSI_ENDPOINT"
				value: "unix://plugin/csi.sock"
			}]
			volumeMounts: [{
				name:      "plugin-dir"
				mountPath: "/plugin"
			}, {
				name:             "pods-mount-dir"
				mountPath:        "/var/lib/kubelet/pods"
				mountPropagation: "Bidirectional"
			}, {
				name:      "csi-data-dir"
				mountPath: "/csi-data-dir"
			}]
			resources: {}
		}]

		volumes: [{
			name: "plugin-dir"
			hostPath: {
				path: "/var/lib/kubelet/plugins/cert-manager-csi-driver"
				type: "DirectoryOrCreate"
			}
		}, {
			name: "pods-mount-dir"
			hostPath: {
				path: "/var/lib/kubelet/pods"
				type: "Directory"
			}
		}, {
			hostPath: {
				path: "/var/lib/kubelet/plugins_registry"
				type: "Directory"
			}
			name: "registration-dir"
		}, {
			hostPath: {
				path: "/tmp/cert-manager-csi-driver"
				type: "DirectoryOrCreate"
			}
			name: "csi-data-dir"
		}]
	}
}

k: ClusterRole: "cert-manager-csi-driver": {
	rules: [{
		apiGroups: ["cert-manager.io"]
		resources: ["certificaterequests"]
		verbs: ["watch", "create", "delete", "list"]
	}]
}

k: ClusterRoleBinding: "cert-manager-csi-driver": {
	roleRef: {
		apiGroup: "rbac.authorization.k8s.io"
		kind:     "ClusterRole"
		name:     "cert-manager-csi-driver"
	}
	subjects: [{
		kind:      "ServiceAccount"
		name:      "cert-manager-csi-driver"
		namespace: "cert-manager"
	}]
}
