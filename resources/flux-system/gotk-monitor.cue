package kube

k: PodMonitor: "gotk-monitor": spec: {
	podMetricsEndpoints: [{
		port:     "http-prom"
		interval: "60s"
	}]
	selector: matchExpressions: [{
		key:      "app"
		operator: "In"
		values: [
			"source-controller",
			"kustomize-controller",
			"helm-controller",
			"notification-controller",
		]
	}]
}

k: RoleBinding: "prometheus-k8s": {
	roleRef: {
		apiGroup: "rbac.authorization.k8s.io"
		kind:     "Role"
		name:     "prometheus-k8s"
	}
	subjects: [{
		kind:      "ServiceAccount"
		name:      "prometheus-k8s"
		namespace: "monitoring"
	}]
}

k: Role: "prometheus-k8s": rules: [{
	apiGroups: [
		"",
	]
	resources: [
		"services",
		"endpoints",
		"pods",
	]
	verbs: [
		"get",
		"list",
		"watch",
	]
}, {
	apiGroups: [
		"extensions",
	]
	resources: [
		"ingresses",
	]
	verbs: [
		"get",
		"list",
		"watch",
	]
}]
