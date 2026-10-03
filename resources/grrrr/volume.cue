package kube

k: PersistentVolume: videos: spec: {
	storageClassName: "nfs"
	accessModes: ["ReadWriteMany"]
	capacity: storage: "24Ti"
	nfs: {
		server: "10.0.0.208"
		path:   "/var/nfs/shared/Videos"
	}
}

k: PersistentVolumeClaim: videos: spec: {
	storageClassName: "nfs"
	accessModes: ["ReadWriteMany"]
	resources: requests: storage: "2Ti"
	volumeName: "videos"
}
