package kube

k: VMAuth: unified: spec: unauthorizedAccessConfig: [{
	src_paths: [
		"/api/v1/rules.*",
		"/api/v1/alerts.*",
		"/rules/.*",
	]
	url_prefix: ["http://vmalert-metrics.monitoring.svc:8080"]
}, {
	src_paths: [".*"]
	url_prefix: ["http://vmsingle-metrics.monitoring.svc:8429"]
}]
