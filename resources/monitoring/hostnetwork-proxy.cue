package kube

k: DaemonSet: "hostnetwork-proxy": {
	metadata: namespace: "kube-system"
	spec: template: spec: {
		hostNetwork: true
		containers: [{
			name:  "kube-scheduler"
			image: "alpine/socat"
			args: ["tcp-listen:11259,fork,reuseaddr", "tcp-connect:127.0.0.1:10259"]
		}, {
			name:  "kube-controller-manager"
			image: "alpine/socat"
			args: ["tcp-listen:11257,fork,reuseaddr", "tcp-connect:127.0.0.1:10257"]
		}]
	}
}

k: Service: "kube-scheduler": {
	metadata: {
		labels: {
			"app.kubernetes.io/name": "kube-scheduler"
			"k8s-app":                "kube-scheduler"
		}
		namespace: "kube-system"
	}
	spec: {
		selector: app: "hostnetwork-proxy"
		ports: [{
			name: "https-metrics"
			port: 11259
		}]
	}
}

k: Service: "kube-controller-manager": {
	metadata: {
		labels: {
			"app.kubernetes.io/name": "kube-controller-manager"
			"k8s-app":                "kube-controller-manager"
		}
		namespace: "kube-system"
	}
	spec: {
		selector: app: "hostnetwork-proxy"
		ports: [{
			name: "https-metrics"
			port: 11257
		}]
	}
}
