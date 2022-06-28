package kube

k: Deployment: "skipper-ingress": spec: {
	replicas: 2
	template: spec: {
		priorityClassName:  "system-cluster-critical"
		serviceAccountName: "skipper-ingress"
		containers: [{
			image: "registry.opensource.zalan.do/teapot/skipper:v0.13.179"
			ports: [{
				name:          "http"
				containerPort: 9999
			}, {
				name:          "metrics"
				containerPort: 9911
			}]
			args: [
				"skipper",
				"-kubernetes",
				"-kubernetes-in-cluster",
				"-kubernetes-path-mode=path-prefix",
				"-kubernetes-ingress-v1",
				"-address=:9999",
				"-wait-first-route-load",
				"-proxy-preserve-host",
				"-serve-host-metrics",
				"-disable-metrics-compat",
				"-enable-profile",
				"-enable-ratelimits",
				"-experimental-upgrade",
				"-metrics-exp-decay-sample",
				"-reverse-source-predicate",
				"-lb-healthcheck-interval=3s",
				"-metrics-flavour=prometheus",
				"-enable-connection-metrics",
				"-max-audit-body=0",
				"-histogram-metric-buckets=.0001,.00025,.0005,.00075,.001,.0025,.005,.0075,.01,.025,.05,.075,.1,.2,.3,.4,.5,.75,1,2,3,4,5,7,10,15,20,30,60,120,300,600",
				"-expect-continue-timeout-backend=30s",
				"-keepalive-backend=30s",
				"-max-idle-connection-backend=0",
				"-response-header-timeout-backend=1m",
				"-timeout-backend=1m",
				"-tls-timeout-backend=1m",
				"-close-idle-conns-period=20s",
				"-idle-timeout-server=62s",
				"-read-timeout-server=5m",
				"-write-timeout-server=60s",
				"-default-filters-prepend=enableAccessLog(4,5) -> lifo(2000,20000,\"3s\")",
			]
			readinessProbe: {
				httpGet: {
					path: "/kube-system/healthz"
					port: 9999
				}
				initialDelaySeconds: 60
				timeoutSeconds:      5
			}
		}]
	}
}

k: Service: "skipper-ingress": {
}

k: VMServiceScrape: "skipper-ingress": spec: endpoints: [{
	port: "metrics"
}]

k: ServiceAccount: "skipper-ingress": {}

k: ClusterRole: "skipper-ingress": rules: [{
	apiGroups: ["networking.k8s.io"]
	resources: ["ingresses"]
	verbs: ["get", "list"]
}, {
	apiGroups: [""]
	resources: [
		"namespaces",
		"services",
		"endpoints",
		"pods",
	]
	verbs: ["get", "list"]
}, {
	apiGroups: ["zalando.org"]
	resources: ["routegroups"]
	verbs: ["get", "list"]
}]

k: ClusterRoleBinding: "skipper-ingress": {
	roleRef: {
		apiGroup: "rbac.authorization.k8s.io"
		kind:     "ClusterRole"
		name:     "skipper-ingress"
	}
	subjects: [{
		kind:      "ServiceAccount"
		name:      "skipper-ingress"
		namespace: "ingress"
	}]
}
