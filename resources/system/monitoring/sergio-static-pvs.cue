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

k: PersistentVolume: "sergio-parseable-logs": spec: {
	capacity: storage: "100Gi"
	local: path:       "/mnt/solid-data/parseable-logs"
}

k: PersistentVolumeClaim: "sergio-parseable-logs": spec: resources: requests: storage: "100Gi"
