package kube

import "encoding/yaml"

k: GitRepository: "hydra-maester": spec: {
	ref: branch: "master"
	url: "https://github.com/ory/hydra-maester"
}

k: Kustomization: "hydra-maester-crd": spec: {
	sourceRef: name: "hydra-maester"
	path: "./config/default"
	images: [{
		name:    "controller"
		newName: "oryd/hydra-maester"
		newTag:  "\(githubReleases["ory/hydra-maester"])-amd64"
	}]
	patches: [{
		target: {
			kind: "Deployment"
		}
		patch: yaml.Marshal([{
			op:    "replace"
			path:  "/spec/template/spec/containers/0/args/1"
			value: "--hydra-url=http://hydra-admin"
		}])
	}]
}
