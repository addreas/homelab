package kube

k: Deployment: "akri-test": spec: template: spec: containers: [{
	resources: limits: "akri.sh/akri-udev-1b1088": 1
	name:  "akri-test"
	image: "busybox:stable"
	command: ["tail", "-f", "/dev/null"]
}]
