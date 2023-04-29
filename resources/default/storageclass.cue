package kube

k: StorageClass: "static-node-local-storage": {
	apiVersion: "storage.k8s.io/v1"
	kind:       "StorageClass"
	metadata: name: "static-node-local-storage"
	provisioner:       "kubernetes.io/no-provisioner"
	volumeBindingMode: "WaitForFirstConsumer"
}
