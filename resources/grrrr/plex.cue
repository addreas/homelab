package kube

k: StatefulSet: "plex": spec: template: spec: {
	containers: [{
		image:           "plexinc/pms-docker"
		imagePullPolicy: "Always"
		command: ["sh", "-c", """
			tail --follow=name "/config/Library/Logs/Plex Media Server/Plex Media Server.log" &
			rm -f "/config/Library/Application Support/Plex Media Server/plexmediaserver.pid"
			exec "/usr/lib/plexmediaserver/Plex Media Server"
			"""]
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
		persistentVolumeClaim: claimName: "plex-config"
	}, {
		name: "data"
		persistentVolumeClaim: claimName: "videos"
	}, {
		name: "transcode"
		emptyDir: {}
	}]
	securityContext: fsGroupChangePolicy: "OnRootMismatch"
}

k: PersistentVolumeClaim: "plex-config": spec: resources: requests: storage: "20Gi"
