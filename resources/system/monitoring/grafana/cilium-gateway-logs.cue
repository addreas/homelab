package kube

import cuejson "encoding/json"

// VictoriaLogs datasource, picked by the dashboard's datasource variable
#datasource: {
	type: "victoriametrics-logs-datasource"
	uid:  "${DS_VICTORIALOGS}"
}

// gateway access logs; every panel narrows this down by the dashboard variables
#filter: #"kubernetes.container_name:cilium-envoy response_code:* gateway:~"${gateway:pipe}" authority:~"${authority:pipe}""#

// readable line for the log panels (the records themselves carry no _msg)
#msg: #"| format "<response_code> <method> <path> <authority> <duration>ms upstream=<upstream_host> downstream=<x_forwarded_for> flags=<response_flags>" as _msg"#

#target: {
	refId:      "A"
	datasource: #datasource
	expr:       string
	queryType:  "stats" | "statsRange" | "instant"

	legendFormat?: string
	maxLines?:     int
}

#step: {
	color: string
	value: null | number
}

#stat: {
	type:       "stat"
	datasource: #datasource
	fieldConfig: {
		defaults: {
			color: {mode: "thresholds"}
			thresholds: {mode: "absolute", steps: [...#step]}
			...
		}
		...
	}
	options: {
		colorMode:   "value"
		graphMode:   "none"
		justifyMode: "auto"
		orientation: "auto"
		reduceOptions: {calcs: ["lastNotNull"], fields: "", values: false}
		textMode:   "auto"
		wideLayout: true
	}
	targets: [#target]

	...
}

#timeseriesBase: {
	type:       "timeseries"
	datasource: #datasource
	fieldConfig: {
		defaults: {
			color: {mode: "palette-classic"}
			custom: {
				axisPlacement: "auto"
				lineWidth:     1
				showPoints:    "never"
				spanNulls:     true
				...
			}
			...
		}
		...
	}
	options: {
		legend: {calcs: ["mean", "max", "last"], displayMode: "table", placement: "bottom", showLegend: true}
		tooltip: {mode: "multi", sort: "desc"}
	}
	targets: [#target]

	...
}

#timeseries: #timeseriesBase & {fieldConfig: defaults: custom: {drawStyle: "line", fillOpacity: 8}}

// stacked area
#stacked: #timeseries & {fieldConfig: defaults: custom: stacking: {mode: "normal", group: "A"}}

// stacked bars, for per-flag breakdowns
#bars: #timeseriesBase & {fieldConfig: defaults: custom: {
	drawStyle:   "bars"
	fillOpacity: 80
	stacking: {mode: "normal", group: "A"}
}}

#bargauge: {
	type:       "bargauge"
	datasource: #datasource
	fieldConfig: {
		defaults: {
			color: {mode: "continuous-GrYlRd"}
			thresholds: {mode: "absolute", steps: [{color: "green", value: null}]}
			unit: "short"
			...
		}
		...
	}
	options: {
		displayMode: "gradient"
		legend: {displayMode: "list", placement: "bottom", showLegend: false}
		maxVizHeight:  300
		minVizHeight:  16
		namePlacement: "auto"
		orientation:   "horizontal"
		reduceOptions: {calcs: ["lastNotNull"], fields: "", values: false}
		showUnfilled: true
		sizing:       "auto"
		valueMode:    "color"
	}
	targets: [#target]

	...
}

#logs: {
	type:       "logs"
	datasource: #datasource
	options: {
		deduplicate:             false
		enableInfiniteScrolling: false
		enableLogDetails:        true
		prettifyLogMessage:      false
		showCommonLabels:        false
		showLabels:              false
		showTime:                true
		sortOrder:               "Descending"
		wrapLogMessage:          true
	}
	targets: [#target]

	...
}

#table: {
	type:       "table"
	datasource: #datasource
	fieldConfig: {
		defaults: {
			custom: {
				align: "auto"
				cellOptions: {type: "auto"}
				filterable: true
			}
			thresholds: {mode: "absolute", steps: [{color: "green", value: null}]}
			...
		}
		...
	}
	options: {
		cellHeight: "sm"
		footer: {countRows: false, fields: "", reducer: ["sum"], show: false}
		showHeader: true
	}
	targets: [#target]

	...
}

