package kube

k: StatefulSet: "sergio-plex": spec: template: spec: {
	containers: [{
		image: "plexinc/pms-docker"
		command: ["/usr/lib/plexmediaserver/Plex Media Server"]
		env: [{
			name:  "PLEX_UID"
			value: "1000"
		}, {
			name:  "PLEX_GID"
			value: "1000"
		}, {
			name:  "TZ"
			value: "Europe/Stockholm"
		}, {
			name:  "ADVERTISE_IP"
			value: "http://192.168.10.83:32400"
		}]
		ports: [{
			name:          "http"
			containerPort: 32400
		}, {
			name:          "companion"
			containerPort: 3005
		}, {
			name:          "plex-dlna"
			containerPort: 32469
		}, {
			name:          "dlna"
			containerPort: 1900
			protocol:      "UDP"
		}, {
			name:          "discovery-0"
			containerPort: 32410
			protocol:      "UDP"
		}, {
			name:          "discovery-2"
			containerPort: 32412
			protocol:      "UDP"
		}, {
			name:          "discovery-3"
			containerPort: 32413
			protocol:      "UDP"
		}, {
			name:          "discovery-4"
			containerPort: 32414
			protocol:      "UDP"
		}]
		volumeMounts: [{
			name:      "config"
			mountPath: "/config"
		}, {
			name:      "data"
			mountPath: "/data"
		}, {
			name:      "transcode"
			mountPath: "/transcode"
		}]
	}]
	volumes: [{
		name: "config"
		persistentVolumeClaim: claimName: "sergio-plex-config"
	}, {
		name: "data"
		persistentVolumeClaim: claimName: "sergio-videos"
	}, {
		name: "transcode"
		emptyDir: {}
	}]
}

k: Service: "sergio-plex": {
	metadata: annotations: "io.cilium/lb-ipam-ips": "192.168.10.83"
	spec: type: "LoadBalancer"
}
