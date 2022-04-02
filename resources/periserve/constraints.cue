package kube

k: [string]: [string]: metadata: {
	namespace: *"periserve" | string
}

k: GrafanaDashboard: [string]: spec: customFolderName: "periserve"
