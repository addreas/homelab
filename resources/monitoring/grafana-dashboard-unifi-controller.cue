package kube

import (
	json656e63 "encoding/json"
	yaml656e63 "encoding/yaml"
)

k: ConfigMap: "grafana-dashboard-unifi-controller": {
	metadata: labels: grafana_dashboard: "unifi"
	data: {
		"unifi-controller.json": json656e63.Marshal({
			annotations: list: [
				{
					builtIn:    1
					datasource: "-- Grafana --"
					enable:     true
					hide:       true
					iconColor:  "rgba(0, 211, 255, 1)"
					name:       "Annotations & Alerts"
					type:       "dashboard"
				},
			]
			description:  "A Grafana dashboard to utilize with the Ubiquiti UniFi exporter."
			editable:     true
			gnetId:       6885
			graphTooltip: 0
			id:           32
			iteration:    1614024047986
			links: []
			panels: [
				{
					aliasColors: {}
					bars:       false
					dashLength: 10
					dashes:     false
					datasource: "prometheus"
					fieldConfig: {
						defaults: custom: {}
						overrides: []
					}
					fill:         1
					fillGradient: 0
					gridPos: {
						h: 8
						w: 24
						x: 0
						y: 0
					}
					hiddenSeries: false
					id:           2
					legend: {
						avg:     false
						current: false
						max:     false
						min:     false
						show:    true
						total:   false
						values:  false
					}
					lines:     true
					linewidth: 2
					links: []
					nullPointMode: "null"
					options: alertThreshold: true
					percentage:    false
					pluginVersion: "7.3.7"
					pointradius:   5
					points:        false
					renderer:      "flot"
					seriesOverrides: []
					spaceLength: 10
					stack:       false
					steppedLine: false
					targets: [
						{
							expr:           "sum(rate(unifi_devices_wireless_transmitted_bytes_total{name=~\"$device\"}[$interval])) by (name)"
							format:         "time_series"
							instant:        false
							interval:       ""
							intervalFactor: 2
							legendFormat:   "tx-{{name}}"
							refId:          "A"
						},
						{
							expr: yaml656e63.Marshal(_cue_expr)
							let _cue_expr = ["sum(rate(unifi_devices_wireless_received_bytes_total{name=~\"$device\"}[$interval])) by (name)"]
							format:         "time_series"
							hide:           false
							intervalFactor: 1
							legendFormat:   "rx-{{name}}"
							refId:          "B"
						},
					]
					thresholds: []
					timeFrom: null
					timeRegions: []
					timeShift: null
					title:     "Total Traffic"
					tooltip: {
						shared:     true
						sort:       0
						value_type: "individual"
					}
					type: "graph"
					xaxis: {
						buckets: null
						mode:    "time"
						name:    null
						show:    true
						values: []
					}
					yaxes: [
						{
							format:  "decbytes"
							label:   null
							logBase: 1
							max:     null
							min:     null
							show:    true
						},
						{
							format:  "short"
							label:   null
							logBase: 1
							max:     null
							min:     null
							show:    true
						},
					]
					yaxis: {
						align:      false
						alignLevel: null
					}
				},
				{
					aliasColors: {}
					bars:       false
					dashLength: 10
					dashes:     false
					datasource: "prometheus"
					fieldConfig: {
						defaults: custom: {}
						overrides: []
					}
					fill:         1
					fillGradient: 0
					gridPos: {
						h: 8
						w: 12
						x: 0
						y: 8
					}
					hiddenSeries: false
					id:           7
					legend: {
						alignAsTable: false
						avg:          false
						current:      false
						max:          false
						min:          false
						rightSide:    false
						show:         true
						total:        false
						values:       false
					}
					lines:     true
					linewidth: 2
					links: []
					nullPointMode: "null"
					options: alertThreshold: true
					percentage:    false
					pluginVersion: "7.3.7"
					pointradius:   5
					points:        false
					renderer:      "flot"
					seriesOverrides: []
					spaceLength: 10
					stack:       false
					steppedLine: false
					targets: [
						{
							bucketAggs: [
								{
									field: "@timestamp"
									id:    "2"
									settings: {
										interval:      "auto"
										min_doc_count: 0
										trimEdges:     0
									}
									type: "date_histogram"
								},
							]
							expr:           "sum(increase(unifi_devices_wireless_transmitted_packets_dropped_total{name=~\"$device\"}[$interval])) by (name)"
							format:         "time_series"
							intervalFactor: 1
							legendFormat:   "{{name}}"
							metrics: [
								{
									field: "select field"
									id:    "1"
									type:  "count"
								},
							]
							refId:     "A"
							timeField: "@timestamp"
						},
					]
					thresholds: []
					timeFrom: null
					timeRegions: []
					timeShift: null
					title:     "Dropped Packets"
					tooltip: {
						shared:     true
						sort:       0
						value_type: "individual"
					}
					type: "graph"
					xaxis: {
						buckets: null
						mode:    "time"
						name:    null
						show:    true
						values: []
					}
					yaxes: [
						{
							format:  "short"
							label:   null
							logBase: 1
							max:     null
							min:     null
							show:    true
						},
						{
							format:  "short"
							label:   null
							logBase: 1
							max:     null
							min:     null
							show:    true
						},
					]
					yaxis: {
						align:      false
						alignLevel: null
					}
				},
				{
					aliasColors: {}
					bars:       false
					dashLength: 10
					dashes:     false
					datasource: "prometheus"
					fieldConfig: {
						defaults: custom: {}
						overrides: []
					}
					fill:         1
					fillGradient: 0
					gridPos: {
						h: 8
						w: 12
						x: 12
						y: 8
					}
					hiddenSeries: false
					id:           16
					legend: {
						avg:     false
						current: false
						max:     false
						min:     false
						show:    true
						total:   false
						values:  false
					}
					lines:     true
					linewidth: 2
					links: []
					nullPointMode: "null"
					options: alertThreshold: true
					percentage:    false
					pluginVersion: "7.3.7"
					pointradius:   5
					points:        false
					renderer:      "flot"
					seriesOverrides: []
					spaceLength: 10
					stack:       false
					steppedLine: false
					targets: [
						{
							bucketAggs: [
								{
									field: "@timestamp"
									id:    "2"
									settings: {
										interval:      "auto"
										min_doc_count: 0
										trimEdges:     0
									}
									type: "date_histogram"
								},
							]
							expr:           "sum(rate(unifi_stations_transmitted_bytes_total{connection=\"wireless\"}[$interval])) by (ap_mac)"
							format:         "time_series"
							intervalFactor: 1
							legendFormat:   "tx-{{ap_mac}}"
							metrics: [
								{
									field: "select field"
									id:    "1"
									type:  "count"
								},
							]
							refId:     "A"
							timeField: "@timestamp"
						},
						{
							expr: yaml656e63.Marshal(_cue_xexpr)
							let _cue_xexpr = ["sum(rate(unifi_stations_received_bytes_total{connection=\"wireless\"}[$interval])) by (ap_mac)"]
							format:         "time_series"
							intervalFactor: 1
							legendFormat:   "rx-{{ap_mac}}"
							refId:          "B"
						},
					]
					thresholds: []
					timeFrom: null
					timeRegions: []
					timeShift: null
					title:     "Wireless Device Utilization"
					tooltip: {
						shared:     true
						sort:       0
						value_type: "individual"
					}
					type: "graph"
					xaxis: {
						buckets: null
						mode:    "time"
						name:    null
						show:    true
						values: []
					}
					yaxes: [
						{
							format:  "bytes"
							label:   null
							logBase: 1
							max:     null
							min:     null
							show:    true
						},
						{
							format:  "short"
							label:   null
							logBase: 1
							max:     null
							min:     null
							show:    true
						},
					]
					yaxis: {
						align:      false
						alignLevel: null
					}
				},
				{
					aliasColors: {}
					bars:       false
					dashLength: 10
					dashes:     false
					datasource: "prometheus"
					fieldConfig: {
						defaults: custom: {}
						overrides: []
					}
					fill:         1
					fillGradient: 0
					gridPos: {
						h: 9
						w: 24
						x: 0
						y: 16
					}
					hiddenSeries: false
					id:           3
					legend: {
						avg:       false
						current:   false
						hideEmpty: false
						hideZero:  false
						max:       false
						min:       false
						show:      true
						total:     false
						values:    false
					}
					lines:     true
					linewidth: 2
					links: []
					nullPointMode: "null"
					options: alertThreshold: true
					percentage:    false
					pluginVersion: "7.3.7"
					pointradius:   5
					points:        false
					renderer:      "flot"
					seriesOverrides: [
						{
							alias:  "hostname"
							legend: false
						},
					]
					spaceLength: 10
					stack:       false
					steppedLine: false
					targets: [
						{
							expr:           "sum(rate(unifi_stations_transmitted_bytes_total{hostname=~\"$client\"}[$interval]))"
							format:         "time_series"
							interval:       ""
							intervalFactor: 2
							legendFormat:   "Sent"
							refId:          "A"
						},
						{
							expr: yaml656e63.Marshal(_cue_xxexpr)
							let _cue_xxexpr = ["sum(rate(unifi_stations_received_bytes_total{hostname=~\"$client\"}[$interval]))"]
							format:         "time_series"
							intervalFactor: 2
							legendFormat:   "Received"
							refId:          "B"
						},
					]
					thresholds: []
					timeFrom: null
					timeRegions: []
					timeShift: null
					title:     "Client Traffic"
					tooltip: {
						shared:     true
						sort:       0
						value_type: "individual"
					}
					type: "graph"
					xaxis: {
						buckets: null
						mode:    "time"
						name:    null
						show:    true
						values: []
					}
					yaxes: [
						{
							format:  "Bps"
							label:   null
							logBase: 1
							max:     null
							min:     null
							show:    true
						},
						{
							format:  "short"
							label:   null
							logBase: 1
							max:     null
							min:     null
							show:    true
						},
					]
					yaxis: {
						align:      false
						alignLevel: null
					}
				},
				{
					aliasColors: {}
					bars:       false
					dashLength: 10
					dashes:     false
					datasource: "prometheus"
					fieldConfig: {
						defaults: custom: {}
						overrides: []
					}
					fill:         1
					fillGradient: 0
					gridPos: {
						h: 8
						w: 12
						x: 0
						y: 25
					}
					hiddenSeries: false
					id:           10
					legend: {
						avg:     false
						current: false
						max:     false
						min:     false
						show:    true
						total:   false
						values:  false
					}
					lines:     true
					linewidth: 2
					links: []
					nullPointMode: "null"
					options: alertThreshold: true
					percentage:    false
					pluginVersion: "7.3.7"
					pointradius:   5
					points:        false
					renderer:      "flot"
					seriesOverrides: []
					spaceLength: 10
					stack:       false
					steppedLine: false
					targets: [
						{
							bucketAggs: [
								{
									field: "@timestamp"
									id:    "2"
									settings: {
										interval:      "auto"
										min_doc_count: 0
										trimEdges:     0
									}
									type: "date_histogram"
								},
							]
							expr:           "sum(rate(unifi_stations_transmitted_bytes_total{hostname=~\"$client\"}[$interval])) by (hostname)"
							format:         "time_series"
							hide:           false
							intervalFactor: 2
							legendFormat:   "{{hostname}}"
							metrics: [
								{
									field: "select field"
									id:    "1"
									type:  "count"
								},
							]
							refId:     "A"
							timeField: "@timestamp"
						},
					]
					thresholds: []
					timeFrom: null
					timeRegions: []
					timeShift: null
					title:     "Sent Network Traffic per Client"
					tooltip: {
						shared:     true
						sort:       0
						value_type: "individual"
					}
					type: "graph"
					xaxis: {
						buckets: null
						mode:    "time"
						name:    null
						show:    true
						values: []
					}
					yaxes: [
						{
							format:  "Bps"
							label:   null
							logBase: 1
							max:     null
							min:     null
							show:    true
						},
						{
							format:  "short"
							label:   null
							logBase: 1
							max:     null
							min:     null
							show:    true
						},
					]
					yaxis: {
						align:      false
						alignLevel: null
					}
				},
				{
					aliasColors: {}
					bars:       false
					dashLength: 10
					dashes:     false
					datasource: "prometheus"
					fieldConfig: {
						defaults: custom: {}
						overrides: []
					}
					fill:         1
					fillGradient: 0
					gridPos: {
						h: 8
						w: 12
						x: 12
						y: 25
					}
					hiddenSeries: false
					id:           9
					legend: {
						avg:     false
						current: false
						max:     false
						min:     false
						show:    true
						total:   false
						values:  false
					}
					lines:     true
					linewidth: 2
					links: []
					nullPointMode: "null"
					options: alertThreshold: true
					percentage:    false
					pluginVersion: "7.3.7"
					pointradius:   5
					points:        false
					renderer:      "flot"
					seriesOverrides: []
					spaceLength: 10
					stack:       false
					steppedLine: false
					targets: [
						{
							bucketAggs: [
								{
									field: "@timestamp"
									id:    "2"
									settings: {
										interval:      "auto"
										min_doc_count: 0
										trimEdges:     0
									}
									type: "date_histogram"
								},
							]
							expr:           "sum(rate(unifi_stations_received_bytes_total{hostname=~\"$client\"}[$interval])) by (hostname)"
							format:         "time_series"
							intervalFactor: 2
							legendFormat:   "{{hostname}}"
							metrics: [
								{
									field: "select field"
									id:    "1"
									type:  "count"
								},
							]
							refId:     "A"
							timeField: "@timestamp"
						},
					]
					thresholds: []
					timeFrom: null
					timeRegions: []
					timeShift: null
					title:     "Recieved Network Traffic per Client"
					tooltip: {
						shared:     true
						sort:       0
						value_type: "individual"
					}
					type: "graph"
					xaxis: {
						buckets: null
						mode:    "time"
						name:    null
						show:    true
						values: []
					}
					yaxes: [
						{
							format:  "Bps"
							label:   null
							logBase: 1
							max:     null
							min:     null
							show:    true
						},
						{
							format:  "short"
							label:   null
							logBase: 1
							max:     null
							min:     null
							show:    true
						},
					]
					yaxis: {
						align:      false
						alignLevel: null
					}
				},
				{
					columns: [
						{
							text:  "Total"
							value: "total"
						},
					]
					datasource: "prometheus"
					fieldConfig: {
						defaults: custom: {}
						overrides: []
					}
					fontSize: "100%"
					gridPos: {
						h: 8
						w: 12
						x: 0
						y: 33
					}
					hideTimeOverride: false
					id:               12
					links: []
					pageSize:   null
					scroll:     true
					showHeader: true
					sort: {
						col:  1
						desc: true
					}
					styles: [
						{
							alias:      "Time"
							align:      "auto"
							dateFormat: "YYYY-MM-DD HH:mm:ss"
							pattern:    "Time"
							type:       "date"
						},
						{
							alias:     "Received"
							align:     "auto"
							colorMode: null
							colors: [
								"rgba(245, 54, 54, 0.9)",
								"rgba(237, 129, 40, 0.89)",
								"rgba(50, 172, 45, 0.97)",
							]
							dateFormat: "YYYY-MM-DD HH:mm:ss"
							decimals:   2
							pattern:    "Value"
							thresholds: []
							type: "number"
							unit: "bytes"
						},
						{
							alias:     ""
							align:     "auto"
							colorMode: null
							colors: [
								"rgba(245, 54, 54, 0.9)",
								"rgba(237, 129, 40, 0.89)",
								"rgba(50, 172, 45, 0.97)",
							]
							dateFormat: "YYYY-MM-DD HH:mm:ss"
							decimals:   2
							pattern:    "Total"
							thresholds: []
							type: "number"
							unit: "bytes"
						},
						{
							alias:     ""
							align:     "auto"
							colorMode: null
							colors: [
								"rgba(245, 54, 54, 0.9)",
								"rgba(237, 129, 40, 0.89)",
								"rgba(50, 172, 45, 0.97)",
							]
							decimals: 2
							pattern:  "/.*/"
							thresholds: []
							type: "number"
							unit: "short"
						},
					]
					targets: [
						{
							bucketAggs: [
								{
									field: "@timestamp"
									id:    "2"
									settings: {
										interval:      "auto"
										min_doc_count: 0
										trimEdges:     0
									}
									type: "date_histogram"
								},
							]
							expr:           "sum(increase(unifi_stations_transmitted_bytes_total{hostname=~\"$client\"}[$interval])) by (hostname)"
							format:         "time_series"
							instant:        false
							intervalFactor: 1
							legendFormat:   "{{hostname}}"
							metrics: [
								{
									field: "select field"
									id:    "1"
									type:  "count"
								},
							]
							refId:     "A"
							timeField: "@timestamp"
						},
					]
					timeFrom:  null
					timeShift: null
					title:     "Top Clients"
					transform: "timeseries_aggregations"
					type:      "table-old"
				},
				{
					columns: [
						{
							text:  "Current"
							value: "current"
						},
					]
					datasource: "prometheus"
					fieldConfig: {
						defaults: custom: {}
						overrides: []
					}
					fontSize: "100%"
					gridPos: {
						h: 8
						w: 12
						x: 12
						y: 33
					}
					id: 14
					links: []
					pageSize:   null
					scroll:     true
					showHeader: true
					sort: {
						col:  0
						desc: true
					}
					styles: [
						{
							alias:      "Time"
							align:      "auto"
							dateFormat: "YYYY-MM-DD HH:mm:ss"
							pattern:    "Time"
							type:       "date"
						},
						{
							alias:     ""
							align:     "auto"
							colorMode: "cell"
							colors: [
								"rgba(245, 54, 54, 0.9)",
								"rgba(237, 129, 40, 0.89)",
								"rgba(50, 172, 45, 0.97)",
							]
							dateFormat: "YYYY-MM-DD HH:mm:ss"
							decimals:   2
							pattern:    "Current"
							thresholds: [
								"86400",
								"604800",
								"1.21e+6",
							]
							type: "number"
							unit: "s"
						},
						{
							alias:     ""
							align:     "auto"
							colorMode: null
							colors: [
								"rgba(245, 54, 54, 0.9)",
								"rgba(237, 129, 40, 0.89)",
								"rgba(50, 172, 45, 0.97)",
							]
							decimals: 2
							pattern:  "/.*/"
							thresholds: []
							type: "number"
							unit: "short"
						},
					]
					targets: [
						{
							bucketAggs: [
								{
									field: "@timestamp"
									id:    "2"
									settings: {
										interval:      "auto"
										min_doc_count: 0
										trimEdges:     0
									}
									type: "date_histogram"
								},
							]
							expr:           "unifi_devices_uptime_seconds_total"
							format:         "time_series"
							intervalFactor: 1
							legendFormat:   "{{name}}"
							metrics: [
								{
									field: "select field"
									id:    "1"
									type:  "count"
								},
							]
							refId:     "A"
							timeField: "@timestamp"
						},
					]
					title:     "Device Uptime"
					transform: "timeseries_aggregations"
					type:      "table-old"
				},
				{
					aliasColors: {}
					bars:       false
					dashLength: 10
					dashes:     false
					datasource: "prometheus"
					fieldConfig: {
						defaults: custom: {}
						overrides: []
					}
					fill: 1
					gridPos: {
						h: 8
						w: 12
						x: 0
						y: 41
					}
					id: 1
					legend: {
						alignAsTable: false
						avg:          false
						current:      false
						max:          false
						min:          false
						show:         true
						total:        false
						values:       false
					}
					lines:     true
					linewidth: 1
					links: []
					nullPointMode: "null"
					percentage:    false
					pluginVersion: "7.3.7"
					pointradius:   5
					points:        false
					renderer:      "flot"
					seriesOverrides: []
					spaceLength: 10
					stack:       false
					steppedLine: false
					targets: [
						{
							expr:           "unifi_devices_stations_user"
							format:         "time_series"
							instant:        false
							interval:       ""
							intervalFactor: 2
							legendFormat:   "user-{{name}} {{radio}}"
							refId:          "A"
						},
						{
							expr:           "unifi_devices_stations_guest"
							format:         "time_series"
							intervalFactor: 2
							legendFormat:   "guest-{{name}} {{radio}}"
							refId:          "B"
						},
					]
					thresholds: []
					timeFrom:  null
					timeShift: null
					title:     "Wifi Clients"
					tooltip: {
						shared:     true
						sort:       0
						value_type: "individual"
					}
					type: "graph"
					xaxis: {
						buckets: null
						mode:    "time"
						name:    null
						show:    true
						values: []
					}
					yaxes: [
						{
							format:  "short"
							label:   null
							logBase: 1
							max:     null
							min:     null
							show:    true
						},
						{
							format:  "short"
							label:   null
							logBase: 1
							max:     null
							min:     null
							show:    true
						},
					]
				},
				{
					columns: []
					datasource: "prometheus"
					fieldConfig: {
						defaults: custom: {}
						overrides: []
					}
					fontSize: "100%"
					gridPos: {
						h: 8
						w: 12
						x: 12
						y: 41
					}
					id: 18
					links: []
					pageSize:   null
					scroll:     true
					showHeader: true
					sort: {
						col:  0
						desc: true
					}
					styles: [
						{
							alias:      "MAC"
							align:      "auto"
							dateFormat: "YYYY-MM-DD HH:mm:ss"
							pattern:    "mac"
							type:       "string"
						},
						{
							alias:     "Name"
							align:     "auto"
							colorMode: null
							colors: [
								"rgba(245, 54, 54, 0.9)",
								"rgba(237, 129, 40, 0.89)",
								"rgba(50, 172, 45, 0.97)",
							]
							dateFormat: "YYYY-MM-DD HH:mm:ss"
							decimals:   2
							pattern:    "name"
							thresholds: []
							type: "string"
							unit: "short"
						},
						{
							alias:     ""
							align:     "auto"
							colorMode: null
							colors: [
								"rgba(245, 54, 54, 0.9)",
								"rgba(237, 129, 40, 0.89)",
								"rgba(50, 172, 45, 0.97)",
							]
							decimals: 2
							pattern:  "/.*/"
							thresholds: []
							type: "hidden"
							unit: "short"
						},
					]
					targets: [
						{
							bucketAggs: [
								{
									field: "@timestamp"
									id:    "2"
									settings: {
										interval:      "auto"
										min_doc_count: 0
										trimEdges:     0
									}
									type: "date_histogram"
								},
							]
							expr:           "sum(unifi_devices_stations) by (name, mac)"
							format:         "table"
							instant:        true
							intervalFactor: 1
							metrics: [
								{
									field: "select field"
									id:    "1"
									type:  "count"
								},
							]
							refId:     "A"
							timeField: "@timestamp"
						},
					]
					title:     "Wireless Devices"
					transform: "table"
					type:      "table-old"
				},
			]
			refresh:       false
			schemaVersion: 26
			style:         "dark"
			tags: []
			templating: list: [
				{
					allValue: null
					current: {
						selected: false
						text:     "All"
						value:    "$__all"
					}
					datasource: "prometheus"
					definition: ""
					error:      null
					hide:       0
					includeAll: true
					label:      "Client"
					multi:      true
					name:       "client"
					options: []
					query:          "label_values(unifi_stations_received_bytes_total,hostname)"
					refresh:        1
					regex:          ""
					skipUrlSync:    false
					sort:           0
					tagValuesQuery: ""
					tags: []
					tagsQuery: ""
					type:      "query"
					useTags:   false
				},
				{
					allValue: null
					current: {
						selected: false
						text:     "All"
						value:    "$__all"
					}
					datasource: "prometheus"
					definition: ""
					error:      null
					hide:       0
					includeAll: true
					label:      "Device"
					multi:      false
					name:       "device"
					options: []
					query:          "label_values(unifi_devices_uptime_seconds_total,name)"
					refresh:        1
					regex:          ""
					skipUrlSync:    false
					sort:           0
					tagValuesQuery: ""
					tags: []
					tagsQuery: ""
					type:      "query"
					useTags:   false
				},
				{
					auto:       true
					auto_count: 50
					auto_min:   "50s"
					current: {
						selected: false
						text:     "auto"
						value:    "$__auto_interval_interval"
					}
					error: null
					hide:  0
					label: "Interval"
					name:  "interval"
					options: [
						{
							selected: true
							text:     "auto"
							value:    "$__auto_interval_interval"
						},
						{
							selected: false
							text:     "30s"
							value:    "30s"
						},
						{
							selected: false
							text:     "1m"
							value:    "1m"
						},
						{
							selected: false
							text:     "2m"
							value:    "2m"
						},
						{
							selected: false
							text:     "3m"
							value:    "3m"
						},
						{
							selected: false
							text:     "5m"
							value:    "5m"
						},
						{
							selected: false
							text:     "7m"
							value:    "7m"
						},
						{
							selected: false
							text:     "10m"
							value:    "10m"
						},
						{
							selected: false
							text:     "30m"
							value:    "30m"
						},
						{
							selected: false
							text:     "1h"
							value:    "1h"
						},
						{
							selected: false
							text:     "6h"
							value:    "6h"
						},
						{
							selected: false
							text:     "12h"
							value:    "12h"
						},
						{
							selected: false
							text:     "1d"
							value:    "1d"
						},
						{
							selected: false
							text:     "7d"
							value:    "7d"
						},
						{
							selected: false
							text:     "14d"
							value:    "14d"
						},
						{
							selected: false
							text:     "30d"
							value:    "30d"
						},
					]
					query:       "30s,1m,2m,3m,5m,7m,10m,30m,1h,6h,12h,1d,7d,14d,30d"
					refresh:     2
					skipUrlSync: false
					type:        "interval"
				},
			]
			time: {
				from: "now-1h"
				to:   "now"
			}
			timepicker: {
				refresh_intervals: [
					"5s",
					"10s",
					"30s",
					"1m",
					"5m",
					"15m",
					"30m",
					"1h",
					"2h",
					"1d",
				]
				time_options: [
					"5m",
					"15m",
					"1h",
					"6h",
					"12h",
					"24h",
					"2d",
					"7d",
					"30d",
				]
			}
			timezone: ""
			title:    "Unifi Controller Dashboard"
			uid:      "9Qk8KXviz"
			version:  1
		})
	}
}
