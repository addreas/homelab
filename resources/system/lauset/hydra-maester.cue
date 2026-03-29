package kube

import "encoding/yaml"

k: GitRepository: "hydra-maester": spec: {
	ref: branch: "master"
	url: "https://github.com/ory/hydra-maester"
}

k: Kustomization: "hydra-maester": spec: {
	sourceRef: name: "hydra-maester"
	path:            "./config/default"
	targetNamespace: "ory"
	images: [{
		name:    "controller"
		newName: "oryd/hydra-maester"
		newTag:  "\(githubReleases["ory/hydra-maester"])-amd64"
	}, {
		name:    "gcr.io/kubebuilder/kube-rbac-proxy"
		newName: "registry.k8s.io/kubebuilder/kube-rbac-proxy"
	}]
	patches: [{
		target: {
			kind: "Deployment"
		}
		patch: yaml.Marshal([{
			op:    "add"
			path:  "/spec/template/spec/containers/1/args/-"
			value: "--hydra-url=http://hydra-admin"
		}, {
			op:    "add"
			path:  "/spec/template/spec/containers/1/args/-"
			value: "--hydra-port=80"
		}])
	}]
}
