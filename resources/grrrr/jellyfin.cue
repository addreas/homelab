package kube

k: StatefulSet: jellyfin: spec: {
	template: spec: {
		containers: [{
			image: "ghcr.io/jellyfin/jellyfin:10.11.11"
			ports: [{
				name:          "http"
				containerPort: 8096
			}]
			volumeMounts: [{
				name:      "config"
				mountPath: "/config"
			}, {
				name:      "cache"
				mountPath: "/cache"
			}, {
				name:      "videos"
				mountPath: "/videos"
			}]
		}]
		volumes: [{
			name: "videos"
			persistentVolumeClaim: claimName: "videos"
		}]
	}
	volumeClaimTemplates: [{
		metadata: name: "config"
		spec: resources: requests: storage: "20Gi"
	}, {
		metadata: name: "cache"
		spec: resources: requests: storage: "20Gi"
	}]
}

k: Service: jellyfin: {
	metadata: labels: advertise: "arp"
	spec: type: "LoadBalancer"
}

k: HTTPRoute: jellyfin: _authproxy: true
