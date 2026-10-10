package kube

k: GrafanaDatasource: prometheus: spec: {
	instanceSelector: {}
	datasource: {
		name:      "prometheus"
		type:      "prometheus"
		url:       "http://vmsingle-metrics.monitoring.svc.cluster.local:8429"
		access:    "proxy"
		isDefault: true
		basicAuth: false
		jsonData: {
			manageAlerts:   true
			prometheusType: "Prometheus"
		}
	}
}

k: GrafanaDatasource: victorialogs: spec: {
	instanceSelector: {}
	datasource: {
		name:      "victorialogs"
		type:      "victorialogs"
		url:       "http://vlsingle-logs.monitoring.svc.cluster.local:9428"
		access:    "proxy"
		isDefault: false
		basicAuth: false
	}
}

let DS_PROMETHEUS = {
	datasourceName: "prometheus"
	inputName:      "DS_PROMETHEUS"
}

let grafanaComDsPrometheus = {
	"k8s-system-api-server": 15761
	"k8s-views-global":      15757
	"k8s-views-namespaces":  15758
	"k8s-views-nodes":       15759
	"k8s-views-pods":        15760
}

for name, grafanaComId in grafanaComDsPrometheus {
	k: GrafanaDashboard: (name): spec: {
		grafanaCom: id: grafanaComId
		instanceSelector: {}
		datasources: [DS_PROMETHEUS]
	}
}
