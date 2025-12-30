package kube

k: StatefulSet: "jellyfin": spec: template: spec: {
	containers: [{
		image:           "ghcr.io/jellyfin/jellyfin:2025072105"
		imagePullPolicy: "Always"
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
		name: "config"
		persistentVolumeClaim: claimName: "jellyfin-config"
	}, {
		name: "cache"
		persistentVolumeClaim: claimName: "jellyfin-cache"
	}, {
		name: "videos"
		persistentVolumeClaim: claimName: "videos"
	}]
}

k: PersistentVolumeClaim: "jellyfin-config": spec: resources: requests: storage: "20Gi"
k: PersistentVolumeClaim: "jellyfin-cache": spec: resources: requests: storage:  "20Gi"

k: Service: "jellyfin": {}
k: Service: "jellyfin": {
	metadata: labels: advertise: "bgp"
	spec: type: "LoadBalancer"
}

k: Ingress: "jellyfin": _authproxy: true