k: GrafanaDashboard: "cilium-gateway-logs": spec: {
	instanceSelector: {}

	// access logs of the cilium-envoy gateway from VictoriaLogs
	json: cuejson.Marshal(#dashboard)
}

#dashboard: {
	panels: [
		{
			#stat & {
				id:          1
				title:       "Requests"
				description: "Access-log entries from cilium-envoy within the selected time range."
				gridPos: {h: 5, w: 4, x: 0, y: 0}
				targets: [#target & {expr: #"\#(#filter) | stats count() as requests"#, queryType: "stats"}]
				fieldConfig: {defaults: {thresholds: {steps: [{color: "green", value: null}]}, unit: "short"}}
			}
		},
		{
			#stat & {
				id:          2
				title:       "5xx error rate"
				description: "Share of responses with a 5xx status code."
				gridPos: {h: 5, w: 4, x: 4, y: 0}
				targets: [#target & {expr: #"\#(#filter) | stats count() as total, count() if (response_code:~"5..") as err | math err/total*100 as err_pct | fields err_pct"#, queryType: "stats"}]
				fieldConfig: defaults: {
					decimals: 2
					thresholds: {
						steps: [{color: "green", value: null}, {color: "orange", value: 1}, {color: "red", value: 5}]
					}
					unit: "percent"
				}
			}
		},
		{
			#stat & {
				id:          3
				title:       "4xx responses"
				description: "Responses with a 4xx status code (client errors, auth redirects excluded)."
				gridPos: {h: 5, w: 4, x: 8, y: 0}
				targets: [#target & {expr: #"\#(#filter) | stats count() if (response_code:~"4..") as n4xx"#, queryType: "stats"}]
				fieldConfig: {defaults: {thresholds: {steps: [{color: "green", value: null}]}, unit: "short"}}
			}
		},
		{
			#stat & {
				id:          4
				title:       "p95 latency"
				description: "95th percentile of the envoy request duration (%DURATION%, milliseconds)."
				gridPos: {h: 5, w: 4, x: 12, y: 0}
				targets: [#target & {expr: #"\#(#filter) | stats quantile(0.95, duration) as p95"#, queryType: "stats"}]
				fieldConfig: defaults: {
					links: [
						{
							targetBlank: false
							title:       "Requests slower than 1s"
							url:         "/explore?schemaVersion=1&panes={%22a%22%3A{%22datasource%22%3A%22${DS_VICTORIALOGS}%22%2C%22queries%22%3A%5B{%22refId%22%3A%22A%22%2C%22expr%22%3A%22kubernetes.container_name%3Acilium-envoy%20response_code%3A%2A%20NOT%20duration%3A%3C1000%20%7C%20sort%20by%20%28duration%20desc%29%20%7C%20format%20%5C%22%3Cresponse_code%3E%20%3Cmethod%3E%20%3Cpath%3E%20%3Cauthority%3E%20%3Cduration%3Ems%20upstream%3D%3Cupstream_host%3E%20downstream%3D%3Cx_forwarded_for%3E%20flags%3D%3Cresponse_flags%3E%5C%22%20as%20_msg%22%2C%22queryType%22%3A%22instant%22%2C%22datasource%22%3A{%22type%22%3A%22victoriametrics-logs-datasource%22%2C%22uid%22%3A%22${DS_VICTORIALOGS}%22}}%5D%2C%22range%22%3A{%22from%22%3A%22${__from}%22%2C%22to%22%3A%22${__to}%22}}}"
						},
					]
					thresholds: {
						steps: [{color: "green", value: null}, {color: "orange", value: 500}, {color: "red", value: 2000}]
					}
					unit: "ms"
				}
			}
		},
		{
			#stat & {
				id:          5
				title:       "Flagged requests"
				description: #"Requests where envoy set any response flag other than "-": upstream connection failures/timeouts (UF/UH/UC/UR/URX/NC…), ext_authz denials (UAEX), no route (NR), downstream resets (DC). Per-flag breakdown is in "Response flags over time"."#
				gridPos: {h: 5, w: 4, x: 16, y: 0}
				targets: [#target & {expr: #"\#(#filter) | stats count() if (NOT response_flags:"-") as flagged"#, queryType: "stats"}]
				fieldConfig: defaults: {
					links: [
						{
							targetBlank: false
							title:       "Requests with a response flag"
							url:         "/explore?schemaVersion=1&panes={%22a%22%3A{%22datasource%22%3A%22${DS_VICTORIALOGS}%22%2C%22queries%22%3A%5B{%22refId%22%3A%22A%22%2C%22expr%22%3A%22kubernetes.container_name%3Acilium-envoy%20response_code%3A%2A%20NOT%20response_flags%3A%5C%22-%5C%22%20%7C%20format%20%5C%22%3Cresponse_code%3E%20%3Cmethod%3E%20%3Cpath%3E%20%3Cauthority%3E%20%3Cduration%3Ems%20upstream%3D%3Cupstream_host%3E%20downstream%3D%3Cx_forwarded_for%3E%20flags%3D%3Cresponse_flags%3E%5C%22%20as%20_msg%22%2C%22queryType%22%3A%22instant%22%2C%22datasource%22%3A{%22type%22%3A%22victoriametrics-logs-datasource%22%2C%22uid%22%3A%22${DS_VICTORIALOGS}%22}}%5D%2C%22range%22%3A{%22from%22%3A%22${__from}%22%2C%22to%22%3A%22${__to}%22}}}"
						},
					]
					thresholds: {
						steps: [{color: "green", value: null}, {color: "orange", value: 1}, {color: "red", value: 1000}]
					}
					unit: "short"
				}
			}
		},
		{
			#stat & {
				id:          6
				title:       "Bytes sent"
				description: "Total response bytes written by cilium-envoy."
				gridPos: {h: 5, w: 4, x: 20, y: 0}
				targets: [#target & {expr: #"\#(#filter) | stats sum(bytes_sent) as sent"#, queryType: "stats"}]
				fieldConfig: {defaults: {thresholds: {steps: [{color: "green", value: null}]}, unit: "bytes"}}
			}
		},
		{
			#stacked & {
				id:          7
				title:       "Requests by status class"
				description: "Requests per interval bucketed by response code class."
				gridPos: {h: 8, w: 12, x: 0, y: 5}
				targets: [#target & {expr: #"\#(#filter) | stats by (_time:$__interval) count() if (response_code:~"2..") as s2xx, count() if (response_code:~"3..") as s3xx, count() if (response_code:~"4..") as s4xx, count() if (response_code:~"5..") as s5xx | sort by (_time)"#, queryType: "statsRange"}]
				fieldConfig: {
					overrides: [
						{matcher: {id: "byName", options: "s2xx"}, properties: [{id: "displayName", value: "2xx"}]},
						{matcher: {id: "byName", options: "s3xx"}, properties: [{id: "displayName", value: "3xx"}]},
						{matcher: {id: "byName", options: "s4xx"}, properties: [{id: "displayName", value: "4xx"}]},
						{matcher: {id: "byName", options: "s5xx"}, properties: [{id: "displayName", value: "5xx"}]},
					]
				}
			}
		},
		{
			#timeseries & {
				id:          8
				title:       "Latency percentiles"
				description: "Envoy request duration percentiles (milliseconds)."
				gridPos: {h: 8, w: 12, x: 12, y: 5}
				targets: [#target & {expr: #"\#(#filter) | stats by (_time:$__interval) quantile(0.50, duration) as p50, quantile(0.95, duration) as p95, quantile(0.99, duration) as p99 | sort by (_time)"#, queryType: "statsRange"}]
				fieldConfig: {defaults: {unit: "ms"}}
			}
		},
		{
			#stacked & {
				id:          9
				title:       "Requests by host"
				description: "Request volume per Host/authority (top series by volume in the legend)."
				gridPos: {h: 8, w: 12, x: 0, y: 13}
				targets: [#target & {expr: #"\#(#filter) | stats by (_time:$__interval, authority) count() as hits | sort by (_time)"#, queryType: "statsRange", legendFormat: "{{authority}}"}]
			}
		},
		{
			#bars & {
				id:          10
				title:       "Response flags over time"
				description: "Non-empty envoy response flags: UAEX = denied by ext_authz, NR = no route, DC = downstream closed, UC = upstream closed, UF = upstream connect failure, UH = no healthy upstream, SI = stream idle timeout."
				gridPos: {h: 8, w: 12, x: 12, y: 13}
				targets: [#target & {expr: #"\#(#filter) NOT response_flags:"-" | stats by (_time:$__interval, response_flags) count() as hits | sort by (_time)"#, queryType: "statsRange", legendFormat: "{{response_flags}}"}]
			}
		},
		{
			#timeseries & {
				id:          11
				title:       "Traffic volume"
				description: "Bytes proxied by cilium-envoy per interval (request bodies vs response bodies)."
				gridPos: {h: 8, w: 24, x: 0, y: 21}
				targets: [#target & {expr: #"\#(#filter) | stats by (_time:$__interval) sum(bytes_received) as received, sum(bytes_sent) as sent | sort by (_time)"#, queryType: "statsRange"}]
				fieldConfig: {defaults: {unit: "bytes"}}
			}
		},
		{
			#bargauge & {
				id:          12
				title:       "Top hosts by requests"
				description: ""
				gridPos: {h: 9, w: 8, x: 0, y: 29}
				targets: [#target & {expr: #"\#(#filter) | stats by (authority) count() as requests | sort by (requests desc) | limit 15"#, queryType: "stats", legendFormat: "{{authority}}"}]
			}
		},
		{
			#bargauge & {
				id:          13
				title:       "Status code distribution"
				description: ""
				gridPos: {h: 9, w: 8, x: 8, y: 29}
				targets: [#target & {expr: #"\#(#filter) | stats by (response_code) count() as hits | sort by (hits desc) | limit 15"#, queryType: "stats", legendFormat: "{{response_code}}"}]
			}
		},
		{
			#bargauge & {
				id:          14
				title:       "Top error paths (4xx/5xx)"
				description: "Paths returning client or server errors, ranked by error count."
				gridPos: {h: 9, w: 8, x: 16, y: 29}
				targets: [#target & {expr: #"\#(#filter) | stats by (authority, path) count() if (response_code:~"[45]..") as errors | filter errors:>0 | sort by (errors desc) | limit 15"#, queryType: "stats", legendFormat: "{{authority}} {{path}}"}]
			}
		},
		{
			#logs & {
				id:          15
				title:       "Access log"
				description: "One line per gateway request: status, method, path, host, duration (ms), upstream host, downstream client (X-Forwarded-For) and envoy response flags. All record fields stay available in the log details pane."
				gridPos: {h: 11, w: 24, x: 0, y: 81}
				targets: [#target & {expr: #"\#(#filter) \#(#msg)"#, queryType: "instant", maxLines: 500}]
			}
		},
		{
			#logs & {
				id:          16
				title:       "Errors and blocked requests"
				description: "Requests that failed (5xx) or carried a non-empty envoy response flag (auth denials, upstream failures, no route). Same line format as the access log."
				gridPos: {h: 11, w: 24, x: 0, y: 92}
				targets: [#target & {expr: #"\#(#filter) (response_code:~"5.." OR NOT response_flags:"-") \#(#msg)"#, queryType: "instant", maxLines: 500}]
			}
		},
		{
			#timeseries & {
				id:          17
				title:       "Latency: gateway vs upstream"
				description: "p95 of the full envoy request duration vs p95 of the upstream service time (time until the backend returned response headers — for streamed responses the body time is not included). The gap is gateway/auth-proxy and transfer overhead."
				gridPos: {h: 8, w: 12, x: 0, y: 38}
				targets: [#target & {expr: #"\#(#filter) | stats by (_time:$__interval) quantile(0.95, duration) as p95, quantile(0.95, upstream_service_time) as upstream_p95 | sort by (_time)"#, queryType: "statsRange"}]
				fieldConfig: {
					defaults: {unit: "ms"}
					overrides: [
						{matcher: {id: "byName", options: "p95"}, properties: [{id: "displayName", value: "total"}]},
						{
							matcher: {id: "byName", options: "upstream_p95"}
							properties: [{id: "displayName", value: "upstream"}]
						},
					]
				}
			}
		},
		{
			#bargauge & {
				id:          18
				title:       "Top clients (X-Forwarded-For)"
				description: "Originating client address from X-Forwarded-For. Only logged since the access-log format was extended, so it is empty for older time ranges."
				gridPos: {h: 8, w: 12, x: 12, y: 38}
				targets: [#target & {expr: #"\#(#filter) x_forwarded_for:* | stats by (x_forwarded_for) count() as requests | sort by (requests desc) | limit 15"#, queryType: "stats", legendFormat: "{{x_forwarded_for}}"}]
			}
		},
		{
			#table & {
				id:          19
				title:       "Stats per client IP (X-Forwarded-For)"
				description: "One row per originating client address, aggregated over the selected range. Only records written after the access-log format gained x_forwarded_for are included."
				gridPos: {h: 10, w: 24, x: 0, y: 46}
				targets: [#target & {expr: #"\#(#filter) x_forwarded_for:* | stats by (x_forwarded_for) count() as requests, count() if (response_code:~"4..") as err4xx, count() if (response_code:~"5..") as err5xx, count() if (NOT response_flags:"-") as flagged, quantile(0.95, duration) as p95_ms, sum(bytes_sent) as bytes_sent, max(_time) as last_seen | sort by (requests desc) | limit 25"#, queryType: "instant", maxLines: 100}]
				fieldConfig: {
					overrides: [
						{
							matcher: {id: "byName", options: "x_forwarded_for"}
							properties: [{id: "custom.width", value: 180}, {id: "displayName", value: "client (xff)"}]
						},
						{
							matcher: {id: "byName", options: "err5xx"}
							properties: [
								{id: "custom.cellOptions", value: {type: "color-text"}},
								{
									id: "thresholds"
									value: {mode: "absolute", steps: [{color: "green", value: null}, {color: "red", value: 1}]}
								},
							]
						},
						{
							matcher: {id: "byName", options: "err4xx"}
							properties: [
								{id: "custom.cellOptions", value: {type: "color-text"}},
								{
									id: "thresholds"
									value: {mode: "absolute", steps: [{color: "green", value: null}, {color: "orange", value: 1}]}
								},
							]
						},
						{
							matcher: {id: "byName", options: "flagged"}
							properties: [
								{id: "custom.cellOptions", value: {type: "color-text"}},
								{
									id: "thresholds"
									value: {mode: "absolute", steps: [{color: "green", value: null}, {color: "red", value: 1}]}
								},
							]
						},
						{
							matcher: {id: "byName", options: "p95_ms"}
							properties: [{id: "decimals", value: 0}, {id: "unit", value: "ms"}]
						},
						{matcher: {id: "byName", options: "bytes_sent"}, properties: [{id: "unit", value: "bytes"}]},
					]
				}
				transformations: [
					{id: "extractFields", options: {format: "json", replace: true, source: "labels"}},
					{
						id: "convertFieldType"
						options: {
							conversions: [
								{destinationType: "number", targetField: "requests"},
								{destinationType: "number", targetField: "err4xx"},
								{destinationType: "number", targetField: "err5xx"},
								{destinationType: "number", targetField: "flagged"},
								{destinationType: "number", targetField: "p95_ms"},
								{destinationType: "number", targetField: "bytes_sent"},
							]
						}
					},
					{
						id: "organize"
						options: {excludeByName: {Line: true, Time: true, id: true, streamId: true, streams: true}}
					},
				]
			}
		},
		{
			#stacked & {
				id:          20
				title:       "Requests by client IP"
				description: "Request volume per originating client address (X-Forwarded-For)."
				gridPos: {h: 8, w: 12, x: 0, y: 56}
				targets: [#target & {expr: #"\#(#filter) x_forwarded_for:* | stats by (_time:$__interval, x_forwarded_for) count() as hits | sort by (_time)"#, queryType: "statsRange", legendFormat: "{{x_forwarded_for}}"}]
			}
		},
		{
			#bargauge & {
				id:          21
				title:       "Top clients by errors"
				description: "Client addresses with 4xx/5xx responses or upstream failures, ranked by error count."
				gridPos: {h: 8, w: 12, x: 12, y: 56}
				targets: [#target & {expr: #"\#(#filter) x_forwarded_for:* | stats by (x_forwarded_for) count() if (response_code:~"[45].." OR NOT response_flags:"-") as errors | filter errors:>0 | sort by (errors desc) | limit 15"#, queryType: "stats", legendFormat: "{{x_forwarded_for}}"}]
			}
		},
		{
			#stacked & {
				id:          22
				title:       "Response time bands"
				description: "Requests per interval grouped by how long the client waited: <200ms, 200ms-1s, 1s-5s, >5s."
				gridPos: {h: 8, w: 12, x: 0, y: 64}
				targets: [#target & {expr: #"\#(#filter) | stats by (_time:$__interval) count() if (duration:<200) as fast, count() if (duration:range(200,1000)) as ok, count() if (duration:range(1000,5000)) as slow, count() if (duration:>5000) as very_slow | sort by (_time)"#, queryType: "statsRange"}]
				fieldConfig: {
					overrides: [
						{
							matcher: {id: "byName", options: "fast"}
							properties: [
								{id: "displayName", value: "<200ms"},
								{id: "color", value: {fixedColor: "green", mode: "fixed"}},
							]
						},
						{
							matcher: {id: "byName", options: "ok"}
							properties: [
								{id: "displayName", value: "200ms-1s"},
								{id: "color", value: {fixedColor: "yellow", mode: "fixed"}},
							]
						},
						{
							matcher: {id: "byName", options: "slow"}
							properties: [
								{id: "displayName", value: "1s-5s"},
								{id: "color", value: {fixedColor: "orange", mode: "fixed"}},
							]
						},
						{
							matcher: {id: "byName", options: "very_slow"}
							properties: [
								{id: "displayName", value: ">5s"},
								{id: "color", value: {fixedColor: "red", mode: "fixed"}},
							]
						},
					]
				}
			}
		},
		{
			#logs & {
				id:          23
				title:       "Slowest requests"
				description: "The 50 slowest requests in the selected range, longest first."
				gridPos: {h: 8, w: 12, x: 12, y: 64}
				targets: [#target & {expr: #"\#(#filter) | sort by (duration desc) | limit 50 \#(#msg)"#, queryType: "instant", maxLines: 50}]
			}
		},
		{
			#table & {
				id:          24
				title:       "Stats per upstream service"
				description: "One row per Envoy upstream cluster behind the gateway (namespace/service:port)."
				gridPos: {h: 9, w: 12, x: 0, y: 72}
				targets: [#target & {expr: #"\#(#filter) upstream_cluster:* | stats by (upstream_cluster) count() as requests, count() if (response_code:~"5..") as err5xx, count() if (NOT response_flags:"-") as flagged, quantile(0.95, duration) as p95_ms, sum(bytes_sent) as bytes_sent | sort by (requests desc) | limit 25"#, queryType: "instant", maxLines: 100}]
				fieldConfig: {
					overrides: [
						{
							matcher: {id: "byName", options: "upstream_cluster"}
							properties: [{id: "displayName", value: "upstream"}]
						},
						{
							matcher: {id: "byName", options: "err5xx"}
							properties: [
								{id: "custom.cellOptions", value: {type: "color-text"}},
								{
									id: "thresholds"
									value: {mode: "absolute", steps: [{color: "green", value: null}, {color: "red", value: 1}]}
								},
							]
						},
						{
							matcher: {id: "byName", options: "flagged"}
							properties: [
								{id: "custom.cellOptions", value: {type: "color-text"}},
								{
									id: "thresholds"
									value: {mode: "absolute", steps: [{color: "green", value: null}, {color: "red", value: 1}]}
								},
							]
						},
						{
							matcher: {id: "byName", options: "p95_ms"}
							properties: [{id: "decimals", value: 0}, {id: "unit", value: "ms"}]
						},
						{matcher: {id: "byName", options: "bytes_sent"}, properties: [{id: "unit", value: "bytes"}]},
					]
				}
				transformations: [
					{id: "extractFields", options: {format: "json", replace: true, source: "labels"}},
					{
						id: "convertFieldType"
						options: {
							conversions: [
								{destinationType: "number", targetField: "requests"},
								{destinationType: "number", targetField: "err5xx"},
								{destinationType: "number", targetField: "flagged"},
								{destinationType: "number", targetField: "p95_ms"},
								{destinationType: "number", targetField: "bytes_sent"},
							]
						}
					},
					{
						id: "organize"
						options: {excludeByName: {Line: true, Time: true, id: true, streamId: true, streams: true}}
					},
				]
			}
		},
		{
			#bargauge & {
				id:          25
				title:       "Top user agents"
				description: "Request count per User-Agent — handy for spotting scanners and CLI clients."
				gridPos: {h: 9, w: 12, x: 12, y: 72}
				targets: [#target & {expr: #"\#(#filter) user_agent:* | stats by (user_agent) count() as hits | sort by (hits desc) | limit 15"#, queryType: "stats", legendFormat: "{{user_agent}}"}]
			}
		},
	]
	annotations: {
		list: [
			{
				builtIn: 1
				datasource: {type: "grafana", uid: "-- Grafana --"}
				enable:    true
				hide:      true
				iconColor: "rgba(0, 211, 255, 1)"
				name:      "Annotations & Alerts"
				type:      "dashboard"
			},
		]
	}
	description:   "HTTP traffic through the Cilium Gateway API (cilium-envoy access logs) stored in VictoriaLogs."
	editable:      true
	graphTooltip:  1
	refresh:       "30s"
	schemaVersion: 39
	tags: ["cilium", "envoy", "gateway", "victorialogs", "logs"]
	templating: {
		list: [
			{
				current: {selected: false, text: "victorialogs", value: "f807dec9-2d3a-4572-8954-830e2f2db085"}
				hide:    0
				label:   "Data source"
				name:    "DS_VICTORIALOGS"
				query:   "victoriametrics-logs-datasource"
				refresh: 1
				regex:   ""
				type:    "datasource"
			},
			{
				allValue: ".*"
				current: {selected: true, text: ["All"], value: ["$__all"]}
				datasource: {type: "victoriametrics-logs-datasource", uid: "${DS_VICTORIALOGS}"}
				definition: "gateway"
				hide:       0
				includeAll: true
				label:      "Gateway"
				multi:      true
				name:       "gateway"
				query: {
					field: "gateway"
					limit: 1000
					query: "kubernetes.container_name:cilium-envoy response_code:*"
					type:  "fieldValue"
				}
				refresh: 2
				sort:    1
				type:    "query"
			},
			{
				allValue: ".*"
				current: {selected: true, text: ["All"], value: ["$__all"]}
				datasource: {type: "victoriametrics-logs-datasource", uid: "${DS_VICTORIALOGS}"}
				definition: "authority"
				hide:       0
				includeAll: true
				label:      "Host"
				multi:      true
				name:       "authority"
				query: {
					field: "authority"
					limit: 1000
					query: "kubernetes.container_name:cilium-envoy response_code:*"
					type:  "fieldValue"
				}
				refresh: 2
				sort:    1
				type:    "query"
			},
		]
	}
	time: {from: "now-6h", to: "now"}
	timepicker: {refresh_intervals: ["10s", "30s", "1m", "5m", "15m", "30m", "1h"]}
	timezone: "browser"
	title:    "Cilium Envoy Gateway Logs"
	uid:      "cilium-gateway-logs"
}
