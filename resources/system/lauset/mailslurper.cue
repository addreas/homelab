package kube

k: Deployment: mailslurper: spec: template: spec: containers: [{
	name:  "mailslurper"
	image: "oryd/mailslurper:latest-smtps"
	ports: [{containerPort: 4436}, {containerPort: 4437}, {containerPort: 1025}]
	securityContext: runAsUser: 0
}]

k: Service: mailslurper: spec: ports: [{
	name: "http"
	port: 4436
}, {
	name: "http-api"
	port: 4437
}, {
	name: "smtp"
	port: 1025
}]
