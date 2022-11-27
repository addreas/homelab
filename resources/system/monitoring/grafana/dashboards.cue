package kube

let DS_PROMETHEUS = {
	datasourceName: "Prometheus"
	inputName:      "DS_PROMETHEUS"
}

let grafanaComDsPrometheus = {
	// https://github.com/dotdc/grafana-dashboards-kubernetes
	"k8s-system-api-server": 15761
	"k8s-views-global":      15757
	"k8s-views-namespaces":  15758
	"k8s-views-nodes":       15759
	"k8s-views-pods":        15760
}

for name, grafanaComId in grafanaComDsPrometheus {
	k: GrafanaDashboard: (name): spec: {
		grafanaCom: id: grafanaComId
		datasources: [DS_PROMETHEUS]
	}
}
