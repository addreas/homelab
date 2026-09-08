@extern(embed)
package kube

k: ConfigMap: "pi-sandbox-dockerfile": data: {
	"Dockerfile.pi": _ @embed(file="Dockerfile.pi", type=text)
}

k: Job: "build-pi-sandbox": spec: template: spec: {
	automountServiceAccountToken: false
	containers: [{
		image: "\(_images.buildkit)-rootless"
		command: ["buildctl"]
		env: [{
			name:  "DOCKER_CONFIG"
			value: "/home/user/.docker"
		}]
		args: [
			"--addr",
			"tcp://buildkitd.buildkitd-system.svc:1234",
			"build",
			"--frontend",
			"dockerfile.v0",
			"--opt",
			"filename=Dockerfile.pi",
			"--local",
			"context=/workspace",
			"--local",
			"dockerfile=/workspace",
			"--output",
			"type=image,name=ghcr.io/addreas/pi-sandbox:latest,push=true",
		]
		volumeMounts: [{
			name:      "dockerfile"
			mountPath: "/workspace"
			readOnly:  true
		}, {
			name:      "registry-auth"
			mountPath: "/home/user/.docker"
			readOnly:  true
		}]
	}]
	volumes: [{
		name: "dockerfile"
		configMap: name: "pi-sandbox-dockerfile"
	}, {
		name: "registry-auth"
		secret: {
			secretName: "pi-sandbox-registry-auth"
			items: [{
				key:  ".dockerconfigjson"
				path: "config.json"
			}]
		}
	}]
}
