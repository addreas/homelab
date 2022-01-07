package kube

k: ServiceAccount: "hydra-maester": {}

k: ClusterRole: "hydra-maester-oauth2clients": rules: [{
	apiGroups: ["hydra.ory.sh"]
	resources: ["oauth2clients", "oauth2clients/status"]
	verbs: ["get", "list", "watch", "create", "update", "patch", "delete"]
}, {
	apiGroups: [""]
	resources: ["secrets"]
	verbs: ["list", "watch", "create"]
}]

k: ClusterRoleBinding: "hydra-maester": {
	subjects: [{
		kind:      "ServiceAccount"
		name:      "hydra-maester"
		namespace: "ory"
	}]
	roleRef: {
		apiGroup: "rbac.authorization.k8s.io"
		kind:     "ClusterRole"
		name:     "hydra-maester-oauth2clients"
	}
}

k: Role: "hydra-maester-secrets: rules: [{
	apiGroups: [""]
	resources: ["secrets"]
	verbs: ["get", "list", "watch", "create"]
}]

k: RoleBinding: "hydra-maester": {
	subjects: [{
		kind:      "ServiceAccount"
		name:      "hydra-maester"
		namespace: "ory"
	}]
	roleRef: {
		apiGroup: "rbac.authorization.k8s.io"
		kind:     "Role"
		name:     "hydra-maester-secrets"
	}
}

k: Deployment: "hydra-maester": spec: template: spec: {
	containers: [{
		name:            "hydra-maester"
		image:           "oryd/hydra-maester:v0.0.24"
		imagePullPolicy: "IfNotPresent"
		command: ["/manager"]
		args: [
			"--metrics-addr=127.0.0.1:8080",
			"--hydra-url=http://hydra-admin",
			"--hydra-port=4445",
		]
	}]
	serviceAccountName:           "hydra-maester"
	automountServiceAccountToken: true
}

