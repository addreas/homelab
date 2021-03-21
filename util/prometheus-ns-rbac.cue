package util

prometheusNamespaceRBAC: {
	RoleBinding: "prometheus-k8s": {
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

	Role: "prometheus-k8s": rules: [{
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
}
