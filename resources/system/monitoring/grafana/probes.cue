package kube

import cuejson "encoding/json"

#datasource: {
	type: "prometheus"
	uid:  "${DS_PROMETHEUS}"
}

#target: {
	refId: *"A" | string
	datasource: #datasource
	expr: string
	instant?: bool
	legendFormat?: string
}

#successStat: {
	id:          1
	type:        "stat"
	title:       "Probes up"
	description: "Targets currently returning success."
	gridPos: {h: 5, w: 8, x: 0, y: 0}
	datasource:  #datasource
	targets: [#target & {expr: "count(probe_success{job=~\"$probe\"} == 1) or vector(0)", instant: true, legendFormat: "up"}]
	options: {
		colorMode:         "background"
		graphMode:         "none"
		reduceOptions: {calcs: ["lastNotNull"], fields: "", values: false}
		textMode:          "auto"
	}
	fieldConfig: defaults: {
		thresholds: {mode: "absolute", steps: [{color: "red", value: null}, {color: "yellow", value: 1}, {color: "green", value: 2}]}
		unit: "short"
	}
}

#failStat: {
	id:          2
	type:        "stat"
	title:       "Probes failing"
	description: "Targets whose last check did not succeed."
	gridPos: {h: 5, w: 8, x: 8, y: 0}
	datasource:  #datasource
	targets: [#target & {expr: "count(probe_success{job=~\"$probe\"} == 0) or vector(0)", instant: true, legendFormat: "failing"}]
	options: {
		colorMode:         "background"
		graphMode:         "none"
		reduceOptions: {calcs: ["lastNotNull"], fields: "", values: false}
		textMode:          "auto"
	}
	fieldConfig: defaults: {
		thresholds: {mode: "absolute", steps: [{color: "green", value: null}, {color: "red", value: 1}]}
		unit: "short"
	}
}

#certStat: {
	id:          3
	type:        "stat"
	title:       "TLS certificate expiry"
	description: "Days left on the certificate served on 443. Every probe target uses the same wildcard cert."
	gridPos: {h: 5, w: 8, x: 16, y: 0}
	datasource:  #datasource
	targets: [#target & {expr: "(min(probe_ssl_earliest_cert_expiry{job=~\"$probe\"}) - time()) / 86400", instant: true, legendFormat: "days"}]
	options: {
		colorMode:         "background"
		graphMode:         "none"
		reduceOptions: {calcs: ["lastNotNull"], fields: "", values: false}
		textMode:          "auto"
	}
	fieldConfig: defaults: {
		decimals:   1
		unit:       "d"
		thresholds: {mode: "absolute", steps: [{color: "red", value: null}, {color: "yellow", value: 14}, {color: "green", value: 30}]}
	}
}

// repeated once per selected value of $probe, so the rows follow the selector
#rowPanel: {
	id:        10
	type:      "row"
	title:     "$probe"
	collapsed: false
	repeat:    "probe"
	gridPos: {h: 1, w: 24, x: 0, y: 5}
	panels: []
}

#statusStat: {
	id:          11
	type:        "stat"
	title:       "Status"
	description: "probe_success for this target."
	gridPos: {h: 4, w: 3, x: 0, y: 6}
	datasource:  #datasource
	targets: [#target & {expr: "probe_success{job=~\"$probe\"}", instant: true, legendFormat: "status"}]
	options: {
		colorMode:         "background"
		graphMode:         "none"
		reduceOptions: {calcs: ["lastNotNull"], fields: "", values: false}
		textMode:          "value"
	}
	fieldConfig: defaults: {
		mappings: [{
			type: "value"
			options: {
				"0": {color: "red", index: 1, text: "DOWN"}
				"1": {color: "green", index: 0, text: "UP"}
			}
		}]
		thresholds: {mode: "absolute", steps: [{color: "green", value: null}]}
	}
}

#statusOverTime: {
	id:          12
	type:        "state-timeline"
	title:       "Status over time"
	description: "Each scrape as a band: green = success, red = failure, blank = no data."
	gridPos: {h: 4, w: 21, x: 3, y: 6}
	datasource:  #datasource
	targets: [#target & {expr: "probe_success{job=~\"$probe\"}", legendFormat: "{{job}}"}]
	fieldConfig: defaults: {
		mappings: [{
			type: "value"
			options: {
				"0": {color: "red", index: 1, text: "DOWN"}
				"1": {color: "green", index: 0, text: "UP"}
			}
		}]
		custom: {
			fillOpacity: 80
			lineWidth:   0
			spanNulls:   false
		}
		thresholds: {mode: "absolute", steps: [{color: "green", value: null}]}
	}
	options: {
		alignValue:   "center"
		mergeValues:  true
		rowHeight:    0.9
		showValue:    "auto"
		legend: {displayMode: "list", placement: "bottom", showLegend: true}
		tooltip: {mode: "single"}
	}
}

