package kube

k: Deployment: "lauset": spec: template: spec: {
	containers: [{
		image:           "ghcr.io/jonasdahl/lauset:latest"
		imagePullPolicy: "Always"
		envFrom: [{configMapRef: name: "lauset"}, {secretRef: name: "lauset"}]
		env: [{
			name:  "LOG_LEVEL"
			value: "debug"
		}, {
			name: "COOKIE_DOMAIN"
			value: "addem.se"
		}]
		ports: [{
			name:          "http"
			containerPort: 3000
		}]
		volumeMounts: [{
			name:      "home-node"
			mountPath: "/home/node"
		}]
	} & _probes]
	volumes: [{
		name: "home-node"
		emptyDir: {}
	}]
}

k: Service: "lauset": spec: ports: [{
	port:       80
	targetPort: "http"
	name:       "http"
}]

k: ConfigMap: "lauset": data: {
	KRATOS_BROWSER_URL: "https://\(_hostname)/kratos"
	KRATOS_ADMIN_URL:   "http://kratos-admin.ory.svc.cluster.local/"
	KRATOS_PUBLIC_URL:  "http://kratos-public.ory.svc.cluster.local/"
	HYDRA_ADMIN_URL:    "http://hydra-admin.ory.svc.cluster.local/"
}

k: SealedSecret: "lauset": spec: encryptedData: COOKIE_SECRET: "AgDoKFk1Lphm2nC7EhMUrl/3xsU0zTAsezPJGncZXGKhMAt0YGPxrPwfh3r8Rs8oXSstWWVXkNi0t7dV5eVwT4DdMqji7vjYKfuLPB+ENYnDJiX2c6Cw2R/tAHAWUGE7/GY91kQXAVwUVJZAHIsK9UTyVMdPeM321n7gEkfYybCq4imnk7HXW88kXgjtD7Lef0Wj7ca8/ncnagwBARZ9+3cYu5CAoYn7qxDTmuoje31lX4qsouzkWbFvSyGBzu5PhJYHiIXPkNW4afBnWzxo+GVIOJyAPfQkZxk2YuunPTKBOcJF6CNuFs/RlnIAHRA8FhZpH47+eYWAeUIghejbJROZWhk7NpPyEwFKoAtdUzjDFihwKMDUD19kMHd2MUJWb80aByqIEmWce+9MRAFmc+MNbTz9LsNrPRn6sTfrTrqQ7fZ3VEJBTJC+aD2sfZxAx5wOWwjtXN9GdQ+BOMXzi2M6ojYwptJZSpGMVyaveMbtJPcl7CHT14ZUsUcxwe/qMAo9LyhwEiqdvveoS0A1lQxKzujZ734K1eUsCG4SWzUFRKGYHzaOMF+B+1pzVi2ROlKh67fgwP6Xp7MN81fqW2YpnJt1JJ9qp73NFnHmZwUUCIFvfumxyejFnmqvChCY7rBs75RLZGOW5m7unr1ruU6aWtdU/wouEe+cdA1iwyzToT2t8Qc5TNz9HchjcEVSQGYoAnJhMKu1wF9dz2gSvtISHLM80GoXC/PKP8D3KLNeGdnPvS/y8C8tuejxkXLSUvrDf8xgF64fuO6BKOawQGHLEw=="
