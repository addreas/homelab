package kube

k: PersistentVolume: [string]: spec: {
	volumeMode: "Filesystem"
	accessModes: ["ReadWriteOnce"]
	persistentVolumeReclaimPolicy: "Retain"
	storageClassName:              "static-node-local-storage"
	nodeAffinity: required: nodeSelectorTerms: [{
		matchExpressions: [{
			key:      "kubernetes.io/hostname"
			operator: "In"
			values: ["sergio"]
		}]
	}]
}

k: PersistentVolumeClaim: [claimName=string]: spec: {
	accessModes: ["ReadWriteOnce"]
	storageClassName: "static-node-local-storage"
	volumeMode:       "Filesystem"
	volumeName:       claimName
}

k: PersistentVolume: "sergio-plex-config": spec: {
	capacity: storage: "100Gi"
	local: path:       "/mnt/plex-config"
}

k: PersistentVolumeClaim: "sergio-plex-config": spec: resources: requests: storage: "20Gi"

k: PersistentVolume: "sergio-videos": spec: {
	capacity: storage: "3Ti"
	local: path:       "/mnt/videos"
}

k: PersistentVolumeClaim: "sergio-videos": spec: resources: requests: storage: "2Ti"
