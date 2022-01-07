package kube

k: Builder: "nh-builder": spec: {
	tag:            "ghcr.io/addreas/nh-builder"
	serviceAccount: "default"
	stack: {
		name: "full-cnb"
		kind: "ClusterStack"
	}
	store: {
		name: "default"
		kind: "ClusterStore"
	}
	order: [{
		group: [{
			id:      "addreas/fwup-bin"
			version: "0.0.1"
		}, {
			id:      "paketo-buildpacks/node-engine"
			version: "0.8.0"
		}, {
			id:      "paketo-buildpacks/npm-install"
			version: "0.4.0"
		}, {
			id:      "addreas/elixir-app"
			version: "0.0.8"
		}]
	}, {
		group: [{
			id:      "addreas/fwup-bin"
			version: "0.0.1"
		}, {
			id:      "addreas/elixir-app"
			version: "0.0.8"
		}]
	}]
}

k: SealedSecret: "registry-credentials": spec: {
	template: type:                     "kubernetes.io/dockerconfigjson"
	encryptedData: ".dockerconfigjson": "AgA6+QrJtu450V8c9lA9TDjoXZCrsZrq3NvescD0pzF46dibQ+fgwpoBopgzuUEBlvm2/3Kvs0bh1+xT1M1HxoiD2hD/0LspuXqPCGrA66Y6dWtTF0MqYkXvXeVCWS9AAdsxZas4yHA/fRVI6iH8AgHNh7SQT3aUjmrQ6+qdz7cdNVFB//hW1m3pu7rsLAe1R6xkVAhQfjS+QcHbddWrJEqOk79jPLO7UHudOu01N4d1XnjEpyt2HnKxFpFLa10/7Ai+39+z/FLOx0+/jwokfacmj9OzJ8nUpUtJsL90OfXDtXVrRY/a41z4uP5/uYYpcWASYNhOB6uSD6yYOZEQszuxeCa6cs90v2lCzGJF+wW9mn59RpsjnVINd0msKpzRBYGUnU6PQmkT8WwFKxu1LtDe/OMEYiOietq24bbNuNrllf27SFD9RcQacm6oiuhnq/ICueK2F/9O1WKSt9VUxItiAHzMilgzyHj8GH0zoRM9GsuGte4tmTCqB0Az/WoQhg4COlrPCjFcLwZMcj+FwY+c5n58anTpPUJN221Xb/Zg04vXFqoIt7zy/CVFluM//XWbecU6exXPerOn0UfzJRMo8z22TGdcc2elwjSBNJxTWimLCJDqcHrt2Y1+s9i7mGihIkjBmKG+Byxr2/2V6g/xvqpbufawSCP7VJlNDfZnuT2M6v+9uLHuBwUOJYWBGKs2tbMVtPZbkaZvWqsCtXLM86WnpVyv+Ti4fHSCRZo4xG6IVTrLqvS8ynDQPtLftE/doAohVIJvM7YpYrcjU7mDbqyf0SlSMYVUjcrhCkp67vACHgPwViBqUsv451g6iyKMnIR4MDQ5E+T22ETXpuoRVNuMCAKPlXDLdySkn3i3/O8yhgLFSZiwYfZbnNTOWEZiTC8V0LkQd84rAPpF6eDGUJvWiVBrYAjqRKzhTjwHewE="
}
