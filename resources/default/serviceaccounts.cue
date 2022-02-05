package kube

for user in ["xps13", "jonas", "lenny"] {
	k: ServiceAccount: "\(user)": {}
	k: ClusterRoleBinding: "\(user)-cluster-admin": {
		metadata: namespace: string
		roleRef: {
			apiGroup: "rbac.authorization.k8s.io"
			kind:     "ClusterRole"
			name:     "cluster-admin"
		}
		subjects: [{
			kind:      "ServiceAccount"
			name:      user
			namespace: metadata.namespace
		}]

	}
}
