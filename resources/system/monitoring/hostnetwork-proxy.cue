package kube

let services = {
	"kube-scheduler": {
		port: 10259
		paths: ["/metrics"]
	}
	"kube-controller-manager": {
		port: 10257
		paths: ["/metrics"]
	}
}

k: DaemonSet: "control-plane-metrics-proxy": {
	metadata: namespace: "kube-system"
	spec: template: spec: {
		hostNetwork: true
		containers: [ for n, p in services {
			name:  n
			image: "alpine/socat"
			imagePullPolicy: "IfNotPresent"
			args: ["tcp-listen:\(p.port),bind=$(IP),fork,reuseaddr", "tcp-connect:127.0.0.1:\(p.port)"]
			env: [{
				name: "IP"
				valueFrom: fieldRef: fieldPath: "status.podIP"
			}]
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
				selector: app: "control-plane-metrics-proxy"
				ports: [{
					name: "https-metrics"
					port: p.port
				}]
			}
		}
	}
}
