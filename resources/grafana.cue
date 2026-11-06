package kube

k: GrafanaDashboard: [string]: {
	metadata: namespace: string
	spec: {
		allowCrossNamespaceImport: _ | *true
		contentCacheDuration:      _ | *"24h"
	}
}

k: ["GrafanaDashboard" | "GrafanaDatasource"]: [string]: spec: {
	instanceSelector: matchExpressions: [{key: "not-default", operator: "DoesNotExist"}]
}
