package kube

k: StatefulSet: prowlarr: spec: {
	template: {
		metadata: labels: "vpn-egress": "client"
		spec: containers: [{
			name:  "prowlarr"
			image: "lscr.io/linuxserver/prowlarr:2.6.5.5623-ls162"
			command: ["app/prowlarr/bin/Prowlarr", "-nobrowser", "-data=/config"]
			env: [{
				name:  "TMPDIR"
				value: "/tmp"
			}]
			ports: [{
				name:          "http"
				containerPort: 9696
			}]
			volumeMounts: [{
				mountPath: "/config"
				name:      "config"
			}]
			resources: {
				limits: {
					cpu:    "100m"
					memory: "256Mi"
				}
				requests: cpu: "10m"
			}
		}]
	}
	volumeClaimTemplates: [{
		metadata: name: "config"
		spec: resources: requests: storage: "1Gi"
	}]
}

k: Service: prowlarr: {}

k: HTTPRoute: prowlarr: _authproxy: true
