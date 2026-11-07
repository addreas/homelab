package kube

k: GrafanaDashboard: "envoy-overview": spec: grafanaCom: id: 24459

k: GrafanaDashboard: "envoy-upstream": spec: grafanaCom: id: 24457

k: GrafanaDashboard: "envoy-downstream": spec: {
	grafanaCom: id: 24458
	variables: [{
		name:  "envoy_http_conn_manager_prefix"
		value: "listener-secure"
	}]
}
