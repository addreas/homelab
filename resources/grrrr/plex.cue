package kube

k: StatefulSet: "sergio-plex": spec: template: {
	metadata: annotations: "v1.multus-cni.io/default-network": "default/macvlan-conf"
	spec: {
		dnsPolicy: "None"
		dnsConfig: nameservers: ["192.168.0.1"]
	}
}
k: StatefulSet: "sergio-plex": spec: template: spec: {
	containers: [{
		image:           "plexinc/pms-docker"
		imagePullPolicy: "Always"
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

k: PersistentVolumeClaim: "sergio-plex-config": spec: resources: requests: storage: "20Gi"
k: PersistentVolume: "sergio-plex-config": spec: local: path: "/mnt/plex-config"
