package kube

import "encoding/json"

k: StatefulSet: "otbr": spec: {
	template: {
		metadata: annotations: "k8s.v1.cni.cncf.io/networks": json.Marshal([{
			name:      "iot-bridge"
			interface: "net1"
			mac:       "02:00:00:00:00:06"
		}])
		spec: {
			tolerations: [{
				key:      "node-role.kubernetes.io/control-plane"
				operator: "Exists"
				effect:   "NoSchedule"
			}]
			containers: [{
				name:  "otbr"
				image: "openthread/otbr@sha256:f3e43ccd86d6da87323873efa0c9b6f92a2a8cc75a804ea50e34c96680363e2e"
				env: [
					{name: "HTTP_HOST", value: "0.0.0.0"},
					{name: "REST_HOST", value: "::"},
					{name: "NAT64", value: "0"},
					{name: "FIREWALL", value: "0"},
				]
				args: [
					"--radio-url", "spinel+hdlc+uart:///dev/thread-rcp?uart-init-deassert",
					"-B", "net1",
					"--trel-url", "trel://net1",
					"--debug-level", "5",
				]
				ports: [{containerPort: 8081}, {containerPort: 80}]
				livenessProbe: {
					exec: command: ["ot-ctl", "state"]
					initialDelaySeconds: 120
					periodSeconds:        20
					timeoutSeconds:       15
					failureThreshold:     3
				}
				volumeMounts: [{
					name:      "thread"
					mountPath: "/var/lib/thread"
				}]
				securityContext: {
					privileged:               true
					runAsNonRoot:             false
					runAsUser:                0
					runAsGroup:               0
					allowPrivilegeEscalation: true
				}
				resources: limits: {
					cpu:                       "200m"
					memory:                    "256Mi"
					"addem.se/dev_thread_rcp": "1"
				}
			}]
		}
	}
	volumeClaimTemplates: [{
		metadata: name: "thread"
		spec: {
			accessModes: ["ReadWriteOnce"]
			resources: requests: storage: "64Mi"
		}
	}]
}

k: Service: "otbr": spec: ports: [{
	name: "rest"
	port: 8081
}, {
	name:       "web"
	port:       8080
	targetPort: 80
}]