#totalStat: {
	id:          13
	type:        "stat"
	title:       "Total time"
	description: "End-to-end probe duration, including DNS, TCP, TLS and the response."
	gridPos: {h: 4, w: 3, x: 0, y: 10}
	datasource:  #datasource
	targets: [#target & {expr: "probe_duration_seconds{job=~\"$probe\"}", instant: true, legendFormat: "total"}]
	options: {
		colorMode:         "value"
		graphMode:         "none"
		reduceOptions: {calcs: ["lastNotNull"], fields: "", values: false}
		textMode:          "value"
	}
	fieldConfig: defaults: {
		decimals: 3
		unit:     "s"
	}
}

#dnsStat: {
	id:          14
	type:        "stat"
	title:       "DNS lookup"
	description: "Time spent resolving the target hostname."
	gridPos: {h: 4, w: 3, x: 0, y: 14}
	datasource:  #datasource
	targets: [#target & {expr: "probe_dns_lookup_time_seconds{job=~\"$probe\"}", instant: true, legendFormat: "dns"}]
	options: {
		colorMode:         "value"
		graphMode:         "none"
		reduceOptions: {calcs: ["lastNotNull"], fields: "", values: false}
		textMode:          "value"
	}
	fieldConfig: defaults: {
		decimals: 3
		unit:     "s"
	}
}

#phaseStack: {
	id:          15
	type:        "timeseries"
	title:       "Request phases"
	description: "Where the time goes: DNS resolve, TCP connect, TLS handshake, server processing, body transfer."
	gridPos: {h: 8, w: 21, x: 3, y: 10}
	datasource:  #datasource
	targets: [#target & {
		expr:         "probe_http_duration_seconds{job=~\"$probe\", phase=~\"resolve|connect|tls|processing|transfer\"}"
		legendFormat: "{{phase}}"
	}]
	fieldConfig: defaults: {
		custom: {
			drawStyle:         "line"
			lineInterpolation: "linear"
			lineWidth:         0
			fillOpacity:       80
			showPoints:        "never"
			spanNulls:         false
			stacking: {mode: "normal", group: "A"}
		}
		unit: "s"
	}
	options: {
		legend: {displayMode: "table", placement: "right", showLegend: true, calcs: ["lastNotNull"]}
		tooltip: {mode: "multi", sort: "desc"}
	}
}

k: GrafanaDashboard: "probes": spec: json: cuejson.Marshal(#dashboard)

#dashboard: {
	title:         "Blackbox Probes"
	description:   "Synthetic HTTP checks of published hostnames, scraped from blackbox exporter by vmagent."
	editable:      true
	graphTooltip:  1
	refresh:       "30s"
	schemaVersion: 39
	tags: ["blackbox", "probes", "gateway", "http"]
	time: {from: "now-6h", to: "now"}
	timepicker: refresh_intervals: ["10s", "30s", "1m", "5m", "15m", "30m", "1h"]
	timezone: "browser"

	templating: list: [{
		current: {selected: false, text: "prometheus", value: "prometheus"}
		hide:    0
		label:   "Data source"
		name:    "DS_PROMETHEUS"
		query:   "prometheus"
		refresh: 1
		regex:   ""
		type:    "datasource"
	}, {
		allValue: ".*"
		current: {selected: true, text: ["All"], value: ["$__all"]}
		datasource: #datasource
		definition: "probe_success"
		hide:       0
		includeAll: true
		label:      "Probes"
		multi:      true
		name:       "probe"
		query: {
			query: "label_values(probe_success, job)"
			refId: "StandardVariableQuery"
		}
		refresh: 2
		sort:    1
		type:    "query"
	}]

	panels: [#successStat, #failStat, #certStat, #rowPanel, #statusStat, #statusOverTime, #totalStat, #dnsStat, #phaseStack]

	annotations: list: [{
		builtIn:    1
		datasource: {type: "grafana", uid: "-- Grafana --"}
		enable:     true
		hide:       true
		iconColor:  "rgba(0, 211, 255, 1)"
		name:       "Annotations & Alerts"
		type:       "dashboard"
	}]
}
