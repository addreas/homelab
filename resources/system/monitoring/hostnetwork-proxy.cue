package kube

let services = {
    kubelet: {
        from: 10250
        to: 11250
    }
    "kube-scheduler": {
        from: 10259
        to: 11259
    }
    "kube-controller-manager": {
        from: 10257
        to: 11257
    }
}

k: DaemonSet: "hostnetwork-proxy": {
	metadata: namespace: "kube-system"
	spec: template: spec: {
		hostNetwork: true
        containers: [ for n, p in services {
			name:  n
			image: "alpine/socat"
			args: ["tcp-listen:\(p.to),fork,reuseaddr", "tcp-connect:127.0.0.1:\(p.from)"]
        }]
	}
}

k: Service: {
    for name, p in services {
        "\(name)": {
            metadata: {
                labels: {
                    "app.kubernetes.io/name": name
                    "k8s-app":                name
                }
                namespace: "kube-system"
            }
            spec: {
                selector: app: "hostnetwork-proxy"
                ports: [{
                    name: "https-metrics"
                    port: p.to
                }]
            }

        }
    }
}
