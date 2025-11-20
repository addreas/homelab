package kube

k: PersistentVolume: "videos": spec: {
	storageClassName: "nfs"
	accessModes: ["ReadWriteOnce"]
	capacity: storage: "2Ti"
	nfs: {
		server: "10.0.0.208"
		path:   "/var/nfs/shared/Videos"
	}
}

k: PersistentVolumeClaim: "videos": spec: {
	storageClassName: "nfs"
	resources: requests: storage: "2Ti"
	volumeName: "videos"
}

k: PersistentVolumeClaim: [string]: spec: accessModes: ["ReadWriteOnce"]
