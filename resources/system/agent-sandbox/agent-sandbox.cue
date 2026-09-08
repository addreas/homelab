package kube

_namespace: "agent-sandbox-system"

k: GitRepository: "agent-sandbox": spec: {
	url: "https://github.com/kubernetes-sigs/agent-sandbox"
	ref: tag: "v1.0.0"
}

k: HelmRelease: "agent-sandbox": spec: {
	chart: spec: {
		chart: "./helm"
		sourceRef: {
			kind: "GitRepository"
			name: "agent-sandbox"
		}
	}
	values: {
		namespace: create:      false
		image: tag:             k.GitRepository["agent-sandbox"].spec.ref.tag
		controller: extensions: true
	}
}
