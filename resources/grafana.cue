package kube

import "strings"

k: GrafanaDashboard: [string]: {
	metadata: namespace: string
	spec: {
		allowCrossNamespaceImport: _ | *true
		folder:                    _ | *strings.ToTitle(metadata.namespace)
		contentCacheDuration:      _ | *"24h"
	}
}

k: ["GrafanaDashboard" | "GrafanaDatasource"]: [string]: spec: {
	instanceSelector: matchExpressions: [{key: "not-default", operator: "DoesNotExist"}]
}
