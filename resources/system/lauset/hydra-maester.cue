package kube

k: GitRepository: "hydra-maester": spec: {
	ref: branch: "master"
	url: "https://github.com/ory/hydra-maester"
}

k: Kustomization: "hydra-maester-crd": spec: {
	sourceRef: name: "hydra-maester"
	path: "./config/crd"
}

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

k: Role: "hydra-maester-secrets": rules: [{
	apiGroups: [""]
	resources: ["secrets"]
	verbs: ["get", "list", "watch", "create"]
}]

k: RoleBinding: "hydra-maester": {
	subjects: [{
		namespace: "ory"
	}]
	roleRef: {
		name: "hydra-maester-secrets"
	}
}

k: Deployment: "hydra-maester": spec: template: spec: {
	containers: [{
		image: "oryd/hydra-maester:\(goModVersions["github.com/ory/hydra-maester"])-amd64"
		command: ["/manager"]
		args: [
			"--metrics-addr=127.0.0.1:8080",
			"--hydra-url=http://hydra-admin",
			"--hydra-port=80",
		]
	}]
	serviceAccountName:           "hydra-maester"
	automountServiceAccountToken: true
}
