package manifests

grafanaDashboards: {
	"apiserver.json": {
		"__inputs": []
		"__requires": []
		annotations: list: []
		editable:     false
		gnetId:       null
		graphTooltip: 0
		hideControls: false
		id:           null
		links: []
		panels: [{
			content:     "The SLO (service level objective) and other metrics displayed on this dashboard are for informational purposes only."
			datasource:  null
			description: "The SLO (service level objective) and other metrics displayed on this dashboard are for informational purposes only."
			gridPos: {
				h: 2
				w: 24
				x: 0
				y: 0
			}
			id:    2
			mode:  "markdown"
			span:  12
			title: "Notice"
			type:  "text"
		}]
		refresh: "10s"
		rows: [{
			collapse:  false
			collapsed: false
			panels: [{
				cacheTimeout:    null
				colorBackground: false
				colorValue:      false
				colors: ["#299c46", "rgba(237, 129, 40, 0.89)", "#d44a3a"]
				datasource:  "$datasource"
				decimals:    3
				description: "How many percent of requests (both read and write) in 30 days have been answered successfully and fast enough?"
				format:      "percentunit"
				gauge: {
					maxValue:         100
					minValue:         0
					show:             false
					thresholdLabels:  false
					thresholdMarkers: true
				}
				gridPos: {}
				id:       3
				interval: "1m"
				legend: {
					alignAsTable: true
					rightSide:    true
				}
				links: []
				mappingType: 1
				mappingTypes: [{
					name:  "value to text"
					value: 1
				}, {
					name:  "range to text"
					value: 2
				}]
				maxDataPoints:   100
				nullPointMode:   "connected"
				nullText:        null
				postfix:         ""
				postfixFontSize: "50%"
				prefix:          ""
				prefixFontSize:  "50%"
				rangeMaps: [{
					from: "null"
					text: "N/A"
					to:   "null"
				}]
				span: 4
				sparkline: {
					fillColor: "rgba(31, 118, 189, 0.18)"
					full:      false
					lineColor: "rgb(31, 120, 193)"
					show:      false
				}
				tableColumn: ""
				targets: [{
					expr:           "apiserver_request:availability30d{verb=\"all\", cluster=\"$cluster\"}"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   ""
					refId:          "A"
				}]
				thresholds: ""
				title:      "Availability (30d) > 99.000%"
				tooltip: shared: false
				type:          "singlestat"
				valueFontSize: "80%"
				valueMaps: [{
					op:    "="
					text:  "N/A"
					value: "null"
				}]
				valueName: "avg"
			}, {
				aliasColors: {}
				bars:         false
				dashLength:   10
				dashes:       false
				datasource:   "$datasource"
				decimals:     3
				description:  "How much error budget is left looking at our 0.990% availability guarantees?"
				fill:         10
				fillGradient: 0
				gridPos: {}
				id:       4
				interval: "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					sideWidth:    null
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 1
				links: []
				nullPointMode: "null"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				repeat:        null
				seriesOverrides: []
				spaceLength: 10
				span:        8
				stack:       false
				steppedLine: false
				targets: [{
					expr:           "100 * (apiserver_request:availability30d{verb=\"all\", cluster=\"$cluster\"} - 0.990000)"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "errorbudget"
					refId:          "A"
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "ErrorBudget (30d) > 99.000%"
				tooltip: {
					shared:     false
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
				yaxes: [{
					decimals: 3
					format:   "percentunit"
					label:    null
					logBase:  1
					max:      null
					min:      null
					show:     true
				}, {
					decimals: 3
					format:   "percentunit"
					label:    null
					logBase:  1
					max:      null
					min:      null
					show:     true
				}]
			}]
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       false
			title:           "Dashboard Row"
			titleSize:       "h6"
			type:            "row"
		}, {
			collapse:  false
			collapsed: false
			panels: [{
				cacheTimeout:    null
				colorBackground: false
				colorValue:      false
				colors: ["#299c46", "rgba(237, 129, 40, 0.89)", "#d44a3a"]
				datasource:  "$datasource"
				decimals:    3
				description: "How many percent of read requests (LIST,GET) in 30 days have been answered successfully and fast enough?"
				format:      "percentunit"
				gauge: {
					maxValue:         100
					minValue:         0
					show:             false
					thresholdLabels:  false
					thresholdMarkers: true
				}
				gridPos: {}
				id:       5
				interval: "1m"
				legend: {
					alignAsTable: true
					rightSide:    true
				}
				links: []
				mappingType: 1
				mappingTypes: [{
					name:  "value to text"
					value: 1
				}, {
					name:  "range to text"
					value: 2
				}]
				maxDataPoints:   100
				nullPointMode:   "connected"
				nullText:        null
				postfix:         ""
				postfixFontSize: "50%"
				prefix:          ""
				prefixFontSize:  "50%"
				rangeMaps: [{
					from: "null"
					text: "N/A"
					to:   "null"
				}]
				span: 3
				sparkline: {
					fillColor: "rgba(31, 118, 189, 0.18)"
					full:      false
					lineColor: "rgb(31, 120, 193)"
					show:      false
				}
				tableColumn: ""
				targets: [{
					expr:           "apiserver_request:availability30d{verb=\"read\", cluster=\"$cluster\"}"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   ""
					refId:          "A"
				}]
				thresholds: ""
				title:      "Read Availability (30d)"
				tooltip: shared: false
				type:          "singlestat"
				valueFontSize: "80%"
				valueMaps: [{
					op:    "="
					text:  "N/A"
					value: "null"
				}]
				valueName: "avg"
			}, {
				aliasColors: {}
				bars:         false
				dashLength:   10
				dashes:       false
				datasource:   "$datasource"
				description:  "How many read requests (LIST,GET) per second do the apiservers get by code?"
				fill:         10
				fillGradient: 0
				gridPos: {}
				id:       6
				interval: "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					sideWidth:    null
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 1
				links: []
				nullPointMode: "null"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				repeat:        null
				seriesOverrides: [{
					alias: "/2../i"
					color: "#56A64B"
				}, {
					alias: "/3../i"
					color: "#F2CC0C"
				}, {
					alias: "/4../i"
					color: "#3274D9"
				}, {
					alias: "/5../i"
					color: "#E02F44"
				}]
				spaceLength: 10
				span:        3
				stack:       true
				steppedLine: false
				targets: [{
					expr:           "sum by (code) (code_resource:apiserver_request_total:rate5m{verb=\"read\", cluster=\"$cluster\"})"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{ code }}"
					refId:          "A"
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Read SLI - Requests"
				tooltip: {
					shared:     false
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
				yaxes: [{
					format:  "reqps"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    true
				}, {
					format:  "reqps"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    true
				}]
			}, {
				aliasColors: {}
				bars:         false
				dashLength:   10
				dashes:       false
				datasource:   "$datasource"
				description:  "How many percent of read requests (LIST,GET) per second are returned with errors (5xx)?"
				fill:         1
				fillGradient: 0
				gridPos: {}
				id:       7
				interval: "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					sideWidth:    null
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 1
				links: []
				nullPointMode: "null"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				repeat:        null
				seriesOverrides: []
				spaceLength: 10
				span:        3
				stack:       false
				steppedLine: false
				targets: [{
					expr:           "sum by (resource) (code_resource:apiserver_request_total:rate5m{verb=\"read\",code=~\"5..\", cluster=\"$cluster\"}) / sum by (resource) (code_resource:apiserver_request_total:rate5m{verb=\"read\", cluster=\"$cluster\"})"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{ resource }}"
					refId:          "A"
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Read SLI - Errors"
				tooltip: {
					shared:     false
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
				yaxes: [{
					format:  "percentunit"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "percentunit"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}]
			}, {
				aliasColors: {}
				bars:         false
				dashLength:   10
				dashes:       false
				datasource:   "$datasource"
				description:  "How many seconds is the 99th percentile for reading (LIST|GET) a given resource?"
				fill:         1
				fillGradient: 0
				gridPos: {}
				id:       8
				interval: "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					sideWidth:    null
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 1
				links: []
				nullPointMode: "null"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				repeat:        null
				seriesOverrides: []
				spaceLength: 10
				span:        3
				stack:       false
				steppedLine: false
				targets: [{
					expr:           "cluster_quantile:apiserver_request_duration_seconds:histogram_quantile{verb=\"read\", cluster=\"$cluster\"}"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{ resource }}"
					refId:          "A"
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Read SLI - Duration"
				tooltip: {
					shared:     false
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
				yaxes: [{
					format:  "s"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    true
				}, {
					format:  "s"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    true
				}]
			}]
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       false
			title:           "Dashboard Row"
			titleSize:       "h6"
			type:            "row"
		}, {
			collapse:  false
			collapsed: false
			panels: [{
				cacheTimeout:    null
				colorBackground: false
				colorValue:      false
				colors: ["#299c46", "rgba(237, 129, 40, 0.89)", "#d44a3a"]
				datasource:  "$datasource"
				decimals:    3
				description: "How many percent of write requests (POST|PUT|PATCH|DELETE) in 30 days have been answered successfully and fast enough?"
				format:      "percentunit"
				gauge: {
					maxValue:         100
					minValue:         0
					show:             false
					thresholdLabels:  false
					thresholdMarkers: true
				}
				gridPos: {}
				id:       9
				interval: "1m"
				legend: {
					alignAsTable: true
					rightSide:    true
				}
				links: []
				mappingType: 1
				mappingTypes: [{
					name:  "value to text"
					value: 1
				}, {
					name:  "range to text"
					value: 2
				}]
				maxDataPoints:   100
				nullPointMode:   "connected"
				nullText:        null
				postfix:         ""
				postfixFontSize: "50%"
				prefix:          ""
				prefixFontSize:  "50%"
				rangeMaps: [{
					from: "null"
					text: "N/A"
					to:   "null"
				}]
				span: 3
				sparkline: {
					fillColor: "rgba(31, 118, 189, 0.18)"
					full:      false
					lineColor: "rgb(31, 120, 193)"
					show:      false
				}
				tableColumn: ""
				targets: [{
					expr:           "apiserver_request:availability30d{verb=\"write\", cluster=\"$cluster\"}"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   ""
					refId:          "A"
				}]
				thresholds: ""
				title:      "Write Availability (30d)"
				tooltip: shared: false
				type:          "singlestat"
				valueFontSize: "80%"
				valueMaps: [{
					op:    "="
					text:  "N/A"
					value: "null"
				}]
				valueName: "avg"
			}, {
				aliasColors: {}
				bars:         false
				dashLength:   10
				dashes:       false
				datasource:   "$datasource"
				description:  "How many write requests (POST|PUT|PATCH|DELETE) per second do the apiservers get by code?"
				fill:         10
				fillGradient: 0
				gridPos: {}
				id:       10
				interval: "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					sideWidth:    null
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 1
				links: []
				nullPointMode: "null"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				repeat:        null
				seriesOverrides: [{
					alias: "/2../i"
					color: "#56A64B"
				}, {
					alias: "/3../i"
					color: "#F2CC0C"
				}, {
					alias: "/4../i"
					color: "#3274D9"
				}, {
					alias: "/5../i"
					color: "#E02F44"
				}]
				spaceLength: 10
				span:        3
				stack:       true
				steppedLine: false
				targets: [{
					expr:           "sum by (code) (code_resource:apiserver_request_total:rate5m{verb=\"write\", cluster=\"$cluster\"})"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{ code }}"
					refId:          "A"
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Write SLI - Requests"
				tooltip: {
					shared:     false
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
				yaxes: [{
					format:  "reqps"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    true
				}, {
					format:  "reqps"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    true
				}]
			}, {
				aliasColors: {}
				bars:         false
				dashLength:   10
				dashes:       false
				datasource:   "$datasource"
				description:  "How many percent of write requests (POST|PUT|PATCH|DELETE) per second are returned with errors (5xx)?"
				fill:         1
				fillGradient: 0
				gridPos: {}
				id:       11
				interval: "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					sideWidth:    null
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 1
				links: []
				nullPointMode: "null"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				repeat:        null
				seriesOverrides: []
				spaceLength: 10
				span:        3
				stack:       false
				steppedLine: false
				targets: [{
					expr:           "sum by (resource) (code_resource:apiserver_request_total:rate5m{verb=\"write\",code=~\"5..\", cluster=\"$cluster\"}) / sum by (resource) (code_resource:apiserver_request_total:rate5m{verb=\"write\", cluster=\"$cluster\"})"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{ resource }}"
					refId:          "A"
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Write SLI - Errors"
				tooltip: {
					shared:     false
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
				yaxes: [{
					format:  "percentunit"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "percentunit"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}]
			}, {
				aliasColors: {}
				bars:         false
				dashLength:   10
				dashes:       false
				datasource:   "$datasource"
				description:  "How many seconds is the 99th percentile for writing (POST|PUT|PATCH|DELETE) a given resource?"
				fill:         1
				fillGradient: 0
				gridPos: {}
				id:       12
				interval: "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					sideWidth:    null
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 1
				links: []
				nullPointMode: "null"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				repeat:        null
				seriesOverrides: []
				spaceLength: 10
				span:        3
				stack:       false
				steppedLine: false
				targets: [{
					expr:           "cluster_quantile:apiserver_request_duration_seconds:histogram_quantile{verb=\"write\", cluster=\"$cluster\"}"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{ resource }}"
					refId:          "A"
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Write SLI - Duration"
				tooltip: {
					shared:     false
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
				yaxes: [{
					format:  "s"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    true
				}, {
					format:  "s"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    true
				}]
			}]
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       false
			title:           "Dashboard Row"
			titleSize:       "h6"
			type:            "row"
		}, {
			collapse:  false
			collapsed: false
			panels: [{
				aliasColors: {}
				bars:         false
				dashLength:   10
				dashes:       false
				datasource:   "$datasource"
				fill:         1
				fillGradient: 0
				gridPos: {}
				id:       13
				interval: "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         false
					sideWidth:    null
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 1
				links: []
				nullPointMode: "null"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				repeat:        null
				seriesOverrides: []
				spaceLength: 10
				span:        6
				stack:       false
				steppedLine: false
				targets: [{
					expr:           "sum(rate(workqueue_adds_total{job=\"apiserver\", instance=~\"$instance\", cluster=\"$cluster\"}[$__rate_interval])) by (instance, name)"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{instance}} {{name}}"
					refId:          "A"
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Work Queue Add Rate"
				tooltip: {
					shared:     false
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
				yaxes: [{
					format:  "ops"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "ops"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}]
			}, {
				aliasColors: {}
				bars:         false
				dashLength:   10
				dashes:       false
				datasource:   "$datasource"
				fill:         1
				fillGradient: 0
				gridPos: {}
				id:       14
				interval: "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         false
					sideWidth:    null
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 1
				links: []
				nullPointMode: "null"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				repeat:        null
				seriesOverrides: []
				spaceLength: 10
				span:        6
				stack:       false
				steppedLine: false
				targets: [{
					expr:           "sum(rate(workqueue_depth{job=\"apiserver\", instance=~\"$instance\", cluster=\"$cluster\"}[$__rate_interval])) by (instance, name)"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{instance}} {{name}}"
					refId:          "A"
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Work Queue Depth"
				tooltip: {
					shared:     false
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
				yaxes: [{
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}]
			}, {
				aliasColors: {}
				bars:         false
				dashLength:   10
				dashes:       false
				datasource:   "$datasource"
				fill:         1
				fillGradient: 0
				gridPos: {}
				id:       15
				interval: "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      true
					max:          false
					min:          false
					rightSide:    true
					show:         true
					sideWidth:    null
					total:        false
					values:       true
				}
				lines:     true
				linewidth: 1
				links: []
				nullPointMode: "null"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				repeat:        null
				seriesOverrides: []
				spaceLength: 10
				span:        12
				stack:       false
				steppedLine: false
				targets: [{
					expr:           "histogram_quantile(0.99, sum(rate(workqueue_queue_duration_seconds_bucket{job=\"apiserver\", instance=~\"$instance\", cluster=\"$cluster\"}[$__rate_interval])) by (instance, name, le))"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{instance}} {{name}}"
					refId:          "A"
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Work Queue Latency"
				tooltip: {
					shared:     false
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
				yaxes: [{
					format:  "s"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    true
				}, {
					format:  "s"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    true
				}]
			}]
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       false
			title:           "Dashboard Row"
			titleSize:       "h6"
			type:            "row"
		}, {
			collapse:  false
			collapsed: false
			panels: [{
				aliasColors: {}
				bars:         false
				dashLength:   10
				dashes:       false
				datasource:   "$datasource"
				fill:         1
				fillGradient: 0
				gridPos: {}
				id:       16
				interval: "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					sideWidth:    null
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 1
				links: []
				nullPointMode: "null"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				repeat:        null
				seriesOverrides: []
				spaceLength: 10
				span:        4
				stack:       false
				steppedLine: false
				targets: [{
					expr:           "process_resident_memory_bytes{job=\"apiserver\",instance=~\"$instance\", cluster=\"$cluster\"}"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{instance}}"
					refId:          "A"
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Memory"
				tooltip: {
					shared:     false
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
				yaxes: [{
					format:  "bytes"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    true
				}, {
					format:  "bytes"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    true
				}]
			}, {
				aliasColors: {}
				bars:         false
				dashLength:   10
				dashes:       false
				datasource:   "$datasource"
				fill:         1
				fillGradient: 0
				gridPos: {}
				id:       17
				interval: "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					sideWidth:    null
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 1
				links: []
				nullPointMode: "null"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				repeat:        null
				seriesOverrides: []
				spaceLength: 10
				span:        4
				stack:       false
				steppedLine: false
				targets: [{
					expr:           "rate(process_cpu_seconds_total{job=\"apiserver\",instance=~\"$instance\", cluster=\"$cluster\"}[$__rate_interval])"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{instance}}"
					refId:          "A"
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "CPU usage"
				tooltip: {
					shared:     false
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
				yaxes: [{
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}]
			}, {
				aliasColors: {}
				bars:         false
				dashLength:   10
				dashes:       false
				datasource:   "$datasource"
				fill:         1
				fillGradient: 0
				gridPos: {}
				id:       18
				interval: "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					sideWidth:    null
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 1
				links: []
				nullPointMode: "null"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				repeat:        null
				seriesOverrides: []
				spaceLength: 10
				span:        4
				stack:       false
				steppedLine: false
				targets: [{
					expr:           "go_goroutines{job=\"apiserver\",instance=~\"$instance\", cluster=\"$cluster\"}"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{instance}}"
					refId:          "A"
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Goroutines"
				tooltip: {
					shared:     false
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
				yaxes: [{
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    true
				}, {
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    true
				}]
			}]
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       false
			title:           "Dashboard Row"
			titleSize:       "h6"
			type:            "row"
		}]
		schemaVersion: 14
		style:         "dark"
		tags: [
			"kubernetes-mixin",
		]
		templating: list: [{
			current: {
				text:  "default"
				value: "default"
			}
			hide:  0
			label: "Data Source"
			name:  "datasource"
			options: []
			query:   "prometheus"
			refresh: 1
			regex:   ""
			type:    "datasource"
		}, {
			allValue: null
			current: {}
			datasource: "$datasource"
			hide:       2
			includeAll: false
			label:      "cluster"
			multi:      false
			name:       "cluster"
			options: []
			query:          "label_values(up{job=\"apiserver\"}, cluster)"
			refresh:        2
			regex:          ""
			sort:           1
			tagValuesQuery: ""
			tags: []
			tagsQuery: ""
			type:      "query"
			useTags:   false
		}, {
			allValue: null
			current: {}
			datasource: "$datasource"
			hide:       0
			includeAll: true
			label:      null
			multi:      false
			name:       "instance"
			options: []
			query:          "label_values(up{job=\"apiserver\", cluster=\"$cluster\"}, instance)"
			refresh:        2
			regex:          ""
			sort:           1
			tagValuesQuery: ""
			tags: []
			tagsQuery: ""
			type:      "query"
			useTags:   false
		}]
		time: {
			from: "now-1h"
			to:   "now"
		}
		timepicker: {
			refresh_intervals: ["5s", "10s", "30s", "1m", "5m", "15m", "30m", "1h", "2h", "1d"]
			time_options: ["5m", "15m", "1h", "6h", "12h", "24h", "2d", "7d", "30d"]
		}
		timezone: "UTC"
		title:    "Kubernetes / API server"
		uid:      "09ec8aa1e996d6ffcd6817bbaff4db1b"
		version:  0
	}
	"cluster-total.json": {
		"__inputs": []
		"__requires": []
		annotations: list: [{
			builtIn:    1
			datasource: "-- Grafana --"
			enable:     true
			hide:       true
			iconColor:  "rgba(0, 211, 255, 1)"
			name:       "Annotations & Alerts"
			type:       "dashboard"
		}]
		editable:     true
		gnetId:       null
		graphTooltip: 0
		hideControls: false
		id:           null
		links: []
		panels: [{
			collapse:  false
			collapsed: false
			gridPos: {
				h: 1
				w: 24
				x: 0
				y: 0
			}
			id: 2
			panels: []
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       true
			title:           "Current Bandwidth"
			titleSize:       "h6"
			type:            "row"
		}, {
			aliasColors: {}
			bars:         true
			dashLength:   10
			dashes:       false
			datasource:   "$datasource"
			fill:         2
			fillGradient: 0
			gridPos: {
				h: 9
				w: 12
				x: 0
				y: 1
			}
			id: 3
			legend: {
				alignAsTable: true
				avg:          false
				current:      true
				hideEmpty:    true
				hideZero:     true
				max:          false
				min:          false
				rightSide:    true
				show:         true
				sideWidth:    null
				sort:         "current"
				sortDesc:     true
				total:        false
				values:       true
			}
			lines:     false
			linewidth: 1
			links: []
			minSpan:       24
			nullPointMode: "null"
			paceLength:    10
			percentage:    false
			pointradius:   5
			points:        false
			renderer:      "flot"
			repeat:        null
			seriesOverrides: []
			spaceLength: 10
			span:        24
			stack:       false
			steppedLine: false
			targets: [{
				expr:           "sort_desc(sum(irate(container_network_receive_bytes_total{cluster=\"$cluster\",namespace=~\".+\"}[$interval:$resolution])) by (namespace))"
				format:         "time_series"
				intervalFactor: 1
				legendFormat:   "{{namespace}}"
				refId:          "A"
				step:           10
			}]
			thresholds: []
			timeFrom:  null
			timeShift: null
			title:     "Current Rate of Bytes Received"
			tooltip: {
				shared:     true
				sort:       2
				value_type: "individual"
			}
			type: "graph"
			xaxis: {
				buckets: null
				mode:    "series"
				name:    null
				show:    false
				values: ["current"]
			}
			yaxes: [{
				format:  "Bps"
				label:   null
				logBase: 1
				max:     null
				min:     0
				show:    true
			}, {
				format:  "Bps"
				label:   null
				logBase: 1
				max:     null
				min:     0
				show:    true
			}]
		}, {
			aliasColors: {}
			bars:         true
			dashLength:   10
			dashes:       false
			datasource:   "$datasource"
			fill:         2
			fillGradient: 0
			gridPos: {
				h: 9
				w: 12
				x: 12
				y: 1
			}
			id: 4
			legend: {
				alignAsTable: true
				avg:          false
				current:      true
				hideEmpty:    true
				hideZero:     true
				max:          false
				min:          false
				rightSide:    true
				show:         true
				sideWidth:    null
				sort:         "current"
				sortDesc:     true
				total:        false
				values:       true
			}
			lines:     false
			linewidth: 1
			links: []
			minSpan:       24
			nullPointMode: "null"
			paceLength:    10
			percentage:    false
			pointradius:   5
			points:        false
			renderer:      "flot"
			repeat:        null
			seriesOverrides: []
			spaceLength: 10
			span:        24
			stack:       false
			steppedLine: false
			targets: [{
				expr:           "sort_desc(sum(irate(container_network_transmit_bytes_total{cluster=\"$cluster\",namespace=~\".+\"}[$interval:$resolution])) by (namespace))"
				format:         "time_series"
				intervalFactor: 1
				legendFormat:   "{{namespace}}"
				refId:          "A"
				step:           10
			}]
			thresholds: []
			timeFrom:  null
			timeShift: null
			title:     "Current Rate of Bytes Transmitted"
			tooltip: {
				shared:     true
				sort:       2
				value_type: "individual"
			}
			type: "graph"
			xaxis: {
				buckets: null
				mode:    "series"
				name:    null
				show:    false
				values: ["current"]
			}
			yaxes: [{
				format:  "Bps"
				label:   null
				logBase: 1
				max:     null
				min:     0
				show:    true
			}, {
				format:  "Bps"
				label:   null
				logBase: 1
				max:     null
				min:     0
				show:    true
			}]
		}, {
			columns: [{
				text:  "Time"
				value: "Time"
			}, {
				text:  "Value #A"
				value: "Value #A"
			}, {
				text:  "Value #B"
				value: "Value #B"
			}, {
				text:  "Value #C"
				value: "Value #C"
			}, {
				text:  "Value #D"
				value: "Value #D"
			}, {
				text:  "Value #E"
				value: "Value #E"
			}, {
				text:  "Value #F"
				value: "Value #F"
			}, {
				text:  "Value #G"
				value: "Value #G"
			}, {
				text:  "Value #H"
				value: "Value #H"
			}, {
				text:  "namespace"
				value: "namespace"
			}]
			datasource: "$datasource"
			fill:       1
			fontSize:   "90%"
			gridPos: {
				h: 9
				w: 24
				x: 0
				y: 10
			}
			id:        5
			lines:     true
			linewidth: 1
			links: []
			minSpan:       24
			nullPointMode: "null as zero"
			renderer:      "flot"
			scroll:        true
			showHeader:    true
			sort: {
				col:  0
				desc: false
			}
			spaceLength: 10
			span:        24
			styles: [{
				alias:     "Time"
				colorMode: null
				colors: []
				dateFormat:  "YYYY-MM-DD HH:mm:ss"
				decimals:    2
				link:        false
				linkTooltip: "Drill down"
				linkUrl:     ""
				pattern:     "Time"
				thresholds: []
				type: "hidden"
				unit: "short"
			}, {
				alias:     "Current Bandwidth Received"
				colorMode: null
				colors: []
				dateFormat:  "YYYY-MM-DD HH:mm:ss"
				decimals:    2
				link:        false
				linkTooltip: "Drill down"
				linkUrl:     ""
				pattern:     "Value #A"
				thresholds: []
				type: "number"
				unit: "Bps"
			}, {
				alias:     "Current Bandwidth Transmitted"
				colorMode: null
				colors: []
				dateFormat:  "YYYY-MM-DD HH:mm:ss"
				decimals:    2
				link:        false
				linkTooltip: "Drill down"
				linkUrl:     ""
				pattern:     "Value #B"
				thresholds: []
				type: "number"
				unit: "Bps"
			}, {
				alias:     "Average Bandwidth Received"
				colorMode: null
				colors: []
				dateFormat:  "YYYY-MM-DD HH:mm:ss"
				decimals:    2
				link:        false
				linkTooltip: "Drill down"
				linkUrl:     ""
				pattern:     "Value #C"
				thresholds: []
				type: "number"
				unit: "Bps"
			}, {
				alias:     "Average Bandwidth Transmitted"
				colorMode: null
				colors: []
				dateFormat:  "YYYY-MM-DD HH:mm:ss"
				decimals:    2
				link:        false
				linkTooltip: "Drill down"
				linkUrl:     ""
				pattern:     "Value #D"
				thresholds: []
				type: "number"
				unit: "Bps"
			}, {
				alias:     "Rate of Received Packets"
				colorMode: null
				colors: []
				dateFormat:  "YYYY-MM-DD HH:mm:ss"
				decimals:    2
				link:        false
				linkTooltip: "Drill down"
				linkUrl:     ""
				pattern:     "Value #E"
				thresholds: []
				type: "number"
				unit: "pps"
			}, {
				alias:     "Rate of Transmitted Packets"
				colorMode: null
				colors: []
				dateFormat:  "YYYY-MM-DD HH:mm:ss"
				decimals:    2
				link:        false
				linkTooltip: "Drill down"
				linkUrl:     ""
				pattern:     "Value #F"
				thresholds: []
				type: "number"
				unit: "pps"
			}, {
				alias:     "Rate of Received Packets Dropped"
				colorMode: null
				colors: []
				dateFormat:  "YYYY-MM-DD HH:mm:ss"
				decimals:    2
				link:        false
				linkTooltip: "Drill down"
				linkUrl:     ""
				pattern:     "Value #G"
				thresholds: []
				type: "number"
				unit: "pps"
			}, {
				alias:     "Rate of Transmitted Packets Dropped"
				colorMode: null
				colors: []
				dateFormat:  "YYYY-MM-DD HH:mm:ss"
				decimals:    2
				link:        false
				linkTooltip: "Drill down"
				linkUrl:     ""
				pattern:     "Value #H"
				thresholds: []
				type: "number"
				unit: "pps"
			}, {
				alias:     "Namespace"
				colorMode: null
				colors: []
				dateFormat:  "YYYY-MM-DD HH:mm:ss"
				decimals:    2
				link:        true
				linkTooltip: "Drill down"
				linkUrl:     "d/8b7a8b326d7a6f1f04244066368c67af/kubernetes-networking-namespace-pods?orgId=1&refresh=30s&var-namespace=$__cell"
				pattern:     "namespace"
				thresholds: []
				type: "number"
				unit: "short"
			}]
			targets: [{
				expr:           "sort_desc(sum(irate(container_network_receive_bytes_total{cluster=\"$cluster\",namespace=~\".+\"}[$interval:$resolution])) by (namespace))"
				format:         "table"
				instant:        true
				intervalFactor: 2
				legendFormat:   ""
				refId:          "A"
				step:           10
			}, {
				expr:           "sort_desc(sum(irate(container_network_transmit_bytes_total{cluster=\"$cluster\",namespace=~\".+\"}[$interval:$resolution])) by (namespace))"
				format:         "table"
				instant:        true
				intervalFactor: 2
				legendFormat:   ""
				refId:          "B"
				step:           10
			}, {
				expr:           "sort_desc(avg(irate(container_network_receive_bytes_total{cluster=\"$cluster\",namespace=~\".+\"}[$interval:$resolution])) by (namespace))"
				format:         "table"
				instant:        true
				intervalFactor: 2
				legendFormat:   ""
				refId:          "C"
				step:           10
			}, {
				expr:           "sort_desc(avg(irate(container_network_transmit_bytes_total{cluster=\"$cluster\",namespace=~\".+\"}[$interval:$resolution])) by (namespace))"
				format:         "table"
				instant:        true
				intervalFactor: 2
				legendFormat:   ""
				refId:          "D"
				step:           10
			}, {
				expr:           "sort_desc(sum(irate(container_network_receive_packets_total{cluster=\"$cluster\",namespace=~\".+\"}[$interval:$resolution])) by (namespace))"
				format:         "table"
				instant:        true
				intervalFactor: 2
				legendFormat:   ""
				refId:          "E"
				step:           10
			}, {
				expr:           "sort_desc(sum(irate(container_network_transmit_packets_total{cluster=\"$cluster\",namespace=~\".+\"}[$interval:$resolution])) by (namespace))"
				format:         "table"
				instant:        true
				intervalFactor: 2
				legendFormat:   ""
				refId:          "F"
				step:           10
			}, {
				expr:           "sort_desc(sum(irate(container_network_receive_packets_dropped_total{cluster=\"$cluster\",namespace=~\".+\"}[$interval:$resolution])) by (namespace))"
				format:         "table"
				instant:        true
				intervalFactor: 2
				legendFormat:   ""
				refId:          "G"
				step:           10
			}, {
				expr:           "sort_desc(sum(irate(container_network_transmit_packets_dropped_total{cluster=\"$cluster\",namespace=~\".+\"}[$interval:$resolution])) by (namespace))"
				format:         "table"
				instant:        true
				intervalFactor: 2
				legendFormat:   ""
				refId:          "H"
				step:           10
			}]
			timeFrom:  null
			timeShift: null
			title:     "Current Status"
			type:      "table"
		}, {
			collapse:  true
			collapsed: true
			gridPos: {
				h: 1
				w: 24
				x: 0
				y: 10
			}
			id: 6
			panels: [{
				aliasColors: {}
				bars:         true
				dashLength:   10
				dashes:       false
				datasource:   "$datasource"
				fill:         2
				fillGradient: 0
				gridPos: {
					h: 9
					w: 12
					x: 0
					y: 11
				}
				id: 7
				legend: {
					alignAsTable: true
					avg:          false
					current:      true
					hideEmpty:    true
					hideZero:     true
					max:          false
					min:          false
					rightSide:    true
					show:         true
					sideWidth:    null
					sort:         "current"
					sortDesc:     true
					total:        false
					values:       true
				}
				lines:     false
				linewidth: 1
				links: []
				minSpan:       24
				nullPointMode: "null"
				paceLength:    10
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				repeat:        null
				seriesOverrides: []
				spaceLength: 10
				span:        24
				stack:       false
				steppedLine: false
				targets: [{
					expr:           "sort_desc(avg(irate(container_network_receive_bytes_total{cluster=\"$cluster\",namespace=~\".+\"}[$interval:$resolution])) by (namespace))"
					format:         "time_series"
					intervalFactor: 1
					legendFormat:   "{{namespace}}"
					refId:          "A"
					step:           10
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Average Rate of Bytes Received"
				tooltip: {
					shared:     true
					sort:       2
					value_type: "individual"
				}
				type: "graph"
				xaxis: {
					buckets: null
					mode:    "series"
					name:    null
					show:    false
					values: ["current"]
				}
				yaxes: [{
					format:  "Bps"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "Bps"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}]
			}, {
				aliasColors: {}
				bars:         true
				dashLength:   10
				dashes:       false
				datasource:   "$datasource"
				fill:         2
				fillGradient: 0
				gridPos: {
					h: 9
					w: 12
					x: 12
					y: 11
				}
				id: 8
				legend: {
					alignAsTable: true
					avg:          false
					current:      true
					hideEmpty:    true
					hideZero:     true
					max:          false
					min:          false
					rightSide:    true
					show:         true
					sideWidth:    null
					sort:         "current"
					sortDesc:     true
					total:        false
					values:       true
				}
				lines:     false
				linewidth: 1
				links: []
				minSpan:       24
				nullPointMode: "null"
				paceLength:    10
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				repeat:        null
				seriesOverrides: []
				spaceLength: 10
				span:        24
				stack:       false
				steppedLine: false
				targets: [{
					expr:           "sort_desc(avg(irate(container_network_transmit_bytes_total{cluster=\"$cluster\",namespace=~\".+\"}[$interval:$resolution])) by (namespace))"
					format:         "time_series"
					intervalFactor: 1
					legendFormat:   "{{namespace}}"
					refId:          "A"
					step:           10
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Average Rate of Bytes Transmitted"
				tooltip: {
					shared:     true
					sort:       2
					value_type: "individual"
				}
				type: "graph"
				xaxis: {
					buckets: null
					mode:    "series"
					name:    null
					show:    false
					values: ["current"]
				}
				yaxes: [{
					format:  "Bps"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "Bps"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}]
			}]
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       true
			title:           "Average Bandwidth"
			titleSize:       "h6"
			type:            "row"
		}, {
			collapse:  false
			collapsed: false
			gridPos: {
				h: 1
				w: 24
				x: 0
				y: 11
			}
			id: 9
			panels: []
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       true
			title:           "Bandwidth History"
			titleSize:       "h6"
			type:            "row"
		}, {
			aliasColors: {}
			bars:         false
			dashLength:   10
			dashes:       false
			datasource:   "$datasource"
			fill:         2
			fillGradient: 0
			gridPos: {
				h: 9
				w: 24
				x: 0
				y: 12
			}
			id: 10
			legend: {
				alignAsTable: true
				avg:          true
				current:      true
				hideEmpty:    true
				hideZero:     true
				max:          true
				min:          true
				rightSide:    true
				show:         true
				sideWidth:    null
				total:        false
				values:       true
			}
			lines:     true
			linewidth: 2
			links: []
			minSpan:       24
			nullPointMode: "connected"
			paceLength:    10
			percentage:    false
			pointradius:   5
			points:        false
			renderer:      "flot"
			repeat:        null
			seriesOverrides: []
			spaceLength: 10
			span:        24
			stack:       true
			steppedLine: false
			targets: [{
				expr:           "sort_desc(sum(irate(container_network_receive_bytes_total{cluster=\"$cluster\",namespace=~\".+\"}[$interval:$resolution])) by (namespace))"
				format:         "time_series"
				intervalFactor: 1
				legendFormat:   "{{namespace}}"
				refId:          "A"
				step:           10
			}]
			thresholds: []
			timeFrom:  null
			timeShift: null
			title:     "Receive Bandwidth"
			tooltip: {
				shared:     true
				sort:       2
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
			yaxes: [{
				format:  "Bps"
				label:   null
				logBase: 1
				max:     null
				min:     0
				show:    true
			}, {
				format:  "Bps"
				label:   null
				logBase: 1
				max:     null
				min:     0
				show:    true
			}]
		}, {
			aliasColors: {}
			bars:         false
			dashLength:   10
			dashes:       false
			datasource:   "$datasource"
			fill:         2
			fillGradient: 0
			gridPos: {
				h: 9
				w: 24
				x: 0
				y: 21
			}
			id: 11
			legend: {
				alignAsTable: true
				avg:          true
				current:      true
				hideEmpty:    true
				hideZero:     true
				max:          true
				min:          true
				rightSide:    true
				show:         true
				sideWidth:    null
				total:        false
				values:       true
			}
			lines:     true
			linewidth: 2
			links: []
			minSpan:       24
			nullPointMode: "connected"
			paceLength:    10
			percentage:    false
			pointradius:   5
			points:        false
			renderer:      "flot"
			repeat:        null
			seriesOverrides: []
			spaceLength: 10
			span:        24
			stack:       true
			steppedLine: false
			targets: [{
				expr:           "sort_desc(sum(irate(container_network_transmit_bytes_total{cluster=\"$cluster\",namespace=~\".+\"}[$interval:$resolution])) by (namespace))"
				format:         "time_series"
				intervalFactor: 1
				legendFormat:   "{{namespace}}"
				refId:          "A"
				step:           10
			}]
			thresholds: []
			timeFrom:  null
			timeShift: null
			title:     "Transmit Bandwidth"
			tooltip: {
				shared:     true
				sort:       2
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
			yaxes: [{
				format:  "Bps"
				label:   null
				logBase: 1
				max:     null
				min:     0
				show:    true
			}, {
				format:  "Bps"
				label:   null
				logBase: 1
				max:     null
				min:     0
				show:    true
			}]
		}, {
			collapse:  true
			collapsed: true
			gridPos: {
				h: 1
				w: 24
				x: 0
				y: 30
			}
			id: 12
			panels: [{
				aliasColors: {}
				bars:         false
				dashLength:   10
				dashes:       false
				datasource:   "$datasource"
				fill:         2
				fillGradient: 0
				gridPos: {
					h: 9
					w: 24
					x: 0
					y: 31
				}
				id: 13
				legend: {
					alignAsTable: true
					avg:          true
					current:      true
					hideEmpty:    true
					hideZero:     true
					max:          true
					min:          true
					rightSide:    true
					show:         true
					sideWidth:    null
					total:        false
					values:       true
				}
				lines:     true
				linewidth: 2
				links: []
				minSpan:       24
				nullPointMode: "connected"
				paceLength:    10
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				repeat:        null
				seriesOverrides: []
				spaceLength: 10
				span:        24
				stack:       true
				steppedLine: false
				targets: [{
					expr:           "sort_desc(sum(irate(container_network_receive_packets_total{cluster=\"$cluster\",namespace=~\".+\"}[$interval:$resolution])) by (namespace))"
					format:         "time_series"
					intervalFactor: 1
					legendFormat:   "{{namespace}}"
					refId:          "A"
					step:           10
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Rate of Received Packets"
				tooltip: {
					shared:     true
					sort:       2
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
				yaxes: [{
					format:  "pps"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "pps"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}]
			}, {
				aliasColors: {}
				bars:         false
				dashLength:   10
				dashes:       false
				datasource:   "$datasource"
				fill:         2
				fillGradient: 0
				gridPos: {
					h: 9
					w: 24
					x: 0
					y: 40
				}
				id: 14
				legend: {
					alignAsTable: true
					avg:          true
					current:      true
					hideEmpty:    true
					hideZero:     true
					max:          true
					min:          true
					rightSide:    true
					show:         true
					sideWidth:    null
					total:        false
					values:       true
				}
				lines:     true
				linewidth: 2
				links: []
				minSpan:       24
				nullPointMode: "connected"
				paceLength:    10
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				repeat:        null
				seriesOverrides: []
				spaceLength: 10
				span:        24
				stack:       true
				steppedLine: false
				targets: [{
					expr:           "sort_desc(sum(irate(container_network_transmit_packets_total{cluster=\"$cluster\",namespace=~\".+\"}[$interval:$resolution])) by (namespace))"
					format:         "time_series"
					intervalFactor: 1
					legendFormat:   "{{namespace}}"
					refId:          "A"
					step:           10
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Rate of Transmitted Packets"
				tooltip: {
					shared:     true
					sort:       2
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
				yaxes: [{
					format:  "pps"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "pps"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}]
			}]
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       true
			title:           "Packets"
			titleSize:       "h6"
			type:            "row"
		}, {
			collapse:  true
			collapsed: true
			gridPos: {
				h: 1
				w: 24
				x: 0
				y: 31
			}
			id: 15
			panels: [{
				aliasColors: {}
				bars:         false
				dashLength:   10
				dashes:       false
				datasource:   "$datasource"
				fill:         2
				fillGradient: 0
				gridPos: {
					h: 9
					w: 24
					x: 0
					y: 50
				}
				id: 16
				legend: {
					alignAsTable: true
					avg:          true
					current:      true
					hideEmpty:    true
					hideZero:     true
					max:          true
					min:          true
					rightSide:    true
					show:         true
					sideWidth:    null
					total:        false
					values:       true
				}
				lines:     true
				linewidth: 2
				links: []
				minSpan:       24
				nullPointMode: "connected"
				paceLength:    10
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				repeat:        null
				seriesOverrides: []
				spaceLength: 10
				span:        24
				stack:       true
				steppedLine: false
				targets: [{
					expr:           "sort_desc(sum(irate(container_network_receive_packets_dropped_total{cluster=\"$cluster\",namespace=~\".+\"}[$interval:$resolution])) by (namespace))"
					format:         "time_series"
					intervalFactor: 1
					legendFormat:   "{{namespace}}"
					refId:          "A"
					step:           10
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Rate of Received Packets Dropped"
				tooltip: {
					shared:     true
					sort:       2
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
				yaxes: [{
					format:  "pps"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "pps"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}]
			}, {
				aliasColors: {}
				bars:         false
				dashLength:   10
				dashes:       false
				datasource:   "$datasource"
				fill:         2
				fillGradient: 0
				gridPos: {
					h: 9
					w: 24
					x: 0
					y: 59
				}
				id: 17
				legend: {
					alignAsTable: true
					avg:          true
					current:      true
					hideEmpty:    true
					hideZero:     true
					max:          true
					min:          true
					rightSide:    true
					show:         true
					sideWidth:    null
					total:        false
					values:       true
				}
				lines:     true
				linewidth: 2
				links: []
				minSpan:       24
				nullPointMode: "connected"
				paceLength:    10
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				repeat:        null
				seriesOverrides: []
				spaceLength: 10
				span:        24
				stack:       true
				steppedLine: false
				targets: [{
					expr:           "sort_desc(sum(irate(container_network_transmit_packets_dropped_total{cluster=\"$cluster\",namespace=~\".+\"}[$interval:$resolution])) by (namespace))"
					format:         "time_series"
					intervalFactor: 1
					legendFormat:   "{{namespace}}"
					refId:          "A"
					step:           10
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Rate of Transmitted Packets Dropped"
				tooltip: {
					shared:     true
					sort:       2
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
				yaxes: [{
					format:  "pps"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "pps"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}]
			}, {
				aliasColors: {}
				bars:         false
				dashLength:   10
				dashes:       false
				datasource:   "$datasource"
				fill:         2
				fillGradient: 0
				gridPos: {
					h: 9
					w: 24
					x: 0
					y: 59
				}
				id: 18
				legend: {
					alignAsTable: true
					avg:          true
					current:      true
					hideEmpty:    true
					hideZero:     true
					max:          true
					min:          true
					rightSide:    true
					show:         true
					sideWidth:    null
					total:        false
					values:       true
				}
				lines:     true
				linewidth: 2
				links: [{
					targetBlank: true
					title:       "What is TCP Retransmit?"
					url:         "https://accedian.com/enterprises/blog/network-packet-loss-retransmissions-and-duplicate-acknowledgements/"
				}]
				minSpan:       24
				nullPointMode: "connected"
				paceLength:    10
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				repeat:        null
				seriesOverrides: []
				spaceLength: 10
				span:        24
				stack:       true
				steppedLine: false
				targets: [{
					expr:           "sort_desc(sum(rate(node_netstat_Tcp_RetransSegs{cluster=\"$cluster\"}[$interval:$resolution]) / rate(node_netstat_Tcp_OutSegs{cluster=\"$cluster\"}[$interval:$resolution])) by (instance))"
					format:         "time_series"
					intervalFactor: 1
					legendFormat:   "{{instance}}"
					refId:          "A"
					step:           10
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Rate of TCP Retransmits out of all sent segments"
				tooltip: {
					shared:     true
					sort:       2
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
				yaxes: [{
					format:  "percentunit"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "percentunit"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}]
			}, {
				aliasColors: {}
				bars:         false
				dashLength:   10
				dashes:       false
				datasource:   "$datasource"
				fill:         2
				fillGradient: 0
				gridPos: {
					h: 9
					w: 24
					x: 0
					y: 59
				}
				id: 19
				legend: {
					alignAsTable: true
					avg:          true
					current:      true
					hideEmpty:    true
					hideZero:     true
					max:          true
					min:          true
					rightSide:    true
					show:         true
					sideWidth:    null
					total:        false
					values:       true
				}
				lines:     true
				linewidth: 2
				links: [{
					targetBlank: true
					title:       "Why monitor SYN retransmits?"
					url:         "https://github.com/prometheus/node_exporter/issues/1023#issuecomment-408128365"
				}]
				minSpan:       24
				nullPointMode: "connected"
				paceLength:    10
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				repeat:        null
				seriesOverrides: []
				spaceLength: 10
				span:        24
				stack:       true
				steppedLine: false
				targets: [{
					expr:           "sort_desc(sum(rate(node_netstat_TcpExt_TCPSynRetrans{cluster=\"$cluster\"}[$interval:$resolution]) / rate(node_netstat_Tcp_RetransSegs{cluster=\"$cluster\"}[$interval:$resolution])) by (instance))"
					format:         "time_series"
					intervalFactor: 1
					legendFormat:   "{{instance}}"
					refId:          "A"
					step:           10
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Rate of TCP SYN Retransmits out of all retransmits"
				tooltip: {
					shared:     true
					sort:       2
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
				yaxes: [{
					format:  "percentunit"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "percentunit"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}]
			}]
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       true
			title:           "Errors"
			titleSize:       "h6"
			type:            "row"
		}]
		refresh: "10s"
		rows: []
		schemaVersion: 18
		style:         "dark"
		tags: [
			"kubernetes-mixin",
		]
		templating: list: [{
			allValue:   null
			auto:       false
			auto_count: 30
			auto_min:   "10s"
			current: {
				text:  "5m"
				value: "5m"
			}
			datasource: "$datasource"
			hide:       0
			includeAll: false
			label:      null
			multi:      false
			name:       "resolution"
			options: [{
				selected: false
				text:     "30s"
				value:    "30s"
			}, {
				selected: true
				text:     "5m"
				value:    "5m"
			}, {
				selected: false
				text:     "1h"
				value:    "1h"
			}]
			query:          "30s,5m,1h"
			refresh:        2
			regex:          ""
			skipUrlSync:    false
			sort:           1
			tagValuesQuery: ""
			tags: []
			tagsQuery: ""
			type:      "interval"
			useTags:   false
		}, {
			allValue:   null
			auto:       false
			auto_count: 30
			auto_min:   "10s"
			current: {
				text:  "5m"
				value: "5m"
			}
			datasource: "$datasource"
			hide:       2
			includeAll: false
			label:      null
			multi:      false
			name:       "interval"
			options: [{
				selected: true
				text:     "4h"
				value:    "4h"
			}]
			query:          "4h"
			refresh:        2
			regex:          ""
			skipUrlSync:    false
			sort:           1
			tagValuesQuery: ""
			tags: []
			tagsQuery: ""
			type:      "interval"
			useTags:   false
		}, {
			current: {
				text:  "default"
				value: "default"
			}
			hide:  0
			label: "Data Source"
			name:  "datasource"
			options: []
			query:   "prometheus"
			refresh: 1
			regex:   ""
			type:    "datasource"
		}, {
			allValue: null
			current: {}
			datasource: "$datasource"
			hide:       2
			includeAll: false
			label:      null
			multi:      false
			name:       "cluster"
			options: []
			query:          "label_values(up{job=\"kubelet\", metrics_path=\"/metrics/cadvisor\"}, cluster)"
			refresh:        2
			regex:          ""
			sort:           0
			tagValuesQuery: ""
			tags: []
			tagsQuery: ""
			type:      "query"
			useTags:   false
		}]
		time: {
			from: "now-1h"
			to:   "now"
		}
		timepicker: {
			refresh_intervals: ["5s", "10s", "30s", "1m", "5m", "15m", "30m", "1h", "2h", "1d"]
			time_options: ["5m", "15m", "1h", "6h", "12h", "24h", "2d", "7d", "30d"]
		}
		timezone: "UTC"
		title:    "Kubernetes / Networking / Cluster"
		uid:      "ff635a025bcfea7bc3dd4f508990a3e9"
		version:  0
	}
	"controller-manager.json": {
		"__inputs": []
		"__requires": []
		annotations: list: []
		editable:     false
		gnetId:       null
		graphTooltip: 0
		hideControls: false
		id:           null
		links: []
		refresh: "10s"
		rows: [{
			collapse:  false
			collapsed: false
			panels: [{
				cacheTimeout:    null
				colorBackground: false
				colorValue:      false
				colors: ["#299c46", "rgba(237, 129, 40, 0.89)", "#d44a3a"]
				datasource: "$datasource"
				format:     "none"
				gauge: {
					maxValue:         100
					minValue:         0
					show:             false
					thresholdLabels:  false
					thresholdMarkers: true
				}
				gridPos: {}
				id:       2
				interval: "1m"
				legend: {
					alignAsTable: true
					rightSide:    true
				}
				links: []
				mappingType: 1
				mappingTypes: [{
					name:  "value to text"
					value: 1
				}, {
					name:  "range to text"
					value: 2
				}]
				maxDataPoints:   100
				nullPointMode:   "connected"
				nullText:        null
				postfix:         ""
				postfixFontSize: "50%"
				prefix:          ""
				prefixFontSize:  "50%"
				rangeMaps: [{
					from: "null"
					text: "N/A"
					to:   "null"
				}]
				span: 2
				sparkline: {
					fillColor: "rgba(31, 118, 189, 0.18)"
					full:      false
					lineColor: "rgb(31, 120, 193)"
					show:      false
				}
				tableColumn: ""
				targets: [{
					expr:           "sum(up{cluster=\"$cluster\", job=\"kube-controller-manager\"})"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   ""
					refId:          "A"
				}]
				thresholds: ""
				title:      "Up"
				tooltip: shared: false
				type:          "singlestat"
				valueFontSize: "80%"
				valueMaps: [{
					op:    "="
					text:  "N/A"
					value: "null"
				}]
				valueName: "min"
			}, {
				aliasColors: {}
				bars:         false
				dashLength:   10
				dashes:       false
				datasource:   "$datasource"
				fill:         1
				fillGradient: 0
				gridPos: {}
				id:       3
				interval: "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      true
					max:          false
					min:          false
					rightSide:    true
					show:         true
					sideWidth:    null
					total:        false
					values:       true
				}
				lines:     true
				linewidth: 1
				links: []
				nullPointMode: "null"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				repeat:        null
				seriesOverrides: []
				spaceLength: 10
				span:        10
				stack:       false
				steppedLine: false
				targets: [{
					expr:           "sum(rate(workqueue_adds_total{cluster=\"$cluster\", job=\"kube-controller-manager\", instance=~\"$instance\"}[$__rate_interval])) by (cluster, instance, name)"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{cluster}} {{instance}} {{name}}"
					refId:          "A"
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Work Queue Add Rate"
				tooltip: {
					shared:     false
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
				yaxes: [{
					format:  "ops"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    true
				}, {
					format:  "ops"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    true
				}]
			}]
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       false
			title:           "Dashboard Row"
			titleSize:       "h6"
			type:            "row"
		}, {
			collapse:  false
			collapsed: false
			panels: [{
				aliasColors: {}
				bars:         false
				dashLength:   10
				dashes:       false
				datasource:   "$datasource"
				fill:         1
				fillGradient: 0
				gridPos: {}
				id:       4
				interval: "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      true
					max:          false
					min:          false
					rightSide:    true
					show:         true
					sideWidth:    null
					total:        false
					values:       true
				}
				lines:     true
				linewidth: 1
				links: []
				nullPointMode: "null"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				repeat:        null
				seriesOverrides: []
				spaceLength: 10
				span:        12
				stack:       false
				steppedLine: false
				targets: [{
					expr:           "sum(rate(workqueue_depth{cluster=\"$cluster\", job=\"kube-controller-manager\", instance=~\"$instance\"}[$__rate_interval])) by (cluster, instance, name)"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{cluster}} {{instance}} {{name}}"
					refId:          "A"
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Work Queue Depth"
				tooltip: {
					shared:     false
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
				yaxes: [{
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}]
			}]
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       false
			title:           "Dashboard Row"
			titleSize:       "h6"
			type:            "row"
		}, {
			collapse:  false
			collapsed: false
			panels: [{
				aliasColors: {}
				bars:         false
				dashLength:   10
				dashes:       false
				datasource:   "$datasource"
				fill:         1
				fillGradient: 0
				gridPos: {}
				id:       5
				interval: "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      true
					max:          false
					min:          false
					rightSide:    true
					show:         true
					sideWidth:    null
					total:        false
					values:       true
				}
				lines:     true
				linewidth: 1
				links: []
				nullPointMode: "null"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				repeat:        null
				seriesOverrides: []
				spaceLength: 10
				span:        12
				stack:       false
				steppedLine: false
				targets: [{
					expr:           "histogram_quantile(0.99, sum(rate(workqueue_queue_duration_seconds_bucket{cluster=\"$cluster\", job=\"kube-controller-manager\", instance=~\"$instance\"}[$__rate_interval])) by (cluster, instance, name, le))"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{cluster}} {{instance}} {{name}}"
					refId:          "A"
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Work Queue Latency"
				tooltip: {
					shared:     false
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
				yaxes: [{
					format:  "s"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    true
				}, {
					format:  "s"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    true
				}]
			}]
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       false
			title:           "Dashboard Row"
			titleSize:       "h6"
			type:            "row"
		}, {
			collapse:  false
			collapsed: false
			panels: [{
				aliasColors: {}
				bars:         false
				dashLength:   10
				dashes:       false
				datasource:   "$datasource"
				fill:         1
				fillGradient: 0
				gridPos: {}
				id:       6
				interval: "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					sideWidth:    null
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 1
				links: []
				nullPointMode: "null"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				repeat:        null
				seriesOverrides: []
				spaceLength: 10
				span:        4
				stack:       false
				steppedLine: false
				targets: [{
					expr:           "sum(rate(rest_client_requests_total{job=\"kube-controller-manager\", instance=~\"$instance\",code=~\"2..\"}[$__rate_interval]))"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "2xx"
					refId:          "A"
				}, {
					expr:           "sum(rate(rest_client_requests_total{job=\"kube-controller-manager\", instance=~\"$instance\",code=~\"3..\"}[$__rate_interval]))"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "3xx"
					refId:          "B"
				}, {
					expr:           "sum(rate(rest_client_requests_total{job=\"kube-controller-manager\", instance=~\"$instance\",code=~\"4..\"}[$__rate_interval]))"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "4xx"
					refId:          "C"
				}, {
					expr:           "sum(rate(rest_client_requests_total{job=\"kube-controller-manager\", instance=~\"$instance\",code=~\"5..\"}[$__rate_interval]))"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "5xx"
					refId:          "D"
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Kube API Request Rate"
				tooltip: {
					shared:     false
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
				yaxes: [{
					format:  "ops"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    true
				}, {
					format:  "ops"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    true
				}]
			}, {
				aliasColors: {}
				bars:         false
				dashLength:   10
				dashes:       false
				datasource:   "$datasource"
				fill:         1
				fillGradient: 0
				gridPos: {}
				id:       7
				interval: "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					sideWidth:    null
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 1
				links: []
				nullPointMode: "null"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				repeat:        null
				seriesOverrides: []
				spaceLength: 10
				span:        8
				stack:       false
				steppedLine: false
				targets: [{
					expr:           "histogram_quantile(0.99, sum(rate(rest_client_request_duration_seconds_bucket{cluster=\"$cluster\", job=\"kube-controller-manager\", instance=~\"$instance\", verb=\"POST\"}[$__rate_interval])) by (verb, url, le))"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{verb}} {{url}}"
					refId:          "A"
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Post Request Latency 99th Quantile"
				tooltip: {
					shared:     false
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
				yaxes: [{
					format:  "s"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "s"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}]
			}]
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       false
			title:           "Dashboard Row"
			titleSize:       "h6"
			type:            "row"
		}, {
			collapse:  false
			collapsed: false
			panels: [{
				aliasColors: {}
				bars:         false
				dashLength:   10
				dashes:       false
				datasource:   "$datasource"
				fill:         1
				fillGradient: 0
				gridPos: {}
				id:       8
				interval: "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      true
					max:          false
					min:          false
					rightSide:    true
					show:         true
					sideWidth:    null
					total:        false
					values:       true
				}
				lines:     true
				linewidth: 1
				links: []
				nullPointMode: "null"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				repeat:        null
				seriesOverrides: []
				spaceLength: 10
				span:        12
				stack:       false
				steppedLine: false
				targets: [{
					expr:           "histogram_quantile(0.99, sum(rate(rest_client_request_duration_seconds_bucket{cluster=\"$cluster\", job=\"kube-controller-manager\", instance=~\"$instance\", verb=\"GET\"}[$__rate_interval])) by (verb, url, le))"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{verb}} {{url}}"
					refId:          "A"
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Get Request Latency 99th Quantile"
				tooltip: {
					shared:     false
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
				yaxes: [{
					format:  "s"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "s"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}]
			}]
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       false
			title:           "Dashboard Row"
			titleSize:       "h6"
			type:            "row"
		}, {
			collapse:  false
			collapsed: false
			panels: [{
				aliasColors: {}
				bars:         false
				dashLength:   10
				dashes:       false
				datasource:   "$datasource"
				fill:         1
				fillGradient: 0
				gridPos: {}
				id:       9
				interval: "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					sideWidth:    null
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 1
				links: []
				nullPointMode: "null"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				repeat:        null
				seriesOverrides: []
				spaceLength: 10
				span:        4
				stack:       false
				steppedLine: false
				targets: [{
					expr:           "process_resident_memory_bytes{cluster=\"$cluster\", job=\"kube-controller-manager\",instance=~\"$instance\"}"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{instance}}"
					refId:          "A"
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Memory"
				tooltip: {
					shared:     false
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
				yaxes: [{
					format:  "bytes"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    true
				}, {
					format:  "bytes"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    true
				}]
			}, {
				aliasColors: {}
				bars:         false
				dashLength:   10
				dashes:       false
				datasource:   "$datasource"
				fill:         1
				fillGradient: 0
				gridPos: {}
				id:       10
				interval: "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					sideWidth:    null
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 1
				links: []
				nullPointMode: "null"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				repeat:        null
				seriesOverrides: []
				spaceLength: 10
				span:        4
				stack:       false
				steppedLine: false
				targets: [{
					expr:           "rate(process_cpu_seconds_total{cluster=\"$cluster\", job=\"kube-controller-manager\",instance=~\"$instance\"}[$__rate_interval])"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{instance}}"
					refId:          "A"
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "CPU usage"
				tooltip: {
					shared:     false
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
				yaxes: [{
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}]
			}, {
				aliasColors: {}
				bars:         false
				dashLength:   10
				dashes:       false
				datasource:   "$datasource"
				fill:         1
				fillGradient: 0
				gridPos: {}
				id:       11
				interval: "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					sideWidth:    null
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 1
				links: []
				nullPointMode: "null"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				repeat:        null
				seriesOverrides: []
				spaceLength: 10
				span:        4
				stack:       false
				steppedLine: false
				targets: [{
					expr:           "go_goroutines{cluster=\"$cluster\", job=\"kube-controller-manager\",instance=~\"$instance\"}"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{instance}}"
					refId:          "A"
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Goroutines"
				tooltip: {
					shared:     false
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
				yaxes: [{
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    true
				}, {
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    true
				}]
			}]
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       false
			title:           "Dashboard Row"
			titleSize:       "h6"
			type:            "row"
		}]
		schemaVersion: 14
		style:         "dark"
		tags: [
			"kubernetes-mixin",
		]
		templating: list: [{
			current: {
				text:  "default"
				value: "default"
			}
			hide:  0
			label: "Data Source"
			name:  "datasource"
			options: []
			query:   "prometheus"
			refresh: 1
			regex:   ""
			type:    "datasource"
		}, {
			allValue: null
			current: {}
			datasource: "$datasource"
			hide:       2
			includeAll: false
			label:      "cluster"
			multi:      false
			name:       "cluster"
			options: []
			query:          "label_values(up{job=\"kube-controller-manager\"}, cluster)"
			refresh:        2
			regex:          ""
			sort:           1
			tagValuesQuery: ""
			tags: []
			tagsQuery: ""
			type:      "query"
			useTags:   false
		}, {
			allValue: null
			current: {}
			datasource: "$datasource"
			hide:       0
			includeAll: true
			label:      null
			multi:      false
			name:       "instance"
			options: []
			query:          "label_values(up{cluster=\"$cluster\", job=\"kube-controller-manager\"}, instance)"
			refresh:        2
			regex:          ""
			sort:           1
			tagValuesQuery: ""
			tags: []
			tagsQuery: ""
			type:      "query"
			useTags:   false
		}]
		time: {
			from: "now-1h"
			to:   "now"
		}
		timepicker: {
			refresh_intervals: ["5s", "10s", "30s", "1m", "5m", "15m", "30m", "1h", "2h", "1d"]
			time_options: ["5m", "15m", "1h", "6h", "12h", "24h", "2d", "7d", "30d"]
		}
		timezone: "UTC"
		title:    "Kubernetes / Controller Manager"
		uid:      "72e0e05bef5099e5f049b05fdc429ed4"
		version:  0
	}
	"k8s-resources-cluster.json": {
		annotations: list: []
		editable:     true
		gnetId:       null
		graphTooltip: 0
		hideControls: false
		links: []
		refresh: "10s"
		rows: [{
			collapse: false
			height:   "100px"
			panels: [{
				aliasColors: {}
				bars:       false
				dashLength: 10
				dashes:     false
				datasource: "$datasource"
				fill:       1
				format:     "percentunit"
				id:         1
				interval:   "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 1
				links: []
				nullPointMode: "null as zero"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				seriesOverrides: []
				spaceLength: 10
				span:        2
				stack:       false
				steppedLine: false
				targets: [{
					expr:           "1 - sum(avg by (mode) (rate(node_cpu_seconds_total{job=\"node-exporter\", mode=~\"idle|iowait|steal\", cluster=\"$cluster\"}[$__rate_interval])))"
					format:         "time_series"
					instant:        true
					intervalFactor: 2
					refId:          "A"
				}]
				thresholds: "70,80"
				timeFrom:   null
				timeShift:  null
				title:      "CPU Utilisation"
				tooltip: {
					shared:     false
					sort:       2
					value_type: "individual"
				}
				type: "singlestat"
				xaxis: {
					buckets: null
					mode:    "time"
					name:    null
					show:    true
					values: []
				}
				yaxes: [{
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    false
				}]
			}, {
				aliasColors: {}
				bars:       false
				dashLength: 10
				dashes:     false
				datasource: "$datasource"
				fill:       1
				format:     "percentunit"
				id:         2
				interval:   "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 1
				links: []
				nullPointMode: "null as zero"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				seriesOverrides: []
				spaceLength: 10
				span:        2
				stack:       false
				steppedLine: false
				targets: [{
					expr:           "sum(namespace_cpu:kube_pod_container_resource_requests:sum{cluster=\"$cluster\"}) / sum(kube_node_status_allocatable{job=\"kube-state-metrics\",resource=\"cpu\",cluster=\"$cluster\"})"
					format:         "time_series"
					instant:        true
					intervalFactor: 2
					refId:          "A"
				}]
				thresholds: "70,80"
				timeFrom:   null
				timeShift:  null
				title:      "CPU Requests Commitment"
				tooltip: {
					shared:     false
					sort:       2
					value_type: "individual"
				}
				type: "singlestat"
				xaxis: {
					buckets: null
					mode:    "time"
					name:    null
					show:    true
					values: []
				}
				yaxes: [{
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    false
				}]
			}, {
				aliasColors: {}
				bars:       false
				dashLength: 10
				dashes:     false
				datasource: "$datasource"
				fill:       1
				format:     "percentunit"
				id:         3
				interval:   "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 1
				links: []
				nullPointMode: "null as zero"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				seriesOverrides: []
				spaceLength: 10
				span:        2
				stack:       false
				steppedLine: false
				targets: [{
					expr:           "sum(namespace_cpu:kube_pod_container_resource_limits:sum{cluster=\"$cluster\"}) / sum(kube_node_status_allocatable{job=\"kube-state-metrics\",resource=\"cpu\",cluster=\"$cluster\"})"
					format:         "time_series"
					instant:        true
					intervalFactor: 2
					refId:          "A"
				}]
				thresholds: "70,80"
				timeFrom:   null
				timeShift:  null
				title:      "CPU Limits Commitment"
				tooltip: {
					shared:     false
					sort:       2
					value_type: "individual"
				}
				type: "singlestat"
				xaxis: {
					buckets: null
					mode:    "time"
					name:    null
					show:    true
					values: []
				}
				yaxes: [{
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    false
				}]
			}, {
				aliasColors: {}
				bars:       false
				dashLength: 10
				dashes:     false
				datasource: "$datasource"
				fill:       1
				format:     "percentunit"
				id:         4
				interval:   "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 1
				links: []
				nullPointMode: "null as zero"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				seriesOverrides: []
				spaceLength: 10
				span:        2
				stack:       false
				steppedLine: false
				targets: [{
					expr:           "1 - sum(:node_memory_MemAvailable_bytes:sum{cluster=\"$cluster\"}) / sum(node_memory_MemTotal_bytes{job=\"node-exporter\",cluster=\"$cluster\"})"
					format:         "time_series"
					instant:        true
					intervalFactor: 2
					refId:          "A"
				}]
				thresholds: "70,80"
				timeFrom:   null
				timeShift:  null
				title:      "Memory Utilisation"
				tooltip: {
					shared:     false
					sort:       2
					value_type: "individual"
				}
				type: "singlestat"
				xaxis: {
					buckets: null
					mode:    "time"
					name:    null
					show:    true
					values: []
				}
				yaxes: [{
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    false
				}]
			}, {
				aliasColors: {}
				bars:       false
				dashLength: 10
				dashes:     false
				datasource: "$datasource"
				fill:       1
				format:     "percentunit"
				id:         5
				interval:   "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 1
				links: []
				nullPointMode: "null as zero"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				seriesOverrides: []
				spaceLength: 10
				span:        2
				stack:       false
				steppedLine: false
				targets: [{
					expr:           "sum(namespace_memory:kube_pod_container_resource_requests:sum{cluster=\"$cluster\"}) / sum(kube_node_status_allocatable{job=\"kube-state-metrics\",resource=\"memory\",cluster=\"$cluster\"})"
					format:         "time_series"
					instant:        true
					intervalFactor: 2
					refId:          "A"
				}]
				thresholds: "70,80"
				timeFrom:   null
				timeShift:  null
				title:      "Memory Requests Commitment"
				tooltip: {
					shared:     false
					sort:       2
					value_type: "individual"
				}
				type: "singlestat"
				xaxis: {
					buckets: null
					mode:    "time"
					name:    null
					show:    true
					values: []
				}
				yaxes: [{
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    false
				}]
			}, {
				aliasColors: {}
				bars:       false
				dashLength: 10
				dashes:     false
				datasource: "$datasource"
				fill:       1
				format:     "percentunit"
				id:         6
				interval:   "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 1
				links: []
				nullPointMode: "null as zero"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				seriesOverrides: []
				spaceLength: 10
				span:        2
				stack:       false
				steppedLine: false
				targets: [{
					expr:           "sum(namespace_memory:kube_pod_container_resource_limits:sum{cluster=\"$cluster\"}) / sum(kube_node_status_allocatable{job=\"kube-state-metrics\",resource=\"memory\",cluster=\"$cluster\"})"
					format:         "time_series"
					instant:        true
					intervalFactor: 2
					refId:          "A"
				}]
				thresholds: "70,80"
				timeFrom:   null
				timeShift:  null
				title:      "Memory Limits Commitment"
				tooltip: {
					shared:     false
					sort:       2
					value_type: "individual"
				}
				type: "singlestat"
				xaxis: {
					buckets: null
					mode:    "time"
					name:    null
					show:    true
					values: []
				}
				yaxes: [{
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    false
				}]
			}]
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       false
			title:           "Headlines"
			titleSize:       "h6"
		}, {
			collapse: false
			height:   "250px"
			panels: [{
				aliasColors: {}
				bars:       false
				dashLength: 10
				dashes:     false
				datasource: "$datasource"
				fill:       10
				id:         7
				interval:   "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 0
				links: []
				nullPointMode: "null as zero"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				seriesOverrides: []
				spaceLength: 10
				span:        12
				stack:       true
				steppedLine: false
				targets: [{
					expr:           "sum(node_namespace_pod_container:container_cpu_usage_seconds_total:sum_irate{cluster=\"$cluster\"}) by (namespace)"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{namespace}}"
					legendLink:     null
					step:           10
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "CPU Usage"
				tooltip: {
					shared:     false
					sort:       2
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
				yaxes: [{
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    false
				}]
			}]
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       true
			title:           "CPU"
			titleSize:       "h6"
		}, {
			collapse: false
			height:   "250px"
			panels: [{
				aliasColors: {}
				bars:       false
				dashLength: 10
				dashes:     false
				datasource: "$datasource"
				fill:       1
				id:         8
				interval:   "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 1
				links: []
				nullPointMode: "null as zero"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				seriesOverrides: []
				spaceLength: 10
				span:        12
				stack:       false
				steppedLine: false
				styles: [{
					alias:      "Time"
					dateFormat: "YYYY-MM-DD HH:mm:ss"
					pattern:    "Time"
					type:       "hidden"
				}, {
					alias:     "Pods"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        0
					link:            true
					linkTargetBlank: false
					linkTooltip:     "Drill down to pods"
					linkUrl:         "/d/85a562078cdf77779eaa1add43ccec1e/k8s-resources-namespace?var-datasource=$datasource&var-cluster=$cluster&var-namespace=$__cell_1"
					pattern:         "Value #A"
					thresholds: []
					type: "number"
					unit: "short"
				}, {
					alias:     "Workloads"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        0
					link:            true
					linkTargetBlank: false
					linkTooltip:     "Drill down to workloads"
					linkUrl:         "/d/a87fb0d919ec0ea5f6543124e16c42a5/k8s-resources-workloads-namespace?var-datasource=$datasource&var-cluster=$cluster&var-namespace=$__cell_1"
					pattern:         "Value #B"
					thresholds: []
					type: "number"
					unit: "short"
				}, {
					alias:     "CPU Usage"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #C"
					thresholds: []
					type: "number"
					unit: "short"
				}, {
					alias:     "CPU Requests"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #D"
					thresholds: []
					type: "number"
					unit: "short"
				}, {
					alias:     "CPU Requests %"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #E"
					thresholds: []
					type: "number"
					unit: "percentunit"
				}, {
					alias:     "CPU Limits"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #F"
					thresholds: []
					type: "number"
					unit: "short"
				}, {
					alias:     "CPU Limits %"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #G"
					thresholds: []
					type: "number"
					unit: "percentunit"
				}, {
					alias:     "Namespace"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            true
					linkTargetBlank: false
					linkTooltip:     "Drill down to pods"
					linkUrl:         "/d/85a562078cdf77779eaa1add43ccec1e/k8s-resources-namespace?var-datasource=$datasource&var-cluster=$cluster&var-namespace=$__cell"
					pattern:         "namespace"
					thresholds: []
					type: "number"
					unit: "short"
				}, {
					alias:     ""
					colorMode: null
					colors: []
					dateFormat: "YYYY-MM-DD HH:mm:ss"
					decimals:   2
					pattern:    "/.*/"
					thresholds: []
					type: "string"
					unit: "short"
				}]
				targets: [{
					expr:           "sum(kube_pod_owner{job=\"kube-state-metrics\", cluster=\"$cluster\"}) by (namespace)"
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "A"
					step:           10
				}, {
					expr:           "count(avg(namespace_workload_pod:kube_pod_owner:relabel{cluster=\"$cluster\"}) by (workload, namespace)) by (namespace)"
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "B"
					step:           10
				}, {
					expr:           "sum(node_namespace_pod_container:container_cpu_usage_seconds_total:sum_irate{cluster=\"$cluster\"}) by (namespace)"
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "C"
					step:           10
				}, {
					expr:           "sum(namespace_cpu:kube_pod_container_resource_requests:sum{cluster=\"$cluster\"}) by (namespace)"
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "D"
					step:           10
				}, {
					expr:           "sum(node_namespace_pod_container:container_cpu_usage_seconds_total:sum_irate{cluster=\"$cluster\"}) by (namespace) / sum(namespace_cpu:kube_pod_container_resource_requests:sum{cluster=\"$cluster\"}) by (namespace)"
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "E"
					step:           10
				}, {
					expr:           "sum(namespace_cpu:kube_pod_container_resource_limits:sum{cluster=\"$cluster\"}) by (namespace)"
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "F"
					step:           10
				}, {
					expr:           "sum(node_namespace_pod_container:container_cpu_usage_seconds_total:sum_irate{cluster=\"$cluster\"}) by (namespace) / sum(namespace_cpu:kube_pod_container_resource_limits:sum{cluster=\"$cluster\"}) by (namespace)"
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "G"
					step:           10
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "CPU Quota"
				tooltip: {
					shared:     false
					sort:       2
					value_type: "individual"
				}
				transform: "table"
				type:      "table"
				xaxis: {
					buckets: null
					mode:    "time"
					name:    null
					show:    true
					values: []
				}
				yaxes: [{
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    false
				}]
			}]
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       true
			title:           "CPU Quota"
			titleSize:       "h6"
		}, {
			collapse: false
			height:   "250px"
			panels: [{
				aliasColors: {}
				bars:       false
				dashLength: 10
				dashes:     false
				datasource: "$datasource"
				fill:       10
				id:         9
				interval:   "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 0
				links: []
				nullPointMode: "null as zero"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				seriesOverrides: []
				spaceLength: 10
				span:        12
				stack:       true
				steppedLine: false
				targets: [{
					expr:           "sum(container_memory_rss{job=\"kubelet\", metrics_path=\"/metrics/cadvisor\", cluster=\"$cluster\", container!=\"\"}) by (namespace)"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{namespace}}"
					legendLink:     null
					step:           10
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Memory Usage (w/o cache)"
				tooltip: {
					shared:     false
					sort:       2
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
				yaxes: [{
					format:  "bytes"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    false
				}]
			}]
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       true
			title:           "Memory"
			titleSize:       "h6"
		}, {
			collapse: false
			height:   "250px"
			panels: [{
				aliasColors: {}
				bars:       false
				dashLength: 10
				dashes:     false
				datasource: "$datasource"
				fill:       1
				id:         10
				interval:   "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 1
				links: []
				nullPointMode: "null as zero"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				seriesOverrides: []
				spaceLength: 10
				span:        12
				stack:       false
				steppedLine: false
				styles: [{
					alias:      "Time"
					dateFormat: "YYYY-MM-DD HH:mm:ss"
					pattern:    "Time"
					type:       "hidden"
				}, {
					alias:     "Pods"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        0
					link:            true
					linkTargetBlank: false
					linkTooltip:     "Drill down to pods"
					linkUrl:         "/d/85a562078cdf77779eaa1add43ccec1e/k8s-resources-namespace?var-datasource=$datasource&var-cluster=$cluster&var-namespace=$__cell_1"
					pattern:         "Value #A"
					thresholds: []
					type: "number"
					unit: "short"
				}, {
					alias:     "Workloads"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        0
					link:            true
					linkTargetBlank: false
					linkTooltip:     "Drill down to workloads"
					linkUrl:         "/d/a87fb0d919ec0ea5f6543124e16c42a5/k8s-resources-workloads-namespace?var-datasource=$datasource&var-cluster=$cluster&var-namespace=$__cell_1"
					pattern:         "Value #B"
					thresholds: []
					type: "number"
					unit: "short"
				}, {
					alias:     "Memory Usage"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #C"
					thresholds: []
					type: "number"
					unit: "bytes"
				}, {
					alias:     "Memory Requests"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #D"
					thresholds: []
					type: "number"
					unit: "bytes"
				}, {
					alias:     "Memory Requests %"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #E"
					thresholds: []
					type: "number"
					unit: "percentunit"
				}, {
					alias:     "Memory Limits"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #F"
					thresholds: []
					type: "number"
					unit: "bytes"
				}, {
					alias:     "Memory Limits %"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #G"
					thresholds: []
					type: "number"
					unit: "percentunit"
				}, {
					alias:     "Namespace"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            true
					linkTargetBlank: false
					linkTooltip:     "Drill down to pods"
					linkUrl:         "/d/85a562078cdf77779eaa1add43ccec1e/k8s-resources-namespace?var-datasource=$datasource&var-cluster=$cluster&var-namespace=$__cell"
					pattern:         "namespace"
					thresholds: []
					type: "number"
					unit: "short"
				}, {
					alias:     ""
					colorMode: null
					colors: []
					dateFormat: "YYYY-MM-DD HH:mm:ss"
					decimals:   2
					pattern:    "/.*/"
					thresholds: []
					type: "string"
					unit: "short"
				}]
				targets: [{
					expr:           "sum(kube_pod_owner{job=\"kube-state-metrics\", cluster=\"$cluster\"}) by (namespace)"
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "A"
					step:           10
				}, {
					expr:           "count(avg(namespace_workload_pod:kube_pod_owner:relabel{cluster=\"$cluster\"}) by (workload, namespace)) by (namespace)"
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "B"
					step:           10
				}, {
					expr:           "sum(container_memory_rss{job=\"kubelet\", metrics_path=\"/metrics/cadvisor\", cluster=\"$cluster\", container!=\"\"}) by (namespace)"
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "C"
					step:           10
				}, {
					expr:           "sum(namespace_memory:kube_pod_container_resource_requests:sum{cluster=\"$cluster\"}) by (namespace)"
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "D"
					step:           10
				}, {
					expr:           "sum(container_memory_rss{job=\"kubelet\", metrics_path=\"/metrics/cadvisor\", cluster=\"$cluster\", container!=\"\"}) by (namespace) / sum(namespace_memory:kube_pod_container_resource_requests:sum{cluster=\"$cluster\"}) by (namespace)"
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "E"
					step:           10
				}, {
					expr:           "sum(namespace_memory:kube_pod_container_resource_limits:sum{cluster=\"$cluster\"}) by (namespace)"
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "F"
					step:           10
				}, {
					expr:           "sum(container_memory_rss{job=\"kubelet\", metrics_path=\"/metrics/cadvisor\", cluster=\"$cluster\", container!=\"\"}) by (namespace) / sum(namespace_memory:kube_pod_container_resource_limits:sum{cluster=\"$cluster\"}) by (namespace)"
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "G"
					step:           10
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Requests by Namespace"
				tooltip: {
					shared:     false
					sort:       2
					value_type: "individual"
				}
				transform: "table"
				type:      "table"
				xaxis: {
					buckets: null
					mode:    "time"
					name:    null
					show:    true
					values: []
				}
				yaxes: [{
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    false
				}]
			}]
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       true
			title:           "Memory Requests"
			titleSize:       "h6"
		}, {
			collapse: false
			height:   "250px"
			panels: [{
				aliasColors: {}
				bars:       false
				dashLength: 10
				dashes:     false
				datasource: "$datasource"
				fill:       1
				id:         11
				interval:   "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 1
				links: []
				nullPointMode: "null as zero"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				seriesOverrides: []
				spaceLength: 10
				span:        12
				stack:       false
				steppedLine: false
				styles: [{
					alias:      "Time"
					dateFormat: "YYYY-MM-DD HH:mm:ss"
					pattern:    "Time"
					type:       "hidden"
				}, {
					alias:     "Current Receive Bandwidth"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #A"
					thresholds: []
					type: "number"
					unit: "Bps"
				}, {
					alias:     "Current Transmit Bandwidth"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #B"
					thresholds: []
					type: "number"
					unit: "Bps"
				}, {
					alias:     "Rate of Received Packets"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #C"
					thresholds: []
					type: "number"
					unit: "pps"
				}, {
					alias:     "Rate of Transmitted Packets"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #D"
					thresholds: []
					type: "number"
					unit: "pps"
				}, {
					alias:     "Rate of Received Packets Dropped"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #E"
					thresholds: []
					type: "number"
					unit: "pps"
				}, {
					alias:     "Rate of Transmitted Packets Dropped"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #F"
					thresholds: []
					type: "number"
					unit: "pps"
				}, {
					alias:     "Namespace"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            true
					linkTargetBlank: false
					linkTooltip:     "Drill down to pods"
					linkUrl:         "/d/85a562078cdf77779eaa1add43ccec1e/k8s-resources-namespace?var-datasource=$datasource&var-cluster=$cluster&var-namespace=$__cell"
					pattern:         "namespace"
					thresholds: []
					type: "number"
					unit: "short"
				}, {
					alias:     ""
					colorMode: null
					colors: []
					dateFormat: "YYYY-MM-DD HH:mm:ss"
					decimals:   2
					pattern:    "/.*/"
					thresholds: []
					type: "string"
					unit: "short"
				}]
				targets: [{
					expr:           "sum(irate(container_network_receive_bytes_total{job=\"kubelet\", metrics_path=\"/metrics/cadvisor\", cluster=\"$cluster\", namespace=~\".+\"}[$__rate_interval])) by (namespace)"
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "A"
					step:           10
				}, {
					expr:           "sum(irate(container_network_transmit_bytes_total{job=\"kubelet\", metrics_path=\"/metrics/cadvisor\", cluster=\"$cluster\", namespace=~\".+\"}[$__rate_interval])) by (namespace)"
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "B"
					step:           10
				}, {
					expr:           "sum(irate(container_network_receive_packets_total{job=\"kubelet\", metrics_path=\"/metrics/cadvisor\", cluster=\"$cluster\", namespace=~\".+\"}[$__rate_interval])) by (namespace)"
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "C"
					step:           10
				}, {
					expr:           "sum(irate(container_network_transmit_packets_total{job=\"kubelet\", metrics_path=\"/metrics/cadvisor\", cluster=\"$cluster\", namespace=~\".+\"}[$__rate_interval])) by (namespace)"
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "D"
					step:           10
				}, {
					expr:           "sum(irate(container_network_receive_packets_dropped_total{job=\"kubelet\", metrics_path=\"/metrics/cadvisor\", cluster=\"$cluster\", namespace=~\".+\"}[$__rate_interval])) by (namespace)"
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "E"
					step:           10
				}, {
					expr:           "sum(irate(container_network_transmit_packets_dropped_total{job=\"kubelet\", metrics_path=\"/metrics/cadvisor\", cluster=\"$cluster\", namespace=~\".+\"}[$__rate_interval])) by (namespace)"
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "F"
					step:           10
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Current Network Usage"
				tooltip: {
					shared:     false
					sort:       2
					value_type: "individual"
				}
				transform: "table"
				type:      "table"
				xaxis: {
					buckets: null
					mode:    "time"
					name:    null
					show:    true
					values: []
				}
				yaxes: [{
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    false
				}]
			}]
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       true
			title:           "Current Network Usage"
			titleSize:       "h6"
		}, {
			collapse: false
			height:   "250px"
			panels: [{
				aliasColors: {}
				bars:       false
				dashLength: 10
				dashes:     false
				datasource: "$datasource"
				fill:       10
				id:         12
				interval:   "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 0
				links: []
				nullPointMode: "null as zero"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				seriesOverrides: []
				spaceLength: 10
				span:        6
				stack:       true
				steppedLine: false
				targets: [{
					expr:           "sum(irate(container_network_receive_bytes_total{job=\"kubelet\", metrics_path=\"/metrics/cadvisor\", cluster=\"$cluster\", namespace=~\".+\"}[$__rate_interval])) by (namespace)"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{namespace}}"
					legendLink:     null
					step:           10
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Receive Bandwidth"
				tooltip: {
					shared:     false
					sort:       2
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
				yaxes: [{
					format:  "Bps"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    false
				}]
			}, {
				aliasColors: {}
				bars:       false
				dashLength: 10
				dashes:     false
				datasource: "$datasource"
				fill:       10
				id:         13
				interval:   "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 0
				links: []
				nullPointMode: "null as zero"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				seriesOverrides: []
				spaceLength: 10
				span:        6
				stack:       true
				steppedLine: false
				targets: [{
					expr:           "sum(irate(container_network_transmit_bytes_total{job=\"kubelet\", metrics_path=\"/metrics/cadvisor\", cluster=\"$cluster\", namespace=~\".+\"}[$__rate_interval])) by (namespace)"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{namespace}}"
					legendLink:     null
					step:           10
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Transmit Bandwidth"
				tooltip: {
					shared:     false
					sort:       2
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
				yaxes: [{
					format:  "Bps"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    false
				}]
			}]
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       true
			title:           "Bandwidth"
			titleSize:       "h6"
		}, {
			collapse: false
			height:   "250px"
			panels: [{
				aliasColors: {}
				bars:       false
				dashLength: 10
				dashes:     false
				datasource: "$datasource"
				fill:       10
				id:         14
				interval:   "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 0
				links: []
				nullPointMode: "null as zero"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				seriesOverrides: []
				spaceLength: 10
				span:        6
				stack:       true
				steppedLine: false
				targets: [{
					expr:           "avg(irate(container_network_receive_bytes_total{job=\"kubelet\", metrics_path=\"/metrics/cadvisor\", cluster=\"$cluster\", namespace=~\".+\"}[$__rate_interval])) by (namespace)"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{namespace}}"
					legendLink:     null
					step:           10
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Average Container Bandwidth by Namespace: Received"
				tooltip: {
					shared:     false
					sort:       2
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
				yaxes: [{
					format:  "Bps"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    false
				}]
			}, {
				aliasColors: {}
				bars:       false
				dashLength: 10
				dashes:     false
				datasource: "$datasource"
				fill:       10
				id:         15
				interval:   "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 0
				links: []
				nullPointMode: "null as zero"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				seriesOverrides: []
				spaceLength: 10
				span:        6
				stack:       true
				steppedLine: false
				targets: [{
					expr:           "avg(irate(container_network_transmit_bytes_total{job=\"kubelet\", metrics_path=\"/metrics/cadvisor\", cluster=\"$cluster\", namespace=~\".+\"}[$__rate_interval])) by (namespace)"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{namespace}}"
					legendLink:     null
					step:           10
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Average Container Bandwidth by Namespace: Transmitted"
				tooltip: {
					shared:     false
					sort:       2
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
				yaxes: [{
					format:  "Bps"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    false
				}]
			}]
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       true
			title:           "Average Container Bandwidth by Namespace"
			titleSize:       "h6"
		}, {
			collapse: false
			height:   "250px"
			panels: [{
				aliasColors: {}
				bars:       false
				dashLength: 10
				dashes:     false
				datasource: "$datasource"
				fill:       10
				id:         16
				interval:   "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 0
				links: []
				nullPointMode: "null as zero"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				seriesOverrides: []
				spaceLength: 10
				span:        6
				stack:       true
				steppedLine: false
				targets: [{
					expr:           "sum(irate(container_network_receive_packets_total{job=\"kubelet\", metrics_path=\"/metrics/cadvisor\", cluster=\"$cluster\", namespace=~\".+\"}[$__rate_interval])) by (namespace)"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{namespace}}"
					legendLink:     null
					step:           10
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Rate of Received Packets"
				tooltip: {
					shared:     false
					sort:       2
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
				yaxes: [{
					format:  "pps"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    false
				}]
			}, {
				aliasColors: {}
				bars:       false
				dashLength: 10
				dashes:     false
				datasource: "$datasource"
				fill:       10
				id:         17
				interval:   "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 0
				links: []
				nullPointMode: "null as zero"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				seriesOverrides: []
				spaceLength: 10
				span:        6
				stack:       true
				steppedLine: false
				targets: [{
					expr:           "sum(irate(container_network_transmit_packets_total{job=\"kubelet\", metrics_path=\"/metrics/cadvisor\", cluster=\"$cluster\", namespace=~\".+\"}[$__rate_interval])) by (namespace)"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{namespace}}"
					legendLink:     null
					step:           10
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Rate of Transmitted Packets"
				tooltip: {
					shared:     false
					sort:       2
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
				yaxes: [{
					format:  "pps"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    false
				}]
			}]
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       true
			title:           "Rate of Packets"
			titleSize:       "h6"
		}, {
			collapse: false
			height:   "250px"
			panels: [{
				aliasColors: {}
				bars:       false
				dashLength: 10
				dashes:     false
				datasource: "$datasource"
				fill:       10
				id:         18
				interval:   "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 0
				links: []
				nullPointMode: "null as zero"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				seriesOverrides: []
				spaceLength: 10
				span:        6
				stack:       true
				steppedLine: false
				targets: [{
					expr:           "sum(irate(container_network_receive_packets_dropped_total{job=\"kubelet\", metrics_path=\"/metrics/cadvisor\", cluster=\"$cluster\", namespace=~\".+\"}[$__rate_interval])) by (namespace)"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{namespace}}"
					legendLink:     null
					step:           10
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Rate of Received Packets Dropped"
				tooltip: {
					shared:     false
					sort:       2
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
				yaxes: [{
					format:  "pps"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    false
				}]
			}, {
				aliasColors: {}
				bars:       false
				dashLength: 10
				dashes:     false
				datasource: "$datasource"
				fill:       10
				id:         19
				interval:   "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 0
				links: []
				nullPointMode: "null as zero"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				seriesOverrides: []
				spaceLength: 10
				span:        6
				stack:       true
				steppedLine: false
				targets: [{
					expr:           "sum(irate(container_network_transmit_packets_dropped_total{job=\"kubelet\", metrics_path=\"/metrics/cadvisor\", cluster=\"$cluster\", namespace=~\".+\"}[$__rate_interval])) by (namespace)"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{namespace}}"
					legendLink:     null
					step:           10
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Rate of Transmitted Packets Dropped"
				tooltip: {
					shared:     false
					sort:       2
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
				yaxes: [{
					format:  "pps"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    false
				}]
			}]
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       true
			title:           "Rate of Packets Dropped"
			titleSize:       "h6"
		}, {
			collapse: false
			height:   "250px"
			panels: [{
				aliasColors: {}
				bars:       false
				dashLength: 10
				dashes:     false
				datasource: "$datasource"
				decimals:   -1
				fill:       10
				id:         20
				interval:   "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 0
				links: []
				nullPointMode: "null as zero"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				seriesOverrides: []
				spaceLength: 10
				span:        6
				stack:       true
				steppedLine: false
				targets: [{
					expr:           "ceil(sum by(namespace) (rate(container_fs_reads_total{job=\"kubelet\", metrics_path=\"/metrics/cadvisor\", container!=\"\", cluster=\"$cluster\"}[$__rate_interval]) + rate(container_fs_writes_total{job=\"kubelet\", metrics_path=\"/metrics/cadvisor\", container!=\"\", cluster=\"$cluster\"}[$__rate_interval])))"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{namespace}}"
					legendLink:     null
					step:           10
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "IOPS(Reads+Writes)"
				tooltip: {
					shared:     false
					sort:       2
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
				yaxes: [{
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    false
				}]
			}, {
				aliasColors: {}
				bars:       false
				dashLength: 10
				dashes:     false
				datasource: "$datasource"
				fill:       10
				id:         21
				interval:   "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 0
				links: []
				nullPointMode: "null as zero"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				seriesOverrides: []
				spaceLength: 10
				span:        6
				stack:       true
				steppedLine: false
				targets: [{
					expr:           "sum by(namespace) (rate(container_fs_reads_bytes_total{job=\"kubelet\", metrics_path=\"/metrics/cadvisor\", container!=\"\", cluster=\"$cluster\"}[$__rate_interval]) + rate(container_fs_writes_bytes_total{job=\"kubelet\", metrics_path=\"/metrics/cadvisor\", container!=\"\", cluster=\"$cluster\"}[$__rate_interval]))"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{namespace}}"
					legendLink:     null
					step:           10
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "ThroughPut(Read+Write)"
				tooltip: {
					shared:     false
					sort:       2
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
				yaxes: [{
					format:  "Bps"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    false
				}]
			}]
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       true
			title:           "Storage IO"
			titleSize:       "h6"
		}, {
			collapse: false
			height:   "250px"
			panels: [{
				aliasColors: {}
				bars:       false
				dashLength: 10
				dashes:     false
				datasource: "$datasource"
				fill:       1
				id:         22
				interval:   "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 1
				links: []
				nullPointMode: "null as zero"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				seriesOverrides: []
				sort: {
					col:  4
					desc: true
				}
				spaceLength: 10
				span:        12
				stack:       false
				steppedLine: false
				styles: [{
					alias:      "Time"
					dateFormat: "YYYY-MM-DD HH:mm:ss"
					pattern:    "Time"
					type:       "hidden"
				}, {
					alias:     "IOPS(Reads)"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        -1
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #A"
					thresholds: []
					type: "number"
					unit: "short"
				}, {
					alias:     "IOPS(Writes)"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        -1
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #B"
					thresholds: []
					type: "number"
					unit: "short"
				}, {
					alias:     "IOPS(Reads + Writes)"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        -1
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #C"
					thresholds: []
					type: "number"
					unit: "short"
				}, {
					alias:     "Throughput(Read)"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #D"
					thresholds: []
					type: "number"
					unit: "Bps"
				}, {
					alias:     "Throughput(Write)"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #E"
					thresholds: []
					type: "number"
					unit: "Bps"
				}, {
					alias:     "Throughput(Read + Write)"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #F"
					thresholds: []
					type: "number"
					unit: "Bps"
				}, {
					alias:     "Namespace"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            true
					linkTargetBlank: false
					linkTooltip:     "Drill down to pods"
					linkUrl:         "/d/85a562078cdf77779eaa1add43ccec1e/k8s-resources-namespace?var-datasource=$datasource&var-cluster=$cluster&var-namespace=$__cell"
					pattern:         "namespace"
					thresholds: []
					type: "number"
					unit: "short"
				}, {
					alias:     ""
					colorMode: null
					colors: []
					dateFormat: "YYYY-MM-DD HH:mm:ss"
					decimals:   2
					pattern:    "/.*/"
					thresholds: []
					type: "string"
					unit: "short"
				}]
				targets: [{
					expr:           "sum by(namespace) (rate(container_fs_reads_total{job=\"kubelet\", metrics_path=\"/metrics/cadvisor\", container!=\"\", cluster=\"$cluster\"}[$__rate_interval]))"
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "A"
					step:           10
				}, {
					expr:           "sum by(namespace) (rate(container_fs_writes_total{job=\"kubelet\", metrics_path=\"/metrics/cadvisor\", container!=\"\", cluster=\"$cluster\"}[$__rate_interval]))"
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "B"
					step:           10
				}, {
					expr:           "sum by(namespace) (rate(container_fs_reads_total{job=\"kubelet\", metrics_path=\"/metrics/cadvisor\", container!=\"\", cluster=\"$cluster\"}[$__rate_interval]) + rate(container_fs_writes_total{job=\"kubelet\", metrics_path=\"/metrics/cadvisor\", container!=\"\", cluster=\"$cluster\"}[$__rate_interval]))"
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "C"
					step:           10
				}, {
					expr:           "sum by(namespace) (rate(container_fs_reads_bytes_total{job=\"kubelet\", metrics_path=\"/metrics/cadvisor\", container!=\"\", cluster=\"$cluster\"}[$__rate_interval]))"
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "D"
					step:           10
				}, {
					expr:           "sum by(namespace) (rate(container_fs_writes_bytes_total{job=\"kubelet\", metrics_path=\"/metrics/cadvisor\", container!=\"\", cluster=\"$cluster\"}[$__rate_interval]))"
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "E"
					step:           10
				}, {
					expr:           "sum by(namespace) (rate(container_fs_reads_bytes_total{job=\"kubelet\", metrics_path=\"/metrics/cadvisor\", container!=\"\", cluster=\"$cluster\"}[$__rate_interval]) + rate(container_fs_writes_bytes_total{job=\"kubelet\", metrics_path=\"/metrics/cadvisor\", container!=\"\", cluster=\"$cluster\"}[$__rate_interval]))"
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "F"
					step:           10
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Current Storage IO"
				tooltip: {
					shared:     false
					sort:       2
					value_type: "individual"
				}
				transform: "table"
				type:      "table"
				xaxis: {
					buckets: null
					mode:    "time"
					name:    null
					show:    true
					values: []
				}
				yaxes: [{
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    false
				}]
			}]
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       true
			title:           "Storage IO - Distribution"
			titleSize:       "h6"
		}]
		schemaVersion: 14
		style:         "dark"
		tags: [
			"kubernetes-mixin",
		]
		templating: list: [{
			current: {
				text:  "default"
				value: "default"
			}
			hide:  0
			label: "Data Source"
			name:  "datasource"
			options: []
			query:   "prometheus"
			refresh: 1
			regex:   ""
			type:    "datasource"
		}, {
			allValue: null
			current: {
				text:  ""
				value: ""
			}
			datasource: "$datasource"
			hide:       2
			includeAll: false
			label:      null
			multi:      false
			name:       "cluster"
			options: []
			query:          "label_values(up{job=\"kubelet\", metrics_path=\"/metrics/cadvisor\"}, cluster)"
			refresh:        2
			regex:          ""
			sort:           1
			tagValuesQuery: ""
			tags: []
			tagsQuery: ""
			type:      "query"
			useTags:   false
		}]
		time: {
			from: "now-1h"
			to:   "now"
		}
		timepicker: {
			refresh_intervals: ["5s", "10s", "30s", "1m", "5m", "15m", "30m", "1h", "2h", "1d"]
			time_options: ["5m", "15m", "1h", "6h", "12h", "24h", "2d", "7d", "30d"]
		}
		timezone: "UTC"
		title:    "Kubernetes / Compute Resources / Cluster"
		uid:      "efa86fd1d0c121a26444b636a3f509a8"
		version:  0
	}
	"k8s-resources-namespace.json": {
		annotations: list: []
		editable:     true
		gnetId:       null
		graphTooltip: 0
		hideControls: false
		links: []
		refresh: "10s"
		rows: [{
			collapse: false
			height:   "100px"
			panels: [{
				aliasColors: {}
				bars:       false
				dashLength: 10
				dashes:     false
				datasource: "$datasource"
				fill:       1
				format:     "percentunit"
				id:         1
				interval:   "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 1
				links: []
				nullPointMode: "null as zero"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				seriesOverrides: []
				spaceLength: 10
				span:        3
				stack:       false
				steppedLine: false
				targets: [{
					expr:           "sum(node_namespace_pod_container:container_cpu_usage_seconds_total:sum_irate{cluster=\"$cluster\", namespace=\"$namespace\"}) / sum(kube_pod_container_resource_requests{job=\"kube-state-metrics\", cluster=\"$cluster\", namespace=\"$namespace\", resource=\"cpu\"})"
					format:         "time_series"
					instant:        true
					intervalFactor: 2
					refId:          "A"
				}]
				thresholds: "70,80"
				timeFrom:   null
				timeShift:  null
				title:      "CPU Utilisation (from requests)"
				tooltip: {
					shared:     false
					sort:       2
					value_type: "individual"
				}
				type: "singlestat"
				xaxis: {
					buckets: null
					mode:    "time"
					name:    null
					show:    true
					values: []
				}
				yaxes: [{
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    false
				}]
			}, {
				aliasColors: {}
				bars:       false
				dashLength: 10
				dashes:     false
				datasource: "$datasource"
				fill:       1
				format:     "percentunit"
				id:         2
				interval:   "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 1
				links: []
				nullPointMode: "null as zero"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				seriesOverrides: []
				spaceLength: 10
				span:        3
				stack:       false
				steppedLine: false
				targets: [{
					expr:           "sum(node_namespace_pod_container:container_cpu_usage_seconds_total:sum_irate{cluster=\"$cluster\", namespace=\"$namespace\"}) / sum(kube_pod_container_resource_limits{job=\"kube-state-metrics\", cluster=\"$cluster\", namespace=\"$namespace\", resource=\"cpu\"})"
					format:         "time_series"
					instant:        true
					intervalFactor: 2
					refId:          "A"
				}]
				thresholds: "70,80"
				timeFrom:   null
				timeShift:  null
				title:      "CPU Utilisation (from limits)"
				tooltip: {
					shared:     false
					sort:       2
					value_type: "individual"
				}
				type: "singlestat"
				xaxis: {
					buckets: null
					mode:    "time"
					name:    null
					show:    true
					values: []
				}
				yaxes: [{
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    false
				}]
			}, {
				aliasColors: {}
				bars:       false
				dashLength: 10
				dashes:     false
				datasource: "$datasource"
				fill:       1
				format:     "percentunit"
				id:         3
				interval:   "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 1
				links: []
				nullPointMode: "null as zero"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				seriesOverrides: []
				spaceLength: 10
				span:        3
				stack:       false
				steppedLine: false
				targets: [{
					expr:           "sum(container_memory_working_set_bytes{job=\"kubelet\", metrics_path=\"/metrics/cadvisor\", cluster=\"$cluster\", namespace=\"$namespace\",container!=\"\", image!=\"\"}) / sum(kube_pod_container_resource_requests{job=\"kube-state-metrics\", cluster=\"$cluster\", namespace=\"$namespace\", resource=\"memory\"})"
					format:         "time_series"
					instant:        true
					intervalFactor: 2
					refId:          "A"
				}]
				thresholds: "70,80"
				timeFrom:   null
				timeShift:  null
				title:      "Memory Utilisation (from requests)"
				tooltip: {
					shared:     false
					sort:       2
					value_type: "individual"
				}
				type: "singlestat"
				xaxis: {
					buckets: null
					mode:    "time"
					name:    null
					show:    true
					values: []
				}
				yaxes: [{
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    false
				}]
			}, {
				aliasColors: {}
				bars:       false
				dashLength: 10
				dashes:     false
				datasource: "$datasource"
				fill:       1
				format:     "percentunit"
				id:         4
				interval:   "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 1
				links: []
				nullPointMode: "null as zero"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				seriesOverrides: []
				spaceLength: 10
				span:        3
				stack:       false
				steppedLine: false
				targets: [{
					expr:           "sum(container_memory_working_set_bytes{job=\"kubelet\", metrics_path=\"/metrics/cadvisor\", cluster=\"$cluster\", namespace=\"$namespace\",container!=\"\", image!=\"\"}) / sum(kube_pod_container_resource_limits{job=\"kube-state-metrics\", cluster=\"$cluster\", namespace=\"$namespace\", resource=\"memory\"})"
					format:         "time_series"
					instant:        true
					intervalFactor: 2
					refId:          "A"
				}]
				thresholds: "70,80"
				timeFrom:   null
				timeShift:  null
				title:      "Memory Utilisation (from limits)"
				tooltip: {
					shared:     false
					sort:       2
					value_type: "individual"
				}
				type: "singlestat"
				xaxis: {
					buckets: null
					mode:    "time"
					name:    null
					show:    true
					values: []
				}
				yaxes: [{
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    false
				}]
			}]
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       false
			title:           "Headlines"
			titleSize:       "h6"
		}, {
			collapse: false
			height:   "250px"
			panels: [{
				aliasColors: {}
				bars:       false
				dashLength: 10
				dashes:     false
				datasource: "$datasource"
				fill:       10
				id:         5
				interval:   "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 0
				links: []
				nullPointMode: "null as zero"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				seriesOverrides: [{
					alias:        "quota - requests"
					color:        "#F2495C"
					dashes:       true
					fill:         0
					hiddenSeries: true
					hideTooltip:  true
					legend:       true
					linewidth:    2
					stack:        false
				}, {
					alias:        "quota - limits"
					color:        "#FF9830"
					dashes:       true
					fill:         0
					hiddenSeries: true
					hideTooltip:  true
					legend:       true
					linewidth:    2
					stack:        false
				}]
				spaceLength: 10
				span:        12
				stack:       true
				steppedLine: false
				targets: [{
					expr:           "sum(node_namespace_pod_container:container_cpu_usage_seconds_total:sum_irate{cluster=\"$cluster\", namespace=\"$namespace\"}) by (pod)"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{pod}}"
					legendLink:     null
					step:           10
				}, {
					expr:           "scalar(kube_resourcequota{cluster=\"$cluster\", namespace=\"$namespace\", type=\"hard\",resource=\"requests.cpu\"})"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "quota - requests"
					legendLink:     null
					step:           10
				}, {
					expr:           "scalar(kube_resourcequota{cluster=\"$cluster\", namespace=\"$namespace\", type=\"hard\",resource=\"limits.cpu\"})"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "quota - limits"
					legendLink:     null
					step:           10
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "CPU Usage"
				tooltip: {
					shared:     false
					sort:       2
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
				yaxes: [{
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    false
				}]
			}]
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       true
			title:           "CPU Usage"
			titleSize:       "h6"
		}, {
			collapse: false
			height:   "250px"
			panels: [{
				aliasColors: {}
				bars:       false
				dashLength: 10
				dashes:     false
				datasource: "$datasource"
				fill:       1
				id:         6
				interval:   "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 1
				links: []
				nullPointMode: "null as zero"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				seriesOverrides: []
				spaceLength: 10
				span:        12
				stack:       false
				steppedLine: false
				styles: [{
					alias:      "Time"
					dateFormat: "YYYY-MM-DD HH:mm:ss"
					pattern:    "Time"
					type:       "hidden"
				}, {
					alias:     "CPU Usage"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #A"
					thresholds: []
					type: "number"
					unit: "short"
				}, {
					alias:     "CPU Requests"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #B"
					thresholds: []
					type: "number"
					unit: "short"
				}, {
					alias:     "CPU Requests %"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #C"
					thresholds: []
					type: "number"
					unit: "percentunit"
				}, {
					alias:     "CPU Limits"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #D"
					thresholds: []
					type: "number"
					unit: "short"
				}, {
					alias:     "CPU Limits %"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #E"
					thresholds: []
					type: "number"
					unit: "percentunit"
				}, {
					alias:     "Pod"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            true
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         "/d/6581e46e4e5c7ba40a07646395ef7b23/k8s-resources-pod?var-datasource=$datasource&var-cluster=$cluster&var-namespace=$namespace&var-pod=$__cell"
					pattern:         "pod"
					thresholds: []
					type: "number"
					unit: "short"
				}, {
					alias:     ""
					colorMode: null
					colors: []
					dateFormat: "YYYY-MM-DD HH:mm:ss"
					decimals:   2
					pattern:    "/.*/"
					thresholds: []
					type: "string"
					unit: "short"
				}]
				targets: [{
					expr:           "sum(node_namespace_pod_container:container_cpu_usage_seconds_total:sum_irate{cluster=\"$cluster\", namespace=\"$namespace\"}) by (pod)"
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "A"
					step:           10
				}, {
					expr:           "sum(cluster:namespace:pod_cpu:active:kube_pod_container_resource_requests{cluster=\"$cluster\", namespace=\"$namespace\"}) by (pod)"
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "B"
					step:           10
				}, {
					expr:           "sum(node_namespace_pod_container:container_cpu_usage_seconds_total:sum_irate{cluster=\"$cluster\", namespace=\"$namespace\"}) by (pod) / sum(cluster:namespace:pod_cpu:active:kube_pod_container_resource_requests{cluster=\"$cluster\", namespace=\"$namespace\"}) by (pod)"
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "C"
					step:           10
				}, {
					expr:           "sum(cluster:namespace:pod_cpu:active:kube_pod_container_resource_limits{cluster=\"$cluster\", namespace=\"$namespace\"}) by (pod)"
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "D"
					step:           10
				}, {
					expr:           "sum(node_namespace_pod_container:container_cpu_usage_seconds_total:sum_irate{cluster=\"$cluster\", namespace=\"$namespace\"}) by (pod) / sum(cluster:namespace:pod_cpu:active:kube_pod_container_resource_limits{cluster=\"$cluster\", namespace=\"$namespace\"}) by (pod)"
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "E"
					step:           10
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "CPU Quota"
				tooltip: {
					shared:     false
					sort:       2
					value_type: "individual"
				}
				transform: "table"
				type:      "table"
				xaxis: {
					buckets: null
					mode:    "time"
					name:    null
					show:    true
					values: []
				}
				yaxes: [{
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    false
				}]
			}]
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       true
			title:           "CPU Quota"
			titleSize:       "h6"
		}, {
			collapse: false
			height:   "250px"
			panels: [{
				aliasColors: {}
				bars:       false
				dashLength: 10
				dashes:     false
				datasource: "$datasource"
				fill:       10
				id:         7
				interval:   "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 0
				links: []
				nullPointMode: "null as zero"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				seriesOverrides: [{
					alias:        "quota - requests"
					color:        "#F2495C"
					dashes:       true
					fill:         0
					hiddenSeries: true
					hideTooltip:  true
					legend:       true
					linewidth:    2
					stack:        false
				}, {
					alias:        "quota - limits"
					color:        "#FF9830"
					dashes:       true
					fill:         0
					hiddenSeries: true
					hideTooltip:  true
					legend:       true
					linewidth:    2
					stack:        false
				}]
				spaceLength: 10
				span:        12
				stack:       true
				steppedLine: false
				targets: [{
					expr:           "sum(container_memory_working_set_bytes{job=\"kubelet\", metrics_path=\"/metrics/cadvisor\", cluster=\"$cluster\", namespace=\"$namespace\", container!=\"\", image!=\"\"}) by (pod)"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{pod}}"
					legendLink:     null
					step:           10
				}, {
					expr:           "scalar(kube_resourcequota{cluster=\"$cluster\", namespace=\"$namespace\", type=\"hard\",resource=\"requests.memory\"})"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "quota - requests"
					legendLink:     null
					step:           10
				}, {
					expr:           "scalar(kube_resourcequota{cluster=\"$cluster\", namespace=\"$namespace\", type=\"hard\",resource=\"limits.memory\"})"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "quota - limits"
					legendLink:     null
					step:           10
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Memory Usage (w/o cache)"
				tooltip: {
					shared:     false
					sort:       2
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
				yaxes: [{
					format:  "bytes"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    false
				}]
			}]
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       true
			title:           "Memory Usage"
			titleSize:       "h6"
		}, {
			collapse: false
			height:   "250px"
			panels: [{
				aliasColors: {}
				bars:       false
				dashLength: 10
				dashes:     false
				datasource: "$datasource"
				fill:       1
				id:         8
				interval:   "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 1
				links: []
				nullPointMode: "null as zero"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				seriesOverrides: []
				spaceLength: 10
				span:        12
				stack:       false
				steppedLine: false
				styles: [{
					alias:      "Time"
					dateFormat: "YYYY-MM-DD HH:mm:ss"
					pattern:    "Time"
					type:       "hidden"
				}, {
					alias:     "Memory Usage"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #A"
					thresholds: []
					type: "number"
					unit: "bytes"
				}, {
					alias:     "Memory Requests"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #B"
					thresholds: []
					type: "number"
					unit: "bytes"
				}, {
					alias:     "Memory Requests %"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #C"
					thresholds: []
					type: "number"
					unit: "percentunit"
				}, {
					alias:     "Memory Limits"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #D"
					thresholds: []
					type: "number"
					unit: "bytes"
				}, {
					alias:     "Memory Limits %"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #E"
					thresholds: []
					type: "number"
					unit: "percentunit"
				}, {
					alias:     "Memory Usage (RSS)"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #F"
					thresholds: []
					type: "number"
					unit: "bytes"
				}, {
					alias:     "Memory Usage (Cache)"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #G"
					thresholds: []
					type: "number"
					unit: "bytes"
				}, {
					alias:     "Memory Usage (Swap)"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #H"
					thresholds: []
					type: "number"
					unit: "bytes"
				}, {
					alias:     "Pod"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            true
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         "/d/6581e46e4e5c7ba40a07646395ef7b23/k8s-resources-pod?var-datasource=$datasource&var-cluster=$cluster&var-namespace=$namespace&var-pod=$__cell"
					pattern:         "pod"
					thresholds: []
					type: "number"
					unit: "short"
				}, {
					alias:     ""
					colorMode: null
					colors: []
					dateFormat: "YYYY-MM-DD HH:mm:ss"
					decimals:   2
					pattern:    "/.*/"
					thresholds: []
					type: "string"
					unit: "short"
				}]
				targets: [{
					expr:           "sum(container_memory_working_set_bytes{job=\"kubelet\", metrics_path=\"/metrics/cadvisor\", cluster=\"$cluster\", namespace=\"$namespace\",container!=\"\", image!=\"\"}) by (pod)"
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "A"
					step:           10
				}, {
					expr:           "sum(cluster:namespace:pod_memory:active:kube_pod_container_resource_requests{cluster=\"$cluster\", namespace=\"$namespace\"}) by (pod)"
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "B"
					step:           10
				}, {
					expr:           "sum(container_memory_working_set_bytes{job=\"kubelet\", metrics_path=\"/metrics/cadvisor\", cluster=\"$cluster\", namespace=\"$namespace\",container!=\"\", image!=\"\"}) by (pod) / sum(cluster:namespace:pod_memory:active:kube_pod_container_resource_requests{cluster=\"$cluster\", namespace=\"$namespace\"}) by (pod)"
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "C"
					step:           10
				}, {
					expr:           "sum(cluster:namespace:pod_memory:active:kube_pod_container_resource_limits{cluster=\"$cluster\", namespace=\"$namespace\"}) by (pod)"
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "D"
					step:           10
				}, {
					expr:           "sum(container_memory_working_set_bytes{job=\"kubelet\", metrics_path=\"/metrics/cadvisor\", cluster=\"$cluster\", namespace=\"$namespace\",container!=\"\", image!=\"\"}) by (pod) / sum(cluster:namespace:pod_memory:active:kube_pod_container_resource_limits{cluster=\"$cluster\", namespace=\"$namespace\"}) by (pod)"
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "E"
					step:           10
				}, {
					expr:           "sum(container_memory_rss{job=\"kubelet\", metrics_path=\"/metrics/cadvisor\", cluster=\"$cluster\", namespace=\"$namespace\",container!=\"\"}) by (pod)"
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "F"
					step:           10
				}, {
					expr:           "sum(container_memory_cache{job=\"kubelet\", metrics_path=\"/metrics/cadvisor\", cluster=\"$cluster\", namespace=\"$namespace\",container!=\"\"}) by (pod)"
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "G"
					step:           10
				}, {
					expr:           "sum(container_memory_swap{job=\"kubelet\", metrics_path=\"/metrics/cadvisor\", cluster=\"$cluster\", namespace=\"$namespace\",container!=\"\"}) by (pod)"
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "H"
					step:           10
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Memory Quota"
				tooltip: {
					shared:     false
					sort:       2
					value_type: "individual"
				}
				transform: "table"
				type:      "table"
				xaxis: {
					buckets: null
					mode:    "time"
					name:    null
					show:    true
					values: []
				}
				yaxes: [{
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    false
				}]
			}]
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       true
			title:           "Memory Quota"
			titleSize:       "h6"
		}, {
			collapse: false
			height:   "250px"
			panels: [{
				aliasColors: {}
				bars:       false
				dashLength: 10
				dashes:     false
				datasource: "$datasource"
				fill:       1
				id:         9
				interval:   "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 1
				links: []
				nullPointMode: "null as zero"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				seriesOverrides: []
				spaceLength: 10
				span:        12
				stack:       false
				steppedLine: false
				styles: [{
					alias:      "Time"
					dateFormat: "YYYY-MM-DD HH:mm:ss"
					pattern:    "Time"
					type:       "hidden"
				}, {
					alias:     "Current Receive Bandwidth"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #A"
					thresholds: []
					type: "number"
					unit: "Bps"
				}, {
					alias:     "Current Transmit Bandwidth"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #B"
					thresholds: []
					type: "number"
					unit: "Bps"
				}, {
					alias:     "Rate of Received Packets"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #C"
					thresholds: []
					type: "number"
					unit: "pps"
				}, {
					alias:     "Rate of Transmitted Packets"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #D"
					thresholds: []
					type: "number"
					unit: "pps"
				}, {
					alias:     "Rate of Received Packets Dropped"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #E"
					thresholds: []
					type: "number"
					unit: "pps"
				}, {
					alias:     "Rate of Transmitted Packets Dropped"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #F"
					thresholds: []
					type: "number"
					unit: "pps"
				}, {
					alias:     "Pod"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            true
					linkTargetBlank: false
					linkTooltip:     "Drill down to pods"
					linkUrl:         "/d/6581e46e4e5c7ba40a07646395ef7b23/k8s-resources-pod?var-datasource=$datasource&var-cluster=$cluster&var-namespace=$namespace&var-pod=$__cell"
					pattern:         "pod"
					thresholds: []
					type: "number"
					unit: "short"
				}, {
					alias:     ""
					colorMode: null
					colors: []
					dateFormat: "YYYY-MM-DD HH:mm:ss"
					decimals:   2
					pattern:    "/.*/"
					thresholds: []
					type: "string"
					unit: "short"
				}]
				targets: [{
					expr:           "sum(irate(container_network_receive_bytes_total{job=\"kubelet\", metrics_path=\"/metrics/cadvisor\", cluster=\"$cluster\", namespace=\"$namespace\"}[$__rate_interval])) by (pod)"
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "A"
					step:           10
				}, {
					expr:           "sum(irate(container_network_transmit_bytes_total{job=\"kubelet\", metrics_path=\"/metrics/cadvisor\", cluster=\"$cluster\", namespace=\"$namespace\"}[$__rate_interval])) by (pod)"
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "B"
					step:           10
				}, {
					expr:           "sum(irate(container_network_receive_packets_total{job=\"kubelet\", metrics_path=\"/metrics/cadvisor\", cluster=\"$cluster\", namespace=\"$namespace\"}[$__rate_interval])) by (pod)"
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "C"
					step:           10
				}, {
					expr:           "sum(irate(container_network_transmit_packets_total{job=\"kubelet\", metrics_path=\"/metrics/cadvisor\", cluster=\"$cluster\", namespace=\"$namespace\"}[$__rate_interval])) by (pod)"
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "D"
					step:           10
				}, {
					expr:           "sum(irate(container_network_receive_packets_dropped_total{job=\"kubelet\", metrics_path=\"/metrics/cadvisor\", cluster=\"$cluster\", namespace=\"$namespace\"}[$__rate_interval])) by (pod)"
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "E"
					step:           10
				}, {
					expr:           "sum(irate(container_network_transmit_packets_dropped_total{job=\"kubelet\", metrics_path=\"/metrics/cadvisor\", cluster=\"$cluster\", namespace=\"$namespace\"}[$__rate_interval])) by (pod)"
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "F"
					step:           10
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Current Network Usage"
				tooltip: {
					shared:     false
					sort:       2
					value_type: "individual"
				}
				transform: "table"
				type:      "table"
				xaxis: {
					buckets: null
					mode:    "time"
					name:    null
					show:    true
					values: []
				}
				yaxes: [{
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    false
				}]
			}]
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       true
			title:           "Current Network Usage"
			titleSize:       "h6"
		}, {
			collapse: false
			height:   "250px"
			panels: [{
				aliasColors: {}
				bars:       false
				dashLength: 10
				dashes:     false
				datasource: "$datasource"
				fill:       10
				id:         10
				interval:   "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 0
				links: []
				nullPointMode: "null as zero"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				seriesOverrides: []
				spaceLength: 10
				span:        6
				stack:       true
				steppedLine: false
				targets: [{
					expr:           "sum(irate(container_network_receive_bytes_total{cluster=\"$cluster\", namespace=\"$namespace\"}[$__rate_interval])) by (pod)"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{pod}}"
					legendLink:     null
					step:           10
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Receive Bandwidth"
				tooltip: {
					shared:     false
					sort:       2
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
				yaxes: [{
					format:  "Bps"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    false
				}]
			}, {
				aliasColors: {}
				bars:       false
				dashLength: 10
				dashes:     false
				datasource: "$datasource"
				fill:       10
				id:         11
				interval:   "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 0
				links: []
				nullPointMode: "null as zero"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				seriesOverrides: []
				spaceLength: 10
				span:        6
				stack:       true
				steppedLine: false
				targets: [{
					expr:           "sum(irate(container_network_transmit_bytes_total{cluster=\"$cluster\", namespace=\"$namespace\"}[$__rate_interval])) by (pod)"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{pod}}"
					legendLink:     null
					step:           10
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Transmit Bandwidth"
				tooltip: {
					shared:     false
					sort:       2
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
				yaxes: [{
					format:  "Bps"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    false
				}]
			}]
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       true
			title:           "Bandwidth"
			titleSize:       "h6"
		}, {
			collapse: false
			height:   "250px"
			panels: [{
				aliasColors: {}
				bars:       false
				dashLength: 10
				dashes:     false
				datasource: "$datasource"
				fill:       10
				id:         12
				interval:   "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 0
				links: []
				nullPointMode: "null as zero"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				seriesOverrides: []
				spaceLength: 10
				span:        6
				stack:       true
				steppedLine: false
				targets: [{
					expr:           "sum(irate(container_network_receive_packets_total{cluster=\"$cluster\", namespace=\"$namespace\"}[$__rate_interval])) by (pod)"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{pod}}"
					legendLink:     null
					step:           10
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Rate of Received Packets"
				tooltip: {
					shared:     false
					sort:       2
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
				yaxes: [{
					format:  "pps"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    false
				}]
			}, {
				aliasColors: {}
				bars:       false
				dashLength: 10
				dashes:     false
				datasource: "$datasource"
				fill:       10
				id:         13
				interval:   "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 0
				links: []
				nullPointMode: "null as zero"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				seriesOverrides: []
				spaceLength: 10
				span:        6
				stack:       true
				steppedLine: false
				targets: [{
					expr:           "sum(irate(container_network_transmit_packets_total{cluster=\"$cluster\", namespace=\"$namespace\"}[$__rate_interval])) by (pod)"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{pod}}"
					legendLink:     null
					step:           10
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Rate of Transmitted Packets"
				tooltip: {
					shared:     false
					sort:       2
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
				yaxes: [{
					format:  "pps"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    false
				}]
			}]
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       true
			title:           "Rate of Packets"
			titleSize:       "h6"
		}, {
			collapse: false
			height:   "250px"
			panels: [{
				aliasColors: {}
				bars:       false
				dashLength: 10
				dashes:     false
				datasource: "$datasource"
				fill:       10
				id:         14
				interval:   "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 0
				links: []
				nullPointMode: "null as zero"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				seriesOverrides: []
				spaceLength: 10
				span:        6
				stack:       true
				steppedLine: false
				targets: [{
					expr:           "sum(irate(container_network_receive_packets_dropped_total{cluster=\"$cluster\", namespace=\"$namespace\"}[$__rate_interval])) by (pod)"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{pod}}"
					legendLink:     null
					step:           10
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Rate of Received Packets Dropped"
				tooltip: {
					shared:     false
					sort:       2
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
				yaxes: [{
					format:  "pps"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    false
				}]
			}, {
				aliasColors: {}
				bars:       false
				dashLength: 10
				dashes:     false
				datasource: "$datasource"
				fill:       10
				id:         15
				interval:   "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 0
				links: []
				nullPointMode: "null as zero"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				seriesOverrides: []
				spaceLength: 10
				span:        6
				stack:       true
				steppedLine: false
				targets: [{
					expr:           "sum(irate(container_network_transmit_packets_dropped_total{cluster=\"$cluster\", namespace=\"$namespace\"}[$__rate_interval])) by (pod)"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{pod}}"
					legendLink:     null
					step:           10
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Rate of Transmitted Packets Dropped"
				tooltip: {
					shared:     false
					sort:       2
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
				yaxes: [{
					format:  "pps"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    false
				}]
			}]
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       true
			title:           "Rate of Packets Dropped"
			titleSize:       "h6"
		}, {
			collapse: false
			height:   "250px"
			panels: [{
				aliasColors: {}
				bars:       false
				dashLength: 10
				dashes:     false
				datasource: "$datasource"
				decimals:   -1
				fill:       10
				id:         16
				interval:   "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 0
				links: []
				nullPointMode: "null as zero"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				seriesOverrides: []
				spaceLength: 10
				span:        6
				stack:       true
				steppedLine: false
				targets: [{
					expr:           "ceil(sum by(pod) (rate(container_fs_reads_total{container!=\"\", cluster=\"$cluster\",namespace=\"$namespace\"}[$__rate_interval]) + rate(container_fs_writes_total{container!=\"\", cluster=\"$cluster\",namespace=\"$namespace\"}[$__rate_interval])))"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{pod}}"
					legendLink:     null
					step:           10
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "IOPS(Reads+Writes)"
				tooltip: {
					shared:     false
					sort:       2
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
				yaxes: [{
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    false
				}]
			}, {
				aliasColors: {}
				bars:       false
				dashLength: 10
				dashes:     false
				datasource: "$datasource"
				fill:       10
				id:         17
				interval:   "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 0
				links: []
				nullPointMode: "null as zero"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				seriesOverrides: []
				spaceLength: 10
				span:        6
				stack:       true
				steppedLine: false
				targets: [{
					expr:           "sum by(pod) (rate(container_fs_reads_bytes_total{container!=\"\", cluster=\"$cluster\",namespace=\"$namespace\"}[$__rate_interval]) + rate(container_fs_writes_bytes_total{container!=\"\", cluster=\"$cluster\",namespace=\"$namespace\"}[$__rate_interval]))"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{pod}}"
					legendLink:     null
					step:           10
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "ThroughPut(Read+Write)"
				tooltip: {
					shared:     false
					sort:       2
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
				yaxes: [{
					format:  "Bps"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    false
				}]
			}]
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       true
			title:           "Storage IO"
			titleSize:       "h6"
		}, {
			collapse: false
			height:   "250px"
			panels: [{
				aliasColors: {}
				bars:       false
				dashLength: 10
				dashes:     false
				datasource: "$datasource"
				fill:       1
				id:         18
				interval:   "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 1
				links: []
				nullPointMode: "null as zero"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				seriesOverrides: []
				sort: {
					col:  4
					desc: true
				}
				spaceLength: 10
				span:        12
				stack:       false
				steppedLine: false
				styles: [{
					alias:      "Time"
					dateFormat: "YYYY-MM-DD HH:mm:ss"
					pattern:    "Time"
					type:       "hidden"
				}, {
					alias:     "IOPS(Reads)"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        -1
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #A"
					thresholds: []
					type: "number"
					unit: "short"
				}, {
					alias:     "IOPS(Writes)"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        -1
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #B"
					thresholds: []
					type: "number"
					unit: "short"
				}, {
					alias:     "IOPS(Reads + Writes)"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        -1
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #C"
					thresholds: []
					type: "number"
					unit: "short"
				}, {
					alias:     "Throughput(Read)"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #D"
					thresholds: []
					type: "number"
					unit: "Bps"
				}, {
					alias:     "Throughput(Write)"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #E"
					thresholds: []
					type: "number"
					unit: "Bps"
				}, {
					alias:     "Throughput(Read + Write)"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #F"
					thresholds: []
					type: "number"
					unit: "Bps"
				}, {
					alias:     "Pod"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            true
					linkTargetBlank: false
					linkTooltip:     "Drill down to pods"
					linkUrl:         "/d/6581e46e4e5c7ba40a07646395ef7b23/k8s-resources-pod?var-datasource=$datasource&var-cluster=$cluster&var-namespace=$namespace&var-pod=$__cell"
					pattern:         "pod"
					thresholds: []
					type: "number"
					unit: "short"
				}, {
					alias:     ""
					colorMode: null
					colors: []
					dateFormat: "YYYY-MM-DD HH:mm:ss"
					decimals:   2
					pattern:    "/.*/"
					thresholds: []
					type: "string"
					unit: "short"
				}]
				targets: [{
					expr:           "sum by(pod) (rate(container_fs_reads_total{job=\"kubelet\", metrics_path=\"/metrics/cadvisor\", container!=\"\", cluster=\"$cluster\",namespace=\"$namespace\"}[$__rate_interval]))"
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "A"
					step:           10
				}, {
					expr:           "sum by(pod) (rate(container_fs_writes_total{job=\"kubelet\", metrics_path=\"/metrics/cadvisor\", container!=\"\", cluster=\"$cluster\",namespace=\"$namespace\"}[$__rate_interval]))"
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "B"
					step:           10
				}, {
					expr:           "sum by(pod) (rate(container_fs_reads_total{job=\"kubelet\", metrics_path=\"/metrics/cadvisor\", container!=\"\", cluster=\"$cluster\",namespace=\"$namespace\"}[$__rate_interval]) + rate(container_fs_writes_total{job=\"kubelet\", metrics_path=\"/metrics/cadvisor\", container!=\"\", cluster=\"$cluster\",namespace=\"$namespace\"}[$__rate_interval]))"
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "C"
					step:           10
				}, {
					expr:           "sum by(pod) (rate(container_fs_reads_bytes_total{job=\"kubelet\", metrics_path=\"/metrics/cadvisor\", container!=\"\", cluster=\"$cluster\",namespace=\"$namespace\"}[$__rate_interval]))"
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "D"
					step:           10
				}, {
					expr:           "sum by(pod) (rate(container_fs_writes_bytes_total{job=\"kubelet\", metrics_path=\"/metrics/cadvisor\", container!=\"\", cluster=\"$cluster\",namespace=\"$namespace\"}[$__rate_interval]))"
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "E"
					step:           10
				}, {
					expr:           "sum by(pod) (rate(container_fs_reads_bytes_total{job=\"kubelet\", metrics_path=\"/metrics/cadvisor\", container!=\"\", cluster=\"$cluster\",namespace=\"$namespace\"}[$__rate_interval]) + rate(container_fs_writes_bytes_total{job=\"kubelet\", metrics_path=\"/metrics/cadvisor\", container!=\"\", cluster=\"$cluster\",namespace=\"$namespace\"}[$__rate_interval]))"
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "F"
					step:           10
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Current Storage IO"
				tooltip: {
					shared:     false
					sort:       2
					value_type: "individual"
				}
				transform: "table"
				type:      "table"
				xaxis: {
					buckets: null
					mode:    "time"
					name:    null
					show:    true
					values: []
				}
				yaxes: [{
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    false
				}]
			}]
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       true
			title:           "Storage IO - Distribution"
			titleSize:       "h6"
		}]
		schemaVersion: 14
		style:         "dark"
		tags: [
			"kubernetes-mixin",
		]
		templating: list: [{
			current: {
				text:  "default"
				value: "default"
			}
			hide:  0
			label: "Data Source"
			name:  "datasource"
			options: []
			query:   "prometheus"
			refresh: 1
			regex:   ""
			type:    "datasource"
		}, {
			allValue: null
			current: {
				text:  ""
				value: ""
			}
			datasource: "$datasource"
			hide:       2
			includeAll: false
			label:      null
			multi:      false
			name:       "cluster"
			options: []
			query:          "label_values(up{job=\"kube-state-metrics\"}, cluster)"
			refresh:        2
			regex:          ""
			sort:           1
			tagValuesQuery: ""
			tags: []
			tagsQuery: ""
			type:      "query"
			useTags:   false
		}, {
			allValue: null
			current: {
				text:  ""
				value: ""
			}
			datasource: "$datasource"
			hide:       0
			includeAll: false
			label:      null
			multi:      false
			name:       "namespace"
			options: []
			query:          "label_values(kube_namespace_status_phase{job=\"kube-state-metrics\", cluster=\"$cluster\"}, namespace)"
			refresh:        2
			regex:          ""
			sort:           1
			tagValuesQuery: ""
			tags: []
			tagsQuery: ""
			type:      "query"
			useTags:   false
		}]
		time: {
			from: "now-1h"
			to:   "now"
		}
		timepicker: {
			refresh_intervals: ["5s", "10s", "30s", "1m", "5m", "15m", "30m", "1h", "2h", "1d"]
			time_options: ["5m", "15m", "1h", "6h", "12h", "24h", "2d", "7d", "30d"]
		}
		timezone: "UTC"
		title:    "Kubernetes / Compute Resources / Namespace (Pods)"
		uid:      "85a562078cdf77779eaa1add43ccec1e"
		version:  0
	}
	"k8s-resources-node.json": {
		annotations: list: []
		editable:     true
		gnetId:       null
		graphTooltip: 0
		hideControls: false
		links: []
		refresh: "10s"
		rows: [{
			collapse: false
			height:   "250px"
			panels: [{
				aliasColors: {}
				bars:       false
				dashLength: 10
				dashes:     false
				datasource: "$datasource"
				fill:       10
				id:         1
				interval:   "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 0
				links: []
				nullPointMode: "null as zero"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				seriesOverrides: [{
					alias:        "max capacity"
					color:        "#F2495C"
					dashes:       true
					fill:         0
					hiddenSeries: true
					hideTooltip:  true
					legend:       true
					linewidth:    2
					stack:        false
				}]
				spaceLength: 10
				span:        12
				stack:       true
				steppedLine: false
				targets: [{
					expr:           "sum(kube_node_status_capacity{cluster=\"$cluster\", node=~\"$node\", resource=\"cpu\"})"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "max capacity"
					legendLink:     null
					step:           10
				}, {
					expr:           "sum(node_namespace_pod_container:container_cpu_usage_seconds_total:sum_irate{cluster=\"$cluster\", node=~\"$node\"}) by (pod)"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{pod}}"
					legendLink:     null
					step:           10
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "CPU Usage"
				tooltip: {
					shared:     false
					sort:       2
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
				yaxes: [{
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    false
				}]
			}]
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       true
			title:           "CPU Usage"
			titleSize:       "h6"
		}, {
			collapse: false
			height:   "250px"
			panels: [{
				aliasColors: {}
				bars:       false
				dashLength: 10
				dashes:     false
				datasource: "$datasource"
				fill:       1
				id:         2
				interval:   "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 1
				links: []
				nullPointMode: "null as zero"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				seriesOverrides: []
				spaceLength: 10
				span:        12
				stack:       false
				steppedLine: false
				styles: [{
					alias:      "Time"
					dateFormat: "YYYY-MM-DD HH:mm:ss"
					pattern:    "Time"
					type:       "hidden"
				}, {
					alias:     "CPU Usage"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #A"
					thresholds: []
					type: "number"
					unit: "short"
				}, {
					alias:     "CPU Requests"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #B"
					thresholds: []
					type: "number"
					unit: "short"
				}, {
					alias:     "CPU Requests %"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #C"
					thresholds: []
					type: "number"
					unit: "percentunit"
				}, {
					alias:     "CPU Limits"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #D"
					thresholds: []
					type: "number"
					unit: "short"
				}, {
					alias:     "CPU Limits %"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #E"
					thresholds: []
					type: "number"
					unit: "percentunit"
				}, {
					alias:     "Pod"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "pod"
					thresholds: []
					type: "number"
					unit: "short"
				}, {
					alias:     ""
					colorMode: null
					colors: []
					dateFormat: "YYYY-MM-DD HH:mm:ss"
					decimals:   2
					pattern:    "/.*/"
					thresholds: []
					type: "string"
					unit: "short"
				}]
				targets: [{
					expr:           "sum(node_namespace_pod_container:container_cpu_usage_seconds_total:sum_irate{cluster=\"$cluster\", node=~\"$node\"}) by (pod)"
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "A"
					step:           10
				}, {
					expr:           "sum(cluster:namespace:pod_cpu:active:kube_pod_container_resource_requests{cluster=\"$cluster\", node=~\"$node\"}) by (pod)"
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "B"
					step:           10
				}, {
					expr:           "sum(node_namespace_pod_container:container_cpu_usage_seconds_total:sum_irate{cluster=\"$cluster\", node=~\"$node\"}) by (pod) / sum(cluster:namespace:pod_cpu:active:kube_pod_container_resource_requests{cluster=\"$cluster\", node=~\"$node\"}) by (pod)"
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "C"
					step:           10
				}, {
					expr:           "sum(cluster:namespace:pod_cpu:active:kube_pod_container_resource_limits{cluster=\"$cluster\", node=~\"$node\"}) by (pod)"
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "D"
					step:           10
				}, {
					expr:           "sum(node_namespace_pod_container:container_cpu_usage_seconds_total:sum_irate{cluster=\"$cluster\", node=~\"$node\"}) by (pod) / sum(cluster:namespace:pod_cpu:active:kube_pod_container_resource_limits{cluster=\"$cluster\", node=~\"$node\"}) by (pod)"
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "E"
					step:           10
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "CPU Quota"
				tooltip: {
					shared:     false
					sort:       2
					value_type: "individual"
				}
				transform: "table"
				type:      "table"
				xaxis: {
					buckets: null
					mode:    "time"
					name:    null
					show:    true
					values: []
				}
				yaxes: [{
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    false
				}]
			}]
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       true
			title:           "CPU Quota"
			titleSize:       "h6"
		}, {
			collapse: false
			height:   "250px"
			panels: [{
				aliasColors: {}
				bars:       false
				dashLength: 10
				dashes:     false
				datasource: "$datasource"
				fill:       10
				id:         3
				interval:   "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 0
				links: []
				nullPointMode: "null as zero"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				seriesOverrides: [{
					alias:        "max capacity"
					color:        "#F2495C"
					dashes:       true
					fill:         0
					hiddenSeries: true
					hideTooltip:  true
					legend:       true
					linewidth:    2
					stack:        false
				}]
				spaceLength: 10
				span:        12
				stack:       true
				steppedLine: false
				targets: [{
					expr:           "sum(kube_node_status_capacity{cluster=\"$cluster\", node=~\"$node\", resource=\"memory\"})"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "max capacity"
					legendLink:     null
					step:           10
				}, {
					expr:           "sum(node_namespace_pod_container:container_memory_working_set_bytes{cluster=\"$cluster\", node=~\"$node\", container!=\"\"}) by (pod)"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{pod}}"
					legendLink:     null
					step:           10
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Memory Usage (w/o cache)"
				tooltip: {
					shared:     false
					sort:       2
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
				yaxes: [{
					format:  "bytes"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    false
				}]
			}]
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       true
			title:           "Memory Usage"
			titleSize:       "h6"
		}, {
			collapse: false
			height:   "250px"
			panels: [{
				aliasColors: {}
				bars:       false
				dashLength: 10
				dashes:     false
				datasource: "$datasource"
				fill:       1
				id:         4
				interval:   "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 1
				links: []
				nullPointMode: "null as zero"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				seriesOverrides: []
				spaceLength: 10
				span:        12
				stack:       false
				steppedLine: false
				styles: [{
					alias:      "Time"
					dateFormat: "YYYY-MM-DD HH:mm:ss"
					pattern:    "Time"
					type:       "hidden"
				}, {
					alias:     "Memory Usage"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #A"
					thresholds: []
					type: "number"
					unit: "bytes"
				}, {
					alias:     "Memory Requests"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #B"
					thresholds: []
					type: "number"
					unit: "bytes"
				}, {
					alias:     "Memory Requests %"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #C"
					thresholds: []
					type: "number"
					unit: "percentunit"
				}, {
					alias:     "Memory Limits"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #D"
					thresholds: []
					type: "number"
					unit: "bytes"
				}, {
					alias:     "Memory Limits %"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #E"
					thresholds: []
					type: "number"
					unit: "percentunit"
				}, {
					alias:     "Memory Usage (RSS)"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #F"
					thresholds: []
					type: "number"
					unit: "bytes"
				}, {
					alias:     "Memory Usage (Cache)"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #G"
					thresholds: []
					type: "number"
					unit: "bytes"
				}, {
					alias:     "Memory Usage (Swap)"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #H"
					thresholds: []
					type: "number"
					unit: "bytes"
				}, {
					alias:     "Pod"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "pod"
					thresholds: []
					type: "number"
					unit: "short"
				}, {
					alias:     ""
					colorMode: null
					colors: []
					dateFormat: "YYYY-MM-DD HH:mm:ss"
					decimals:   2
					pattern:    "/.*/"
					thresholds: []
					type: "string"
					unit: "short"
				}]
				targets: [{
					expr:           "sum(node_namespace_pod_container:container_memory_working_set_bytes{cluster=\"$cluster\", node=~\"$node\",container!=\"\"}) by (pod)"
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "A"
					step:           10
				}, {
					expr:           "sum(cluster:namespace:pod_memory:active:kube_pod_container_resource_requests{cluster=\"$cluster\", node=~\"$node\"}) by (pod)"
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "B"
					step:           10
				}, {
					expr:           "sum(node_namespace_pod_container:container_memory_working_set_bytes{cluster=\"$cluster\", node=~\"$node\",container!=\"\"}) by (pod) / sum(cluster:namespace:pod_memory:active:kube_pod_container_resource_requests{cluster=\"$cluster\", node=~\"$node\"}) by (pod)"
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "C"
					step:           10
				}, {
					expr:           "sum(cluster:namespace:pod_memory:active:kube_pod_container_resource_limits{cluster=\"$cluster\", node=~\"$node\"}) by (pod)"
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "D"
					step:           10
				}, {
					expr:           "sum(node_namespace_pod_container:container_memory_working_set_bytes{cluster=\"$cluster\", node=~\"$node\",container!=\"\"}) by (pod) / sum(cluster:namespace:pod_memory:active:kube_pod_container_resource_limits{cluster=\"$cluster\", node=~\"$node\"}) by (pod)"
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "E"
					step:           10
				}, {
					expr:           "sum(node_namespace_pod_container:container_memory_rss{cluster=\"$cluster\", node=~\"$node\",container!=\"\"}) by (pod)"
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "F"
					step:           10
				}, {
					expr:           "sum(node_namespace_pod_container:container_memory_cache{cluster=\"$cluster\", node=~\"$node\",container!=\"\"}) by (pod)"
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "G"
					step:           10
				}, {
					expr:           "sum(node_namespace_pod_container:container_memory_swap{cluster=\"$cluster\", node=~\"$node\",container!=\"\"}) by (pod)"
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "H"
					step:           10
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Memory Quota"
				tooltip: {
					shared:     false
					sort:       2
					value_type: "individual"
				}
				transform: "table"
				type:      "table"
				xaxis: {
					buckets: null
					mode:    "time"
					name:    null
					show:    true
					values: []
				}
				yaxes: [{
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    false
				}]
			}]
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       true
			title:           "Memory Quota"
			titleSize:       "h6"
		}]
		schemaVersion: 14
		style:         "dark"
		tags: [
			"kubernetes-mixin",
		]
		templating: list: [{
			current: {
				text:  "default"
				value: "default"
			}
			hide:  0
			label: "Data Source"
			name:  "datasource"
			options: []
			query:   "prometheus"
			refresh: 1
			regex:   ""
			type:    "datasource"
		}, {
			allValue: null
			current: {
				text:  ""
				value: ""
			}
			datasource: "$datasource"
			hide:       2
			includeAll: false
			label:      null
			multi:      false
			name:       "cluster"
			options: []
			query:          "label_values(up{job=\"kube-state-metrics\"}, cluster)"
			refresh:        2
			regex:          ""
			sort:           1
			tagValuesQuery: ""
			tags: []
			tagsQuery: ""
			type:      "query"
			useTags:   false
		}, {
			allValue: null
			current: {
				text:  ""
				value: ""
			}
			datasource: "$datasource"
			hide:       0
			includeAll: false
			label:      null
			multi:      true
			name:       "node"
			options: []
			query:          "label_values(kube_node_info{cluster=\"$cluster\"}, node)"
			refresh:        2
			regex:          ""
			sort:           1
			tagValuesQuery: ""
			tags: []
			tagsQuery: ""
			type:      "query"
			useTags:   false
		}]
		time: {
			from: "now-1h"
			to:   "now"
		}
		timepicker: {
			refresh_intervals: ["5s", "10s", "30s", "1m", "5m", "15m", "30m", "1h", "2h", "1d"]
			time_options: ["5m", "15m", "1h", "6h", "12h", "24h", "2d", "7d", "30d"]
		}
		timezone: "UTC"
		title:    "Kubernetes / Compute Resources / Node (Pods)"
		uid:      "200ac8fdbfbb74b39aff88118e4d1c2c"
		version:  0
	}
	"k8s-resources-pod.json": {
		annotations: list: []
		editable:     true
		gnetId:       null
		graphTooltip: 0
		hideControls: false
		links: []
		refresh: "10s"
		rows: [{
			collapse: false
			height:   "250px"
			panels: [{
				aliasColors: {}
				bars:       false
				dashLength: 10
				dashes:     false
				datasource: "$datasource"
				fill:       10
				id:         1
				interval:   "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 0
				links: []
				nullPointMode: "null as zero"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				seriesOverrides: [{
					alias:       "requests"
					color:       "#F2495C"
					fill:        0
					hideTooltip: true
					legend:      true
					linewidth:   2
					stack:       false
				}, {
					alias:       "limits"
					color:       "#FF9830"
					fill:        0
					hideTooltip: true
					legend:      true
					linewidth:   2
					stack:       false
				}]
				spaceLength: 10
				span:        12
				stack:       true
				steppedLine: false
				targets: [{
					expr:           "sum(node_namespace_pod_container:container_cpu_usage_seconds_total:sum_irate{namespace=\"$namespace\", pod=\"$pod\", cluster=\"$cluster\"}) by (container)"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{container}}"
					legendLink:     null
					step:           10
				}, {
					expr: """
						sum(
						    kube_pod_container_resource_requests{job="kube-state-metrics", cluster="$cluster", namespace="$namespace", pod="$pod", resource="cpu"}
						)

						"""
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "requests"
					legendLink:     null
					step:           10
				}, {
					expr: """
						sum(
						    kube_pod_container_resource_limits{job="kube-state-metrics", cluster="$cluster", namespace="$namespace", pod="$pod", resource="cpu"}
						)

						"""
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "limits"
					legendLink:     null
					step:           10
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "CPU Usage"
				tooltip: {
					shared:     false
					sort:       2
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
				yaxes: [{
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    false
				}]
			}]
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       true
			title:           "CPU Usage"
			titleSize:       "h6"
		}, {
			collapse: false
			height:   "250px"
			panels: [{
				aliasColors: {}
				bars:       false
				dashLength: 10
				dashes:     false
				datasource: "$datasource"
				fill:       10
				id:         2
				interval:   "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      true
					max:          true
					min:          false
					rightSide:    true
					show:         true
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 0
				links: []
				nullPointMode: "null as zero"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				seriesOverrides: []
				spaceLength: 10
				span:        12
				stack:       true
				steppedLine: false
				targets: [{
					expr:           "sum(increase(container_cpu_cfs_throttled_periods_total{job=\"kubelet\", metrics_path=\"/metrics/cadvisor\", namespace=\"$namespace\", pod=\"$pod\", container!=\"\", cluster=\"$cluster\"}[$__rate_interval])) by (container) /sum(increase(container_cpu_cfs_periods_total{job=\"kubelet\", metrics_path=\"/metrics/cadvisor\", namespace=\"$namespace\", pod=\"$pod\", container!=\"\", cluster=\"$cluster\"}[$__rate_interval])) by (container)"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{container}}"
					legendLink:     null
					step:           10
				}]
				thresholds: [{
					colorMode: "critical"
					fill:      true
					line:      true
					op:        "gt"
					value:     0.25
					yaxis:     "left"
				}]
				timeFrom:  null
				timeShift: null
				title:     "CPU Throttling"
				tooltip: {
					shared:     false
					sort:       2
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
				yaxes: [{
					format:  "percentunit"
					label:   null
					logBase: 1
					max:     1
					min:     0
					show:    true
				}, {
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    false
				}]
			}]
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       true
			title:           "CPU Throttling"
			titleSize:       "h6"
		}, {
			collapse: false
			height:   "250px"
			panels: [{
				aliasColors: {}
				bars:       false
				dashLength: 10
				dashes:     false
				datasource: "$datasource"
				fill:       1
				id:         3
				interval:   "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 1
				links: []
				nullPointMode: "null as zero"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				seriesOverrides: []
				spaceLength: 10
				span:        12
				stack:       false
				steppedLine: false
				styles: [{
					alias:      "Time"
					dateFormat: "YYYY-MM-DD HH:mm:ss"
					pattern:    "Time"
					type:       "hidden"
				}, {
					alias:     "CPU Usage"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #A"
					thresholds: []
					type: "number"
					unit: "short"
				}, {
					alias:     "CPU Requests"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #B"
					thresholds: []
					type: "number"
					unit: "short"
				}, {
					alias:     "CPU Requests %"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #C"
					thresholds: []
					type: "number"
					unit: "percentunit"
				}, {
					alias:     "CPU Limits"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #D"
					thresholds: []
					type: "number"
					unit: "short"
				}, {
					alias:     "CPU Limits %"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #E"
					thresholds: []
					type: "number"
					unit: "percentunit"
				}, {
					alias:     "Container"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "container"
					thresholds: []
					type: "number"
					unit: "short"
				}, {
					alias:     ""
					colorMode: null
					colors: []
					dateFormat: "YYYY-MM-DD HH:mm:ss"
					decimals:   2
					pattern:    "/.*/"
					thresholds: []
					type: "string"
					unit: "short"
				}]
				targets: [{
					expr:           "sum(node_namespace_pod_container:container_cpu_usage_seconds_total:sum_irate{cluster=\"$cluster\", namespace=\"$namespace\", pod=\"$pod\"}) by (container)"
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "A"
					step:           10
				}, {
					expr:           "sum(cluster:namespace:pod_cpu:active:kube_pod_container_resource_requests{cluster=\"$cluster\", namespace=\"$namespace\", pod=\"$pod\"}) by (container)"
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "B"
					step:           10
				}, {
					expr:           "sum(node_namespace_pod_container:container_cpu_usage_seconds_total:sum_irate{cluster=\"$cluster\", namespace=\"$namespace\", pod=\"$pod\"}) by (container) / sum(cluster:namespace:pod_cpu:active:kube_pod_container_resource_requests{cluster=\"$cluster\", namespace=\"$namespace\", pod=\"$pod\"}) by (container)"
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "C"
					step:           10
				}, {
					expr:           "sum(cluster:namespace:pod_cpu:active:kube_pod_container_resource_limits{cluster=\"$cluster\", namespace=\"$namespace\", pod=\"$pod\"}) by (container)"
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "D"
					step:           10
				}, {
					expr:           "sum(node_namespace_pod_container:container_cpu_usage_seconds_total:sum_irate{cluster=\"$cluster\", namespace=\"$namespace\", pod=\"$pod\"}) by (container) / sum(cluster:namespace:pod_cpu:active:kube_pod_container_resource_limits{cluster=\"$cluster\", namespace=\"$namespace\", pod=\"$pod\"}) by (container)"
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "E"
					step:           10
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "CPU Quota"
				tooltip: {
					shared:     false
					sort:       2
					value_type: "individual"
				}
				transform: "table"
				type:      "table"
				xaxis: {
					buckets: null
					mode:    "time"
					name:    null
					show:    true
					values: []
				}
				yaxes: [{
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    false
				}]
			}]
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       true
			title:           "CPU Quota"
			titleSize:       "h6"
		}, {
			collapse: false
			height:   "250px"
			panels: [{
				aliasColors: {}
				bars:       false
				dashLength: 10
				dashes:     false
				datasource: "$datasource"
				fill:       10
				id:         4
				interval:   "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 0
				links: []
				nullPointMode: "null as zero"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				seriesOverrides: [{
					alias:       "requests"
					color:       "#F2495C"
					dashes:      true
					fill:        0
					hideTooltip: true
					legend:      true
					linewidth:   2
					stack:       false
				}, {
					alias:       "limits"
					color:       "#FF9830"
					dashes:      true
					fill:        0
					hideTooltip: true
					legend:      true
					linewidth:   2
					stack:       false
				}]
				spaceLength: 10
				span:        12
				stack:       true
				steppedLine: false
				targets: [{
					expr:           "sum(container_memory_working_set_bytes{job=\"kubelet\", metrics_path=\"/metrics/cadvisor\", cluster=\"$cluster\", namespace=\"$namespace\", pod=\"$pod\", container!=\"\", image!=\"\"}) by (container)"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{container}}"
					legendLink:     null
					step:           10
				}, {
					expr: """
						sum(
						    kube_pod_container_resource_requests{job="kube-state-metrics", cluster="$cluster", namespace="$namespace", pod="$pod", resource="memory"}
						)

						"""
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "requests"
					legendLink:     null
					step:           10
				}, {
					expr: """
						sum(
						    kube_pod_container_resource_limits{job="kube-state-metrics", cluster="$cluster", namespace="$namespace", pod="$pod", resource="memory"}
						)

						"""
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "limits"
					legendLink:     null
					step:           10
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Memory Usage (WSS)"
				tooltip: {
					shared:     false
					sort:       2
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
				yaxes: [{
					format:  "bytes"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    false
				}]
			}]
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       true
			title:           "Memory Usage"
			titleSize:       "h6"
		}, {
			collapse: false
			height:   "250px"
			panels: [{
				aliasColors: {}
				bars:       false
				dashLength: 10
				dashes:     false
				datasource: "$datasource"
				fill:       1
				id:         5
				interval:   "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 1
				links: []
				nullPointMode: "null as zero"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				seriesOverrides: []
				spaceLength: 10
				span:        12
				stack:       false
				steppedLine: false
				styles: [{
					alias:      "Time"
					dateFormat: "YYYY-MM-DD HH:mm:ss"
					pattern:    "Time"
					type:       "hidden"
				}, {
					alias:     "Memory Usage (WSS)"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #A"
					thresholds: []
					type: "number"
					unit: "bytes"
				}, {
					alias:     "Memory Requests"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #B"
					thresholds: []
					type: "number"
					unit: "bytes"
				}, {
					alias:     "Memory Requests %"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #C"
					thresholds: []
					type: "number"
					unit: "percentunit"
				}, {
					alias:     "Memory Limits"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #D"
					thresholds: []
					type: "number"
					unit: "bytes"
				}, {
					alias:     "Memory Limits %"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #E"
					thresholds: []
					type: "number"
					unit: "percentunit"
				}, {
					alias:     "Memory Usage (RSS)"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #F"
					thresholds: []
					type: "number"
					unit: "bytes"
				}, {
					alias:     "Memory Usage (Cache)"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #G"
					thresholds: []
					type: "number"
					unit: "bytes"
				}, {
					alias:     "Memory Usage (Swap)"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #H"
					thresholds: []
					type: "number"
					unit: "bytes"
				}, {
					alias:     "Container"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "container"
					thresholds: []
					type: "number"
					unit: "short"
				}, {
					alias:     ""
					colorMode: null
					colors: []
					dateFormat: "YYYY-MM-DD HH:mm:ss"
					decimals:   2
					pattern:    "/.*/"
					thresholds: []
					type: "string"
					unit: "short"
				}]
				targets: [{
					expr:           "sum(container_memory_working_set_bytes{job=\"kubelet\", metrics_path=\"/metrics/cadvisor\", cluster=\"$cluster\", namespace=\"$namespace\", pod=\"$pod\", container!=\"\", image!=\"\"}) by (container)"
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "A"
					step:           10
				}, {
					expr:           "sum(cluster:namespace:pod_memory:active:kube_pod_container_resource_requests{cluster=\"$cluster\", namespace=\"$namespace\", pod=\"$pod\"}) by (container)"
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "B"
					step:           10
				}, {
					expr:           "sum(container_memory_working_set_bytes{job=\"kubelet\", metrics_path=\"/metrics/cadvisor\", cluster=\"$cluster\", namespace=\"$namespace\", pod=\"$pod\", image!=\"\"}) by (container) / sum(cluster:namespace:pod_memory:active:kube_pod_container_resource_requests{cluster=\"$cluster\", namespace=\"$namespace\", pod=\"$pod\"}) by (container)"
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "C"
					step:           10
				}, {
					expr:           "sum(cluster:namespace:pod_memory:active:kube_pod_container_resource_limits{cluster=\"$cluster\", namespace=\"$namespace\", pod=\"$pod\"}) by (container)"
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "D"
					step:           10
				}, {
					expr:           "sum(container_memory_working_set_bytes{job=\"kubelet\", metrics_path=\"/metrics/cadvisor\", cluster=\"$cluster\", namespace=\"$namespace\", pod=\"$pod\", container!=\"\", image!=\"\"}) by (container) / sum(cluster:namespace:pod_memory:active:kube_pod_container_resource_limits{cluster=\"$cluster\", namespace=\"$namespace\", pod=\"$pod\"}) by (container)"
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "E"
					step:           10
				}, {
					expr:           "sum(container_memory_rss{job=\"kubelet\", metrics_path=\"/metrics/cadvisor\", cluster=\"$cluster\", namespace=\"$namespace\", pod=\"$pod\", container != \"\", container != \"POD\"}) by (container)"
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "F"
					step:           10
				}, {
					expr:           "sum(container_memory_cache{job=\"kubelet\", metrics_path=\"/metrics/cadvisor\", cluster=\"$cluster\", namespace=\"$namespace\", pod=\"$pod\", container != \"\", container != \"POD\"}) by (container)"
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "G"
					step:           10
				}, {
					expr:           "sum(container_memory_swap{job=\"kubelet\", metrics_path=\"/metrics/cadvisor\", cluster=\"$cluster\", namespace=\"$namespace\", pod=\"$pod\", container != \"\", container != \"POD\"}) by (container)"
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "H"
					step:           10
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Memory Quota"
				tooltip: {
					shared:     false
					sort:       2
					value_type: "individual"
				}
				transform: "table"
				type:      "table"
				xaxis: {
					buckets: null
					mode:    "time"
					name:    null
					show:    true
					values: []
				}
				yaxes: [{
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    false
				}]
			}]
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       true
			title:           "Memory Quota"
			titleSize:       "h6"
		}, {
			collapse: false
			height:   "250px"
			panels: [{
				aliasColors: {}
				bars:       false
				dashLength: 10
				dashes:     false
				datasource: "$datasource"
				fill:       10
				id:         6
				interval:   "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 0
				links: []
				nullPointMode: "null as zero"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				seriesOverrides: []
				spaceLength: 10
				span:        6
				stack:       true
				steppedLine: false
				targets: [{
					expr:           "sum(irate(container_network_receive_bytes_total{job=\"kubelet\", metrics_path=\"/metrics/cadvisor\", cluster=\"$cluster\", namespace=\"$namespace\", pod=~\"$pod\"}[$__rate_interval])) by (pod)"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{pod}}"
					legendLink:     null
					step:           10
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Receive Bandwidth"
				tooltip: {
					shared:     false
					sort:       2
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
				yaxes: [{
					format:  "Bps"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    false
				}]
			}, {
				aliasColors: {}
				bars:       false
				dashLength: 10
				dashes:     false
				datasource: "$datasource"
				fill:       10
				id:         7
				interval:   "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 0
				links: []
				nullPointMode: "null as zero"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				seriesOverrides: []
				spaceLength: 10
				span:        6
				stack:       true
				steppedLine: false
				targets: [{
					expr:           "sum(irate(container_network_transmit_bytes_total{job=\"kubelet\", metrics_path=\"/metrics/cadvisor\", cluster=\"$cluster\", namespace=\"$namespace\", pod=~\"$pod\"}[$__rate_interval])) by (pod)"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{pod}}"
					legendLink:     null
					step:           10
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Transmit Bandwidth"
				tooltip: {
					shared:     false
					sort:       2
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
				yaxes: [{
					format:  "Bps"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    false
				}]
			}]
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       true
			title:           "Bandwidth"
			titleSize:       "h6"
		}, {
			collapse: false
			height:   "250px"
			panels: [{
				aliasColors: {}
				bars:       false
				dashLength: 10
				dashes:     false
				datasource: "$datasource"
				fill:       10
				id:         8
				interval:   "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 0
				links: []
				nullPointMode: "null as zero"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				seriesOverrides: []
				spaceLength: 10
				span:        6
				stack:       true
				steppedLine: false
				targets: [{
					expr:           "sum(irate(container_network_receive_packets_total{job=\"kubelet\", metrics_path=\"/metrics/cadvisor\", cluster=\"$cluster\", namespace=\"$namespace\", pod=~\"$pod\"}[$__rate_interval])) by (pod)"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{pod}}"
					legendLink:     null
					step:           10
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Rate of Received Packets"
				tooltip: {
					shared:     false
					sort:       2
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
				yaxes: [{
					format:  "pps"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    false
				}]
			}, {
				aliasColors: {}
				bars:       false
				dashLength: 10
				dashes:     false
				datasource: "$datasource"
				fill:       10
				id:         9
				interval:   "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 0
				links: []
				nullPointMode: "null as zero"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				seriesOverrides: []
				spaceLength: 10
				span:        6
				stack:       true
				steppedLine: false
				targets: [{
					expr:           "sum(irate(container_network_transmit_packets_total{job=\"kubelet\", metrics_path=\"/metrics/cadvisor\", cluster=\"$cluster\", namespace=\"$namespace\", pod=~\"$pod\"}[$__rate_interval])) by (pod)"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{pod}}"
					legendLink:     null
					step:           10
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Rate of Transmitted Packets"
				tooltip: {
					shared:     false
					sort:       2
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
				yaxes: [{
					format:  "pps"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    false
				}]
			}]
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       true
			title:           "Rate of Packets"
			titleSize:       "h6"
		}, {
			collapse: false
			height:   "250px"
			panels: [{
				aliasColors: {}
				bars:       false
				dashLength: 10
				dashes:     false
				datasource: "$datasource"
				fill:       10
				id:         10
				interval:   "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 0
				links: []
				nullPointMode: "null as zero"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				seriesOverrides: []
				spaceLength: 10
				span:        6
				stack:       true
				steppedLine: false
				targets: [{
					expr:           "sum(irate(container_network_receive_packets_dropped_total{job=\"kubelet\", metrics_path=\"/metrics/cadvisor\", cluster=\"$cluster\", namespace=\"$namespace\", pod=~\"$pod\"}[$__rate_interval])) by (pod)"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{pod}}"
					legendLink:     null
					step:           10
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Rate of Received Packets Dropped"
				tooltip: {
					shared:     false
					sort:       2
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
				yaxes: [{
					format:  "pps"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    false
				}]
			}, {
				aliasColors: {}
				bars:       false
				dashLength: 10
				dashes:     false
				datasource: "$datasource"
				fill:       10
				id:         11
				interval:   "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 0
				links: []
				nullPointMode: "null as zero"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				seriesOverrides: []
				spaceLength: 10
				span:        6
				stack:       true
				steppedLine: false
				targets: [{
					expr:           "sum(irate(container_network_transmit_packets_dropped_total{job=\"kubelet\", metrics_path=\"/metrics/cadvisor\", cluster=\"$cluster\", namespace=\"$namespace\", pod=~\"$pod\"}[$__rate_interval])) by (pod)"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{pod}}"
					legendLink:     null
					step:           10
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Rate of Transmitted Packets Dropped"
				tooltip: {
					shared:     false
					sort:       2
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
				yaxes: [{
					format:  "pps"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    false
				}]
			}]
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       true
			title:           "Rate of Packets Dropped"
			titleSize:       "h6"
		}, {
			collapse: false
			height:   "250px"
			panels: [{
				aliasColors: {}
				bars:       false
				dashLength: 10
				dashes:     false
				datasource: "$datasource"
				decimals:   -1
				fill:       10
				id:         12
				interval:   "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 0
				links: []
				nullPointMode: "null as zero"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				seriesOverrides: []
				spaceLength: 10
				span:        6
				stack:       true
				steppedLine: false
				targets: [{
					expr:           "ceil(sum by(pod) (rate(container_fs_reads_total{job=\"kubelet\", metrics_path=\"/metrics/cadvisor\", container!=\"\", cluster=\"$cluster\",namespace=\"$namespace\", pod=~\"$pod\"}[$__rate_interval])))"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "Reads"
					legendLink:     null
					step:           10
				}, {
					expr:           "ceil(sum by(pod) (rate(container_fs_writes_total{job=\"kubelet\", metrics_path=\"/metrics/cadvisor\", container!=\"\", cluster=\"$cluster\",namespace=\"$namespace\", pod=~\"$pod\"}[$__rate_interval])))"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "Writes"
					legendLink:     null
					step:           10
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "IOPS"
				tooltip: {
					shared:     false
					sort:       2
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
				yaxes: [{
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    false
				}]
			}, {
				aliasColors: {}
				bars:       false
				dashLength: 10
				dashes:     false
				datasource: "$datasource"
				fill:       10
				id:         13
				interval:   "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 0
				links: []
				nullPointMode: "null as zero"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				seriesOverrides: []
				spaceLength: 10
				span:        6
				stack:       true
				steppedLine: false
				targets: [{
					expr:           "sum by(pod) (rate(container_fs_reads_bytes_total{job=\"kubelet\", metrics_path=\"/metrics/cadvisor\", container!=\"\", cluster=\"$cluster\",namespace=\"$namespace\", pod=~\"$pod\"}[$__rate_interval]))"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "Reads"
					legendLink:     null
					step:           10
				}, {
					expr:           "sum by(pod) (rate(container_fs_writes_bytes_total{job=\"kubelet\", metrics_path=\"/metrics/cadvisor\", container!=\"\", cluster=\"$cluster\",namespace=\"$namespace\", pod=~\"$pod\"}[$__rate_interval]))"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "Writes"
					legendLink:     null
					step:           10
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "ThroughPut"
				tooltip: {
					shared:     false
					sort:       2
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
				yaxes: [{
					format:  "Bps"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    false
				}]
			}]
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       true
			title:           "Storage IO - Distribution(Pod - Read & Writes)"
			titleSize:       "h6"
		}, {
			collapse: false
			height:   "250px"
			panels: [{
				aliasColors: {}
				bars:       false
				dashLength: 10
				dashes:     false
				datasource: "$datasource"
				decimals:   -1
				fill:       10
				id:         14
				interval:   "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 0
				links: []
				nullPointMode: "null as zero"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				seriesOverrides: []
				spaceLength: 10
				span:        6
				stack:       true
				steppedLine: false
				targets: [{
					expr:           "ceil(sum by(container) (rate(container_fs_reads_total{job=\"kubelet\", metrics_path=\"/metrics/cadvisor\", container!=\"\", cluster=\"$cluster\",namespace=\"$namespace\", pod=\"$pod\"}[$__rate_interval]) + rate(container_fs_writes_total{job=\"kubelet\", metrics_path=\"/metrics/cadvisor\", container!=\"\", cluster=\"$cluster\",namespace=\"$namespace\", pod=\"$pod\"}[$__rate_interval])))"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{container}}"
					legendLink:     null
					step:           10
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "IOPS(Reads+Writes)"
				tooltip: {
					shared:     false
					sort:       2
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
				yaxes: [{
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    false
				}]
			}, {
				aliasColors: {}
				bars:       false
				dashLength: 10
				dashes:     false
				datasource: "$datasource"
				fill:       10
				id:         15
				interval:   "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 0
				links: []
				nullPointMode: "null as zero"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				seriesOverrides: []
				spaceLength: 10
				span:        6
				stack:       true
				steppedLine: false
				targets: [{
					expr:           "sum by(container) (rate(container_fs_reads_bytes_total{job=\"kubelet\", metrics_path=\"/metrics/cadvisor\", container!=\"\", cluster=\"$cluster\",namespace=\"$namespace\", pod=\"$pod\"}[$__rate_interval]) + rate(container_fs_writes_bytes_total{job=\"kubelet\", metrics_path=\"/metrics/cadvisor\", container!=\"\", cluster=\"$cluster\",namespace=\"$namespace\", pod=\"$pod\"}[$__rate_interval]))"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{container}}"
					legendLink:     null
					step:           10
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "ThroughPut(Read+Write)"
				tooltip: {
					shared:     false
					sort:       2
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
				yaxes: [{
					format:  "Bps"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    false
				}]
			}]
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       true
			title:           "Storage IO - Distribution(Containers)"
			titleSize:       "h6"
		}, {
			collapse: false
			height:   "250px"
			panels: [{
				aliasColors: {}
				bars:       false
				dashLength: 10
				dashes:     false
				datasource: "$datasource"
				fill:       1
				id:         16
				interval:   "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 1
				links: []
				nullPointMode: "null as zero"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				seriesOverrides: []
				sort: {
					col:  4
					desc: true
				}
				spaceLength: 10
				span:        12
				stack:       false
				steppedLine: false
				styles: [{
					alias:      "Time"
					dateFormat: "YYYY-MM-DD HH:mm:ss"
					pattern:    "Time"
					type:       "hidden"
				}, {
					alias:     "IOPS(Reads)"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        -1
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #A"
					thresholds: []
					type: "number"
					unit: "short"
				}, {
					alias:     "IOPS(Writes)"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        -1
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #B"
					thresholds: []
					type: "number"
					unit: "short"
				}, {
					alias:     "IOPS(Reads + Writes)"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        -1
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #C"
					thresholds: []
					type: "number"
					unit: "short"
				}, {
					alias:     "Throughput(Read)"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #D"
					thresholds: []
					type: "number"
					unit: "Bps"
				}, {
					alias:     "Throughput(Write)"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #E"
					thresholds: []
					type: "number"
					unit: "Bps"
				}, {
					alias:     "Throughput(Read + Write)"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #F"
					thresholds: []
					type: "number"
					unit: "Bps"
				}, {
					alias:     "Container"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "container"
					thresholds: []
					type: "number"
					unit: "short"
				}, {
					alias:     ""
					colorMode: null
					colors: []
					dateFormat: "YYYY-MM-DD HH:mm:ss"
					decimals:   2
					pattern:    "/.*/"
					thresholds: []
					type: "string"
					unit: "short"
				}]
				targets: [{
					expr:           "sum by(container) (rate(container_fs_reads_total{job=\"kubelet\", metrics_path=\"/metrics/cadvisor\", container!=\"\", cluster=\"$cluster\",namespace=\"$namespace\", pod=\"$pod\"}[$__rate_interval]))"
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "A"
					step:           10
				}, {
					expr:           "sum by(container) (rate(container_fs_writes_total{job=\"kubelet\", metrics_path=\"/metrics/cadvisor\", container!=\"\", cluster=\"$cluster\",namespace=\"$namespace\", pod=\"$pod\"}[$__rate_interval]))"
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "B"
					step:           10
				}, {
					expr:           "sum by(container) (rate(container_fs_reads_total{job=\"kubelet\", metrics_path=\"/metrics/cadvisor\", container!=\"\", cluster=\"$cluster\",namespace=\"$namespace\", pod=\"$pod\"}[$__rate_interval]) + rate(container_fs_writes_total{job=\"kubelet\", metrics_path=\"/metrics/cadvisor\", container!=\"\", cluster=\"$cluster\",namespace=\"$namespace\", pod=\"$pod\"}[$__rate_interval]))"
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "C"
					step:           10
				}, {
					expr:           "sum by(container) (rate(container_fs_reads_bytes_total{job=\"kubelet\", metrics_path=\"/metrics/cadvisor\", container!=\"\", cluster=\"$cluster\",namespace=\"$namespace\", pod=\"$pod\"}[$__rate_interval]))"
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "D"
					step:           10
				}, {
					expr:           "sum by(container) (rate(container_fs_writes_bytes_total{job=\"kubelet\", metrics_path=\"/metrics/cadvisor\", container!=\"\", cluster=\"$cluster\",namespace=\"$namespace\", pod=\"$pod\"}[$__rate_interval]))"
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "E"
					step:           10
				}, {
					expr:           "sum by(container) (rate(container_fs_reads_bytes_total{job=\"kubelet\", metrics_path=\"/metrics/cadvisor\", container!=\"\", cluster=\"$cluster\",namespace=\"$namespace\", pod=\"$pod\"}[$__rate_interval]) + rate(container_fs_writes_bytes_total{job=\"kubelet\", metrics_path=\"/metrics/cadvisor\", container!=\"\", cluster=\"$cluster\",namespace=\"$namespace\", pod=\"$pod\"}[$__rate_interval]))"
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "F"
					step:           10
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Current Storage IO"
				tooltip: {
					shared:     false
					sort:       2
					value_type: "individual"
				}
				transform: "table"
				type:      "table"
				xaxis: {
					buckets: null
					mode:    "time"
					name:    null
					show:    true
					values: []
				}
				yaxes: [{
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    false
				}]
			}]
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       true
			title:           "Storage IO - Distribution"
			titleSize:       "h6"
		}]
		schemaVersion: 14
		style:         "dark"
		tags: [
			"kubernetes-mixin",
		]
		templating: list: [{
			current: {
				text:  "default"
				value: "default"
			}
			hide:  0
			label: "Data Source"
			name:  "datasource"
			options: []
			query:   "prometheus"
			refresh: 1
			regex:   ""
			type:    "datasource"
		}, {
			allValue: null
			current: {
				text:  ""
				value: ""
			}
			datasource: "$datasource"
			hide:       2
			includeAll: false
			label:      null
			multi:      false
			name:       "cluster"
			options: []
			query:          "label_values(up{job=\"kube-state-metrics\"}, cluster)"
			refresh:        2
			regex:          ""
			sort:           1
			tagValuesQuery: ""
			tags: []
			tagsQuery: ""
			type:      "query"
			useTags:   false
		}, {
			allValue: null
			current: {
				text:  ""
				value: ""
			}
			datasource: "$datasource"
			hide:       0
			includeAll: false
			label:      null
			multi:      false
			name:       "namespace"
			options: []
			query:          "label_values(kube_namespace_status_phase{job=\"kube-state-metrics\", cluster=\"$cluster\"}, namespace)"
			refresh:        2
			regex:          ""
			sort:           1
			tagValuesQuery: ""
			tags: []
			tagsQuery: ""
			type:      "query"
			useTags:   false
		}, {
			allValue: null
			current: {
				text:  ""
				value: ""
			}
			datasource: "$datasource"
			hide:       0
			includeAll: false
			label:      null
			multi:      false
			name:       "pod"
			options: []
			query:          "label_values(kube_pod_info{job=\"kube-state-metrics\", cluster=\"$cluster\", namespace=\"$namespace\"}, pod)"
			refresh:        2
			regex:          ""
			sort:           1
			tagValuesQuery: ""
			tags: []
			tagsQuery: ""
			type:      "query"
			useTags:   false
		}]
		time: {
			from: "now-1h"
			to:   "now"
		}
		timepicker: {
			refresh_intervals: ["5s", "10s", "30s", "1m", "5m", "15m", "30m", "1h", "2h", "1d"]
			time_options: ["5m", "15m", "1h", "6h", "12h", "24h", "2d", "7d", "30d"]
		}
		timezone: "UTC"
		title:    "Kubernetes / Compute Resources / Pod"
		uid:      "6581e46e4e5c7ba40a07646395ef7b23"
		version:  0
	}
	"k8s-resources-workload.json": {
		annotations: list: []
		editable:     true
		gnetId:       null
		graphTooltip: 0
		hideControls: false
		links: []
		refresh: "10s"
		rows: [{
			collapse: false
			height:   "250px"
			panels: [{
				aliasColors: {}
				bars:       false
				dashLength: 10
				dashes:     false
				datasource: "$datasource"
				fill:       10
				id:         1
				interval:   "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 0
				links: []
				nullPointMode: "null as zero"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				seriesOverrides: []
				spaceLength: 10
				span:        12
				stack:       true
				steppedLine: false
				targets: [{
					expr: """
						sum(
						    node_namespace_pod_container:container_cpu_usage_seconds_total:sum_irate{cluster="$cluster", namespace="$namespace"}
						  * on(namespace,pod)
						    group_left(workload, workload_type) namespace_workload_pod:kube_pod_owner:relabel{cluster="$cluster", namespace="$namespace", workload="$workload", workload_type="$type"}
						) by (pod)

						"""
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{pod}}"
					legendLink:     null
					step:           10
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "CPU Usage"
				tooltip: {
					shared:     false
					sort:       2
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
				yaxes: [{
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    false
				}]
			}]
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       true
			title:           "CPU Usage"
			titleSize:       "h6"
		}, {
			collapse: false
			height:   "250px"
			panels: [{
				aliasColors: {}
				bars:       false
				dashLength: 10
				dashes:     false
				datasource: "$datasource"
				fill:       1
				id:         2
				interval:   "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 1
				links: []
				nullPointMode: "null as zero"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				seriesOverrides: []
				spaceLength: 10
				span:        12
				stack:       false
				steppedLine: false
				styles: [{
					alias:      "Time"
					dateFormat: "YYYY-MM-DD HH:mm:ss"
					pattern:    "Time"
					type:       "hidden"
				}, {
					alias:     "CPU Usage"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #A"
					thresholds: []
					type: "number"
					unit: "short"
				}, {
					alias:     "CPU Requests"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #B"
					thresholds: []
					type: "number"
					unit: "short"
				}, {
					alias:     "CPU Requests %"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #C"
					thresholds: []
					type: "number"
					unit: "percentunit"
				}, {
					alias:     "CPU Limits"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #D"
					thresholds: []
					type: "number"
					unit: "short"
				}, {
					alias:     "CPU Limits %"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #E"
					thresholds: []
					type: "number"
					unit: "percentunit"
				}, {
					alias:     "Pod"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            true
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         "/d/6581e46e4e5c7ba40a07646395ef7b23/k8s-resources-pod?var-datasource=$datasource&var-cluster=$cluster&var-namespace=$namespace&var-pod=$__cell"
					pattern:         "pod"
					thresholds: []
					type: "number"
					unit: "short"
				}, {
					alias:     ""
					colorMode: null
					colors: []
					dateFormat: "YYYY-MM-DD HH:mm:ss"
					decimals:   2
					pattern:    "/.*/"
					thresholds: []
					type: "string"
					unit: "short"
				}]
				targets: [{
					expr: """
						sum(
						    node_namespace_pod_container:container_cpu_usage_seconds_total:sum_irate{cluster="$cluster", namespace="$namespace"}
						  * on(namespace,pod)
						    group_left(workload, workload_type) namespace_workload_pod:kube_pod_owner:relabel{cluster="$cluster", namespace="$namespace", workload="$workload", workload_type="$type"}
						) by (pod)

						"""
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "A"
					step:           10
				}, {
					expr: """
						sum(
						    kube_pod_container_resource_requests{job="kube-state-metrics", cluster="$cluster", namespace="$namespace", resource="cpu"}
						  * on(namespace,pod)
						    group_left(workload, workload_type) namespace_workload_pod:kube_pod_owner:relabel{cluster="$cluster", namespace="$namespace", workload="$workload", workload_type="$type"}
						) by (pod)

						"""
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "B"
					step:           10
				}, {
					expr: """
						sum(
						    node_namespace_pod_container:container_cpu_usage_seconds_total:sum_irate{cluster="$cluster", namespace="$namespace"}
						  * on(namespace,pod)
						    group_left(workload, workload_type) namespace_workload_pod:kube_pod_owner:relabel{cluster="$cluster", namespace="$namespace", workload="$workload", workload_type="$type"}
						) by (pod)
						/sum(
						    kube_pod_container_resource_requests{job="kube-state-metrics", cluster="$cluster", namespace="$namespace", resource="cpu"}
						  * on(namespace,pod)
						    group_left(workload, workload_type) namespace_workload_pod:kube_pod_owner:relabel{cluster="$cluster", namespace="$namespace", workload="$workload", workload_type="$type"}
						) by (pod)

						"""
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "C"
					step:           10
				}, {
					expr: """
						sum(
						    kube_pod_container_resource_limits{job="kube-state-metrics", cluster="$cluster", namespace="$namespace", resource="cpu"}
						  * on(namespace,pod)
						    group_left(workload, workload_type) namespace_workload_pod:kube_pod_owner:relabel{cluster="$cluster", namespace="$namespace", workload="$workload", workload_type="$type"}
						) by (pod)

						"""
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "D"
					step:           10
				}, {
					expr: """
						sum(
						    node_namespace_pod_container:container_cpu_usage_seconds_total:sum_irate{cluster="$cluster", namespace="$namespace"}
						  * on(namespace,pod)
						    group_left(workload, workload_type) namespace_workload_pod:kube_pod_owner:relabel{cluster="$cluster", namespace="$namespace", workload="$workload", workload_type="$type"}
						) by (pod)
						/sum(
						    kube_pod_container_resource_limits{job="kube-state-metrics", cluster="$cluster", namespace="$namespace", resource="cpu"}
						  * on(namespace,pod)
						    group_left(workload, workload_type) namespace_workload_pod:kube_pod_owner:relabel{cluster="$cluster", namespace="$namespace", workload="$workload", workload_type="$type"}
						) by (pod)

						"""
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "E"
					step:           10
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "CPU Quota"
				tooltip: {
					shared:     false
					sort:       2
					value_type: "individual"
				}
				transform: "table"
				type:      "table"
				xaxis: {
					buckets: null
					mode:    "time"
					name:    null
					show:    true
					values: []
				}
				yaxes: [{
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    false
				}]
			}]
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       true
			title:           "CPU Quota"
			titleSize:       "h6"
		}, {
			collapse: false
			height:   "250px"
			panels: [{
				aliasColors: {}
				bars:       false
				dashLength: 10
				dashes:     false
				datasource: "$datasource"
				fill:       10
				id:         3
				interval:   "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 0
				links: []
				nullPointMode: "null as zero"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				seriesOverrides: []
				spaceLength: 10
				span:        12
				stack:       true
				steppedLine: false
				targets: [{
					expr: """
						sum(
						    container_memory_working_set_bytes{cluster="$cluster", namespace="$namespace", container!="", image!=""}
						  * on(namespace,pod)
						    group_left(workload, workload_type) namespace_workload_pod:kube_pod_owner:relabel{cluster="$cluster", namespace="$namespace", workload="$workload", workload_type="$type"}
						) by (pod)

						"""
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{pod}}"
					legendLink:     null
					step:           10
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Memory Usage"
				tooltip: {
					shared:     false
					sort:       2
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
				yaxes: [{
					format:  "bytes"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    false
				}]
			}]
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       true
			title:           "Memory Usage"
			titleSize:       "h6"
		}, {
			collapse: false
			height:   "250px"
			panels: [{
				aliasColors: {}
				bars:       false
				dashLength: 10
				dashes:     false
				datasource: "$datasource"
				fill:       1
				id:         4
				interval:   "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 1
				links: []
				nullPointMode: "null as zero"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				seriesOverrides: []
				spaceLength: 10
				span:        12
				stack:       false
				steppedLine: false
				styles: [{
					alias:      "Time"
					dateFormat: "YYYY-MM-DD HH:mm:ss"
					pattern:    "Time"
					type:       "hidden"
				}, {
					alias:     "Memory Usage"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #A"
					thresholds: []
					type: "number"
					unit: "bytes"
				}, {
					alias:     "Memory Requests"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #B"
					thresholds: []
					type: "number"
					unit: "bytes"
				}, {
					alias:     "Memory Requests %"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #C"
					thresholds: []
					type: "number"
					unit: "percentunit"
				}, {
					alias:     "Memory Limits"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #D"
					thresholds: []
					type: "number"
					unit: "bytes"
				}, {
					alias:     "Memory Limits %"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #E"
					thresholds: []
					type: "number"
					unit: "percentunit"
				}, {
					alias:     "Pod"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            true
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         "/d/6581e46e4e5c7ba40a07646395ef7b23/k8s-resources-pod?var-datasource=$datasource&var-cluster=$cluster&var-namespace=$namespace&var-pod=$__cell"
					pattern:         "pod"
					thresholds: []
					type: "number"
					unit: "short"
				}, {
					alias:     ""
					colorMode: null
					colors: []
					dateFormat: "YYYY-MM-DD HH:mm:ss"
					decimals:   2
					pattern:    "/.*/"
					thresholds: []
					type: "string"
					unit: "short"
				}]
				targets: [{
					expr: """
						sum(
						    container_memory_working_set_bytes{cluster="$cluster", namespace="$namespace", container!="", image!=""}
						  * on(namespace,pod)
						    group_left(workload, workload_type) namespace_workload_pod:kube_pod_owner:relabel{cluster="$cluster", namespace="$namespace", workload="$workload", workload_type="$type"}
						) by (pod)

						"""
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "A"
					step:           10
				}, {
					expr: """
						sum(
						    kube_pod_container_resource_requests{job="kube-state-metrics", cluster="$cluster", namespace="$namespace", resource="memory"}
						  * on(namespace,pod)
						    group_left(workload, workload_type) namespace_workload_pod:kube_pod_owner:relabel{cluster="$cluster", namespace="$namespace", workload="$workload", workload_type="$type"}
						) by (pod)

						"""
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "B"
					step:           10
				}, {
					expr: """
						sum(
						    container_memory_working_set_bytes{cluster="$cluster", namespace="$namespace", container!="", image!=""}
						  * on(namespace,pod)
						    group_left(workload, workload_type) namespace_workload_pod:kube_pod_owner:relabel{cluster="$cluster", namespace="$namespace", workload="$workload", workload_type="$type"}
						) by (pod)
						/sum(
						    kube_pod_container_resource_requests{job="kube-state-metrics", cluster="$cluster", namespace="$namespace", resource="memory"}
						  * on(namespace,pod)
						    group_left(workload, workload_type) namespace_workload_pod:kube_pod_owner:relabel{cluster="$cluster", namespace="$namespace", workload="$workload", workload_type="$type"}
						) by (pod)

						"""
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "C"
					step:           10
				}, {
					expr: """
						sum(
						    kube_pod_container_resource_limits{job="kube-state-metrics", cluster="$cluster", namespace="$namespace", resource="memory"}
						  * on(namespace,pod)
						    group_left(workload, workload_type) namespace_workload_pod:kube_pod_owner:relabel{cluster="$cluster", namespace="$namespace", workload="$workload", workload_type="$type"}
						) by (pod)

						"""
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "D"
					step:           10
				}, {
					expr: """
						sum(
						    container_memory_working_set_bytes{cluster="$cluster", namespace="$namespace", container!="", image!=""}
						  * on(namespace,pod)
						    group_left(workload, workload_type) namespace_workload_pod:kube_pod_owner:relabel{cluster="$cluster", namespace="$namespace", workload="$workload", workload_type="$type"}
						) by (pod)
						/sum(
						    kube_pod_container_resource_limits{job="kube-state-metrics", cluster="$cluster", namespace="$namespace", resource="memory"}
						  * on(namespace,pod)
						    group_left(workload, workload_type) namespace_workload_pod:kube_pod_owner:relabel{cluster="$cluster", namespace="$namespace", workload="$workload", workload_type="$type"}
						) by (pod)

						"""
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "E"
					step:           10
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Memory Quota"
				tooltip: {
					shared:     false
					sort:       2
					value_type: "individual"
				}
				transform: "table"
				type:      "table"
				xaxis: {
					buckets: null
					mode:    "time"
					name:    null
					show:    true
					values: []
				}
				yaxes: [{
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    false
				}]
			}]
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       true
			title:           "Memory Quota"
			titleSize:       "h6"
		}, {
			collapse: false
			height:   "250px"
			panels: [{
				aliasColors: {}
				bars:       false
				dashLength: 10
				dashes:     false
				datasource: "$datasource"
				fill:       1
				id:         5
				interval:   "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 1
				links: []
				nullPointMode: "null as zero"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				seriesOverrides: []
				spaceLength: 10
				span:        12
				stack:       false
				steppedLine: false
				styles: [{
					alias:      "Time"
					dateFormat: "YYYY-MM-DD HH:mm:ss"
					pattern:    "Time"
					type:       "hidden"
				}, {
					alias:     "Current Receive Bandwidth"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #A"
					thresholds: []
					type: "number"
					unit: "Bps"
				}, {
					alias:     "Current Transmit Bandwidth"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #B"
					thresholds: []
					type: "number"
					unit: "Bps"
				}, {
					alias:     "Rate of Received Packets"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #C"
					thresholds: []
					type: "number"
					unit: "pps"
				}, {
					alias:     "Rate of Transmitted Packets"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #D"
					thresholds: []
					type: "number"
					unit: "pps"
				}, {
					alias:     "Rate of Received Packets Dropped"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #E"
					thresholds: []
					type: "number"
					unit: "pps"
				}, {
					alias:     "Rate of Transmitted Packets Dropped"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #F"
					thresholds: []
					type: "number"
					unit: "pps"
				}, {
					alias:     "Pod"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            true
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         "/d/6581e46e4e5c7ba40a07646395ef7b23/k8s-resources-pod?var-datasource=$datasource&var-cluster=$cluster&var-namespace=$namespace&var-pod=$__cell"
					pattern:         "pod"
					thresholds: []
					type: "number"
					unit: "short"
				}, {
					alias:     ""
					colorMode: null
					colors: []
					dateFormat: "YYYY-MM-DD HH:mm:ss"
					decimals:   2
					pattern:    "/.*/"
					thresholds: []
					type: "string"
					unit: "short"
				}]
				targets: [{
					expr: """
						(sum(irate(container_network_receive_bytes_total{job="kubelet", metrics_path="/metrics/cadvisor", cluster="$cluster", namespace="$namespace"}[$__rate_interval])
						* on (namespace,pod)
						group_left(workload,workload_type) namespace_workload_pod:kube_pod_owner:relabel{cluster="$cluster", namespace="$namespace", workload=~"$workload", workload_type="$type"}) by (pod))

						"""
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "A"
					step:           10
				}, {
					expr: """
						(sum(irate(container_network_transmit_bytes_total{job="kubelet", metrics_path="/metrics/cadvisor", cluster="$cluster", namespace="$namespace"}[$__rate_interval])
						* on (namespace,pod)
						group_left(workload,workload_type) namespace_workload_pod:kube_pod_owner:relabel{cluster="$cluster", namespace="$namespace", workload=~"$workload", workload_type="$type"}) by (pod))

						"""
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "B"
					step:           10
				}, {
					expr: """
						(sum(irate(container_network_receive_packets_total{job="kubelet", metrics_path="/metrics/cadvisor", cluster="$cluster", namespace="$namespace"}[$__rate_interval])
						* on (namespace,pod)
						group_left(workload,workload_type) namespace_workload_pod:kube_pod_owner:relabel{cluster="$cluster", namespace="$namespace", workload=~"$workload", workload_type="$type"}) by (pod))

						"""
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "C"
					step:           10
				}, {
					expr: """
						(sum(irate(container_network_transmit_packets_total{job="kubelet", metrics_path="/metrics/cadvisor", cluster="$cluster", namespace="$namespace"}[$__rate_interval])
						* on (namespace,pod)
						group_left(workload,workload_type) namespace_workload_pod:kube_pod_owner:relabel{cluster="$cluster", namespace="$namespace", workload=~"$workload", workload_type="$type"}) by (pod))

						"""
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "D"
					step:           10
				}, {
					expr: """
						(sum(irate(container_network_receive_packets_dropped_total{job="kubelet", metrics_path="/metrics/cadvisor", cluster="$cluster", namespace="$namespace"}[$__rate_interval])
						* on (namespace,pod)
						group_left(workload,workload_type) namespace_workload_pod:kube_pod_owner:relabel{cluster="$cluster", namespace="$namespace", workload=~"$workload", workload_type="$type"}) by (pod))

						"""
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "E"
					step:           10
				}, {
					expr: """
						(sum(irate(container_network_transmit_packets_dropped_total{job="kubelet", metrics_path="/metrics/cadvisor", cluster="$cluster", namespace="$namespace"}[$__rate_interval])
						* on (namespace,pod)
						group_left(workload,workload_type) namespace_workload_pod:kube_pod_owner:relabel{cluster="$cluster", namespace="$namespace", workload=~"$workload", workload_type="$type"}) by (pod))

						"""
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "F"
					step:           10
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Current Network Usage"
				tooltip: {
					shared:     false
					sort:       2
					value_type: "individual"
				}
				transform: "table"
				type:      "table"
				xaxis: {
					buckets: null
					mode:    "time"
					name:    null
					show:    true
					values: []
				}
				yaxes: [{
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    false
				}]
			}]
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       true
			title:           "Current Network Usage"
			titleSize:       "h6"
		}, {
			collapse: false
			height:   "250px"
			panels: [{
				aliasColors: {}
				bars:       false
				dashLength: 10
				dashes:     false
				datasource: "$datasource"
				fill:       10
				id:         6
				interval:   "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 0
				links: []
				nullPointMode: "null as zero"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				seriesOverrides: []
				spaceLength: 10
				span:        6
				stack:       true
				steppedLine: false
				targets: [{
					expr: """
						(sum(irate(container_network_receive_bytes_total{job="kubelet", metrics_path="/metrics/cadvisor", cluster="$cluster", namespace="$namespace"}[$__rate_interval])
						* on (namespace,pod)
						group_left(workload,workload_type) namespace_workload_pod:kube_pod_owner:relabel{cluster="$cluster", namespace="$namespace", workload=~"$workload", workload_type="$type"}) by (pod))

						"""
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{pod}}"
					legendLink:     null
					step:           10
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Receive Bandwidth"
				tooltip: {
					shared:     false
					sort:       2
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
				yaxes: [{
					format:  "Bps"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    false
				}]
			}, {
				aliasColors: {}
				bars:       false
				dashLength: 10
				dashes:     false
				datasource: "$datasource"
				fill:       10
				id:         7
				interval:   "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 0
				links: []
				nullPointMode: "null as zero"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				seriesOverrides: []
				spaceLength: 10
				span:        6
				stack:       true
				steppedLine: false
				targets: [{
					expr: """
						(sum(irate(container_network_transmit_bytes_total{job="kubelet", metrics_path="/metrics/cadvisor", cluster="$cluster", namespace="$namespace"}[$__rate_interval])
						* on (namespace,pod)
						group_left(workload,workload_type) namespace_workload_pod:kube_pod_owner:relabel{cluster="$cluster", namespace="$namespace", workload=~"$workload", workload_type="$type"}) by (pod))

						"""
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{pod}}"
					legendLink:     null
					step:           10
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Transmit Bandwidth"
				tooltip: {
					shared:     false
					sort:       2
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
				yaxes: [{
					format:  "Bps"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    false
				}]
			}]
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       true
			title:           "Bandwidth"
			titleSize:       "h6"
		}, {
			collapse: false
			height:   "250px"
			panels: [{
				aliasColors: {}
				bars:       false
				dashLength: 10
				dashes:     false
				datasource: "$datasource"
				fill:       10
				id:         8
				interval:   "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 0
				links: []
				nullPointMode: "null as zero"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				seriesOverrides: []
				spaceLength: 10
				span:        6
				stack:       true
				steppedLine: false
				targets: [{
					expr: """
						(avg(irate(container_network_receive_bytes_total{job="kubelet", metrics_path="/metrics/cadvisor", cluster="$cluster", namespace="$namespace"}[$__rate_interval])
						* on (namespace,pod)
						group_left(workload,workload_type) namespace_workload_pod:kube_pod_owner:relabel{cluster="$cluster", namespace="$namespace", workload=~"$workload", workload_type="$type"}) by (pod))

						"""
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{pod}}"
					legendLink:     null
					step:           10
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Average Container Bandwidth by Pod: Received"
				tooltip: {
					shared:     false
					sort:       2
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
				yaxes: [{
					format:  "Bps"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    false
				}]
			}, {
				aliasColors: {}
				bars:       false
				dashLength: 10
				dashes:     false
				datasource: "$datasource"
				fill:       10
				id:         9
				interval:   "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 0
				links: []
				nullPointMode: "null as zero"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				seriesOverrides: []
				spaceLength: 10
				span:        6
				stack:       true
				steppedLine: false
				targets: [{
					expr: """
						(avg(irate(container_network_transmit_bytes_total{job="kubelet", metrics_path="/metrics/cadvisor", cluster="$cluster", namespace="$namespace"}[$__rate_interval])
						* on (namespace,pod)
						group_left(workload,workload_type) namespace_workload_pod:kube_pod_owner:relabel{cluster="$cluster", namespace="$namespace", workload=~"$workload", workload_type="$type"}) by (pod))

						"""
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{pod}}"
					legendLink:     null
					step:           10
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Average Container Bandwidth by Pod: Transmitted"
				tooltip: {
					shared:     false
					sort:       2
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
				yaxes: [{
					format:  "Bps"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    false
				}]
			}]
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       true
			title:           "Average Container Bandwidth by Pod"
			titleSize:       "h6"
		}, {
			collapse: false
			height:   "250px"
			panels: [{
				aliasColors: {}
				bars:       false
				dashLength: 10
				dashes:     false
				datasource: "$datasource"
				fill:       10
				id:         10
				interval:   "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 0
				links: []
				nullPointMode: "null as zero"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				seriesOverrides: []
				spaceLength: 10
				span:        6
				stack:       true
				steppedLine: false
				targets: [{
					expr: """
						(sum(irate(container_network_receive_packets_total{job="kubelet", metrics_path="/metrics/cadvisor", cluster="$cluster", namespace="$namespace"}[$__rate_interval])
						* on (namespace,pod)
						group_left(workload,workload_type) namespace_workload_pod:kube_pod_owner:relabel{cluster="$cluster", namespace="$namespace", workload=~"$workload", workload_type="$type"}) by (pod))

						"""
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{pod}}"
					legendLink:     null
					step:           10
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Rate of Received Packets"
				tooltip: {
					shared:     false
					sort:       2
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
				yaxes: [{
					format:  "pps"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    false
				}]
			}, {
				aliasColors: {}
				bars:       false
				dashLength: 10
				dashes:     false
				datasource: "$datasource"
				fill:       10
				id:         11
				interval:   "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 0
				links: []
				nullPointMode: "null as zero"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				seriesOverrides: []
				spaceLength: 10
				span:        6
				stack:       true
				steppedLine: false
				targets: [{
					expr: """
						(sum(irate(container_network_transmit_packets_total{job="kubelet", metrics_path="/metrics/cadvisor", cluster="$cluster", namespace="$namespace"}[$__rate_interval])
						* on (namespace,pod)
						group_left(workload,workload_type) namespace_workload_pod:kube_pod_owner:relabel{cluster="$cluster", namespace="$namespace", workload=~"$workload", workload_type="$type"}) by (pod))

						"""
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{pod}}"
					legendLink:     null
					step:           10
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Rate of Transmitted Packets"
				tooltip: {
					shared:     false
					sort:       2
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
				yaxes: [{
					format:  "pps"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    false
				}]
			}]
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       true
			title:           "Rate of Packets"
			titleSize:       "h6"
		}, {
			collapse: false
			height:   "250px"
			panels: [{
				aliasColors: {}
				bars:       false
				dashLength: 10
				dashes:     false
				datasource: "$datasource"
				fill:       10
				id:         12
				interval:   "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 0
				links: []
				nullPointMode: "null as zero"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				seriesOverrides: []
				spaceLength: 10
				span:        6
				stack:       true
				steppedLine: false
				targets: [{
					expr: """
						(sum(irate(container_network_receive_packets_dropped_total{job="kubelet", metrics_path="/metrics/cadvisor", cluster="$cluster", namespace="$namespace"}[$__rate_interval])
						* on (namespace,pod)
						group_left(workload,workload_type) namespace_workload_pod:kube_pod_owner:relabel{cluster="$cluster", namespace="$namespace", workload=~"$workload", workload_type="$type"}) by (pod))

						"""
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{pod}}"
					legendLink:     null
					step:           10
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Rate of Received Packets Dropped"
				tooltip: {
					shared:     false
					sort:       2
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
				yaxes: [{
					format:  "pps"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    false
				}]
			}, {
				aliasColors: {}
				bars:       false
				dashLength: 10
				dashes:     false
				datasource: "$datasource"
				fill:       10
				id:         13
				interval:   "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 0
				links: []
				nullPointMode: "null as zero"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				seriesOverrides: []
				spaceLength: 10
				span:        6
				stack:       true
				steppedLine: false
				targets: [{
					expr: """
						(sum(irate(container_network_transmit_packets_dropped_total{job="kubelet", metrics_path="/metrics/cadvisor", cluster="$cluster", namespace="$namespace"}[$__rate_interval])
						* on (namespace,pod)
						group_left(workload,workload_type) namespace_workload_pod:kube_pod_owner:relabel{cluster="$cluster", namespace="$namespace", workload=~"$workload", workload_type="$type"}) by (pod))

						"""
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{pod}}"
					legendLink:     null
					step:           10
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Rate of Transmitted Packets Dropped"
				tooltip: {
					shared:     false
					sort:       2
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
				yaxes: [{
					format:  "pps"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    false
				}]
			}]
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       true
			title:           "Rate of Packets Dropped"
			titleSize:       "h6"
		}]
		schemaVersion: 14
		style:         "dark"
		tags: [
			"kubernetes-mixin",
		]
		templating: list: [{
			current: {
				text:  "default"
				value: "default"
			}
			hide:  0
			label: "Data Source"
			name:  "datasource"
			options: []
			query:   "prometheus"
			refresh: 1
			regex:   ""
			type:    "datasource"
		}, {
			allValue: null
			current: {
				text:  ""
				value: ""
			}
			datasource: "$datasource"
			hide:       2
			includeAll: false
			label:      null
			multi:      false
			name:       "cluster"
			options: []
			query:          "label_values(up{job=\"kube-state-metrics\"}, cluster)"
			refresh:        2
			regex:          ""
			sort:           1
			tagValuesQuery: ""
			tags: []
			tagsQuery: ""
			type:      "query"
			useTags:   false
		}, {
			allValue: null
			current: {
				text:  ""
				value: ""
			}
			datasource: "$datasource"
			hide:       0
			includeAll: false
			label:      null
			multi:      false
			name:       "namespace"
			options: []
			query:          "label_values(kube_namespace_status_phase{job=\"kube-state-metrics\", cluster=\"$cluster\"}, namespace)"
			refresh:        2
			regex:          ""
			sort:           1
			tagValuesQuery: ""
			tags: []
			tagsQuery: ""
			type:      "query"
			useTags:   false
		}, {
			allValue: null
			current: {
				text:  ""
				value: ""
			}
			datasource: "$datasource"
			hide:       0
			includeAll: false
			label:      null
			multi:      false
			name:       "type"
			options: []
			query:          "label_values(namespace_workload_pod:kube_pod_owner:relabel{cluster=\"$cluster\", namespace=\"$namespace\"}, workload_type)"
			refresh:        2
			regex:          ""
			sort:           1
			tagValuesQuery: ""
			tags: []
			tagsQuery: ""
			type:      "query"
			useTags:   false
		}, {
			allValue: null
			current: {
				text:  ""
				value: ""
			}
			datasource: "$datasource"
			hide:       0
			includeAll: false
			label:      null
			multi:      false
			name:       "workload"
			options: []
			query:          "label_values(namespace_workload_pod:kube_pod_owner:relabel{cluster=\"$cluster\", namespace=\"$namespace\", workload_type=\"$type\"}, workload)"
			refresh:        2
			regex:          ""
			sort:           1
			tagValuesQuery: ""
			tags: []
			tagsQuery: ""
			type:      "query"
			useTags:   false
		}]
		time: {
			from: "now-1h"
			to:   "now"
		}
		timepicker: {
			refresh_intervals: ["5s", "10s", "30s", "1m", "5m", "15m", "30m", "1h", "2h", "1d"]
			time_options: ["5m", "15m", "1h", "6h", "12h", "24h", "2d", "7d", "30d"]
		}
		timezone: "UTC"
		title:    "Kubernetes / Compute Resources / Workload"
		uid:      "a164a7f0339f99e89cea5cb47e9be617"
		version:  0
	}
	"k8s-resources-workloads-namespace.json": {
		annotations: list: []
		editable:     true
		gnetId:       null
		graphTooltip: 0
		hideControls: false
		links: []
		refresh: "10s"
		rows: [{
			collapse: false
			height:   "250px"
			panels: [{
				aliasColors: {}
				bars:       false
				dashLength: 10
				dashes:     false
				datasource: "$datasource"
				fill:       10
				id:         1
				interval:   "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 0
				links: []
				nullPointMode: "null as zero"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				seriesOverrides: [{
					alias:        "quota - requests"
					color:        "#F2495C"
					dashes:       true
					fill:         0
					hiddenSeries: true
					hideTooltip:  true
					legend:       true
					linewidth:    2
					stack:        false
				}, {
					alias:        "quota - limits"
					color:        "#FF9830"
					dashes:       true
					fill:         0
					hiddenSeries: true
					hideTooltip:  true
					legend:       true
					linewidth:    2
					stack:        false
				}]
				spaceLength: 10
				span:        12
				stack:       true
				steppedLine: false
				targets: [{
					expr: """
						sum(
						  node_namespace_pod_container:container_cpu_usage_seconds_total:sum_irate{cluster="$cluster", namespace="$namespace"}
						* on(namespace,pod)
						  group_left(workload, workload_type) namespace_workload_pod:kube_pod_owner:relabel{cluster="$cluster", namespace="$namespace", workload_type="$type"}
						) by (workload, workload_type)

						"""
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{workload}} - {{workload_type}}"
					legendLink:     null
					step:           10
				}, {
					expr:           "scalar(kube_resourcequota{cluster=\"$cluster\", namespace=\"$namespace\", type=\"hard\",resource=\"requests.cpu\"})"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "quota - requests"
					legendLink:     null
					step:           10
				}, {
					expr:           "scalar(kube_resourcequota{cluster=\"$cluster\", namespace=\"$namespace\", type=\"hard\",resource=\"limits.cpu\"})"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "quota - limits"
					legendLink:     null
					step:           10
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "CPU Usage"
				tooltip: {
					shared:     false
					sort:       2
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
				yaxes: [{
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    false
				}]
			}]
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       true
			title:           "CPU Usage"
			titleSize:       "h6"
		}, {
			collapse: false
			height:   "250px"
			panels: [{
				aliasColors: {}
				bars:       false
				dashLength: 10
				dashes:     false
				datasource: "$datasource"
				fill:       1
				id:         2
				interval:   "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 1
				links: []
				nullPointMode: "null as zero"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				seriesOverrides: []
				spaceLength: 10
				span:        12
				stack:       false
				steppedLine: false
				styles: [{
					alias:      "Time"
					dateFormat: "YYYY-MM-DD HH:mm:ss"
					pattern:    "Time"
					type:       "hidden"
				}, {
					alias:     "Running Pods"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        0
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #A"
					thresholds: []
					type: "number"
					unit: "short"
				}, {
					alias:     "CPU Usage"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #B"
					thresholds: []
					type: "number"
					unit: "short"
				}, {
					alias:     "CPU Requests"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #C"
					thresholds: []
					type: "number"
					unit: "short"
				}, {
					alias:     "CPU Requests %"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #D"
					thresholds: []
					type: "number"
					unit: "percentunit"
				}, {
					alias:     "CPU Limits"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #E"
					thresholds: []
					type: "number"
					unit: "short"
				}, {
					alias:     "CPU Limits %"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #F"
					thresholds: []
					type: "number"
					unit: "percentunit"
				}, {
					alias:     "Workload"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            true
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         "/d/a164a7f0339f99e89cea5cb47e9be617/k8s-resources-workload?var-datasource=$datasource&var-cluster=$cluster&var-namespace=$namespace&var-workload=$__cell&var-type=$__cell_2"
					pattern:         "workload"
					thresholds: []
					type: "number"
					unit: "short"
				}, {
					alias:     "Workload Type"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "workload_type"
					thresholds: []
					type: "number"
					unit: "short"
				}, {
					alias:     ""
					colorMode: null
					colors: []
					dateFormat: "YYYY-MM-DD HH:mm:ss"
					decimals:   2
					pattern:    "/.*/"
					thresholds: []
					type: "string"
					unit: "short"
				}]
				targets: [{
					expr:           "count(namespace_workload_pod:kube_pod_owner:relabel{cluster=\"$cluster\", namespace=\"$namespace\", workload_type=\"$type\"}) by (workload, workload_type)"
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "A"
					step:           10
				}, {
					expr: """
						sum(
						  node_namespace_pod_container:container_cpu_usage_seconds_total:sum_irate{cluster="$cluster", namespace="$namespace"}
						* on(namespace,pod)
						  group_left(workload, workload_type) namespace_workload_pod:kube_pod_owner:relabel{cluster="$cluster", namespace="$namespace", workload_type="$type"}
						) by (workload, workload_type)

						"""
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "B"
					step:           10
				}, {
					expr: """
						sum(
						  kube_pod_container_resource_requests{job="kube-state-metrics", cluster="$cluster", namespace="$namespace", resource="cpu"}
						* on(namespace,pod)
						  group_left(workload, workload_type) namespace_workload_pod:kube_pod_owner:relabel{cluster="$cluster", namespace="$namespace", workload_type="$type"}
						) by (workload, workload_type)

						"""
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "C"
					step:           10
				}, {
					expr: """
						sum(
						  node_namespace_pod_container:container_cpu_usage_seconds_total:sum_irate{cluster="$cluster", namespace="$namespace"}
						* on(namespace,pod)
						  group_left(workload, workload_type) namespace_workload_pod:kube_pod_owner:relabel{cluster="$cluster", namespace="$namespace", workload_type="$type"}
						) by (workload, workload_type)
						/sum(
						  kube_pod_container_resource_requests{job="kube-state-metrics", cluster="$cluster", namespace="$namespace", resource="cpu"}
						* on(namespace,pod)
						  group_left(workload, workload_type) namespace_workload_pod:kube_pod_owner:relabel{cluster="$cluster", namespace="$namespace", workload_type="$type"}
						) by (workload, workload_type)

						"""
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "D"
					step:           10
				}, {
					expr: """
						sum(
						  kube_pod_container_resource_limits{job="kube-state-metrics", cluster="$cluster", namespace="$namespace", resource="cpu"}
						* on(namespace,pod)
						  group_left(workload, workload_type) namespace_workload_pod:kube_pod_owner:relabel{cluster="$cluster", namespace="$namespace", workload_type="$type"}
						) by (workload, workload_type)

						"""
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "E"
					step:           10
				}, {
					expr: """
						sum(
						  node_namespace_pod_container:container_cpu_usage_seconds_total:sum_irate{cluster="$cluster", namespace="$namespace"}
						* on(namespace,pod)
						  group_left(workload, workload_type) namespace_workload_pod:kube_pod_owner:relabel{cluster="$cluster", namespace="$namespace", workload_type="$type"}
						) by (workload, workload_type)
						/sum(
						  kube_pod_container_resource_limits{job="kube-state-metrics", cluster="$cluster", namespace="$namespace", resource="cpu"}
						* on(namespace,pod)
						  group_left(workload, workload_type) namespace_workload_pod:kube_pod_owner:relabel{cluster="$cluster", namespace="$namespace", workload_type="$type"}
						) by (workload, workload_type)

						"""
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "F"
					step:           10
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "CPU Quota"
				tooltip: {
					shared:     false
					sort:       2
					value_type: "individual"
				}
				transform: "table"
				type:      "table"
				xaxis: {
					buckets: null
					mode:    "time"
					name:    null
					show:    true
					values: []
				}
				yaxes: [{
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    false
				}]
			}]
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       true
			title:           "CPU Quota"
			titleSize:       "h6"
		}, {
			collapse: false
			height:   "250px"
			panels: [{
				aliasColors: {}
				bars:       false
				dashLength: 10
				dashes:     false
				datasource: "$datasource"
				fill:       10
				id:         3
				interval:   "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 0
				links: []
				nullPointMode: "null as zero"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				seriesOverrides: [{
					alias:        "quota - requests"
					color:        "#F2495C"
					dashes:       true
					fill:         0
					hiddenSeries: true
					hideTooltip:  true
					legend:       true
					linewidth:    2
					stack:        false
				}, {
					alias:        "quota - limits"
					color:        "#FF9830"
					dashes:       true
					fill:         0
					hiddenSeries: true
					hideTooltip:  true
					legend:       true
					linewidth:    2
					stack:        false
				}]
				spaceLength: 10
				span:        12
				stack:       true
				steppedLine: false
				targets: [{
					expr: """
						sum(
						    container_memory_working_set_bytes{job="kubelet", metrics_path="/metrics/cadvisor", cluster="$cluster", namespace="$namespace", container!="", image!=""}
						  * on(namespace,pod)
						    group_left(workload, workload_type) namespace_workload_pod:kube_pod_owner:relabel{cluster="$cluster", namespace="$namespace", workload_type="$type"}
						) by (workload, workload_type)

						"""
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{workload}} - {{workload_type}}"
					legendLink:     null
					step:           10
				}, {
					expr:           "scalar(kube_resourcequota{cluster=\"$cluster\", namespace=\"$namespace\", type=\"hard\",resource=\"requests.memory\"})"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "quota - requests"
					legendLink:     null
					step:           10
				}, {
					expr:           "scalar(kube_resourcequota{cluster=\"$cluster\", namespace=\"$namespace\", type=\"hard\",resource=\"limits.memory\"})"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "quota - limits"
					legendLink:     null
					step:           10
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Memory Usage"
				tooltip: {
					shared:     false
					sort:       2
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
				yaxes: [{
					format:  "bytes"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    false
				}]
			}]
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       true
			title:           "Memory Usage"
			titleSize:       "h6"
		}, {
			collapse: false
			height:   "250px"
			panels: [{
				aliasColors: {}
				bars:       false
				dashLength: 10
				dashes:     false
				datasource: "$datasource"
				fill:       1
				id:         4
				interval:   "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 1
				links: []
				nullPointMode: "null as zero"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				seriesOverrides: []
				spaceLength: 10
				span:        12
				stack:       false
				steppedLine: false
				styles: [{
					alias:      "Time"
					dateFormat: "YYYY-MM-DD HH:mm:ss"
					pattern:    "Time"
					type:       "hidden"
				}, {
					alias:     "Running Pods"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        0
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #A"
					thresholds: []
					type: "number"
					unit: "short"
				}, {
					alias:     "Memory Usage"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #B"
					thresholds: []
					type: "number"
					unit: "bytes"
				}, {
					alias:     "Memory Requests"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #C"
					thresholds: []
					type: "number"
					unit: "bytes"
				}, {
					alias:     "Memory Requests %"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #D"
					thresholds: []
					type: "number"
					unit: "percentunit"
				}, {
					alias:     "Memory Limits"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #E"
					thresholds: []
					type: "number"
					unit: "bytes"
				}, {
					alias:     "Memory Limits %"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #F"
					thresholds: []
					type: "number"
					unit: "percentunit"
				}, {
					alias:     "Workload"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            true
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         "/d/a164a7f0339f99e89cea5cb47e9be617/k8s-resources-workload?var-datasource=$datasource&var-cluster=$cluster&var-namespace=$namespace&var-workload=$__cell&var-type=$__cell_2"
					pattern:         "workload"
					thresholds: []
					type: "number"
					unit: "short"
				}, {
					alias:     "Workload Type"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "workload_type"
					thresholds: []
					type: "number"
					unit: "short"
				}, {
					alias:     ""
					colorMode: null
					colors: []
					dateFormat: "YYYY-MM-DD HH:mm:ss"
					decimals:   2
					pattern:    "/.*/"
					thresholds: []
					type: "string"
					unit: "short"
				}]
				targets: [{
					expr:           "count(namespace_workload_pod:kube_pod_owner:relabel{cluster=\"$cluster\", namespace=\"$namespace\", workload_type=\"$type\"}) by (workload, workload_type)"
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "A"
					step:           10
				}, {
					expr: """
						sum(
						    container_memory_working_set_bytes{job="kubelet", metrics_path="/metrics/cadvisor", cluster="$cluster", namespace="$namespace", container!="", image!=""}
						  * on(namespace,pod)
						    group_left(workload, workload_type) namespace_workload_pod:kube_pod_owner:relabel{cluster="$cluster", namespace="$namespace", workload_type="$type"}
						) by (workload, workload_type)

						"""
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "B"
					step:           10
				}, {
					expr: """
						sum(
						  kube_pod_container_resource_requests{job="kube-state-metrics", cluster="$cluster", namespace="$namespace", resource="memory"}
						* on(namespace,pod)
						  group_left(workload, workload_type) namespace_workload_pod:kube_pod_owner:relabel{cluster="$cluster", namespace="$namespace", workload_type="$type"}
						) by (workload, workload_type)

						"""
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "C"
					step:           10
				}, {
					expr: """
						sum(
						    container_memory_working_set_bytes{job="kubelet", metrics_path="/metrics/cadvisor", cluster="$cluster", namespace="$namespace", container!="", image!=""}
						  * on(namespace,pod)
						    group_left(workload, workload_type) namespace_workload_pod:kube_pod_owner:relabel{cluster="$cluster", namespace="$namespace", workload_type="$type"}
						) by (workload, workload_type)
						/sum(
						  kube_pod_container_resource_requests{job="kube-state-metrics", cluster="$cluster", namespace="$namespace", resource="memory"}
						* on(namespace,pod)
						  group_left(workload, workload_type) namespace_workload_pod:kube_pod_owner:relabel{cluster="$cluster", namespace="$namespace", workload_type="$type"}
						) by (workload, workload_type)

						"""
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "D"
					step:           10
				}, {
					expr: """
						sum(
						  kube_pod_container_resource_limits{job="kube-state-metrics", cluster="$cluster", namespace="$namespace", resource="memory"}
						* on(namespace,pod)
						  group_left(workload, workload_type) namespace_workload_pod:kube_pod_owner:relabel{cluster="$cluster", namespace="$namespace", workload_type="$type"}
						) by (workload, workload_type)

						"""
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "E"
					step:           10
				}, {
					expr: """
						sum(
						    container_memory_working_set_bytes{job="kubelet", metrics_path="/metrics/cadvisor", cluster="$cluster", namespace="$namespace", container!="", image!=""}
						  * on(namespace,pod)
						    group_left(workload, workload_type) namespace_workload_pod:kube_pod_owner:relabel{cluster="$cluster", namespace="$namespace", workload_type="$type"}
						) by (workload, workload_type)
						/sum(
						  kube_pod_container_resource_limits{job="kube-state-metrics", cluster="$cluster", namespace="$namespace", resource="memory"}
						* on(namespace,pod)
						  group_left(workload, workload_type) namespace_workload_pod:kube_pod_owner:relabel{cluster="$cluster", namespace="$namespace", workload_type="$type"}
						) by (workload, workload_type)

						"""
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "F"
					step:           10
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Memory Quota"
				tooltip: {
					shared:     false
					sort:       2
					value_type: "individual"
				}
				transform: "table"
				type:      "table"
				xaxis: {
					buckets: null
					mode:    "time"
					name:    null
					show:    true
					values: []
				}
				yaxes: [{
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    false
				}]
			}]
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       true
			title:           "Memory Quota"
			titleSize:       "h6"
		}, {
			collapse: false
			height:   "250px"
			panels: [{
				aliasColors: {}
				bars:       false
				dashLength: 10
				dashes:     false
				datasource: "$datasource"
				fill:       1
				id:         5
				interval:   "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 1
				links: []
				nullPointMode: "null as zero"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				seriesOverrides: []
				spaceLength: 10
				span:        12
				stack:       false
				steppedLine: false
				styles: [{
					alias:      "Time"
					dateFormat: "YYYY-MM-DD HH:mm:ss"
					pattern:    "Time"
					type:       "hidden"
				}, {
					alias:     "Current Receive Bandwidth"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #A"
					thresholds: []
					type: "number"
					unit: "Bps"
				}, {
					alias:     "Current Transmit Bandwidth"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #B"
					thresholds: []
					type: "number"
					unit: "Bps"
				}, {
					alias:     "Rate of Received Packets"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #C"
					thresholds: []
					type: "number"
					unit: "pps"
				}, {
					alias:     "Rate of Transmitted Packets"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #D"
					thresholds: []
					type: "number"
					unit: "pps"
				}, {
					alias:     "Rate of Received Packets Dropped"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #E"
					thresholds: []
					type: "number"
					unit: "pps"
				}, {
					alias:     "Rate of Transmitted Packets Dropped"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "Value #F"
					thresholds: []
					type: "number"
					unit: "pps"
				}, {
					alias:     "Workload"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            true
					linkTargetBlank: false
					linkTooltip:     "Drill down to pods"
					linkUrl:         "/d/a164a7f0339f99e89cea5cb47e9be617/k8s-resources-workload?var-datasource=$datasource&var-cluster=$cluster&var-namespace=$namespace&var-workload=$__cell&var-type=$type"
					pattern:         "workload"
					thresholds: []
					type: "number"
					unit: "short"
				}, {
					alias:     "Workload Type"
					colorMode: null
					colors: []
					dateFormat:      "YYYY-MM-DD HH:mm:ss"
					decimals:        2
					link:            false
					linkTargetBlank: false
					linkTooltip:     "Drill down"
					linkUrl:         ""
					pattern:         "workload_type"
					thresholds: []
					type: "number"
					unit: "short"
				}, {
					alias:     ""
					colorMode: null
					colors: []
					dateFormat: "YYYY-MM-DD HH:mm:ss"
					decimals:   2
					pattern:    "/.*/"
					thresholds: []
					type: "string"
					unit: "short"
				}]
				targets: [{
					expr: """
						(sum(irate(container_network_receive_bytes_total{job="kubelet", metrics_path="/metrics/cadvisor", cluster="$cluster", namespace="$namespace"}[$__rate_interval])
						* on (namespace,pod)
						group_left(workload,workload_type) namespace_workload_pod:kube_pod_owner:relabel{cluster="$cluster", namespace="$namespace", workload_type="$type"}) by (workload))

						"""
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "A"
					step:           10
				}, {
					expr: """
						(sum(irate(container_network_transmit_bytes_total{job="kubelet", metrics_path="/metrics/cadvisor", cluster="$cluster", namespace="$namespace"}[$__rate_interval])
						* on (namespace,pod)
						group_left(workload,workload_type) namespace_workload_pod:kube_pod_owner:relabel{cluster="$cluster", namespace="$namespace", workload_type="$type"}) by (workload))

						"""
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "B"
					step:           10
				}, {
					expr: """
						(sum(irate(container_network_receive_packets_total{job="kubelet", metrics_path="/metrics/cadvisor", cluster="$cluster", namespace="$namespace"}[$__rate_interval])
						* on (namespace,pod)
						group_left(workload,workload_type) namespace_workload_pod:kube_pod_owner:relabel{cluster="$cluster", namespace="$namespace", workload_type="$type"}) by (workload))

						"""
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "C"
					step:           10
				}, {
					expr: """
						(sum(irate(container_network_transmit_packets_total{job="kubelet", metrics_path="/metrics/cadvisor", cluster="$cluster", namespace="$namespace"}[$__rate_interval])
						* on (namespace,pod)
						group_left(workload,workload_type) namespace_workload_pod:kube_pod_owner:relabel{cluster="$cluster", namespace="$namespace", workload_type="$type"}) by (workload))

						"""
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "D"
					step:           10
				}, {
					expr: """
						(sum(irate(container_network_receive_packets_dropped_total{job="kubelet", metrics_path="/metrics/cadvisor", cluster="$cluster", namespace="$namespace"}[$__rate_interval])
						* on (namespace,pod)
						group_left(workload,workload_type) namespace_workload_pod:kube_pod_owner:relabel{cluster="$cluster", namespace="$namespace", workload_type="$type"}) by (workload))

						"""
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "E"
					step:           10
				}, {
					expr: """
						(sum(irate(container_network_transmit_packets_dropped_total{job="kubelet", metrics_path="/metrics/cadvisor", cluster="$cluster", namespace="$namespace"}[$__rate_interval])
						* on (namespace,pod)
						group_left(workload,workload_type) namespace_workload_pod:kube_pod_owner:relabel{cluster="$cluster", namespace="$namespace", workload_type="$type"}) by (workload))

						"""
					format:         "table"
					instant:        true
					intervalFactor: 2
					legendFormat:   ""
					refId:          "F"
					step:           10
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Current Network Usage"
				tooltip: {
					shared:     false
					sort:       2
					value_type: "individual"
				}
				transform: "table"
				type:      "table"
				xaxis: {
					buckets: null
					mode:    "time"
					name:    null
					show:    true
					values: []
				}
				yaxes: [{
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    false
				}]
			}]
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       true
			title:           "Current Network Usage"
			titleSize:       "h6"
		}, {
			collapse: false
			height:   "250px"
			panels: [{
				aliasColors: {}
				bars:       false
				dashLength: 10
				dashes:     false
				datasource: "$datasource"
				fill:       10
				id:         6
				interval:   "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 0
				links: []
				nullPointMode: "null as zero"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				seriesOverrides: []
				spaceLength: 10
				span:        6
				stack:       true
				steppedLine: false
				targets: [{
					expr: """
						(sum(irate(container_network_receive_bytes_total{job="kubelet", metrics_path="/metrics/cadvisor", cluster="$cluster", namespace="$namespace"}[$__rate_interval])
						* on (namespace,pod)
						group_left(workload,workload_type) namespace_workload_pod:kube_pod_owner:relabel{cluster="$cluster", namespace="$namespace", workload=~".+", workload_type="$type"}) by (workload))

						"""
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{workload}}"
					legendLink:     null
					step:           10
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Receive Bandwidth"
				tooltip: {
					shared:     false
					sort:       2
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
				yaxes: [{
					format:  "Bps"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    false
				}]
			}, {
				aliasColors: {}
				bars:       false
				dashLength: 10
				dashes:     false
				datasource: "$datasource"
				fill:       10
				id:         7
				interval:   "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 0
				links: []
				nullPointMode: "null as zero"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				seriesOverrides: []
				spaceLength: 10
				span:        6
				stack:       true
				steppedLine: false
				targets: [{
					expr: """
						(sum(irate(container_network_transmit_bytes_total{job="kubelet", metrics_path="/metrics/cadvisor", cluster="$cluster", namespace="$namespace"}[$__rate_interval])
						* on (namespace,pod)
						group_left(workload,workload_type) namespace_workload_pod:kube_pod_owner:relabel{cluster="$cluster", namespace="$namespace", workload=~".+", workload_type="$type"}) by (workload))

						"""
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{workload}}"
					legendLink:     null
					step:           10
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Transmit Bandwidth"
				tooltip: {
					shared:     false
					sort:       2
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
				yaxes: [{
					format:  "Bps"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    false
				}]
			}]
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       true
			title:           "Bandwidth"
			titleSize:       "h6"
		}, {
			collapse: false
			height:   "250px"
			panels: [{
				aliasColors: {}
				bars:       false
				dashLength: 10
				dashes:     false
				datasource: "$datasource"
				fill:       10
				id:         8
				interval:   "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 0
				links: []
				nullPointMode: "null as zero"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				seriesOverrides: []
				spaceLength: 10
				span:        6
				stack:       true
				steppedLine: false
				targets: [{
					expr: """
						(avg(irate(container_network_receive_bytes_total{job="kubelet", metrics_path="/metrics/cadvisor", cluster="$cluster", namespace="$namespace"}[$__rate_interval])
						* on (namespace,pod)
						group_left(workload,workload_type) namespace_workload_pod:kube_pod_owner:relabel{cluster="$cluster", namespace="$namespace", workload=~".+", workload_type="$type"}) by (workload))

						"""
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{workload}}"
					legendLink:     null
					step:           10
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Average Container Bandwidth by Workload: Received"
				tooltip: {
					shared:     false
					sort:       2
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
				yaxes: [{
					format:  "Bps"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    false
				}]
			}, {
				aliasColors: {}
				bars:       false
				dashLength: 10
				dashes:     false
				datasource: "$datasource"
				fill:       10
				id:         9
				interval:   "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 0
				links: []
				nullPointMode: "null as zero"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				seriesOverrides: []
				spaceLength: 10
				span:        6
				stack:       true
				steppedLine: false
				targets: [{
					expr: """
						(avg(irate(container_network_transmit_bytes_total{job="kubelet", metrics_path="/metrics/cadvisor", cluster="$cluster", namespace="$namespace"}[$__rate_interval])
						* on (namespace,pod)
						group_left(workload,workload_type) namespace_workload_pod:kube_pod_owner:relabel{cluster="$cluster", namespace="$namespace", workload=~".+", workload_type="$type"}) by (workload))

						"""
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{workload}}"
					legendLink:     null
					step:           10
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Average Container Bandwidth by Workload: Transmitted"
				tooltip: {
					shared:     false
					sort:       2
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
				yaxes: [{
					format:  "Bps"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    false
				}]
			}]
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       true
			title:           "Average Container Bandwidth by Workload"
			titleSize:       "h6"
		}, {
			collapse: false
			height:   "250px"
			panels: [{
				aliasColors: {}
				bars:       false
				dashLength: 10
				dashes:     false
				datasource: "$datasource"
				fill:       10
				id:         10
				interval:   "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 0
				links: []
				nullPointMode: "null as zero"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				seriesOverrides: []
				spaceLength: 10
				span:        6
				stack:       true
				steppedLine: false
				targets: [{
					expr: """
						(sum(irate(container_network_receive_packets_total{job="kubelet", metrics_path="/metrics/cadvisor", cluster="$cluster", namespace="$namespace"}[$__rate_interval])
						* on (namespace,pod)
						group_left(workload,workload_type) namespace_workload_pod:kube_pod_owner:relabel{cluster="$cluster", namespace="$namespace", workload=~".+", workload_type="$type"}) by (workload))

						"""
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{workload}}"
					legendLink:     null
					step:           10
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Rate of Received Packets"
				tooltip: {
					shared:     false
					sort:       2
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
				yaxes: [{
					format:  "pps"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    false
				}]
			}, {
				aliasColors: {}
				bars:       false
				dashLength: 10
				dashes:     false
				datasource: "$datasource"
				fill:       10
				id:         11
				interval:   "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 0
				links: []
				nullPointMode: "null as zero"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				seriesOverrides: []
				spaceLength: 10
				span:        6
				stack:       true
				steppedLine: false
				targets: [{
					expr: """
						(sum(irate(container_network_transmit_packets_total{job="kubelet", metrics_path="/metrics/cadvisor", cluster="$cluster", namespace="$namespace"}[$__rate_interval])
						* on (namespace,pod)
						group_left(workload,workload_type) namespace_workload_pod:kube_pod_owner:relabel{cluster="$cluster", namespace="$namespace", workload=~".+", workload_type="$type"}) by (workload))

						"""
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{workload}}"
					legendLink:     null
					step:           10
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Rate of Transmitted Packets"
				tooltip: {
					shared:     false
					sort:       2
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
				yaxes: [{
					format:  "pps"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    false
				}]
			}]
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       true
			title:           "Rate of Packets"
			titleSize:       "h6"
		}, {
			collapse: false
			height:   "250px"
			panels: [{
				aliasColors: {}
				bars:       false
				dashLength: 10
				dashes:     false
				datasource: "$datasource"
				fill:       10
				id:         12
				interval:   "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 0
				links: []
				nullPointMode: "null as zero"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				seriesOverrides: []
				spaceLength: 10
				span:        6
				stack:       true
				steppedLine: false
				targets: [{
					expr: """
						(sum(irate(container_network_receive_packets_dropped_total{job="kubelet", metrics_path="/metrics/cadvisor", cluster="$cluster", namespace="$namespace"}[$__rate_interval])
						* on (namespace,pod)
						group_left(workload,workload_type) namespace_workload_pod:kube_pod_owner:relabel{cluster="$cluster", namespace="$namespace", workload=~".+", workload_type="$type"}) by (workload))

						"""
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{workload}}"
					legendLink:     null
					step:           10
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Rate of Received Packets Dropped"
				tooltip: {
					shared:     false
					sort:       2
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
				yaxes: [{
					format:  "pps"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    false
				}]
			}, {
				aliasColors: {}
				bars:       false
				dashLength: 10
				dashes:     false
				datasource: "$datasource"
				fill:       10
				id:         13
				interval:   "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 0
				links: []
				nullPointMode: "null as zero"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				seriesOverrides: []
				spaceLength: 10
				span:        6
				stack:       true
				steppedLine: false
				targets: [{
					expr: """
						(sum(irate(container_network_transmit_packets_dropped_total{job="kubelet", metrics_path="/metrics/cadvisor", cluster="$cluster", namespace="$namespace"}[$__rate_interval])
						* on (namespace,pod)
						group_left(workload,workload_type) namespace_workload_pod:kube_pod_owner:relabel{cluster="$cluster", namespace="$namespace", workload=~".+", workload_type="$type"}) by (workload))

						"""
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{workload}}"
					legendLink:     null
					step:           10
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Rate of Transmitted Packets Dropped"
				tooltip: {
					shared:     false
					sort:       2
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
				yaxes: [{
					format:  "pps"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    false
				}]
			}]
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       true
			title:           "Rate of Packets Dropped"
			titleSize:       "h6"
		}]
		schemaVersion: 14
		style:         "dark"
		tags: [
			"kubernetes-mixin",
		]
		templating: list: [{
			current: {
				text:  "default"
				value: "default"
			}
			hide:  0
			label: "Data Source"
			name:  "datasource"
			options: []
			query:   "prometheus"
			refresh: 1
			regex:   ""
			type:    "datasource"
		}, {
			allValue: null
			current: {
				text:  ""
				value: ""
			}
			datasource: "$datasource"
			hide:       2
			includeAll: false
			label:      null
			multi:      false
			name:       "cluster"
			options: []
			query:          "label_values(up{job=\"kube-state-metrics\"}, cluster)"
			refresh:        2
			regex:          ""
			sort:           1
			tagValuesQuery: ""
			tags: []
			tagsQuery: ""
			type:      "query"
			useTags:   false
		}, {
			allValue: null
			current: {
				text:  ""
				value: ""
			}
			datasource: "$datasource"
			hide:       0
			includeAll: false
			label:      null
			multi:      false
			name:       "namespace"
			options: []
			query:          "label_values(kube_pod_info{job=\"kube-state-metrics\", cluster=\"$cluster\"}, namespace)"
			refresh:        2
			regex:          ""
			sort:           1
			tagValuesQuery: ""
			tags: []
			tagsQuery: ""
			type:      "query"
			useTags:   false
		}, {
			allValue:   null
			auto:       false
			auto_count: 30
			auto_min:   "10s"
			current: {
				text:  "deployment"
				value: "deployment"
			}
			datasource: "$datasource"
			definition: "label_values(namespace_workload_pod:kube_pod_owner:relabel{cluster=\"$cluster\", namespace=\"$namespace\", workload=~\".+\"}, workload_type)"
			hide:       0
			includeAll: false
			label:      null
			multi:      false
			name:       "type"
			options: []
			query:          "label_values(namespace_workload_pod:kube_pod_owner:relabel{cluster=\"$cluster\", namespace=\"$namespace\", workload=~\".+\"}, workload_type)"
			refresh:        2
			regex:          ""
			skipUrlSync:    false
			sort:           0
			tagValuesQuery: ""
			tags: []
			tagsQuery: ""
			type:      "query"
			useTags:   false
		}]
		time: {
			from: "now-1h"
			to:   "now"
		}
		timepicker: {
			refresh_intervals: ["5s", "10s", "30s", "1m", "5m", "15m", "30m", "1h", "2h", "1d"]
			time_options: ["5m", "15m", "1h", "6h", "12h", "24h", "2d", "7d", "30d"]
		}
		timezone: "UTC"
		title:    "Kubernetes / Compute Resources / Namespace (Workloads)"
		uid:      "a87fb0d919ec0ea5f6543124e16c42a5"
		version:  0
	}
	"kubelet.json": {
		"__inputs": []
		"__requires": []
		annotations: list: []
		editable:     false
		gnetId:       null
		graphTooltip: 0
		hideControls: false
		id:           null
		links: []
		panels: [{
			datasource: "$datasource"
			fieldConfig: defaults: {
				links: []
				mappings: []
				thresholds: {
					mode: "absolute"
					steps: []
				}
				unit: "none"
			}
			gridPos: {
				h: 7
				w: 4
				x: 0
				y: 0
			}
			id: 2
			links: []
			options: {
				colorMode:   "value"
				graphMode:   "area"
				justifyMode: "auto"
				orientation: "auto"
				reduceOptions: {
					calcs: ["lastNotNull"]
					fields: ""
					values: false
				}
				textMode: "auto"
			}
			pluginVersion: "7"
			targets: [{
				expr:           "sum(kubelet_node_name{cluster=\"$cluster\", job=\"kubelet\", metrics_path=\"/metrics\"})"
				format:         "time_series"
				intervalFactor: 2
				legendFormat:   ""
				refId:          "A"
			}]
			title:       "Running Kubelets"
			transparent: false
			type:        "stat"
		}, {
			datasource: "$datasource"
			fieldConfig: defaults: {
				links: []
				mappings: []
				thresholds: {
					mode: "absolute"
					steps: []
				}
				unit: "none"
			}
			gridPos: {
				h: 7
				w: 4
				x: 4
				y: 0
			}
			id: 3
			links: []
			options: {
				colorMode:   "value"
				graphMode:   "area"
				justifyMode: "auto"
				orientation: "auto"
				reduceOptions: {
					calcs: ["lastNotNull"]
					fields: ""
					values: false
				}
				textMode: "auto"
			}
			pluginVersion: "7"
			targets: [{
				expr:           "sum(kubelet_running_pods{cluster=\"$cluster\", job=\"kubelet\", metrics_path=\"/metrics\", instance=~\"$instance\"}) OR sum(kubelet_running_pod_count{cluster=\"$cluster\", job=\"kubelet\", metrics_path=\"/metrics\", instance=~\"$instance\"})"
				format:         "time_series"
				intervalFactor: 2
				legendFormat:   "{{instance}}"
				refId:          "A"
			}]
			title:       "Running Pods"
			transparent: false
			type:        "stat"
		}, {
			datasource: "$datasource"
			fieldConfig: defaults: {
				links: []
				mappings: []
				thresholds: {
					mode: "absolute"
					steps: []
				}
				unit: "none"
			}
			gridPos: {
				h: 7
				w: 4
				x: 8
				y: 0
			}
			id: 4
			links: []
			options: {
				colorMode:   "value"
				graphMode:   "area"
				justifyMode: "auto"
				orientation: "auto"
				reduceOptions: {
					calcs: ["lastNotNull"]
					fields: ""
					values: false
				}
				textMode: "auto"
			}
			pluginVersion: "7"
			targets: [{
				expr:           "sum(kubelet_running_containers{cluster=\"$cluster\", job=\"kubelet\", metrics_path=\"/metrics\", instance=~\"$instance\"}) OR sum(kubelet_running_container_count{cluster=\"$cluster\", job=\"kubelet\", metrics_path=\"/metrics\", instance=~\"$instance\"})"
				format:         "time_series"
				intervalFactor: 2
				legendFormat:   "{{instance}}"
				refId:          "A"
			}]
			title:       "Running Containers"
			transparent: false
			type:        "stat"
		}, {
			datasource: "$datasource"
			fieldConfig: defaults: {
				links: []
				mappings: []
				thresholds: {
					mode: "absolute"
					steps: []
				}
				unit: "none"
			}
			gridPos: {
				h: 7
				w: 4
				x: 12
				y: 0
			}
			id: 5
			links: []
			options: {
				colorMode:   "value"
				graphMode:   "area"
				justifyMode: "auto"
				orientation: "auto"
				reduceOptions: {
					calcs: ["lastNotNull"]
					fields: ""
					values: false
				}
				textMode: "auto"
			}
			pluginVersion: "7"
			targets: [{
				expr:           "sum(volume_manager_total_volumes{cluster=\"$cluster\", job=\"kubelet\", metrics_path=\"/metrics\", instance=~\"$instance\", state=\"actual_state_of_world\"})"
				format:         "time_series"
				intervalFactor: 2
				legendFormat:   "{{instance}}"
				refId:          "A"
			}]
			title:       "Actual Volume Count"
			transparent: false
			type:        "stat"
		}, {
			datasource: "$datasource"
			fieldConfig: defaults: {
				links: []
				mappings: []
				thresholds: {
					mode: "absolute"
					steps: []
				}
				unit: "none"
			}
			gridPos: {
				h: 7
				w: 4
				x: 16
				y: 0
			}
			id: 6
			links: []
			options: {
				colorMode:   "value"
				graphMode:   "area"
				justifyMode: "auto"
				orientation: "auto"
				reduceOptions: {
					calcs: ["lastNotNull"]
					fields: ""
					values: false
				}
				textMode: "auto"
			}
			pluginVersion: "7"
			targets: [{
				expr:           "sum(volume_manager_total_volumes{cluster=\"$cluster\", job=\"kubelet\", metrics_path=\"/metrics\", instance=~\"$instance\",state=\"desired_state_of_world\"})"
				format:         "time_series"
				intervalFactor: 2
				legendFormat:   "{{instance}}"
				refId:          "A"
			}]
			title:       "Desired Volume Count"
			transparent: false
			type:        "stat"
		}, {
			datasource: "$datasource"
			fieldConfig: defaults: {
				links: []
				mappings: []
				thresholds: {
					mode: "absolute"
					steps: []
				}
				unit: "none"
			}
			gridPos: {
				h: 7
				w: 4
				x: 20
				y: 0
			}
			id: 7
			links: []
			options: {
				colorMode:   "value"
				graphMode:   "area"
				justifyMode: "auto"
				orientation: "auto"
				reduceOptions: {
					calcs: ["lastNotNull"]
					fields: ""
					values: false
				}
				textMode: "auto"
			}
			pluginVersion: "7"
			targets: [{
				expr:           "sum(rate(kubelet_node_config_error{cluster=\"$cluster\", job=\"kubelet\", metrics_path=\"/metrics\", instance=~\"$instance\"}[$__rate_interval]))"
				format:         "time_series"
				intervalFactor: 2
				legendFormat:   "{{instance}}"
				refId:          "A"
			}]
			title:       "Config Error Count"
			transparent: false
			type:        "stat"
		}, {
			aliasColors: {}
			bars:         false
			dashLength:   10
			dashes:       false
			datasource:   "$datasource"
			fill:         1
			fillGradient: 0
			gridPos: {
				h: 7
				w: 12
				x: 0
				y: 7
			}
			id: 8
			legend: {
				alignAsTable: true
				avg:          false
				current:      true
				max:          false
				min:          false
				rightSide:    true
				show:         true
				sideWidth:    null
				total:        false
				values:       true
			}
			lines:     true
			linewidth: 1
			links: []
			nullPointMode: "null"
			percentage:    false
			pointradius:   5
			points:        false
			renderer:      "flot"
			repeat:        null
			seriesOverrides: []
			spaceLength: 10
			stack:       false
			steppedLine: false
			targets: [{
				expr:           "sum(rate(kubelet_runtime_operations_total{cluster=\"$cluster\",job=\"kubelet\", metrics_path=\"/metrics\",instance=~\"$instance\"}[$__rate_interval])) by (operation_type, instance)"
				format:         "time_series"
				intervalFactor: 2
				legendFormat:   "{{instance}} {{operation_type}}"
				refId:          "A"
			}]
			thresholds: []
			timeFrom:  null
			timeShift: null
			title:     "Operation Rate"
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
			yaxes: [{
				format:  "ops"
				label:   null
				logBase: 1
				max:     null
				min:     null
				show:    true
			}, {
				format:  "ops"
				label:   null
				logBase: 1
				max:     null
				min:     null
				show:    true
			}]
		}, {
			aliasColors: {}
			bars:         false
			dashLength:   10
			dashes:       false
			datasource:   "$datasource"
			fill:         1
			fillGradient: 0
			gridPos: {
				h: 7
				w: 12
				x: 12
				y: 7
			}
			id: 9
			legend: {
				alignAsTable: true
				avg:          false
				current:      true
				max:          false
				min:          false
				rightSide:    true
				show:         true
				sideWidth:    null
				total:        false
				values:       true
			}
			lines:     true
			linewidth: 1
			links: []
			nullPointMode: "null"
			percentage:    false
			pointradius:   5
			points:        false
			renderer:      "flot"
			repeat:        null
			seriesOverrides: []
			spaceLength: 10
			stack:       false
			steppedLine: false
			targets: [{
				expr:           "sum(rate(kubelet_runtime_operations_errors_total{cluster=\"$cluster\",job=\"kubelet\", metrics_path=\"/metrics\",instance=~\"$instance\"}[$__rate_interval])) by (instance, operation_type)"
				format:         "time_series"
				intervalFactor: 2
				legendFormat:   "{{instance}} {{operation_type}}"
				refId:          "A"
			}]
			thresholds: []
			timeFrom:  null
			timeShift: null
			title:     "Operation Error Rate"
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
			yaxes: [{
				format:  "ops"
				label:   null
				logBase: 1
				max:     null
				min:     null
				show:    true
			}, {
				format:  "ops"
				label:   null
				logBase: 1
				max:     null
				min:     null
				show:    true
			}]
		}, {
			aliasColors: {}
			bars:         false
			dashLength:   10
			dashes:       false
			datasource:   "$datasource"
			fill:         1
			fillGradient: 0
			gridPos: {
				h: 7
				w: 24
				x: 0
				y: 14
			}
			id: 10
			legend: {
				alignAsTable: true
				avg:          false
				current:      true
				max:          false
				min:          false
				rightSide:    true
				show:         true
				sideWidth:    null
				total:        false
				values:       true
			}
			lines:     true
			linewidth: 1
			links: []
			nullPointMode: "null"
			percentage:    false
			pointradius:   5
			points:        false
			renderer:      "flot"
			repeat:        null
			seriesOverrides: []
			spaceLength: 10
			stack:       false
			steppedLine: false
			targets: [{
				expr:           "histogram_quantile(0.99, sum(rate(kubelet_runtime_operations_duration_seconds_bucket{cluster=\"$cluster\",job=\"kubelet\", metrics_path=\"/metrics\",instance=~\"$instance\"}[$__rate_interval])) by (instance, operation_type, le))"
				format:         "time_series"
				intervalFactor: 2
				legendFormat:   "{{instance}} {{operation_type}}"
				refId:          "A"
			}]
			thresholds: []
			timeFrom:  null
			timeShift: null
			title:     "Operation duration 99th quantile"
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
			yaxes: [{
				format:  "s"
				label:   null
				logBase: 1
				max:     null
				min:     null
				show:    true
			}, {
				format:  "s"
				label:   null
				logBase: 1
				max:     null
				min:     null
				show:    true
			}]
		}, {
			aliasColors: {}
			bars:         false
			dashLength:   10
			dashes:       false
			datasource:   "$datasource"
			fill:         1
			fillGradient: 0
			gridPos: {
				h: 7
				w: 12
				x: 0
				y: 21
			}
			id: 11
			legend: {
				alignAsTable: true
				avg:          false
				current:      true
				max:          false
				min:          false
				rightSide:    true
				show:         true
				sideWidth:    null
				total:        false
				values:       true
			}
			lines:     true
			linewidth: 1
			links: []
			nullPointMode: "null"
			percentage:    false
			pointradius:   5
			points:        false
			renderer:      "flot"
			repeat:        null
			seriesOverrides: []
			spaceLength: 10
			stack:       false
			steppedLine: false
			targets: [{
				expr:           "sum(rate(kubelet_pod_start_duration_seconds_count{cluster=\"$cluster\",job=\"kubelet\", metrics_path=\"/metrics\",instance=~\"$instance\"}[$__rate_interval])) by (instance)"
				format:         "time_series"
				intervalFactor: 2
				legendFormat:   "{{instance}} pod"
				refId:          "A"
			}, {
				expr:           "sum(rate(kubelet_pod_worker_duration_seconds_count{cluster=\"$cluster\",job=\"kubelet\", metrics_path=\"/metrics\",instance=~\"$instance\"}[$__rate_interval])) by (instance)"
				format:         "time_series"
				intervalFactor: 2
				legendFormat:   "{{instance}} worker"
				refId:          "B"
			}]
			thresholds: []
			timeFrom:  null
			timeShift: null
			title:     "Pod Start Rate"
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
			yaxes: [{
				format:  "ops"
				label:   null
				logBase: 1
				max:     null
				min:     null
				show:    true
			}, {
				format:  "ops"
				label:   null
				logBase: 1
				max:     null
				min:     null
				show:    true
			}]
		}, {
			aliasColors: {}
			bars:         false
			dashLength:   10
			dashes:       false
			datasource:   "$datasource"
			fill:         1
			fillGradient: 0
			gridPos: {
				h: 7
				w: 12
				x: 12
				y: 21
			}
			id: 12
			legend: {
				alignAsTable: true
				avg:          false
				current:      true
				max:          false
				min:          false
				rightSide:    true
				show:         true
				sideWidth:    null
				total:        false
				values:       true
			}
			lines:     true
			linewidth: 1
			links: []
			nullPointMode: "null"
			percentage:    false
			pointradius:   5
			points:        false
			renderer:      "flot"
			repeat:        null
			seriesOverrides: []
			spaceLength: 10
			stack:       false
			steppedLine: false
			targets: [{
				expr:           "histogram_quantile(0.99, sum(rate(kubelet_pod_start_duration_seconds_count{cluster=\"$cluster\",job=\"kubelet\", metrics_path=\"/metrics\",instance=~\"$instance\"}[$__rate_interval])) by (instance, le))"
				format:         "time_series"
				intervalFactor: 2
				legendFormat:   "{{instance}} pod"
				refId:          "A"
			}, {
				expr:           "histogram_quantile(0.99, sum(rate(kubelet_pod_worker_duration_seconds_bucket{cluster=\"$cluster\",job=\"kubelet\", metrics_path=\"/metrics\",instance=~\"$instance\"}[$__rate_interval])) by (instance, le))"
				format:         "time_series"
				intervalFactor: 2
				legendFormat:   "{{instance}} worker"
				refId:          "B"
			}]
			thresholds: []
			timeFrom:  null
			timeShift: null
			title:     "Pod Start Duration"
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
			yaxes: [{
				format:  "s"
				label:   null
				logBase: 1
				max:     null
				min:     null
				show:    true
			}, {
				format:  "s"
				label:   null
				logBase: 1
				max:     null
				min:     null
				show:    true
			}]
		}, {
			aliasColors: {}
			bars:         false
			dashLength:   10
			dashes:       false
			datasource:   "$datasource"
			fill:         1
			fillGradient: 0
			gridPos: {
				h: 7
				w: 12
				x: 0
				y: 28
			}
			id: 13
			legend: {
				alignAsTable: true
				avg:          false
				current:      true
				hideEmpty:    true
				hideZero:     true
				max:          false
				min:          false
				rightSide:    true
				show:         true
				sideWidth:    null
				total:        false
				values:       true
			}
			lines:     true
			linewidth: 1
			links: []
			nullPointMode: "null"
			percentage:    false
			pointradius:   5
			points:        false
			renderer:      "flot"
			repeat:        null
			seriesOverrides: []
			spaceLength: 10
			stack:       false
			steppedLine: false
			targets: [{
				expr:           "sum(rate(storage_operation_duration_seconds_count{cluster=\"$cluster\",job=\"kubelet\", metrics_path=\"/metrics\",instance=~\"$instance\"}[$__rate_interval])) by (instance, operation_name, volume_plugin)"
				format:         "time_series"
				intervalFactor: 2
				legendFormat:   "{{instance}} {{operation_name}} {{volume_plugin}}"
				refId:          "A"
			}]
			thresholds: []
			timeFrom:  null
			timeShift: null
			title:     "Storage Operation Rate"
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
			yaxes: [{
				format:  "ops"
				label:   null
				logBase: 1
				max:     null
				min:     null
				show:    true
			}, {
				format:  "ops"
				label:   null
				logBase: 1
				max:     null
				min:     null
				show:    true
			}]
		}, {
			aliasColors: {}
			bars:         false
			dashLength:   10
			dashes:       false
			datasource:   "$datasource"
			fill:         1
			fillGradient: 0
			gridPos: {
				h: 7
				w: 12
				x: 12
				y: 28
			}
			id: 14
			legend: {
				alignAsTable: true
				avg:          false
				current:      true
				hideEmpty:    true
				hideZero:     true
				max:          false
				min:          false
				rightSide:    true
				show:         true
				sideWidth:    null
				total:        false
				values:       true
			}
			lines:     true
			linewidth: 1
			links: []
			nullPointMode: "null"
			percentage:    false
			pointradius:   5
			points:        false
			renderer:      "flot"
			repeat:        null
			seriesOverrides: []
			spaceLength: 10
			stack:       false
			steppedLine: false
			targets: [{
				expr:           "sum(rate(storage_operation_errors_total{cluster=\"$cluster\",job=\"kubelet\", metrics_path=\"/metrics\",instance=~\"$instance\"}[$__rate_interval])) by (instance, operation_name, volume_plugin)"
				format:         "time_series"
				intervalFactor: 2
				legendFormat:   "{{instance}} {{operation_name}} {{volume_plugin}}"
				refId:          "A"
			}]
			thresholds: []
			timeFrom:  null
			timeShift: null
			title:     "Storage Operation Error Rate"
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
			yaxes: [{
				format:  "ops"
				label:   null
				logBase: 1
				max:     null
				min:     null
				show:    true
			}, {
				format:  "ops"
				label:   null
				logBase: 1
				max:     null
				min:     null
				show:    true
			}]
		}, {
			aliasColors: {}
			bars:         false
			dashLength:   10
			dashes:       false
			datasource:   "$datasource"
			fill:         1
			fillGradient: 0
			gridPos: {
				h: 7
				w: 24
				x: 0
				y: 35
			}
			id: 15
			legend: {
				alignAsTable: true
				avg:          false
				current:      true
				hideEmpty:    true
				hideZero:     true
				max:          false
				min:          false
				rightSide:    true
				show:         true
				sideWidth:    null
				total:        false
				values:       true
			}
			lines:     true
			linewidth: 1
			links: []
			nullPointMode: "null"
			percentage:    false
			pointradius:   5
			points:        false
			renderer:      "flot"
			repeat:        null
			seriesOverrides: []
			spaceLength: 10
			stack:       false
			steppedLine: false
			targets: [{
				expr:           "histogram_quantile(0.99, sum(rate(storage_operation_duration_seconds_bucket{cluster=\"$cluster\", job=\"kubelet\", metrics_path=\"/metrics\", instance=~\"$instance\"}[$__rate_interval])) by (instance, operation_name, volume_plugin, le))"
				format:         "time_series"
				intervalFactor: 2
				legendFormat:   "{{instance}} {{operation_name}} {{volume_plugin}}"
				refId:          "A"
			}]
			thresholds: []
			timeFrom:  null
			timeShift: null
			title:     "Storage Operation Duration 99th quantile"
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
			yaxes: [{
				format:  "s"
				label:   null
				logBase: 1
				max:     null
				min:     null
				show:    true
			}, {
				format:  "s"
				label:   null
				logBase: 1
				max:     null
				min:     null
				show:    true
			}]
		}, {
			aliasColors: {}
			bars:         false
			dashLength:   10
			dashes:       false
			datasource:   "$datasource"
			fill:         1
			fillGradient: 0
			gridPos: {
				h: 7
				w: 12
				x: 0
				y: 42
			}
			id: 16
			legend: {
				alignAsTable: true
				avg:          false
				current:      true
				max:          false
				min:          false
				rightSide:    true
				show:         true
				sideWidth:    null
				total:        false
				values:       true
			}
			lines:     true
			linewidth: 1
			links: []
			nullPointMode: "null"
			percentage:    false
			pointradius:   5
			points:        false
			renderer:      "flot"
			repeat:        null
			seriesOverrides: []
			spaceLength: 10
			stack:       false
			steppedLine: false
			targets: [{
				expr:           "sum(rate(kubelet_cgroup_manager_duration_seconds_count{cluster=\"$cluster\", job=\"kubelet\", metrics_path=\"/metrics\", instance=~\"$instance\"}[$__rate_interval])) by (instance, operation_type)"
				format:         "time_series"
				intervalFactor: 2
				legendFormat:   "{{operation_type}}"
				refId:          "A"
			}]
			thresholds: []
			timeFrom:  null
			timeShift: null
			title:     "Cgroup manager operation rate"
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
			yaxes: [{
				format:  "ops"
				label:   null
				logBase: 1
				max:     null
				min:     null
				show:    true
			}, {
				format:  "ops"
				label:   null
				logBase: 1
				max:     null
				min:     null
				show:    true
			}]
		}, {
			aliasColors: {}
			bars:         false
			dashLength:   10
			dashes:       false
			datasource:   "$datasource"
			fill:         1
			fillGradient: 0
			gridPos: {
				h: 7
				w: 12
				x: 12
				y: 42
			}
			id: 17
			legend: {
				alignAsTable: true
				avg:          false
				current:      true
				max:          false
				min:          false
				rightSide:    true
				show:         true
				sideWidth:    null
				total:        false
				values:       true
			}
			lines:     true
			linewidth: 1
			links: []
			nullPointMode: "null"
			percentage:    false
			pointradius:   5
			points:        false
			renderer:      "flot"
			repeat:        null
			seriesOverrides: []
			spaceLength: 10
			stack:       false
			steppedLine: false
			targets: [{
				expr:           "histogram_quantile(0.99, sum(rate(kubelet_cgroup_manager_duration_seconds_bucket{cluster=\"$cluster\", job=\"kubelet\", metrics_path=\"/metrics\", instance=~\"$instance\"}[$__rate_interval])) by (instance, operation_type, le))"
				format:         "time_series"
				intervalFactor: 2
				legendFormat:   "{{instance}} {{operation_type}}"
				refId:          "A"
			}]
			thresholds: []
			timeFrom:  null
			timeShift: null
			title:     "Cgroup manager 99th quantile"
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
			yaxes: [{
				format:  "s"
				label:   null
				logBase: 1
				max:     null
				min:     null
				show:    true
			}, {
				format:  "s"
				label:   null
				logBase: 1
				max:     null
				min:     null
				show:    true
			}]
		}, {
			aliasColors: {}
			bars:         false
			dashLength:   10
			dashes:       false
			datasource:   "$datasource"
			description:  "Pod lifecycle event generator"
			fill:         1
			fillGradient: 0
			gridPos: {
				h: 7
				w: 12
				x: 0
				y: 49
			}
			id: 18
			legend: {
				alignAsTable: true
				avg:          false
				current:      true
				max:          false
				min:          false
				rightSide:    true
				show:         true
				sideWidth:    null
				total:        false
				values:       true
			}
			lines:     true
			linewidth: 1
			links: []
			nullPointMode: "null"
			percentage:    false
			pointradius:   5
			points:        false
			renderer:      "flot"
			repeat:        null
			seriesOverrides: []
			spaceLength: 10
			stack:       false
			steppedLine: false
			targets: [{
				expr:           "sum(rate(kubelet_pleg_relist_duration_seconds_count{cluster=\"$cluster\", job=\"kubelet\", metrics_path=\"/metrics\", instance=~\"$instance\"}[$__rate_interval])) by (instance)"
				format:         "time_series"
				intervalFactor: 2
				legendFormat:   "{{instance}}"
				refId:          "A"
			}]
			thresholds: []
			timeFrom:  null
			timeShift: null
			title:     "PLEG relist rate"
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
			yaxes: [{
				format:  "ops"
				label:   null
				logBase: 1
				max:     null
				min:     null
				show:    true
			}, {
				format:  "ops"
				label:   null
				logBase: 1
				max:     null
				min:     null
				show:    true
			}]
		}, {
			aliasColors: {}
			bars:         false
			dashLength:   10
			dashes:       false
			datasource:   "$datasource"
			fill:         1
			fillGradient: 0
			gridPos: {
				h: 7
				w: 12
				x: 12
				y: 49
			}
			id: 19
			legend: {
				alignAsTable: true
				avg:          false
				current:      true
				max:          false
				min:          false
				rightSide:    true
				show:         true
				sideWidth:    null
				total:        false
				values:       true
			}
			lines:     true
			linewidth: 1
			links: []
			nullPointMode: "null"
			percentage:    false
			pointradius:   5
			points:        false
			renderer:      "flot"
			repeat:        null
			seriesOverrides: []
			spaceLength: 10
			stack:       false
			steppedLine: false
			targets: [{
				expr:           "histogram_quantile(0.99, sum(rate(kubelet_pleg_relist_interval_seconds_bucket{cluster=\"$cluster\",job=\"kubelet\", metrics_path=\"/metrics\",instance=~\"$instance\"}[$__rate_interval])) by (instance, le))"
				format:         "time_series"
				intervalFactor: 2
				legendFormat:   "{{instance}}"
				refId:          "A"
			}]
			thresholds: []
			timeFrom:  null
			timeShift: null
			title:     "PLEG relist interval"
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
			yaxes: [{
				format:  "s"
				label:   null
				logBase: 1
				max:     null
				min:     null
				show:    true
			}, {
				format:  "s"
				label:   null
				logBase: 1
				max:     null
				min:     null
				show:    true
			}]
		}, {
			aliasColors: {}
			bars:         false
			dashLength:   10
			dashes:       false
			datasource:   "$datasource"
			fill:         1
			fillGradient: 0
			gridPos: {
				h: 7
				w: 24
				x: 0
				y: 56
			}
			id: 20
			legend: {
				alignAsTable: true
				avg:          false
				current:      true
				max:          false
				min:          false
				rightSide:    true
				show:         true
				sideWidth:    null
				total:        false
				values:       true
			}
			lines:     true
			linewidth: 1
			links: []
			nullPointMode: "null"
			percentage:    false
			pointradius:   5
			points:        false
			renderer:      "flot"
			repeat:        null
			seriesOverrides: []
			spaceLength: 10
			stack:       false
			steppedLine: false
			targets: [{
				expr:           "histogram_quantile(0.99, sum(rate(kubelet_pleg_relist_duration_seconds_bucket{cluster=\"$cluster\",job=\"kubelet\", metrics_path=\"/metrics\",instance=~\"$instance\"}[$__rate_interval])) by (instance, le))"
				format:         "time_series"
				intervalFactor: 2
				legendFormat:   "{{instance}}"
				refId:          "A"
			}]
			thresholds: []
			timeFrom:  null
			timeShift: null
			title:     "PLEG relist duration"
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
			yaxes: [{
				format:  "s"
				label:   null
				logBase: 1
				max:     null
				min:     null
				show:    true
			}, {
				format:  "s"
				label:   null
				logBase: 1
				max:     null
				min:     null
				show:    true
			}]
		}, {
			aliasColors: {}
			bars:         false
			dashLength:   10
			dashes:       false
			datasource:   "$datasource"
			fill:         1
			fillGradient: 0
			gridPos: {
				h: 7
				w: 24
				x: 0
				y: 63
			}
			id: 21
			legend: {
				alignAsTable: false
				avg:          false
				current:      false
				max:          false
				min:          false
				rightSide:    false
				show:         true
				sideWidth:    null
				total:        false
				values:       false
			}
			lines:     true
			linewidth: 1
			links: []
			nullPointMode: "null"
			percentage:    false
			pointradius:   5
			points:        false
			renderer:      "flot"
			repeat:        null
			seriesOverrides: []
			spaceLength: 10
			stack:       false
			steppedLine: false
			targets: [{
				expr:           "sum(rate(rest_client_requests_total{cluster=\"$cluster\",job=\"kubelet\", metrics_path=\"/metrics\", instance=~\"$instance\",code=~\"2..\"}[$__rate_interval]))"
				format:         "time_series"
				intervalFactor: 2
				legendFormat:   "2xx"
				refId:          "A"
			}, {
				expr:           "sum(rate(rest_client_requests_total{cluster=\"$cluster\",job=\"kubelet\", metrics_path=\"/metrics\", instance=~\"$instance\",code=~\"3..\"}[$__rate_interval]))"
				format:         "time_series"
				intervalFactor: 2
				legendFormat:   "3xx"
				refId:          "B"
			}, {
				expr:           "sum(rate(rest_client_requests_total{cluster=\"$cluster\",job=\"kubelet\", metrics_path=\"/metrics\", instance=~\"$instance\",code=~\"4..\"}[$__rate_interval]))"
				format:         "time_series"
				intervalFactor: 2
				legendFormat:   "4xx"
				refId:          "C"
			}, {
				expr:           "sum(rate(rest_client_requests_total{cluster=\"$cluster\",job=\"kubelet\", metrics_path=\"/metrics\", instance=~\"$instance\",code=~\"5..\"}[$__rate_interval]))"
				format:         "time_series"
				intervalFactor: 2
				legendFormat:   "5xx"
				refId:          "D"
			}]
			thresholds: []
			timeFrom:  null
			timeShift: null
			title:     "RPC Rate"
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
			yaxes: [{
				format:  "ops"
				label:   null
				logBase: 1
				max:     null
				min:     null
				show:    true
			}, {
				format:  "ops"
				label:   null
				logBase: 1
				max:     null
				min:     null
				show:    true
			}]
		}, {
			aliasColors: {}
			bars:         false
			dashLength:   10
			dashes:       false
			datasource:   "$datasource"
			fill:         1
			fillGradient: 0
			gridPos: {
				h: 7
				w: 24
				x: 0
				y: 70
			}
			id: 22
			legend: {
				alignAsTable: true
				avg:          false
				current:      true
				max:          false
				min:          false
				rightSide:    true
				show:         true
				sideWidth:    null
				total:        false
				values:       true
			}
			lines:     true
			linewidth: 1
			links: []
			nullPointMode: "null"
			percentage:    false
			pointradius:   5
			points:        false
			renderer:      "flot"
			repeat:        null
			seriesOverrides: []
			spaceLength: 10
			stack:       false
			steppedLine: false
			targets: [{
				expr:           "histogram_quantile(0.99, sum(rate(rest_client_request_duration_seconds_bucket{cluster=\"$cluster\",job=\"kubelet\", metrics_path=\"/metrics\", instance=~\"$instance\"}[$__rate_interval])) by (instance, verb, url, le))"
				format:         "time_series"
				intervalFactor: 2
				legendFormat:   "{{instance}} {{verb}} {{url}}"
				refId:          "A"
			}]
			thresholds: []
			timeFrom:  null
			timeShift: null
			title:     "Request duration 99th quantile"
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
			yaxes: [{
				format:  "s"
				label:   null
				logBase: 1
				max:     null
				min:     null
				show:    true
			}, {
				format:  "s"
				label:   null
				logBase: 1
				max:     null
				min:     null
				show:    true
			}]
		}, {
			aliasColors: {}
			bars:         false
			dashLength:   10
			dashes:       false
			datasource:   "$datasource"
			fill:         1
			fillGradient: 0
			gridPos: {
				h: 7
				w: 8
				x: 0
				y: 77
			}
			id: 23
			legend: {
				alignAsTable: false
				avg:          false
				current:      false
				max:          false
				min:          false
				rightSide:    false
				show:         true
				sideWidth:    null
				total:        false
				values:       false
			}
			lines:     true
			linewidth: 1
			links: []
			nullPointMode: "null"
			percentage:    false
			pointradius:   5
			points:        false
			renderer:      "flot"
			repeat:        null
			seriesOverrides: []
			spaceLength: 10
			stack:       false
			steppedLine: false
			targets: [{
				expr:           "process_resident_memory_bytes{cluster=\"$cluster\",job=\"kubelet\", metrics_path=\"/metrics\",instance=~\"$instance\"}"
				format:         "time_series"
				intervalFactor: 2
				legendFormat:   "{{instance}}"
				refId:          "A"
			}]
			thresholds: []
			timeFrom:  null
			timeShift: null
			title:     "Memory"
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
			yaxes: [{
				format:  "bytes"
				label:   null
				logBase: 1
				max:     null
				min:     null
				show:    true
			}, {
				format:  "bytes"
				label:   null
				logBase: 1
				max:     null
				min:     null
				show:    true
			}]
		}, {
			aliasColors: {}
			bars:         false
			dashLength:   10
			dashes:       false
			datasource:   "$datasource"
			fill:         1
			fillGradient: 0
			gridPos: {
				h: 7
				w: 8
				x: 8
				y: 77
			}
			id: 24
			legend: {
				alignAsTable: false
				avg:          false
				current:      false
				max:          false
				min:          false
				rightSide:    false
				show:         true
				sideWidth:    null
				total:        false
				values:       false
			}
			lines:     true
			linewidth: 1
			links: []
			nullPointMode: "null"
			percentage:    false
			pointradius:   5
			points:        false
			renderer:      "flot"
			repeat:        null
			seriesOverrides: []
			spaceLength: 10
			stack:       false
			steppedLine: false
			targets: [{
				expr:           "rate(process_cpu_seconds_total{cluster=\"$cluster\",job=\"kubelet\", metrics_path=\"/metrics\",instance=~\"$instance\"}[$__rate_interval])"
				format:         "time_series"
				intervalFactor: 2
				legendFormat:   "{{instance}}"
				refId:          "A"
			}]
			thresholds: []
			timeFrom:  null
			timeShift: null
			title:     "CPU usage"
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
			yaxes: [{
				format:  "short"
				label:   null
				logBase: 1
				max:     null
				min:     null
				show:    true
			}, {
				format:  "short"
				label:   null
				logBase: 1
				max:     null
				min:     null
				show:    true
			}]
		}, {
			aliasColors: {}
			bars:         false
			dashLength:   10
			dashes:       false
			datasource:   "$datasource"
			fill:         1
			fillGradient: 0
			gridPos: {
				h: 7
				w: 8
				x: 16
				y: 77
			}
			id: 25
			legend: {
				alignAsTable: false
				avg:          false
				current:      false
				max:          false
				min:          false
				rightSide:    false
				show:         true
				sideWidth:    null
				total:        false
				values:       false
			}
			lines:     true
			linewidth: 1
			links: []
			nullPointMode: "null"
			percentage:    false
			pointradius:   5
			points:        false
			renderer:      "flot"
			repeat:        null
			seriesOverrides: []
			spaceLength: 10
			stack:       false
			steppedLine: false
			targets: [{
				expr:           "go_goroutines{cluster=\"$cluster\",job=\"kubelet\", metrics_path=\"/metrics\",instance=~\"$instance\"}"
				format:         "time_series"
				intervalFactor: 2
				legendFormat:   "{{instance}}"
				refId:          "A"
			}]
			thresholds: []
			timeFrom:  null
			timeShift: null
			title:     "Goroutines"
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
			yaxes: [{
				format:  "short"
				label:   null
				logBase: 1
				max:     null
				min:     null
				show:    true
			}, {
				format:  "short"
				label:   null
				logBase: 1
				max:     null
				min:     null
				show:    true
			}]
		}]
		refresh: "10s"
		rows: []
		schemaVersion: 14
		style:         "dark"
		tags: [
			"kubernetes-mixin",
		]
		templating: list: [{
			current: {
				text:  "default"
				value: "default"
			}
			hide:  0
			label: "Data Source"
			name:  "datasource"
			options: []
			query:   "prometheus"
			refresh: 1
			regex:   ""
			type:    "datasource"
		}, {
			allValue: null
			current: {}
			datasource: "$datasource"
			hide:       2
			includeAll: false
			label:      "cluster"
			multi:      false
			name:       "cluster"
			options: []
			query:          "label_values(up{job=\"kubelet\", metrics_path=\"/metrics\"}, cluster)"
			refresh:        2
			regex:          ""
			sort:           1
			tagValuesQuery: ""
			tags: []
			tagsQuery: ""
			type:      "query"
			useTags:   false
		}, {
			allValue: null
			current: {}
			datasource: "$datasource"
			hide:       0
			includeAll: true
			label:      "Data Source"
			multi:      false
			name:       "instance"
			options: []
			query:          "label_values(up{job=\"kubelet\", metrics_path=\"/metrics\",cluster=\"$cluster\"}, instance)"
			refresh:        2
			regex:          ""
			sort:           1
			tagValuesQuery: ""
			tags: []
			tagsQuery: ""
			type:      "query"
			useTags:   false
		}]
		time: {
			from: "now-1h"
			to:   "now"
		}
		timepicker: {
			refresh_intervals: ["5s", "10s", "30s", "1m", "5m", "15m", "30m", "1h", "2h", "1d"]
			time_options: ["5m", "15m", "1h", "6h", "12h", "24h", "2d", "7d", "30d"]
		}
		timezone: "UTC"
		title:    "Kubernetes / Kubelet"
		uid:      "3138fa155d5915769fbded898ac09fd9"
		version:  0
	}
	"namespace-by-pod.json": {
		"__inputs": []
		"__requires": []
		annotations: list: [{
			builtIn:    1
			datasource: "-- Grafana --"
			enable:     true
			hide:       true
			iconColor:  "rgba(0, 211, 255, 1)"
			name:       "Annotations & Alerts"
			type:       "dashboard"
		}]
		editable:     true
		gnetId:       null
		graphTooltip: 0
		hideControls: false
		id:           null
		links: []
		panels: [{
			collapse:  false
			collapsed: false
			gridPos: {
				h: 1
				w: 24
				x: 0
				y: 0
			}
			id: 2
			panels: []
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       true
			title:           "Current Bandwidth"
			titleSize:       "h6"
			type:            "row"
		}, {
			cacheTimeout:    null
			colorBackground: false
			colorValue:      false
			colors: ["#299c46", "rgba(237, 129, 40, 0.89)", "#d44a3a"]
			datasource: "$datasource"
			decimals:   0
			format:     "time_series"
			gauge: {
				maxValue:         100
				minValue:         0
				show:             false
				thresholdLabels:  false
				thresholdMarkers: true
			}
			gridPos: {
				h: 9
				w: 12
				x: 0
				y: 1
			}
			height:   9
			id:       3
			interval: null
			links: []
			mappingType: 1
			mappingTypes: [{
				name:  "value to text"
				value: 1
			}, {
				name:  "range to text"
				value: 2
			}]
			maxDataPoints: 100
			minSpan:       12
			nullPointMode: "connected"
			nullText:      null
			options: fieldOptions: {
				calcs: ["last"]
				defaults: {
					max:   10000000000
					min:   0
					title: "$namespace"
					unit:  "Bps"
				}
				mappings: []
				override: {}
				thresholds: [{
					color: "dark-green"
					index: 0
					value: null
				}, {
					color: "dark-yellow"
					index: 1
					value: 5000000000
				}, {
					color: "dark-red"
					index: 2
					value: 7000000000
				}]
				values: false
			}
			postfix:         ""
			postfixFontSize: "50%"
			prefix:          ""
			prefixFontSize:  "50%"
			rangeMaps: [{
				from: "null"
				text: "N/A"
				to:   "null"
			}]
			span: 12
			sparkline: {
				fillColor: "rgba(31, 118, 189, 0.18)"
				full:      false
				lineColor: "rgb(31, 120, 193)"
				show:      false
			}
			tableColumn: ""
			targets: [{
				expr:           "sum(irate(container_network_receive_bytes_total{cluster=\"$cluster\",namespace=~\"$namespace\"}[$interval:$resolution]))"
				format:         "time_series"
				instant:        null
				intervalFactor: 1
				legendFormat:   ""
				refId:          "A"
			}]
			thresholds:    ""
			timeFrom:      null
			timeShift:     null
			title:         "Current Rate of Bytes Received"
			type:          "gauge"
			valueFontSize: "80%"
			valueMaps: [{
				op:    "="
				text:  "N/A"
				value: "null"
			}]
			valueName: "current"
		}, {
			cacheTimeout:    null
			colorBackground: false
			colorValue:      false
			colors: ["#299c46", "rgba(237, 129, 40, 0.89)", "#d44a3a"]
			datasource: "$datasource"
			decimals:   0
			format:     "time_series"
			gauge: {
				maxValue:         100
				minValue:         0
				show:             false
				thresholdLabels:  false
				thresholdMarkers: true
			}
			gridPos: {
				h: 9
				w: 12
				x: 12
				y: 1
			}
			height:   9
			id:       4
			interval: null
			links: []
			mappingType: 1
			mappingTypes: [{
				name:  "value to text"
				value: 1
			}, {
				name:  "range to text"
				value: 2
			}]
			maxDataPoints: 100
			minSpan:       12
			nullPointMode: "connected"
			nullText:      null
			options: fieldOptions: {
				calcs: ["last"]
				defaults: {
					max:   10000000000
					min:   0
					title: "$namespace"
					unit:  "Bps"
				}
				mappings: []
				override: {}
				thresholds: [{
					color: "dark-green"
					index: 0
					value: null
				}, {
					color: "dark-yellow"
					index: 1
					value: 5000000000
				}, {
					color: "dark-red"
					index: 2
					value: 7000000000
				}]
				values: false
			}
			postfix:         ""
			postfixFontSize: "50%"
			prefix:          ""
			prefixFontSize:  "50%"
			rangeMaps: [{
				from: "null"
				text: "N/A"
				to:   "null"
			}]
			span: 12
			sparkline: {
				fillColor: "rgba(31, 118, 189, 0.18)"
				full:      false
				lineColor: "rgb(31, 120, 193)"
				show:      false
			}
			tableColumn: ""
			targets: [{
				expr:           "sum(irate(container_network_transmit_bytes_total{cluster=\"$cluster\",namespace=~\"$namespace\"}[$interval:$resolution]))"
				format:         "time_series"
				instant:        null
				intervalFactor: 1
				legendFormat:   ""
				refId:          "A"
			}]
			thresholds:    ""
			timeFrom:      null
			timeShift:     null
			title:         "Current Rate of Bytes Transmitted"
			type:          "gauge"
			valueFontSize: "80%"
			valueMaps: [{
				op:    "="
				text:  "N/A"
				value: "null"
			}]
			valueName: "current"
		}, {
			columns: [{
				text:  "Time"
				value: "Time"
			}, {
				text:  "Value #A"
				value: "Value #A"
			}, {
				text:  "Value #B"
				value: "Value #B"
			}, {
				text:  "Value #C"
				value: "Value #C"
			}, {
				text:  "Value #D"
				value: "Value #D"
			}, {
				text:  "Value #E"
				value: "Value #E"
			}, {
				text:  "Value #F"
				value: "Value #F"
			}, {
				text:  "pod"
				value: "pod"
			}]
			datasource: "$datasource"
			fill:       1
			fontSize:   "100%"
			gridPos: {
				h: 9
				w: 24
				x: 0
				y: 10
			}
			id:        5
			lines:     true
			linewidth: 1
			links: []
			minSpan:       24
			nullPointMode: "null as zero"
			renderer:      "flot"
			scroll:        true
			showHeader:    true
			sort: {
				col:  0
				desc: false
			}
			spaceLength: 10
			span:        24
			styles: [{
				alias:     "Time"
				colorMode: null
				colors: []
				dateFormat:  "YYYY-MM-DD HH:mm:ss"
				decimals:    2
				link:        false
				linkTooltip: "Drill down"
				linkUrl:     ""
				pattern:     "Time"
				thresholds: []
				type: "hidden"
				unit: "short"
			}, {
				alias:     "Bandwidth Received"
				colorMode: null
				colors: []
				dateFormat:  "YYYY-MM-DD HH:mm:ss"
				decimals:    2
				link:        false
				linkTooltip: "Drill down"
				linkUrl:     ""
				pattern:     "Value #A"
				thresholds: []
				type: "number"
				unit: "Bps"
			}, {
				alias:     "Bandwidth Transmitted"
				colorMode: null
				colors: []
				dateFormat:  "YYYY-MM-DD HH:mm:ss"
				decimals:    2
				link:        false
				linkTooltip: "Drill down"
				linkUrl:     ""
				pattern:     "Value #B"
				thresholds: []
				type: "number"
				unit: "Bps"
			}, {
				alias:     "Rate of Received Packets"
				colorMode: null
				colors: []
				dateFormat:  "YYYY-MM-DD HH:mm:ss"
				decimals:    2
				link:        false
				linkTooltip: "Drill down"
				linkUrl:     ""
				pattern:     "Value #C"
				thresholds: []
				type: "number"
				unit: "pps"
			}, {
				alias:     "Rate of Transmitted Packets"
				colorMode: null
				colors: []
				dateFormat:  "YYYY-MM-DD HH:mm:ss"
				decimals:    2
				link:        false
				linkTooltip: "Drill down"
				linkUrl:     ""
				pattern:     "Value #D"
				thresholds: []
				type: "number"
				unit: "pps"
			}, {
				alias:     "Rate of Received Packets Dropped"
				colorMode: null
				colors: []
				dateFormat:  "YYYY-MM-DD HH:mm:ss"
				decimals:    2
				link:        false
				linkTooltip: "Drill down"
				linkUrl:     ""
				pattern:     "Value #E"
				thresholds: []
				type: "number"
				unit: "pps"
			}, {
				alias:     "Rate of Transmitted Packets Dropped"
				colorMode: null
				colors: []
				dateFormat:  "YYYY-MM-DD HH:mm:ss"
				decimals:    2
				link:        false
				linkTooltip: "Drill down"
				linkUrl:     ""
				pattern:     "Value #F"
				thresholds: []
				type: "number"
				unit: "pps"
			}, {
				alias:     "Pod"
				colorMode: null
				colors: []
				dateFormat:  "YYYY-MM-DD HH:mm:ss"
				decimals:    2
				link:        true
				linkTooltip: "Drill down"
				linkUrl:     "d/7a18067ce943a40ae25454675c19ff5c/kubernetes-networking-pod?orgId=1&refresh=30s&var-namespace=$namespace&var-pod=$__cell"
				pattern:     "pod"
				thresholds: []
				type: "number"
				unit: "short"
			}]
			targets: [{
				expr:           "sum(irate(container_network_receive_bytes_total{cluster=\"$cluster\",namespace=~\"$namespace\"}[$interval:$resolution])) by (pod)"
				format:         "table"
				instant:        true
				intervalFactor: 2
				legendFormat:   ""
				refId:          "A"
				step:           10
			}, {
				expr:           "sum(irate(container_network_transmit_bytes_total{cluster=\"$cluster\",namespace=~\"$namespace\"}[$interval:$resolution])) by (pod)"
				format:         "table"
				instant:        true
				intervalFactor: 2
				legendFormat:   ""
				refId:          "B"
				step:           10
			}, {
				expr:           "sum(irate(container_network_receive_packets_total{cluster=\"$cluster\",namespace=~\"$namespace\"}[$interval:$resolution])) by (pod)"
				format:         "table"
				instant:        true
				intervalFactor: 2
				legendFormat:   ""
				refId:          "C"
				step:           10
			}, {
				expr:           "sum(irate(container_network_transmit_packets_total{cluster=\"$cluster\",namespace=~\"$namespace\"}[$interval:$resolution])) by (pod)"
				format:         "table"
				instant:        true
				intervalFactor: 2
				legendFormat:   ""
				refId:          "D"
				step:           10
			}, {
				expr:           "sum(irate(container_network_receive_packets_dropped_total{cluster=\"$cluster\",namespace=~\"$namespace\"}[$interval:$resolution])) by (pod)"
				format:         "table"
				instant:        true
				intervalFactor: 2
				legendFormat:   ""
				refId:          "E"
				step:           10
			}, {
				expr:           "sum(irate(container_network_transmit_packets_dropped_total{cluster=\"$cluster\",namespace=~\"$namespace\"}[$interval:$resolution])) by (pod)"
				format:         "table"
				instant:        true
				intervalFactor: 2
				legendFormat:   ""
				refId:          "F"
				step:           10
			}]
			timeFrom:  null
			timeShift: null
			title:     "Current Status"
			type:      "table"
		}, {
			collapse:  false
			collapsed: false
			gridPos: {
				h: 1
				w: 24
				x: 0
				y: 19
			}
			id: 6
			panels: []
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       true
			title:           "Bandwidth"
			titleSize:       "h6"
			type:            "row"
		}, {
			aliasColors: {}
			bars:         false
			dashLength:   10
			dashes:       false
			datasource:   "$datasource"
			fill:         2
			fillGradient: 0
			gridPos: {
				h: 9
				w: 12
				x: 0
				y: 20
			}
			id: 7
			legend: {
				alignAsTable: false
				avg:          false
				current:      false
				hideEmpty:    true
				hideZero:     true
				max:          false
				min:          false
				rightSide:    false
				show:         true
				sideWidth:    null
				total:        false
				values:       false
			}
			lines:     true
			linewidth: 2
			links: []
			minSpan:       12
			nullPointMode: "connected"
			paceLength:    10
			percentage:    false
			pointradius:   5
			points:        false
			renderer:      "flot"
			repeat:        null
			seriesOverrides: []
			spaceLength: 10
			span:        12
			stack:       true
			steppedLine: false
			targets: [{
				expr:           "sum(irate(container_network_receive_bytes_total{cluster=\"$cluster\",namespace=~\"$namespace\"}[$interval:$resolution])) by (pod)"
				format:         "time_series"
				intervalFactor: 1
				legendFormat:   "{{pod}}"
				refId:          "A"
				step:           10
			}]
			thresholds: []
			timeFrom:  null
			timeShift: null
			title:     "Receive Bandwidth"
			tooltip: {
				shared:     true
				sort:       2
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
			yaxes: [{
				format:  "Bps"
				label:   null
				logBase: 1
				max:     null
				min:     0
				show:    true
			}, {
				format:  "Bps"
				label:   null
				logBase: 1
				max:     null
				min:     0
				show:    true
			}]
		}, {
			aliasColors: {}
			bars:         false
			dashLength:   10
			dashes:       false
			datasource:   "$datasource"
			fill:         2
			fillGradient: 0
			gridPos: {
				h: 9
				w: 12
				x: 12
				y: 20
			}
			id: 8
			legend: {
				alignAsTable: false
				avg:          false
				current:      false
				hideEmpty:    true
				hideZero:     true
				max:          false
				min:          false
				rightSide:    false
				show:         true
				sideWidth:    null
				total:        false
				values:       false
			}
			lines:     true
			linewidth: 2
			links: []
			minSpan:       12
			nullPointMode: "connected"
			paceLength:    10
			percentage:    false
			pointradius:   5
			points:        false
			renderer:      "flot"
			repeat:        null
			seriesOverrides: []
			spaceLength: 10
			span:        12
			stack:       true
			steppedLine: false
			targets: [{
				expr:           "sum(irate(container_network_transmit_bytes_total{cluster=\"$cluster\",namespace=~\"$namespace\"}[$interval:$resolution])) by (pod)"
				format:         "time_series"
				intervalFactor: 1
				legendFormat:   "{{pod}}"
				refId:          "A"
				step:           10
			}]
			thresholds: []
			timeFrom:  null
			timeShift: null
			title:     "Transmit Bandwidth"
			tooltip: {
				shared:     true
				sort:       2
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
			yaxes: [{
				format:  "Bps"
				label:   null
				logBase: 1
				max:     null
				min:     0
				show:    true
			}, {
				format:  "Bps"
				label:   null
				logBase: 1
				max:     null
				min:     0
				show:    true
			}]
		}, {
			collapse:  true
			collapsed: true
			gridPos: {
				h: 1
				w: 24
				x: 0
				y: 29
			}
			id: 9
			panels: [{
				aliasColors: {}
				bars:         false
				dashLength:   10
				dashes:       false
				datasource:   "$datasource"
				fill:         2
				fillGradient: 0
				gridPos: {
					h: 10
					w: 12
					x: 0
					y: 30
				}
				id: 10
				legend: {
					alignAsTable: false
					avg:          false
					current:      false
					hideEmpty:    true
					hideZero:     true
					max:          false
					min:          false
					rightSide:    false
					show:         true
					sideWidth:    null
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 2
				links: []
				minSpan:       12
				nullPointMode: "connected"
				paceLength:    10
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				repeat:        null
				seriesOverrides: []
				spaceLength: 10
				span:        12
				stack:       true
				steppedLine: false
				targets: [{
					expr:           "sum(irate(container_network_receive_packets_total{cluster=\"$cluster\",namespace=~\"$namespace\"}[$interval:$resolution])) by (pod)"
					format:         "time_series"
					intervalFactor: 1
					legendFormat:   "{{pod}}"
					refId:          "A"
					step:           10
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Rate of Received Packets"
				tooltip: {
					shared:     true
					sort:       2
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
				yaxes: [{
					format:  "pps"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "pps"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}]
			}, {
				aliasColors: {}
				bars:         false
				dashLength:   10
				dashes:       false
				datasource:   "$datasource"
				fill:         2
				fillGradient: 0
				gridPos: {
					h: 10
					w: 12
					x: 12
					y: 30
				}
				id: 11
				legend: {
					alignAsTable: false
					avg:          false
					current:      false
					hideEmpty:    true
					hideZero:     true
					max:          false
					min:          false
					rightSide:    false
					show:         true
					sideWidth:    null
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 2
				links: []
				minSpan:       12
				nullPointMode: "connected"
				paceLength:    10
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				repeat:        null
				seriesOverrides: []
				spaceLength: 10
				span:        12
				stack:       true
				steppedLine: false
				targets: [{
					expr:           "sum(irate(container_network_transmit_packets_total{cluster=\"$cluster\",namespace=~\"$namespace\"}[$interval:$resolution])) by (pod)"
					format:         "time_series"
					intervalFactor: 1
					legendFormat:   "{{pod}}"
					refId:          "A"
					step:           10
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Rate of Transmitted Packets"
				tooltip: {
					shared:     true
					sort:       2
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
				yaxes: [{
					format:  "pps"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "pps"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}]
			}]
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       true
			title:           "Packets"
			titleSize:       "h6"
			type:            "row"
		}, {
			collapse:  true
			collapsed: true
			gridPos: {
				h: 1
				w: 24
				x: 0
				y: 30
			}
			id: 12
			panels: [{
				aliasColors: {}
				bars:         false
				dashLength:   10
				dashes:       false
				datasource:   "$datasource"
				fill:         2
				fillGradient: 0
				gridPos: {
					h: 10
					w: 12
					x: 0
					y: 40
				}
				id: 13
				legend: {
					alignAsTable: false
					avg:          false
					current:      false
					hideEmpty:    true
					hideZero:     true
					max:          false
					min:          false
					rightSide:    false
					show:         true
					sideWidth:    null
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 2
				links: []
				minSpan:       12
				nullPointMode: "connected"
				paceLength:    10
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				repeat:        null
				seriesOverrides: []
				spaceLength: 10
				span:        12
				stack:       true
				steppedLine: false
				targets: [{
					expr:           "sum(irate(container_network_receive_packets_dropped_total{cluster=\"$cluster\",namespace=~\"$namespace\"}[$interval:$resolution])) by (pod)"
					format:         "time_series"
					intervalFactor: 1
					legendFormat:   "{{pod}}"
					refId:          "A"
					step:           10
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Rate of Received Packets Dropped"
				tooltip: {
					shared:     true
					sort:       2
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
				yaxes: [{
					format:  "pps"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "pps"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}]
			}, {
				aliasColors: {}
				bars:         false
				dashLength:   10
				dashes:       false
				datasource:   "$datasource"
				fill:         2
				fillGradient: 0
				gridPos: {
					h: 10
					w: 12
					x: 12
					y: 40
				}
				id: 14
				legend: {
					alignAsTable: false
					avg:          false
					current:      false
					hideEmpty:    true
					hideZero:     true
					max:          false
					min:          false
					rightSide:    false
					show:         true
					sideWidth:    null
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 2
				links: []
				minSpan:       12
				nullPointMode: "connected"
				paceLength:    10
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				repeat:        null
				seriesOverrides: []
				spaceLength: 10
				span:        12
				stack:       true
				steppedLine: false
				targets: [{
					expr:           "sum(irate(container_network_transmit_packets_dropped_total{cluster=\"$cluster\",namespace=~\"$namespace\"}[$interval:$resolution])) by (pod)"
					format:         "time_series"
					intervalFactor: 1
					legendFormat:   "{{pod}}"
					refId:          "A"
					step:           10
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Rate of Transmitted Packets Dropped"
				tooltip: {
					shared:     true
					sort:       2
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
				yaxes: [{
					format:  "pps"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "pps"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}]
			}]
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       true
			title:           "Errors"
			titleSize:       "h6"
			type:            "row"
		}]
		refresh: "10s"
		rows: []
		schemaVersion: 18
		style:         "dark"
		tags: [
			"kubernetes-mixin",
		]
		templating: list: [{
			current: {
				text:  "default"
				value: "default"
			}
			hide:  0
			label: "Data Source"
			name:  "datasource"
			options: []
			query:   "prometheus"
			refresh: 1
			regex:   ""
			type:    "datasource"
		}, {
			allValue: null
			current: {}
			datasource: "$datasource"
			hide:       2
			includeAll: false
			label:      null
			multi:      false
			name:       "cluster"
			options: []
			query:          "label_values(up{job=\"kubelet\", metrics_path=\"/metrics/cadvisor\"}, cluster)"
			refresh:        2
			regex:          ""
			sort:           0
			tagValuesQuery: ""
			tags: []
			tagsQuery: ""
			type:      "query"
			useTags:   false
		}, {
			allValue:   ".+"
			auto:       false
			auto_count: 30
			auto_min:   "10s"
			current: {
				text:  "kube-system"
				value: "kube-system"
			}
			datasource: "$datasource"
			definition: "label_values(container_network_receive_packets_total{cluster=\"$cluster\"}, namespace)"
			hide:       0
			includeAll: true
			label:      null
			multi:      false
			name:       "namespace"
			options: []
			query:          "label_values(container_network_receive_packets_total{cluster=\"$cluster\"}, namespace)"
			refresh:        2
			regex:          ""
			skipUrlSync:    false
			sort:           1
			tagValuesQuery: ""
			tags: []
			tagsQuery: ""
			type:      "query"
			useTags:   false
		}, {
			allValue:   null
			auto:       false
			auto_count: 30
			auto_min:   "10s"
			current: {
				text:  "5m"
				value: "5m"
			}
			datasource: "$datasource"
			hide:       0
			includeAll: false
			label:      null
			multi:      false
			name:       "resolution"
			options: [{
				selected: false
				text:     "30s"
				value:    "30s"
			}, {
				selected: true
				text:     "5m"
				value:    "5m"
			}, {
				selected: false
				text:     "1h"
				value:    "1h"
			}]
			query:          "30s,5m,1h"
			refresh:        2
			regex:          ""
			skipUrlSync:    false
			sort:           1
			tagValuesQuery: ""
			tags: []
			tagsQuery: ""
			type:      "interval"
			useTags:   false
		}, {
			allValue:   null
			auto:       false
			auto_count: 30
			auto_min:   "10s"
			current: {
				text:  "5m"
				value: "5m"
			}
			datasource: "$datasource"
			hide:       2
			includeAll: false
			label:      null
			multi:      false
			name:       "interval"
			options: [{
				selected: true
				text:     "4h"
				value:    "4h"
			}]
			query:          "4h"
			refresh:        2
			regex:          ""
			skipUrlSync:    false
			sort:           1
			tagValuesQuery: ""
			tags: []
			tagsQuery: ""
			type:      "interval"
			useTags:   false
		}]
		time: {
			from: "now-1h"
			to:   "now"
		}
		timepicker: {
			refresh_intervals: ["5s", "10s", "30s", "1m", "5m", "15m", "30m", "1h", "2h", "1d"]
			time_options: ["5m", "15m", "1h", "6h", "12h", "24h", "2d", "7d", "30d"]
		}
		timezone: "UTC"
		title:    "Kubernetes / Networking / Namespace (Pods)"
		uid:      "8b7a8b326d7a6f1f04244066368c67af"
		version:  0
	}
	"namespace-by-workload.json": {
		"__inputs": []
		"__requires": []
		annotations: list: [{
			builtIn:    1
			datasource: "-- Grafana --"
			enable:     true
			hide:       true
			iconColor:  "rgba(0, 211, 255, 1)"
			name:       "Annotations & Alerts"
			type:       "dashboard"
		}]
		editable:     true
		gnetId:       null
		graphTooltip: 0
		hideControls: false
		id:           null
		links: []
		panels: [{
			collapse:  false
			collapsed: false
			gridPos: {
				h: 1
				w: 24
				x: 0
				y: 0
			}
			id: 2
			panels: []
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       true
			title:           "Current Bandwidth"
			titleSize:       "h6"
			type:            "row"
		}, {
			aliasColors: {}
			bars:         true
			dashLength:   10
			dashes:       false
			datasource:   "$datasource"
			fill:         2
			fillGradient: 0
			gridPos: {
				h: 9
				w: 12
				x: 0
				y: 1
			}
			id: 3
			legend: {
				alignAsTable: true
				avg:          false
				current:      true
				hideEmpty:    true
				hideZero:     true
				max:          false
				min:          false
				rightSide:    true
				show:         true
				sideWidth:    null
				sort:         "current"
				sortDesc:     true
				total:        false
				values:       true
			}
			lines:     false
			linewidth: 1
			links: []
			minSpan:       24
			nullPointMode: "null"
			paceLength:    10
			percentage:    false
			pointradius:   5
			points:        false
			renderer:      "flot"
			repeat:        null
			seriesOverrides: []
			spaceLength: 10
			span:        24
			stack:       false
			steppedLine: false
			targets: [{
				expr: """
					sort_desc(sum(irate(container_network_receive_bytes_total{cluster="$cluster",namespace="$namespace"}[$interval:$resolution])
					* on (namespace,pod)
					group_left(workload,workload_type) namespace_workload_pod:kube_pod_owner:relabel{cluster="$cluster",namespace="$namespace", workload=~".+", workload_type="$type"}) by (workload))

					"""
				format:         "time_series"
				intervalFactor: 1
				legendFormat:   "{{ workload }}"
				refId:          "A"
				step:           10
			}]
			thresholds: []
			timeFrom:  null
			timeShift: null
			title:     "Current Rate of Bytes Received"
			tooltip: {
				shared:     true
				sort:       2
				value_type: "individual"
			}
			type: "graph"
			xaxis: {
				buckets: null
				mode:    "series"
				name:    null
				show:    false
				values: ["current"]
			}
			yaxes: [{
				format:  "Bps"
				label:   null
				logBase: 1
				max:     null
				min:     0
				show:    true
			}, {
				format:  "Bps"
				label:   null
				logBase: 1
				max:     null
				min:     0
				show:    true
			}]
		}, {
			aliasColors: {}
			bars:         true
			dashLength:   10
			dashes:       false
			datasource:   "$datasource"
			fill:         2
			fillGradient: 0
			gridPos: {
				h: 9
				w: 12
				x: 12
				y: 1
			}
			id: 4
			legend: {
				alignAsTable: true
				avg:          false
				current:      true
				hideEmpty:    true
				hideZero:     true
				max:          false
				min:          false
				rightSide:    true
				show:         true
				sideWidth:    null
				sort:         "current"
				sortDesc:     true
				total:        false
				values:       true
			}
			lines:     false
			linewidth: 1
			links: []
			minSpan:       24
			nullPointMode: "null"
			paceLength:    10
			percentage:    false
			pointradius:   5
			points:        false
			renderer:      "flot"
			repeat:        null
			seriesOverrides: []
			spaceLength: 10
			span:        24
			stack:       false
			steppedLine: false
			targets: [{
				expr: """
					sort_desc(sum(irate(container_network_transmit_bytes_total{cluster="$cluster",namespace="$namespace"}[$interval:$resolution])
					* on (namespace,pod)
					group_left(workload,workload_type) namespace_workload_pod:kube_pod_owner:relabel{cluster="$cluster",namespace="$namespace", workload=~".+", workload_type="$type"}) by (workload))

					"""
				format:         "time_series"
				intervalFactor: 1
				legendFormat:   "{{ workload }}"
				refId:          "A"
				step:           10
			}]
			thresholds: []
			timeFrom:  null
			timeShift: null
			title:     "Current Rate of Bytes Transmitted"
			tooltip: {
				shared:     true
				sort:       2
				value_type: "individual"
			}
			type: "graph"
			xaxis: {
				buckets: null
				mode:    "series"
				name:    null
				show:    false
				values: ["current"]
			}
			yaxes: [{
				format:  "Bps"
				label:   null
				logBase: 1
				max:     null
				min:     0
				show:    true
			}, {
				format:  "Bps"
				label:   null
				logBase: 1
				max:     null
				min:     0
				show:    true
			}]
		}, {
			columns: [{
				text:  "Time"
				value: "Time"
			}, {
				text:  "Value #A"
				value: "Value #A"
			}, {
				text:  "Value #B"
				value: "Value #B"
			}, {
				text:  "Value #C"
				value: "Value #C"
			}, {
				text:  "Value #D"
				value: "Value #D"
			}, {
				text:  "Value #E"
				value: "Value #E"
			}, {
				text:  "Value #F"
				value: "Value #F"
			}, {
				text:  "Value #G"
				value: "Value #G"
			}, {
				text:  "Value #H"
				value: "Value #H"
			}, {
				text:  "workload"
				value: "workload"
			}]
			datasource: "$datasource"
			fill:       1
			fontSize:   "90%"
			gridPos: {
				h: 9
				w: 24
				x: 0
				y: 10
			}
			id:        5
			lines:     true
			linewidth: 1
			links: []
			minSpan:       24
			nullPointMode: "null as zero"
			renderer:      "flot"
			scroll:        true
			showHeader:    true
			sort: {
				col:  0
				desc: false
			}
			spaceLength: 10
			span:        24
			styles: [{
				alias:     "Time"
				colorMode: null
				colors: []
				dateFormat:  "YYYY-MM-DD HH:mm:ss"
				decimals:    2
				link:        false
				linkTooltip: "Drill down"
				linkUrl:     ""
				pattern:     "Time"
				thresholds: []
				type: "hidden"
				unit: "short"
			}, {
				alias:     "Current Bandwidth Received"
				colorMode: null
				colors: []
				dateFormat:  "YYYY-MM-DD HH:mm:ss"
				decimals:    2
				link:        false
				linkTooltip: "Drill down"
				linkUrl:     ""
				pattern:     "Value #A"
				thresholds: []
				type: "number"
				unit: "Bps"
			}, {
				alias:     "Current Bandwidth Transmitted"
				colorMode: null
				colors: []
				dateFormat:  "YYYY-MM-DD HH:mm:ss"
				decimals:    2
				link:        false
				linkTooltip: "Drill down"
				linkUrl:     ""
				pattern:     "Value #B"
				thresholds: []
				type: "number"
				unit: "Bps"
			}, {
				alias:     "Average Bandwidth Received"
				colorMode: null
				colors: []
				dateFormat:  "YYYY-MM-DD HH:mm:ss"
				decimals:    2
				link:        false
				linkTooltip: "Drill down"
				linkUrl:     ""
				pattern:     "Value #C"
				thresholds: []
				type: "number"
				unit: "Bps"
			}, {
				alias:     "Average Bandwidth Transmitted"
				colorMode: null
				colors: []
				dateFormat:  "YYYY-MM-DD HH:mm:ss"
				decimals:    2
				link:        false
				linkTooltip: "Drill down"
				linkUrl:     ""
				pattern:     "Value #D"
				thresholds: []
				type: "number"
				unit: "Bps"
			}, {
				alias:     "Rate of Received Packets"
				colorMode: null
				colors: []
				dateFormat:  "YYYY-MM-DD HH:mm:ss"
				decimals:    2
				link:        false
				linkTooltip: "Drill down"
				linkUrl:     ""
				pattern:     "Value #E"
				thresholds: []
				type: "number"
				unit: "pps"
			}, {
				alias:     "Rate of Transmitted Packets"
				colorMode: null
				colors: []
				dateFormat:  "YYYY-MM-DD HH:mm:ss"
				decimals:    2
				link:        false
				linkTooltip: "Drill down"
				linkUrl:     ""
				pattern:     "Value #F"
				thresholds: []
				type: "number"
				unit: "pps"
			}, {
				alias:     "Rate of Received Packets Dropped"
				colorMode: null
				colors: []
				dateFormat:  "YYYY-MM-DD HH:mm:ss"
				decimals:    2
				link:        false
				linkTooltip: "Drill down"
				linkUrl:     ""
				pattern:     "Value #G"
				thresholds: []
				type: "number"
				unit: "pps"
			}, {
				alias:     "Rate of Transmitted Packets Dropped"
				colorMode: null
				colors: []
				dateFormat:  "YYYY-MM-DD HH:mm:ss"
				decimals:    2
				link:        false
				linkTooltip: "Drill down"
				linkUrl:     ""
				pattern:     "Value #H"
				thresholds: []
				type: "number"
				unit: "pps"
			}, {
				alias:     "Workload"
				colorMode: null
				colors: []
				dateFormat:  "YYYY-MM-DD HH:mm:ss"
				decimals:    2
				link:        true
				linkTooltip: "Drill down"
				linkUrl:     "d/728bf77cc1166d2f3133bf25846876cc/kubernetes-networking-workload?orgId=1&refresh=30s&var-namespace=$namespace&var-type=$type&var-workload=$__cell"
				pattern:     "workload"
				thresholds: []
				type: "number"
				unit: "short"
			}]
			targets: [{
				expr: """
					sort_desc(sum(irate(container_network_receive_bytes_total{cluster="$cluster",namespace="$namespace"}[$interval:$resolution])
					* on (namespace,pod)
					group_left(workload,workload_type) namespace_workload_pod:kube_pod_owner:relabel{cluster="$cluster",namespace="$namespace", workload=~".+", workload_type="$type"}) by (workload))

					"""
				format:         "table"
				instant:        true
				intervalFactor: 2
				legendFormat:   ""
				refId:          "A"
				step:           10
			}, {
				expr: """
					sort_desc(sum(irate(container_network_transmit_bytes_total{cluster="$cluster",namespace="$namespace"}[$interval:$resolution])
					* on (namespace,pod)
					group_left(workload,workload_type) namespace_workload_pod:kube_pod_owner:relabel{cluster="$cluster",namespace="$namespace", workload=~".+", workload_type="$type"}) by (workload))

					"""
				format:         "table"
				instant:        true
				intervalFactor: 2
				legendFormat:   ""
				refId:          "B"
				step:           10
			}, {
				expr: """
					sort_desc(avg(irate(container_network_receive_bytes_total{cluster="$cluster",namespace="$namespace"}[$interval:$resolution])
					* on (namespace,pod)
					group_left(workload,workload_type) namespace_workload_pod:kube_pod_owner:relabel{cluster="$cluster",namespace="$namespace", workload=~".+", workload_type="$type"}) by (workload))

					"""
				format:         "table"
				instant:        true
				intervalFactor: 2
				legendFormat:   ""
				refId:          "C"
				step:           10
			}, {
				expr: """
					sort_desc(avg(irate(container_network_transmit_bytes_total{cluster="$cluster",namespace="$namespace"}[$interval:$resolution])
					* on (namespace,pod)
					group_left(workload,workload_type) namespace_workload_pod:kube_pod_owner:relabel{cluster="$cluster",namespace="$namespace", workload=~".+", workload_type="$type"}) by (workload))

					"""
				format:         "table"
				instant:        true
				intervalFactor: 2
				legendFormat:   ""
				refId:          "D"
				step:           10
			}, {
				expr: """
					sort_desc(sum(irate(container_network_receive_packets_total{cluster="$cluster",namespace="$namespace"}[$interval:$resolution])
					* on (namespace,pod)
					group_left(workload,workload_type) namespace_workload_pod:kube_pod_owner:relabel{cluster="$cluster",namespace="$namespace", workload=~".+", workload_type="$type"}) by (workload))

					"""
				format:         "table"
				instant:        true
				intervalFactor: 2
				legendFormat:   ""
				refId:          "E"
				step:           10
			}, {
				expr: """
					sort_desc(sum(irate(container_network_transmit_packets_total{cluster="$cluster",namespace="$namespace"}[$interval:$resolution])
					* on (namespace,pod)
					group_left(workload,workload_type) namespace_workload_pod:kube_pod_owner:relabel{cluster="$cluster",namespace="$namespace", workload=~".+", workload_type="$type"}) by (workload))

					"""
				format:         "table"
				instant:        true
				intervalFactor: 2
				legendFormat:   ""
				refId:          "F"
				step:           10
			}, {
				expr: """
					sort_desc(sum(irate(container_network_receive_packets_dropped_total{cluster="$cluster",namespace="$namespace"}[$interval:$resolution])
					* on (namespace,pod)
					group_left(workload,workload_type) namespace_workload_pod:kube_pod_owner:relabel{cluster="$cluster",namespace="$namespace", workload=~".+", workload_type="$type"}) by (workload))

					"""
				format:         "table"
				instant:        true
				intervalFactor: 2
				legendFormat:   ""
				refId:          "G"
				step:           10
			}, {
				expr: """
					sort_desc(sum(irate(container_network_transmit_packets_dropped_total{cluster="$cluster",namespace="$namespace"}[$interval:$resolution])
					* on (namespace,pod)
					group_left(workload,workload_type) namespace_workload_pod:kube_pod_owner:relabel{cluster="$cluster",namespace="$namespace", workload=~".+", workload_type="$type"}) by (workload))

					"""
				format:         "table"
				instant:        true
				intervalFactor: 2
				legendFormat:   ""
				refId:          "H"
				step:           10
			}]
			timeFrom:  null
			timeShift: null
			title:     "Current Status"
			type:      "table"
		}, {
			collapse:  true
			collapsed: true
			gridPos: {
				h: 1
				w: 24
				x: 0
				y: 19
			}
			id: 6
			panels: [{
				aliasColors: {}
				bars:         true
				dashLength:   10
				dashes:       false
				datasource:   "$datasource"
				fill:         2
				fillGradient: 0
				gridPos: {
					h: 9
					w: 12
					x: 0
					y: 20
				}
				id: 7
				legend: {
					alignAsTable: true
					avg:          false
					current:      true
					hideEmpty:    true
					hideZero:     true
					max:          false
					min:          false
					rightSide:    true
					show:         true
					sideWidth:    null
					sort:         "current"
					sortDesc:     true
					total:        false
					values:       true
				}
				lines:     false
				linewidth: 1
				links: []
				minSpan:       24
				nullPointMode: "null"
				paceLength:    10
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				repeat:        null
				seriesOverrides: []
				spaceLength: 10
				span:        24
				stack:       false
				steppedLine: false
				targets: [{
					expr: """
						sort_desc(avg(irate(container_network_receive_bytes_total{cluster="$cluster",namespace="$namespace"}[$interval:$resolution])
						* on (namespace,pod)
						group_left(workload,workload_type) namespace_workload_pod:kube_pod_owner:relabel{cluster="$cluster",namespace="$namespace", workload=~".+", workload_type="$type"}) by (workload))

						"""
					format:         "time_series"
					intervalFactor: 1
					legendFormat:   "{{ workload }}"
					refId:          "A"
					step:           10
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Average Rate of Bytes Received"
				tooltip: {
					shared:     true
					sort:       2
					value_type: "individual"
				}
				type: "graph"
				xaxis: {
					buckets: null
					mode:    "series"
					name:    null
					show:    false
					values: ["current"]
				}
				yaxes: [{
					format:  "Bps"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "Bps"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}]
			}, {
				aliasColors: {}
				bars:         true
				dashLength:   10
				dashes:       false
				datasource:   "$datasource"
				fill:         2
				fillGradient: 0
				gridPos: {
					h: 9
					w: 12
					x: 12
					y: 20
				}
				id: 8
				legend: {
					alignAsTable: true
					avg:          false
					current:      true
					hideEmpty:    true
					hideZero:     true
					max:          false
					min:          false
					rightSide:    true
					show:         true
					sideWidth:    null
					sort:         "current"
					sortDesc:     true
					total:        false
					values:       true
				}
				lines:     false
				linewidth: 1
				links: []
				minSpan:       24
				nullPointMode: "null"
				paceLength:    10
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				repeat:        null
				seriesOverrides: []
				spaceLength: 10
				span:        24
				stack:       false
				steppedLine: false
				targets: [{
					expr: """
						sort_desc(avg(irate(container_network_transmit_bytes_total{cluster="$cluster",namespace="$namespace"}[$interval:$resolution])
						* on (namespace,pod)
						group_left(workload,workload_type) namespace_workload_pod:kube_pod_owner:relabel{cluster="$cluster",namespace="$namespace", workload=~".+", workload_type="$type"}) by (workload))

						"""
					format:         "time_series"
					intervalFactor: 1
					legendFormat:   "{{ workload }}"
					refId:          "A"
					step:           10
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Average Rate of Bytes Transmitted"
				tooltip: {
					shared:     true
					sort:       2
					value_type: "individual"
				}
				type: "graph"
				xaxis: {
					buckets: null
					mode:    "series"
					name:    null
					show:    false
					values: ["current"]
				}
				yaxes: [{
					format:  "Bps"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "Bps"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}]
			}]
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       true
			title:           "Average Bandwidth"
			titleSize:       "h6"
			type:            "row"
		}, {
			collapse:  false
			collapsed: false
			gridPos: {
				h: 1
				w: 24
				x: 0
				y: 29
			}
			id: 9
			panels: []
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       true
			title:           "Bandwidth HIstory"
			titleSize:       "h6"
			type:            "row"
		}, {
			aliasColors: {}
			bars:         false
			dashLength:   10
			dashes:       false
			datasource:   "$datasource"
			fill:         2
			fillGradient: 0
			gridPos: {
				h: 9
				w: 12
				x: 0
				y: 38
			}
			id: 10
			legend: {
				alignAsTable: false
				avg:          false
				current:      false
				hideEmpty:    true
				hideZero:     true
				max:          false
				min:          false
				rightSide:    false
				show:         true
				sideWidth:    null
				total:        false
				values:       false
			}
			lines:     true
			linewidth: 2
			links: []
			minSpan:       12
			nullPointMode: "connected"
			paceLength:    10
			percentage:    false
			pointradius:   5
			points:        false
			renderer:      "flot"
			repeat:        null
			seriesOverrides: []
			spaceLength: 10
			span:        12
			stack:       true
			steppedLine: false
			targets: [{
				expr: """
					sort_desc(sum(irate(container_network_receive_bytes_total{cluster="$cluster",namespace="$namespace"}[$interval:$resolution])
					* on (namespace,pod)
					group_left(workload,workload_type) namespace_workload_pod:kube_pod_owner:relabel{cluster="$cluster",namespace="$namespace", workload=~".+", workload_type="$type"}) by (workload))

					"""
				format:         "time_series"
				intervalFactor: 1
				legendFormat:   "{{workload}}"
				refId:          "A"
				step:           10
			}]
			thresholds: []
			timeFrom:  null
			timeShift: null
			title:     "Receive Bandwidth"
			tooltip: {
				shared:     true
				sort:       2
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
			yaxes: [{
				format:  "Bps"
				label:   null
				logBase: 1
				max:     null
				min:     0
				show:    true
			}, {
				format:  "Bps"
				label:   null
				logBase: 1
				max:     null
				min:     0
				show:    true
			}]
		}, {
			aliasColors: {}
			bars:         false
			dashLength:   10
			dashes:       false
			datasource:   "$datasource"
			fill:         2
			fillGradient: 0
			gridPos: {
				h: 9
				w: 12
				x: 12
				y: 38
			}
			id: 11
			legend: {
				alignAsTable: false
				avg:          false
				current:      false
				hideEmpty:    true
				hideZero:     true
				max:          false
				min:          false
				rightSide:    false
				show:         true
				sideWidth:    null
				total:        false
				values:       false
			}
			lines:     true
			linewidth: 2
			links: []
			minSpan:       12
			nullPointMode: "connected"
			paceLength:    10
			percentage:    false
			pointradius:   5
			points:        false
			renderer:      "flot"
			repeat:        null
			seriesOverrides: []
			spaceLength: 10
			span:        12
			stack:       true
			steppedLine: false
			targets: [{
				expr: """
					sort_desc(sum(irate(container_network_transmit_bytes_total{cluster="$cluster",namespace="$namespace"}[$interval:$resolution])
					* on (namespace,pod)
					group_left(workload,workload_type) namespace_workload_pod:kube_pod_owner:relabel{cluster="$cluster",namespace="$namespace", workload=~".+", workload_type="$type"}) by (workload))

					"""
				format:         "time_series"
				intervalFactor: 1
				legendFormat:   "{{workload}}"
				refId:          "A"
				step:           10
			}]
			thresholds: []
			timeFrom:  null
			timeShift: null
			title:     "Transmit Bandwidth"
			tooltip: {
				shared:     true
				sort:       2
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
			yaxes: [{
				format:  "Bps"
				label:   null
				logBase: 1
				max:     null
				min:     0
				show:    true
			}, {
				format:  "Bps"
				label:   null
				logBase: 1
				max:     null
				min:     0
				show:    true
			}]
		}, {
			collapse:  true
			collapsed: true
			gridPos: {
				h: 1
				w: 24
				x: 0
				y: 39
			}
			id: 12
			panels: [{
				aliasColors: {}
				bars:         false
				dashLength:   10
				dashes:       false
				datasource:   "$datasource"
				fill:         2
				fillGradient: 0
				gridPos: {
					h: 9
					w: 12
					x: 0
					y: 40
				}
				id: 13
				legend: {
					alignAsTable: false
					avg:          false
					current:      false
					hideEmpty:    true
					hideZero:     true
					max:          false
					min:          false
					rightSide:    false
					show:         true
					sideWidth:    null
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 2
				links: []
				minSpan:       12
				nullPointMode: "connected"
				paceLength:    10
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				repeat:        null
				seriesOverrides: []
				spaceLength: 10
				span:        12
				stack:       true
				steppedLine: false
				targets: [{
					expr: """
						sort_desc(sum(irate(container_network_receive_packets_total{cluster="$cluster",namespace="$namespace"}[$interval:$resolution])
						* on (namespace,pod)
						group_left(workload,workload_type) namespace_workload_pod:kube_pod_owner:relabel{cluster="$cluster",namespace="$namespace", workload=~".+", workload_type="$type"}) by (workload))

						"""
					format:         "time_series"
					intervalFactor: 1
					legendFormat:   "{{workload}}"
					refId:          "A"
					step:           10
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Rate of Received Packets"
				tooltip: {
					shared:     true
					sort:       2
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
				yaxes: [{
					format:  "pps"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "pps"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}]
			}, {
				aliasColors: {}
				bars:         false
				dashLength:   10
				dashes:       false
				datasource:   "$datasource"
				fill:         2
				fillGradient: 0
				gridPos: {
					h: 9
					w: 12
					x: 12
					y: 40
				}
				id: 14
				legend: {
					alignAsTable: false
					avg:          false
					current:      false
					hideEmpty:    true
					hideZero:     true
					max:          false
					min:          false
					rightSide:    false
					show:         true
					sideWidth:    null
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 2
				links: []
				minSpan:       12
				nullPointMode: "connected"
				paceLength:    10
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				repeat:        null
				seriesOverrides: []
				spaceLength: 10
				span:        12
				stack:       true
				steppedLine: false
				targets: [{
					expr: """
						sort_desc(sum(irate(container_network_transmit_packets_total{cluster="$cluster",namespace="$namespace"}[$interval:$resolution])
						* on (namespace,pod)
						group_left(workload,workload_type) namespace_workload_pod:kube_pod_owner:relabel{cluster="$cluster",namespace="$namespace", workload=~".+", workload_type="$type"}) by (workload))

						"""
					format:         "time_series"
					intervalFactor: 1
					legendFormat:   "{{workload}}"
					refId:          "A"
					step:           10
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Rate of Transmitted Packets"
				tooltip: {
					shared:     true
					sort:       2
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
				yaxes: [{
					format:  "pps"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "pps"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}]
			}]
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       true
			title:           "Packets"
			titleSize:       "h6"
			type:            "row"
		}, {
			collapse:  true
			collapsed: true
			gridPos: {
				h: 1
				w: 24
				x: 0
				y: 40
			}
			id: 15
			panels: [{
				aliasColors: {}
				bars:         false
				dashLength:   10
				dashes:       false
				datasource:   "$datasource"
				fill:         2
				fillGradient: 0
				gridPos: {
					h: 9
					w: 12
					x: 0
					y: 41
				}
				id: 16
				legend: {
					alignAsTable: false
					avg:          false
					current:      false
					hideEmpty:    true
					hideZero:     true
					max:          false
					min:          false
					rightSide:    false
					show:         true
					sideWidth:    null
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 2
				links: []
				minSpan:       12
				nullPointMode: "connected"
				paceLength:    10
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				repeat:        null
				seriesOverrides: []
				spaceLength: 10
				span:        12
				stack:       true
				steppedLine: false
				targets: [{
					expr: """
						sort_desc(sum(irate(container_network_receive_packets_dropped_total{cluster="$cluster",namespace="$namespace"}[$interval:$resolution])
						* on (namespace,pod)
						group_left(workload,workload_type) namespace_workload_pod:kube_pod_owner:relabel{cluster="$cluster",namespace="$namespace", workload=~".+", workload_type="$type"}) by (workload))

						"""
					format:         "time_series"
					intervalFactor: 1
					legendFormat:   "{{workload}}"
					refId:          "A"
					step:           10
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Rate of Received Packets Dropped"
				tooltip: {
					shared:     true
					sort:       2
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
				yaxes: [{
					format:  "pps"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "pps"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}]
			}, {
				aliasColors: {}
				bars:         false
				dashLength:   10
				dashes:       false
				datasource:   "$datasource"
				fill:         2
				fillGradient: 0
				gridPos: {
					h: 9
					w: 12
					x: 12
					y: 41
				}
				id: 17
				legend: {
					alignAsTable: false
					avg:          false
					current:      false
					hideEmpty:    true
					hideZero:     true
					max:          false
					min:          false
					rightSide:    false
					show:         true
					sideWidth:    null
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 2
				links: []
				minSpan:       12
				nullPointMode: "connected"
				paceLength:    10
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				repeat:        null
				seriesOverrides: []
				spaceLength: 10
				span:        12
				stack:       true
				steppedLine: false
				targets: [{
					expr: """
						sort_desc(sum(irate(container_network_transmit_packets_dropped_total{cluster="$cluster",namespace="$namespace"}[$interval:$resolution])
						* on (namespace,pod)
						group_left(workload,workload_type) namespace_workload_pod:kube_pod_owner:relabel{cluster="$cluster",namespace="$namespace", workload=~".+", workload_type="$type"}) by (workload))

						"""
					format:         "time_series"
					intervalFactor: 1
					legendFormat:   "{{workload}}"
					refId:          "A"
					step:           10
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Rate of Transmitted Packets Dropped"
				tooltip: {
					shared:     true
					sort:       2
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
				yaxes: [{
					format:  "pps"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "pps"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}]
			}]
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       true
			title:           "Errors"
			titleSize:       "h6"
			type:            "row"
		}]
		refresh: "10s"
		rows: []
		schemaVersion: 18
		style:         "dark"
		tags: [
			"kubernetes-mixin",
		]
		templating: list: [{
			current: {
				text:  "default"
				value: "default"
			}
			hide:  0
			label: "Data Source"
			name:  "datasource"
			options: []
			query:   "prometheus"
			refresh: 1
			regex:   ""
			type:    "datasource"
		}, {
			allValue: null
			current: {}
			datasource: "$datasource"
			hide:       2
			includeAll: false
			label:      null
			multi:      false
			name:       "cluster"
			options: []
			query:          "label_values(up{job=\"kubelet\", metrics_path=\"/metrics/cadvisor\"}, cluster)"
			refresh:        2
			regex:          ""
			sort:           0
			tagValuesQuery: ""
			tags: []
			tagsQuery: ""
			type:      "query"
			useTags:   false
		}, {
			allValue:   null
			auto:       false
			auto_count: 30
			auto_min:   "10s"
			current: {
				text:  "kube-system"
				value: "kube-system"
			}
			datasource: "$datasource"
			definition: "label_values(container_network_receive_packets_total{cluster=\"$cluster\"}, namespace)"
			hide:       0
			includeAll: false
			label:      null
			multi:      false
			name:       "namespace"
			options: []
			query:          "label_values(container_network_receive_packets_total{cluster=\"$cluster\"}, namespace)"
			refresh:        2
			regex:          ""
			skipUrlSync:    false
			sort:           1
			tagValuesQuery: ""
			tags: []
			tagsQuery: ""
			type:      "query"
			useTags:   false
		}, {
			allValue:   null
			auto:       false
			auto_count: 30
			auto_min:   "10s"
			current: {
				text:  "deployment"
				value: "deployment"
			}
			datasource: "$datasource"
			definition: "label_values(namespace_workload_pod:kube_pod_owner:relabel{cluster=\"$cluster\",namespace=\"$namespace\", workload=~\".+\"}, workload_type)"
			hide:       0
			includeAll: false
			label:      null
			multi:      false
			name:       "type"
			options: []
			query:          "label_values(namespace_workload_pod:kube_pod_owner:relabel{cluster=\"$cluster\",namespace=\"$namespace\", workload=~\".+\"}, workload_type)"
			refresh:        2
			regex:          ""
			skipUrlSync:    false
			sort:           0
			tagValuesQuery: ""
			tags: []
			tagsQuery: ""
			type:      "query"
			useTags:   false
		}, {
			allValue:   null
			auto:       false
			auto_count: 30
			auto_min:   "10s"
			current: {
				text:  "5m"
				value: "5m"
			}
			datasource: "$datasource"
			hide:       0
			includeAll: false
			label:      null
			multi:      false
			name:       "resolution"
			options: [{
				selected: false
				text:     "30s"
				value:    "30s"
			}, {
				selected: true
				text:     "5m"
				value:    "5m"
			}, {
				selected: false
				text:     "1h"
				value:    "1h"
			}]
			query:          "30s,5m,1h"
			refresh:        2
			regex:          ""
			skipUrlSync:    false
			sort:           1
			tagValuesQuery: ""
			tags: []
			tagsQuery: ""
			type:      "interval"
			useTags:   false
		}, {
			allValue:   null
			auto:       false
			auto_count: 30
			auto_min:   "10s"
			current: {
				text:  "5m"
				value: "5m"
			}
			datasource: "$datasource"
			hide:       2
			includeAll: false
			label:      null
			multi:      false
			name:       "interval"
			options: [{
				selected: true
				text:     "4h"
				value:    "4h"
			}]
			query:          "4h"
			refresh:        2
			regex:          ""
			skipUrlSync:    false
			sort:           1
			tagValuesQuery: ""
			tags: []
			tagsQuery: ""
			type:      "interval"
			useTags:   false
		}]
		time: {
			from: "now-1h"
			to:   "now"
		}
		timepicker: {
			refresh_intervals: ["5s", "10s", "30s", "1m", "5m", "15m", "30m", "1h", "2h", "1d"]
			time_options: ["5m", "15m", "1h", "6h", "12h", "24h", "2d", "7d", "30d"]
		}
		timezone: "UTC"
		title:    "Kubernetes / Networking / Namespace (Workload)"
		uid:      "bbb2a765a623ae38130206c7d94a160f"
		version:  0
	}
	"node-cluster-rsrc-use.json": {
		"__inputs": []
		"__requires": []
		annotations: list: []
		editable:     false
		gnetId:       null
		graphTooltip: 1
		hideControls: false
		id:           null
		links: []
		refresh: "30s"
		rows: [{
			collapse:  false
			collapsed: false
			panels: [{
				aliasColors: {}
				bars:         false
				dashLength:   10
				dashes:       false
				datasource:   "$datasource"
				fill:         10
				fillGradient: 0
				gridPos: {}
				id: 2
				legend: {
					alignAsTable: false
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    false
					show:         false
					sideWidth:    null
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 1
				links: []
				nullPointMode: "null"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				repeat:        null
				seriesOverrides: []
				spaceLength: 10
				span:        6
				stack:       true
				steppedLine: false
				targets: [{
					expr: """
						((
						  instance:node_cpu_utilisation:rate5m{job="node-exporter", cluster="$cluster"}
						  *
						  instance:node_num_cpu:sum{job="node-exporter", cluster="$cluster"}
						) != 0 )
						/ scalar(sum(instance:node_num_cpu:sum{job="node-exporter", cluster="$cluster"}))

						"""
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{ instance }}"
					refId:          "A"
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "CPU Utilisation"
				tooltip: {
					shared:     true
					sort:       2
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
				yaxes: [{
					format:  "percentunit"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    true
				}, {
					format:  "percentunit"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    true
				}]
			}, {
				aliasColors: {}
				bars:         false
				dashLength:   10
				dashes:       false
				datasource:   "$datasource"
				fill:         10
				fillGradient: 0
				gridPos: {}
				id: 3
				legend: {
					alignAsTable: false
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    false
					show:         false
					sideWidth:    null
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 1
				links: []
				nullPointMode: "null"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				repeat:        null
				seriesOverrides: []
				spaceLength: 10
				span:        6
				stack:       true
				steppedLine: false
				targets: [{
					expr: """
						(
						  instance:node_load1_per_cpu:ratio{job="node-exporter", cluster="$cluster"}
						  / scalar(count(instance:node_load1_per_cpu:ratio{job="node-exporter", cluster="$cluster"}))
						)  != 0

						"""
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{instance}}"
					refId:          "A"
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "CPU Saturation (Load1 per CPU)"
				tooltip: {
					shared:     true
					sort:       2
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
				yaxes: [{
					format:  "percentunit"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    true
				}, {
					format:  "percentunit"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    true
				}]
			}]
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       true
			title:           "CPU"
			titleSize:       "h6"
			type:            "row"
		}, {
			collapse:  false
			collapsed: false
			panels: [{
				aliasColors: {}
				bars:         false
				dashLength:   10
				dashes:       false
				datasource:   "$datasource"
				fill:         10
				fillGradient: 0
				gridPos: {}
				id: 4
				legend: {
					alignAsTable: false
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    false
					show:         false
					sideWidth:    null
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 1
				links: []
				nullPointMode: "null"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				repeat:        null
				seriesOverrides: []
				spaceLength: 10
				span:        6
				stack:       true
				steppedLine: false
				targets: [{
					expr: """
						(
						  instance:node_memory_utilisation:ratio{job="node-exporter", cluster="$cluster"}
						  / scalar(count(instance:node_memory_utilisation:ratio{job="node-exporter", cluster="$cluster"}))
						) != 0

						"""
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{instance}}"
					refId:          "A"
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Memory Utilisation"
				tooltip: {
					shared:     true
					sort:       2
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
				yaxes: [{
					format:  "percentunit"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    true
				}, {
					format:  "percentunit"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    true
				}]
			}, {
				aliasColors: {}
				bars:         false
				dashLength:   10
				dashes:       false
				datasource:   "$datasource"
				fill:         10
				fillGradient: 0
				gridPos: {}
				id: 5
				legend: {
					alignAsTable: false
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    false
					show:         false
					sideWidth:    null
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 1
				links: []
				nullPointMode: "null"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				repeat:        null
				seriesOverrides: []
				spaceLength: 10
				span:        6
				stack:       true
				steppedLine: false
				targets: [{
					expr:           "instance:node_vmstat_pgmajfault:rate5m{job=\"node-exporter\", cluster=\"$cluster\"}"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{instance}}"
					refId:          "A"
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Memory Saturation (Major Page Faults)"
				tooltip: {
					shared:     true
					sort:       2
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
				yaxes: [{
					format:  "rds"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    true
				}, {
					format:  "rds"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    true
				}]
			}]
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       true
			title:           "Memory"
			titleSize:       "h6"
			type:            "row"
		}, {
			collapse:  false
			collapsed: false
			panels: [{
				aliasColors: {}
				bars:         false
				dashLength:   10
				dashes:       false
				datasource:   "$datasource"
				fill:         10
				fillGradient: 0
				gridPos: {}
				id: 6
				legend: {
					alignAsTable: false
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    false
					show:         false
					sideWidth:    null
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 1
				links: []
				nullPointMode: "null"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				repeat:        null
				seriesOverrides: [{
					alias: "/Receive/"
					stack: "A"
				}, {
					alias:     "/Transmit/"
					stack:     "B"
					transform: "negative-Y"
				}]
				spaceLength: 10
				span:        6
				stack:       true
				steppedLine: false
				targets: [{
					expr:           "instance:node_network_receive_bytes_excluding_lo:rate5m{job=\"node-exporter\", cluster=\"$cluster\"} != 0"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{instance}} Receive"
					refId:          "A"
				}, {
					expr:           "instance:node_network_transmit_bytes_excluding_lo:rate5m{job=\"node-exporter\", cluster=\"$cluster\"} != 0"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{instance}} Transmit"
					refId:          "B"
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Network Utilisation (Bytes Receive/Transmit)"
				tooltip: {
					shared:     true
					sort:       2
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
				yaxes: [{
					format:  "Bps"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    true
				}, {
					format:  "Bps"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    true
				}]
			}, {
				aliasColors: {}
				bars:         false
				dashLength:   10
				dashes:       false
				datasource:   "$datasource"
				fill:         10
				fillGradient: 0
				gridPos: {}
				id: 7
				legend: {
					alignAsTable: false
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    false
					show:         false
					sideWidth:    null
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 1
				links: []
				nullPointMode: "null"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				repeat:        null
				seriesOverrides: [{
					alias: "/ Receive/"
					stack: "A"
				}, {
					alias:     "/ Transmit/"
					stack:     "B"
					transform: "negative-Y"
				}]
				spaceLength: 10
				span:        6
				stack:       true
				steppedLine: false
				targets: [{
					expr:           "instance:node_network_receive_drop_excluding_lo:rate5m{job=\"node-exporter\", cluster=\"$cluster\"} != 0"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{instance}} Receive"
					refId:          "A"
				}, {
					expr:           "instance:node_network_transmit_drop_excluding_lo:rate5m{job=\"node-exporter\", cluster=\"$cluster\"} != 0"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{instance}} Transmit"
					refId:          "B"
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Network Saturation (Drops Receive/Transmit)"
				tooltip: {
					shared:     true
					sort:       2
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
				yaxes: [{
					format:  "Bps"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    true
				}, {
					format:  "Bps"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    true
				}]
			}]
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       true
			title:           "Network"
			titleSize:       "h6"
			type:            "row"
		}, {
			collapse:  false
			collapsed: false
			panels: [{
				aliasColors: {}
				bars:         false
				dashLength:   10
				dashes:       false
				datasource:   "$datasource"
				fill:         10
				fillGradient: 0
				gridPos: {}
				id: 8
				legend: {
					alignAsTable: false
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    false
					show:         false
					sideWidth:    null
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 1
				links: []
				nullPointMode: "null"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				repeat:        null
				seriesOverrides: []
				spaceLength: 10
				span:        6
				stack:       true
				steppedLine: false
				targets: [{
					expr: """
						(
						  instance_device:node_disk_io_time_seconds:rate5m{job="node-exporter", cluster="$cluster"}
						  / scalar(count(instance_device:node_disk_io_time_seconds:rate5m{job="node-exporter", cluster="$cluster"}))
						) != 0

						"""
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{instance}} {{device}}"
					refId:          "A"
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Disk IO Utilisation"
				tooltip: {
					shared:     true
					sort:       2
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
				yaxes: [{
					format:  "percentunit"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    true
				}, {
					format:  "percentunit"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    true
				}]
			}, {
				aliasColors: {}
				bars:         false
				dashLength:   10
				dashes:       false
				datasource:   "$datasource"
				fill:         10
				fillGradient: 0
				gridPos: {}
				id: 9
				legend: {
					alignAsTable: false
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    false
					show:         false
					sideWidth:    null
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 1
				links: []
				nullPointMode: "null"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				repeat:        null
				seriesOverrides: []
				spaceLength: 10
				span:        6
				stack:       true
				steppedLine: false
				targets: [{
					expr: """
						(
						  instance_device:node_disk_io_time_weighted_seconds:rate5m{job="node-exporter", cluster="$cluster"}
						  / scalar(count(instance_device:node_disk_io_time_weighted_seconds:rate5m{job="node-exporter", cluster="$cluster"}))
						) != 0

						"""
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{instance}} {{device}}"
					refId:          "A"
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Disk IO Saturation"
				tooltip: {
					shared:     true
					sort:       2
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
				yaxes: [{
					format:  "percentunit"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    true
				}, {
					format:  "percentunit"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    true
				}]
			}]
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       true
			title:           "Disk IO"
			titleSize:       "h6"
			type:            "row"
		}, {
			collapse:  false
			collapsed: false
			panels: [{
				aliasColors: {}
				bars:         false
				dashLength:   10
				dashes:       false
				datasource:   "$datasource"
				fill:         10
				fillGradient: 0
				gridPos: {}
				id: 10
				legend: {
					alignAsTable: false
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    false
					show:         false
					sideWidth:    null
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 1
				links: []
				nullPointMode: "null"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				repeat:        null
				seriesOverrides: []
				spaceLength: 10
				span:        12
				stack:       true
				steppedLine: false
				targets: [{
					expr: """
						sum without (device) (
						  max without (fstype, mountpoint) ((
						    node_filesystem_size_bytes{job="node-exporter", fstype!="", cluster="$cluster"}
						    -
						    node_filesystem_avail_bytes{job="node-exporter", fstype!="", cluster="$cluster"}
						  ) != 0)
						)
						/ scalar(sum(max without (fstype, mountpoint) (node_filesystem_size_bytes{job="node-exporter", fstype!="", cluster="$cluster"})))

						"""
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{instance}}"
					refId:          "A"
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Disk Space Utilisation"
				tooltip: {
					shared:     true
					sort:       2
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
				yaxes: [{
					format:  "percentunit"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    true
				}, {
					format:  "percentunit"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    true
				}]
			}]
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       true
			title:           "Disk Space"
			titleSize:       "h6"
			type:            "row"
		}]
		schemaVersion: 14
		style:         "dark"
		tags: [
			"node-exporter-mixin",
		]
		templating: list: [{
			current: {
				text:  "Prometheus"
				value: "Prometheus"
			}
			hide:  0
			label: "Data Source"
			name:  "datasource"
			options: []
			query:   "prometheus"
			refresh: 1
			regex:   ""
			type:    "datasource"
		}, {
			allValue: null
			current: {
				text:  ""
				value: ""
			}
			datasource: "$datasource"
			hide:       2
			includeAll: false
			label:      null
			multi:      false
			name:       "cluster"
			options: []
			query:          "label_values(node_time_seconds, cluster)"
			refresh:        2
			regex:          ""
			sort:           1
			tagValuesQuery: ""
			tags: []
			tagsQuery: ""
			type:      "query"
			useTags:   false
		}]
		time: {
			from: "now-1h"
			to:   "now"
		}
		timepicker: {
			refresh_intervals: ["5s", "10s", "30s", "1m", "5m", "15m", "30m", "1h", "2h", "1d"]
			time_options: ["5m", "15m", "1h", "6h", "12h", "24h", "2d", "7d", "30d"]
		}
		timezone: "utc"
		title:    "Node Exporter / USE Method / Cluster"
		version:  0
	}
	"node-rsrc-use.json": {
		"__inputs": []
		"__requires": []
		annotations: list: []
		editable:     false
		gnetId:       null
		graphTooltip: 1
		hideControls: false
		id:           null
		links: []
		refresh: "30s"
		rows: [{
			collapse:  false
			collapsed: false
			panels: [{
				aliasColors: {}
				bars:         false
				dashLength:   10
				dashes:       false
				datasource:   "$datasource"
				fill:         10
				fillGradient: 0
				gridPos: {}
				id: 2
				legend: {
					alignAsTable: false
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    false
					show:         false
					sideWidth:    null
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 1
				links: []
				nullPointMode: "null"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				repeat:        null
				seriesOverrides: []
				spaceLength: 10
				span:        6
				stack:       true
				steppedLine: false
				targets: [{
					expr:           "instance:node_cpu_utilisation:rate5m{job=\"node-exporter\", instance=\"$instance\", cluster=\"$cluster\"} != 0"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "Utilisation"
					refId:          "A"
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "CPU Utilisation"
				tooltip: {
					shared:     true
					sort:       2
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
				yaxes: [{
					format:  "percentunit"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    true
				}, {
					format:  "percentunit"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    true
				}]
			}, {
				aliasColors: {}
				bars:         false
				dashLength:   10
				dashes:       false
				datasource:   "$datasource"
				fill:         10
				fillGradient: 0
				gridPos: {}
				id: 3
				legend: {
					alignAsTable: false
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    false
					show:         false
					sideWidth:    null
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 1
				links: []
				nullPointMode: "null"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				repeat:        null
				seriesOverrides: []
				spaceLength: 10
				span:        6
				stack:       true
				steppedLine: false
				targets: [{
					expr:           "instance:node_load1_per_cpu:ratio{job=\"node-exporter\", instance=\"$instance\", cluster=\"$cluster\"} != 0"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "Saturation"
					refId:          "A"
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "CPU Saturation (Load1 per CPU)"
				tooltip: {
					shared:     true
					sort:       2
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
				yaxes: [{
					format:  "percentunit"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    true
				}, {
					format:  "percentunit"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    true
				}]
			}]
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       true
			title:           "CPU"
			titleSize:       "h6"
			type:            "row"
		}, {
			collapse:  false
			collapsed: false
			panels: [{
				aliasColors: {}
				bars:         false
				dashLength:   10
				dashes:       false
				datasource:   "$datasource"
				fill:         10
				fillGradient: 0
				gridPos: {}
				id: 4
				legend: {
					alignAsTable: false
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    false
					show:         false
					sideWidth:    null
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 1
				links: []
				nullPointMode: "null"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				repeat:        null
				seriesOverrides: []
				spaceLength: 10
				span:        6
				stack:       true
				steppedLine: false
				targets: [{
					expr:           "instance:node_memory_utilisation:ratio{job=\"node-exporter\", instance=\"$instance\", cluster=\"$cluster\"} != 0"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "Utilisation"
					refId:          "A"
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Memory Utilisation"
				tooltip: {
					shared:     true
					sort:       2
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
				yaxes: [{
					format:  "percentunit"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    true
				}, {
					format:  "percentunit"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    true
				}]
			}, {
				aliasColors: {}
				bars:         false
				dashLength:   10
				dashes:       false
				datasource:   "$datasource"
				fill:         10
				fillGradient: 0
				gridPos: {}
				id: 5
				legend: {
					alignAsTable: false
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    false
					show:         false
					sideWidth:    null
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 1
				links: []
				nullPointMode: "null"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				repeat:        null
				seriesOverrides: []
				spaceLength: 10
				span:        6
				stack:       true
				steppedLine: false
				targets: [{
					expr:           "instance:node_vmstat_pgmajfault:rate5m{job=\"node-exporter\", instance=\"$instance\", cluster=\"$cluster\"} != 0"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "Major page Faults"
					refId:          "A"
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Memory Saturation (Major Page Faults)"
				tooltip: {
					shared:     true
					sort:       2
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
				yaxes: [{
					format:  "rds"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    true
				}, {
					format:  "rds"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    true
				}]
			}]
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       true
			title:           "Memory"
			titleSize:       "h6"
			type:            "row"
		}, {
			collapse:  false
			collapsed: false
			panels: [{
				aliasColors: {}
				bars:         false
				dashLength:   10
				dashes:       false
				datasource:   "$datasource"
				fill:         10
				fillGradient: 0
				gridPos: {}
				id: 6
				legend: {
					alignAsTable: false
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    false
					show:         false
					sideWidth:    null
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 1
				links: []
				nullPointMode: "null"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				repeat:        null
				seriesOverrides: [{
					alias: "/Receive/"
					stack: "A"
				}, {
					alias:     "/Transmit/"
					stack:     "B"
					transform: "negative-Y"
				}]
				spaceLength: 10
				span:        6
				stack:       true
				steppedLine: false
				targets: [{
					expr:           "instance:node_network_receive_bytes_excluding_lo:rate5m{job=\"node-exporter\", instance=\"$instance\", cluster=\"$cluster\"} != 0"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "Receive"
					refId:          "A"
				}, {
					expr:           "instance:node_network_transmit_bytes_excluding_lo:rate5m{job=\"node-exporter\", instance=\"$instance\", cluster=\"$cluster\"} != 0"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "Transmit"
					refId:          "B"
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Network Utilisation (Bytes Receive/Transmit)"
				tooltip: {
					shared:     true
					sort:       2
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
				yaxes: [{
					format:  "Bps"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    true
				}, {
					format:  "Bps"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    true
				}]
			}, {
				aliasColors: {}
				bars:         false
				dashLength:   10
				dashes:       false
				datasource:   "$datasource"
				fill:         10
				fillGradient: 0
				gridPos: {}
				id: 7
				legend: {
					alignAsTable: false
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    false
					show:         false
					sideWidth:    null
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 1
				links: []
				nullPointMode: "null"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				repeat:        null
				seriesOverrides: [{
					alias: "/ Receive/"
					stack: "A"
				}, {
					alias:     "/ Transmit/"
					stack:     "B"
					transform: "negative-Y"
				}]
				spaceLength: 10
				span:        6
				stack:       true
				steppedLine: false
				targets: [{
					expr:           "instance:node_network_receive_drop_excluding_lo:rate5m{job=\"node-exporter\", instance=\"$instance\", cluster=\"$cluster\"} != 0"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "Receive"
					refId:          "A"
				}, {
					expr:           "instance:node_network_transmit_drop_excluding_lo:rate5m{job=\"node-exporter\", instance=\"$instance\", cluster=\"$cluster\"} != 0"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "Transmit"
					refId:          "B"
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Network Saturation (Drops Receive/Transmit)"
				tooltip: {
					shared:     true
					sort:       2
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
				yaxes: [{
					format:  "Bps"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    true
				}, {
					format:  "Bps"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    true
				}]
			}]
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       true
			title:           "Network"
			titleSize:       "h6"
			type:            "row"
		}, {
			collapse:  false
			collapsed: false
			panels: [{
				aliasColors: {}
				bars:         false
				dashLength:   10
				dashes:       false
				datasource:   "$datasource"
				fill:         10
				fillGradient: 0
				gridPos: {}
				id: 8
				legend: {
					alignAsTable: false
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    false
					show:         false
					sideWidth:    null
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 1
				links: []
				nullPointMode: "null"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				repeat:        null
				seriesOverrides: []
				spaceLength: 10
				span:        6
				stack:       true
				steppedLine: false
				targets: [{
					expr:           "instance_device:node_disk_io_time_seconds:rate5m{job=\"node-exporter\", instance=\"$instance\", cluster=\"$cluster\"} != 0"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{device}}"
					refId:          "A"
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Disk IO Utilisation"
				tooltip: {
					shared:     true
					sort:       2
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
				yaxes: [{
					format:  "percentunit"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    true
				}, {
					format:  "percentunit"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    true
				}]
			}, {
				aliasColors: {}
				bars:         false
				dashLength:   10
				dashes:       false
				datasource:   "$datasource"
				fill:         10
				fillGradient: 0
				gridPos: {}
				id: 9
				legend: {
					alignAsTable: false
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    false
					show:         false
					sideWidth:    null
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 1
				links: []
				nullPointMode: "null"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				repeat:        null
				seriesOverrides: []
				spaceLength: 10
				span:        6
				stack:       true
				steppedLine: false
				targets: [{
					expr:           "instance_device:node_disk_io_time_weighted_seconds:rate5m{job=\"node-exporter\", instance=\"$instance\", cluster=\"$cluster\"} != 0"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{device}}"
					refId:          "A"
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Disk IO Saturation"
				tooltip: {
					shared:     true
					sort:       2
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
				yaxes: [{
					format:  "percentunit"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    true
				}, {
					format:  "percentunit"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    true
				}]
			}]
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       true
			title:           "Disk IO"
			titleSize:       "h6"
			type:            "row"
		}, {
			collapse:  false
			collapsed: false
			panels: [{
				aliasColors: {}
				bars:         false
				dashLength:   10
				dashes:       false
				datasource:   "$datasource"
				fill:         10
				fillGradient: 0
				gridPos: {}
				id: 10
				legend: {
					alignAsTable: false
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    false
					show:         false
					sideWidth:    null
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 1
				links: []
				nullPointMode: "null"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				repeat:        null
				seriesOverrides: []
				spaceLength: 10
				span:        12
				stack:       true
				steppedLine: false
				targets: [{
					expr: """
						sort_desc(1 -
						  (
						   max without (mountpoint, fstype) (node_filesystem_avail_bytes{job="node-exporter", fstype!="", instance="$instance", cluster="$cluster"})
						   /
						   max without (mountpoint, fstype) (node_filesystem_size_bytes{job="node-exporter", fstype!="", instance="$instance", cluster="$cluster"})
						  ) != 0
						)

						"""
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{device}}"
					refId:          "A"
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Disk Space Utilisation"
				tooltip: {
					shared:     true
					sort:       2
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
				yaxes: [{
					format:  "percentunit"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    true
				}, {
					format:  "percentunit"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    true
				}]
			}]
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       true
			title:           "Disk Space"
			titleSize:       "h6"
			type:            "row"
		}]
		schemaVersion: 14
		style:         "dark"
		tags: [
			"node-exporter-mixin",
		]
		templating: list: [{
			current: {
				text:  "Prometheus"
				value: "Prometheus"
			}
			hide:  0
			label: "Data Source"
			name:  "datasource"
			options: []
			query:   "prometheus"
			refresh: 1
			regex:   ""
			type:    "datasource"
		}, {
			allValue: null
			current: {
				text:  ""
				value: ""
			}
			datasource: "$datasource"
			hide:       2
			includeAll: false
			label:      null
			multi:      false
			name:       "cluster"
			options: []
			query:          "label_values(node_time_seconds, cluster)"
			refresh:        2
			regex:          ""
			sort:           1
			tagValuesQuery: ""
			tags: []
			tagsQuery: ""
			type:      "query"
			useTags:   false
		}, {
			allValue: null
			current: {}
			datasource: "$datasource"
			hide:       0
			includeAll: false
			label:      null
			multi:      false
			name:       "instance"
			options: []
			query:          "label_values(node_exporter_build_info{job=\"node-exporter\", cluster=\"$cluster\"}, instance)"
			refresh:        2
			regex:          ""
			sort:           1
			tagValuesQuery: ""
			tags: []
			tagsQuery: ""
			type:      "query"
			useTags:   false
		}]
		time: {
			from: "now-1h"
			to:   "now"
		}
		timepicker: {
			refresh_intervals: ["5s", "10s", "30s", "1m", "5m", "15m", "30m", "1h", "2h", "1d"]
			time_options: ["5m", "15m", "1h", "6h", "12h", "24h", "2d", "7d", "30d"]
		}
		timezone: "utc"
		title:    "Node Exporter / USE Method / Node"
		version:  0
	}
	"nodes.json": {
		"__inputs": []
		"__requires": []
		annotations: list: []
		editable:     false
		gnetId:       null
		graphTooltip: 1
		hideControls: false
		id:           null
		links: []
		refresh: "30s"
		rows: [{
			collapse:  false
			collapsed: false
			panels: [{
				aliasColors: {}
				bars:         false
				dashLength:   10
				dashes:       false
				datasource:   "$datasource"
				fill:         1
				fillGradient: 0
				gridPos: {}
				id: 2
				legend: {
					alignAsTable: false
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    false
					show:         true
					sideWidth:    null
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 1
				links: []
				nullPointMode: "null"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				repeat:        null
				seriesOverrides: []
				spaceLength: 10
				span:        6
				stack:       true
				steppedLine: false
				targets: [{
					expr: """
						(
						  (1 - sum without (mode) (rate(node_cpu_seconds_total{job="node-exporter", mode=~"idle|iowait|steal", instance="$instance"}[$__rate_interval])))
						/ ignoring(cpu) group_left
						  count without (cpu, mode) (node_cpu_seconds_total{job="node-exporter", mode="idle", instance="$instance"})
						)

						"""
					format:         "time_series"
					intervalFactor: 5
					legendFormat:   "{{cpu}}"
					refId:          "A"
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "CPU Usage"
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
				yaxes: [{
					format:  "percentunit"
					label:   null
					logBase: 1
					max:     1
					min:     0
					show:    true
				}, {
					format:  "percentunit"
					label:   null
					logBase: 1
					max:     1
					min:     0
					show:    true
				}]
			}, {
				aliasColors: {}
				bars:         false
				dashLength:   10
				dashes:       false
				datasource:   "$datasource"
				fill:         0
				fillGradient: 0
				gridPos: {}
				id: 3
				legend: {
					alignAsTable: false
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    false
					show:         true
					sideWidth:    null
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 1
				links: []
				nullPointMode: "null"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				repeat:        null
				seriesOverrides: []
				spaceLength: 10
				span:        6
				stack:       false
				steppedLine: false
				targets: [{
					expr:           "node_load1{job=\"node-exporter\", instance=\"$instance\"}"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "1m load average"
					refId:          "A"
				}, {
					expr:           "node_load5{job=\"node-exporter\", instance=\"$instance\"}"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "5m load average"
					refId:          "B"
				}, {
					expr:           "node_load15{job=\"node-exporter\", instance=\"$instance\"}"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "15m load average"
					refId:          "C"
				}, {
					expr:           "count(node_cpu_seconds_total{job=\"node-exporter\", instance=\"$instance\", mode=\"idle\"})"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "logical cores"
					refId:          "D"
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Load Average"
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
				yaxes: [{
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}]
			}]
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       false
			title:           "Dashboard Row"
			titleSize:       "h6"
			type:            "row"
		}, {
			collapse:  false
			collapsed: false
			panels: [{
				aliasColors: {}
				bars:         false
				dashLength:   10
				dashes:       false
				datasource:   "$datasource"
				fill:         1
				fillGradient: 0
				gridPos: {}
				id: 4
				legend: {
					alignAsTable: false
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    false
					show:         true
					sideWidth:    null
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 1
				links: []
				nullPointMode: "null"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				repeat:        null
				seriesOverrides: []
				spaceLength: 10
				span:        9
				stack:       true
				steppedLine: false
				targets: [{
					expr: """
						(
						  node_memory_MemTotal_bytes{job="node-exporter", instance="$instance"}
						-
						  node_memory_MemFree_bytes{job="node-exporter", instance="$instance"}
						-
						  node_memory_Buffers_bytes{job="node-exporter", instance="$instance"}
						-
						  node_memory_Cached_bytes{job="node-exporter", instance="$instance"}
						)

						"""
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "memory used"
					refId:          "A"
				}, {
					expr:           "node_memory_Buffers_bytes{job=\"node-exporter\", instance=\"$instance\"}"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "memory buffers"
					refId:          "B"
				}, {
					expr:           "node_memory_Cached_bytes{job=\"node-exporter\", instance=\"$instance\"}"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "memory cached"
					refId:          "C"
				}, {
					expr:           "node_memory_MemFree_bytes{job=\"node-exporter\", instance=\"$instance\"}"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "memory free"
					refId:          "D"
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Memory Usage"
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
				yaxes: [{
					format:  "bytes"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "bytes"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}]
			}, {
				cacheTimeout:    null
				colorBackground: false
				colorValue:      false
				colors: ["rgba(50, 172, 45, 0.97)", "rgba(237, 129, 40, 0.89)", "rgba(245, 54, 54, 0.9)"]
				datasource: "$datasource"
				format:     "percent"
				gauge: {
					maxValue:         100
					minValue:         0
					show:             true
					thresholdLabels:  false
					thresholdMarkers: true
				}
				gridPos: {}
				id:       5
				interval: null
				links: []
				mappingType: 1
				mappingTypes: [{
					name:  "value to text"
					value: 1
				}, {
					name:  "range to text"
					value: 2
				}]
				maxDataPoints:   100
				nullPointMode:   "connected"
				nullText:        null
				postfix:         ""
				postfixFontSize: "50%"
				prefix:          ""
				prefixFontSize:  "50%"
				rangeMaps: [{
					from: "null"
					text: "N/A"
					to:   "null"
				}]
				span: 3
				sparkline: {
					fillColor: "rgba(31, 118, 189, 0.18)"
					full:      false
					lineColor: "rgb(31, 120, 193)"
					show:      false
				}
				tableColumn: ""
				targets: [{
					expr: """
						100 -
						(
						  avg(node_memory_MemAvailable_bytes{job="node-exporter", instance="$instance"})
						/
						  avg(node_memory_MemTotal_bytes{job="node-exporter", instance="$instance"})
						* 100
						)

						"""
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   ""
					refId:          "A"
				}]
				thresholds:    "80, 90"
				title:         "Memory Usage"
				type:          "singlestat"
				valueFontSize: "80%"
				valueMaps: [{
					op:    "="
					text:  "N/A"
					value: "null"
				}]
				valueName: "current"
			}]
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       false
			title:           "Dashboard Row"
			titleSize:       "h6"
			type:            "row"
		}, {
			collapse:  false
			collapsed: false
			panels: [{
				aliasColors: {}
				bars:         false
				dashLength:   10
				dashes:       false
				datasource:   "$datasource"
				fill:         0
				fillGradient: 0
				gridPos: {}
				id: 6
				legend: {
					alignAsTable: false
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    false
					show:         true
					sideWidth:    null
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 1
				links: []
				nullPointMode: "null"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				repeat:        null
				seriesOverrides: [{
					alias: "/ read| written/"
					yaxis: 1
				}, {
					alias: "/ io time/"
					yaxis: 2
				}]
				spaceLength: 10
				span:        6
				stack:       false
				steppedLine: false
				targets: [{
					expr:           "rate(node_disk_read_bytes_total{job=\"node-exporter\", instance=\"$instance\", device=~\"mmcblk.p.+|nvme.+|rbd.+|sd.+|vd.+|xvd.+|dm-.+|dasd.+\"}[$__rate_interval])"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{device}} read"
					refId:          "A"
				}, {
					expr:           "rate(node_disk_written_bytes_total{job=\"node-exporter\", instance=\"$instance\", device=~\"mmcblk.p.+|nvme.+|rbd.+|sd.+|vd.+|xvd.+|dm-.+|dasd.+\"}[$__rate_interval])"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{device}} written"
					refId:          "B"
				}, {
					expr:           "rate(node_disk_io_time_seconds_total{job=\"node-exporter\", instance=\"$instance\", device=~\"mmcblk.p.+|nvme.+|rbd.+|sd.+|vd.+|xvd.+|dm-.+|dasd.+\"}[$__rate_interval])"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{device}} io time"
					refId:          "C"
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Disk I/O"
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
				yaxes: [{
					format:  "bytes"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    true
				}, {
					format:  "s"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    true
				}]
			}, {
				aliasColors: {}
				bars:         false
				dashLength:   10
				dashes:       false
				datasource:   "$datasource"
				fill:         1
				fillGradient: 0
				gridPos: {}
				id: 7
				legend: {
					alignAsTable: false
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    false
					show:         true
					sideWidth:    null
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 1
				links: []
				nullPointMode: "null"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				repeat:        null
				seriesOverrides: [{
					alias: "used"
					color: "#E0B400"
				}, {
					alias: "available"
					color: "#73BF69"
				}]
				spaceLength: 10
				span:        6
				stack:       true
				steppedLine: false
				targets: [{
					expr: """
						sum(
						  max by (device) (
						    node_filesystem_size_bytes{job="node-exporter", instance="$instance", fstype!=""}
						  -
						    node_filesystem_avail_bytes{job="node-exporter", instance="$instance", fstype!=""}
						  )
						)

						"""
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "used"
					refId:          "A"
				}, {
					expr: """
						sum(
						  max by (device) (
						    node_filesystem_avail_bytes{job="node-exporter", instance="$instance", fstype!=""}
						  )
						)

						"""
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "available"
					refId:          "B"
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Disk Space Usage"
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
				yaxes: [{
					format:  "bytes"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "bytes"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}]
			}]
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       false
			title:           "Dashboard Row"
			titleSize:       "h6"
			type:            "row"
		}, {
			collapse:  false
			collapsed: false
			panels: [{
				aliasColors: {}
				bars:         false
				dashLength:   10
				dashes:       false
				datasource:   "$datasource"
				fill:         0
				fillGradient: 0
				gridPos: {}
				id: 8
				legend: {
					alignAsTable: false
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    false
					show:         true
					sideWidth:    null
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 1
				links: []
				nullPointMode: "null"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				repeat:        null
				seriesOverrides: []
				spaceLength: 10
				span:        6
				stack:       false
				steppedLine: false
				targets: [{
					expr:           "rate(node_network_receive_bytes_total{job=\"node-exporter\", instance=\"$instance\", device!=\"lo\"}[$__rate_interval])"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{device}}"
					refId:          "A"
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Network Received"
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
				yaxes: [{
					format:  "bytes"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "bytes"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}]
			}, {
				aliasColors: {}
				bars:         false
				dashLength:   10
				dashes:       false
				datasource:   "$datasource"
				fill:         0
				fillGradient: 0
				gridPos: {}
				id: 9
				legend: {
					alignAsTable: false
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    false
					show:         true
					sideWidth:    null
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 1
				links: []
				nullPointMode: "null"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				repeat:        null
				seriesOverrides: []
				spaceLength: 10
				span:        6
				stack:       false
				steppedLine: false
				targets: [{
					expr:           "rate(node_network_transmit_bytes_total{job=\"node-exporter\", instance=\"$instance\", device!=\"lo\"}[$__rate_interval])"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{device}}"
					refId:          "A"
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Network Transmitted"
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
				yaxes: [{
					format:  "bytes"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "bytes"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}]
			}]
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       false
			title:           "Dashboard Row"
			titleSize:       "h6"
			type:            "row"
		}]
		schemaVersion: 14
		style:         "dark"
		tags: [
			"node-exporter-mixin",
		]
		templating: list: [{
			current: {
				text:  "Prometheus"
				value: "Prometheus"
			}
			hide:  0
			label: "Data Source"
			name:  "datasource"
			options: []
			query:   "prometheus"
			refresh: 1
			regex:   ""
			type:    "datasource"
		}, {
			allValue: null
			current: {}
			datasource: "$datasource"
			hide:       0
			includeAll: false
			label:      null
			multi:      false
			name:       "instance"
			options: []
			query:          "label_values(node_exporter_build_info{job=\"node-exporter\"}, instance)"
			refresh:        2
			regex:          ""
			sort:           0
			tagValuesQuery: ""
			tags: []
			tagsQuery: ""
			type:      "query"
			useTags:   false
		}]
		time: {
			from: "now-1h"
			to:   "now"
		}
		timepicker: {
			refresh_intervals: ["5s", "10s", "30s", "1m", "5m", "15m", "30m", "1h", "2h", "1d"]
			time_options: ["5m", "15m", "1h", "6h", "12h", "24h", "2d", "7d", "30d"]
		}
		timezone: "utc"
		title:    "Node Exporter / Nodes"
		version:  0
	}
	"persistentvolumesusage.json": {
		"__inputs": []
		"__requires": []
		annotations: list: []
		editable:     false
		gnetId:       null
		graphTooltip: 0
		hideControls: false
		id:           null
		links: []
		refresh: "10s"
		rows: [{
			collapse:  false
			collapsed: false
			panels: [{
				aliasColors: {}
				bars:         false
				dashLength:   10
				dashes:       false
				datasource:   "$datasource"
				fill:         1
				fillGradient: 0
				gridPos: {}
				id:       2
				interval: "1m"
				legend: {
					alignAsTable: true
					avg:          true
					current:      true
					max:          true
					min:          true
					rightSide:    true
					show:         true
					sideWidth:    null
					total:        false
					values:       true
				}
				lines:     true
				linewidth: 1
				links: []
				nullPointMode: "null"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				repeat:        null
				seriesOverrides: []
				spaceLength: 10
				span:        9
				stack:       true
				steppedLine: false
				targets: [{
					expr: """
						(
						  sum without(instance, node) (topk(1, (kubelet_volume_stats_capacity_bytes{cluster="$cluster", job="kubelet", metrics_path="/metrics", namespace="$namespace", persistentvolumeclaim="$volume"})))
						  -
						  sum without(instance, node) (topk(1, (kubelet_volume_stats_available_bytes{cluster="$cluster", job="kubelet", metrics_path="/metrics", namespace="$namespace", persistentvolumeclaim="$volume"})))
						)

						"""
					format:         "time_series"
					intervalFactor: 1
					legendFormat:   "Used Space"
					refId:          "A"
				}, {
					expr: """
						sum without(instance, node) (topk(1, (kubelet_volume_stats_available_bytes{cluster="$cluster", job="kubelet", metrics_path="/metrics", namespace="$namespace", persistentvolumeclaim="$volume"})))

						"""
					format:         "time_series"
					intervalFactor: 1
					legendFormat:   "Free Space"
					refId:          "B"
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Volume Space Usage"
				tooltip: {
					shared:     false
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
				yaxes: [{
					format:  "bytes"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "bytes"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}]
			}, {
				cacheTimeout:    null
				colorBackground: false
				colorValue:      false
				colors: ["rgba(50, 172, 45, 0.97)", "rgba(237, 129, 40, 0.89)", "rgba(245, 54, 54, 0.9)"]
				datasource: "$datasource"
				format:     "percent"
				gauge: {
					maxValue:         100
					minValue:         0
					show:             true
					thresholdLabels:  false
					thresholdMarkers: true
				}
				gridPos: {}
				id:       3
				interval: "1m"
				legend: {
					alignAsTable: true
					rightSide:    true
				}
				links: []
				mappingType: 1
				mappingTypes: [{
					name:  "value to text"
					value: 1
				}, {
					name:  "range to text"
					value: 2
				}]
				maxDataPoints:   100
				nullPointMode:   "connected"
				nullText:        null
				postfix:         ""
				postfixFontSize: "50%"
				prefix:          ""
				prefixFontSize:  "50%"
				rangeMaps: [{
					from: "null"
					text: "N/A"
					to:   "null"
				}]
				span: 3
				sparkline: {
					fillColor: "rgba(31, 118, 189, 0.18)"
					full:      false
					lineColor: "rgb(31, 120, 193)"
					show:      false
				}
				tableColumn: ""
				targets: [{
					expr: """
						max without(instance,node) (
						(
						  topk(1, kubelet_volume_stats_capacity_bytes{cluster="$cluster", job="kubelet", metrics_path="/metrics", namespace="$namespace", persistentvolumeclaim="$volume"})
						  -
						  topk(1, kubelet_volume_stats_available_bytes{cluster="$cluster", job="kubelet", metrics_path="/metrics", namespace="$namespace", persistentvolumeclaim="$volume"})
						)
						/
						topk(1, kubelet_volume_stats_capacity_bytes{cluster="$cluster", job="kubelet", metrics_path="/metrics", namespace="$namespace", persistentvolumeclaim="$volume"})
						* 100)

						"""
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   ""
					refId:          "A"
				}]
				thresholds: "80, 90"
				title:      "Volume Space Usage"
				tooltip: shared: false
				type:          "singlestat"
				valueFontSize: "80%"
				valueMaps: [{
					op:    "="
					text:  "N/A"
					value: "null"
				}]
				valueName: "current"
			}]
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       false
			title:           "Dashboard Row"
			titleSize:       "h6"
			type:            "row"
		}, {
			collapse:  false
			collapsed: false
			panels: [{
				aliasColors: {}
				bars:         false
				dashLength:   10
				dashes:       false
				datasource:   "$datasource"
				fill:         1
				fillGradient: 0
				gridPos: {}
				id:       4
				interval: "1m"
				legend: {
					alignAsTable: true
					avg:          true
					current:      true
					max:          true
					min:          true
					rightSide:    true
					show:         true
					sideWidth:    null
					total:        false
					values:       true
				}
				lines:     true
				linewidth: 1
				links: []
				nullPointMode: "null"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				repeat:        null
				seriesOverrides: []
				spaceLength: 10
				span:        9
				stack:       true
				steppedLine: false
				targets: [{
					expr: """
						sum without(instance, node) (topk(1, (kubelet_volume_stats_inodes_used{cluster="$cluster", job="kubelet", metrics_path="/metrics", namespace="$namespace", persistentvolumeclaim="$volume"})))

						"""
					format:         "time_series"
					intervalFactor: 1
					legendFormat:   "Used inodes"
					refId:          "A"
				}, {
					expr: """
						(
						  sum without(instance, node) (topk(1, (kubelet_volume_stats_inodes{cluster="$cluster", job="kubelet", metrics_path="/metrics", namespace="$namespace", persistentvolumeclaim="$volume"})))
						  -
						  sum without(instance, node) (topk(1, (kubelet_volume_stats_inodes_used{cluster="$cluster", job="kubelet", metrics_path="/metrics", namespace="$namespace", persistentvolumeclaim="$volume"})))
						)

						"""
					format:         "time_series"
					intervalFactor: 1
					legendFormat:   " Free inodes"
					refId:          "B"
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Volume inodes Usage"
				tooltip: {
					shared:     false
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
				yaxes: [{
					format:  "none"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "none"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}]
			}, {
				cacheTimeout:    null
				colorBackground: false
				colorValue:      false
				colors: ["rgba(50, 172, 45, 0.97)", "rgba(237, 129, 40, 0.89)", "rgba(245, 54, 54, 0.9)"]
				datasource: "$datasource"
				format:     "percent"
				gauge: {
					maxValue:         100
					minValue:         0
					show:             true
					thresholdLabels:  false
					thresholdMarkers: true
				}
				gridPos: {}
				id:       5
				interval: "1m"
				legend: {
					alignAsTable: true
					rightSide:    true
				}
				links: []
				mappingType: 1
				mappingTypes: [{
					name:  "value to text"
					value: 1
				}, {
					name:  "range to text"
					value: 2
				}]
				maxDataPoints:   100
				nullPointMode:   "connected"
				nullText:        null
				postfix:         ""
				postfixFontSize: "50%"
				prefix:          ""
				prefixFontSize:  "50%"
				rangeMaps: [{
					from: "null"
					text: "N/A"
					to:   "null"
				}]
				span: 3
				sparkline: {
					fillColor: "rgba(31, 118, 189, 0.18)"
					full:      false
					lineColor: "rgb(31, 120, 193)"
					show:      false
				}
				tableColumn: ""
				targets: [{
					expr: """
						max without(instance,node) (
						topk(1, kubelet_volume_stats_inodes_used{cluster="$cluster", job="kubelet", metrics_path="/metrics", namespace="$namespace", persistentvolumeclaim="$volume"})
						/
						topk(1, kubelet_volume_stats_inodes{cluster="$cluster", job="kubelet", metrics_path="/metrics", namespace="$namespace", persistentvolumeclaim="$volume"})
						* 100)

						"""
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   ""
					refId:          "A"
				}]
				thresholds: "80, 90"
				title:      "Volume inodes Usage"
				tooltip: shared: false
				type:          "singlestat"
				valueFontSize: "80%"
				valueMaps: [{
					op:    "="
					text:  "N/A"
					value: "null"
				}]
				valueName: "current"
			}]
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       false
			title:           "Dashboard Row"
			titleSize:       "h6"
			type:            "row"
		}]
		schemaVersion: 14
		style:         "dark"
		tags: [
			"kubernetes-mixin",
		]
		templating: list: [{
			current: {
				text:  "default"
				value: "default"
			}
			hide:  0
			label: "Data Source"
			name:  "datasource"
			options: []
			query:   "prometheus"
			refresh: 1
			regex:   ""
			type:    "datasource"
		}, {
			allValue: null
			current: {}
			datasource: "$datasource"
			hide:       2
			includeAll: false
			label:      "cluster"
			multi:      false
			name:       "cluster"
			options: []
			query:          "label_values(kubelet_volume_stats_capacity_bytes{job=\"kubelet\", metrics_path=\"/metrics\"}, cluster)"
			refresh:        2
			regex:          ""
			sort:           1
			tagValuesQuery: ""
			tags: []
			tagsQuery: ""
			type:      "query"
			useTags:   false
		}, {
			allValue: null
			current: {}
			datasource: "$datasource"
			hide:       0
			includeAll: false
			label:      "Namespace"
			multi:      false
			name:       "namespace"
			options: []
			query:          "label_values(kubelet_volume_stats_capacity_bytes{cluster=\"$cluster\", job=\"kubelet\", metrics_path=\"/metrics\"}, namespace)"
			refresh:        2
			regex:          ""
			sort:           1
			tagValuesQuery: ""
			tags: []
			tagsQuery: ""
			type:      "query"
			useTags:   false
		}, {
			allValue: null
			current: {}
			datasource: "$datasource"
			hide:       0
			includeAll: false
			label:      "PersistentVolumeClaim"
			multi:      false
			name:       "volume"
			options: []
			query:          "label_values(kubelet_volume_stats_capacity_bytes{cluster=\"$cluster\", job=\"kubelet\", metrics_path=\"/metrics\", namespace=\"$namespace\"}, persistentvolumeclaim)"
			refresh:        2
			regex:          ""
			sort:           1
			tagValuesQuery: ""
			tags: []
			tagsQuery: ""
			type:      "query"
			useTags:   false
		}]
		time: {
			from: "now-7d"
			to:   "now"
		}
		timepicker: {
			refresh_intervals: ["5s", "10s", "30s", "1m", "5m", "15m", "30m", "1h", "2h", "1d"]
			time_options: ["5m", "15m", "1h", "6h", "12h", "24h", "2d", "7d", "30d"]
		}
		timezone: "UTC"
		title:    "Kubernetes / Persistent Volumes"
		uid:      "919b92a8e8041bd567af9edab12c840c"
		version:  0
	}
	"pod-total.json": {
		"__inputs": []
		"__requires": []
		annotations: list: [{
			builtIn:    1
			datasource: "-- Grafana --"
			enable:     true
			hide:       true
			iconColor:  "rgba(0, 211, 255, 1)"
			name:       "Annotations & Alerts"
			type:       "dashboard"
		}]
		editable:     true
		gnetId:       null
		graphTooltip: 0
		hideControls: false
		id:           null
		links: []
		panels: [{
			collapse:  false
			collapsed: false
			gridPos: {
				h: 1
				w: 24
				x: 0
				y: 0
			}
			id: 2
			panels: []
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       true
			title:           "Current Bandwidth"
			titleSize:       "h6"
			type:            "row"
		}, {
			cacheTimeout:    null
			colorBackground: false
			colorValue:      false
			colors: ["#299c46", "rgba(237, 129, 40, 0.89)", "#d44a3a"]
			datasource: "$datasource"
			decimals:   0
			format:     "time_series"
			gauge: {
				maxValue:         100
				minValue:         0
				show:             false
				thresholdLabels:  false
				thresholdMarkers: true
			}
			gridPos: {
				h: 9
				w: 12
				x: 0
				y: 1
			}
			height:   9
			id:       3
			interval: null
			links: []
			mappingType: 1
			mappingTypes: [{
				name:  "value to text"
				value: 1
			}, {
				name:  "range to text"
				value: 2
			}]
			maxDataPoints: 100
			minSpan:       12
			nullPointMode: "connected"
			nullText:      null
			options: fieldOptions: {
				calcs: ["last"]
				defaults: {
					max:   10000000000
					min:   0
					title: "$namespace: $pod"
					unit:  "Bps"
				}
				mappings: []
				override: {}
				thresholds: [{
					color: "dark-green"
					index: 0
					value: null
				}, {
					color: "dark-yellow"
					index: 1
					value: 5000000000
				}, {
					color: "dark-red"
					index: 2
					value: 7000000000
				}]
				values: false
			}
			postfix:         ""
			postfixFontSize: "50%"
			prefix:          ""
			prefixFontSize:  "50%"
			rangeMaps: [{
				from: "null"
				text: "N/A"
				to:   "null"
			}]
			span: 12
			sparkline: {
				fillColor: "rgba(31, 118, 189, 0.18)"
				full:      false
				lineColor: "rgb(31, 120, 193)"
				show:      false
			}
			tableColumn: ""
			targets: [{
				expr:           "sum(irate(container_network_receive_bytes_total{cluster=\"$cluster\",namespace=~\"$namespace\", pod=~\"$pod\"}[$interval:$resolution]))"
				format:         "time_series"
				instant:        null
				intervalFactor: 1
				legendFormat:   ""
				refId:          "A"
			}]
			thresholds:    ""
			timeFrom:      null
			timeShift:     null
			title:         "Current Rate of Bytes Received"
			type:          "gauge"
			valueFontSize: "80%"
			valueMaps: [{
				op:    "="
				text:  "N/A"
				value: "null"
			}]
			valueName: "current"
		}, {
			cacheTimeout:    null
			colorBackground: false
			colorValue:      false
			colors: ["#299c46", "rgba(237, 129, 40, 0.89)", "#d44a3a"]
			datasource: "$datasource"
			decimals:   0
			format:     "time_series"
			gauge: {
				maxValue:         100
				minValue:         0
				show:             false
				thresholdLabels:  false
				thresholdMarkers: true
			}
			gridPos: {
				h: 9
				w: 12
				x: 12
				y: 1
			}
			height:   9
			id:       4
			interval: null
			links: []
			mappingType: 1
			mappingTypes: [{
				name:  "value to text"
				value: 1
			}, {
				name:  "range to text"
				value: 2
			}]
			maxDataPoints: 100
			minSpan:       12
			nullPointMode: "connected"
			nullText:      null
			options: fieldOptions: {
				calcs: ["last"]
				defaults: {
					max:   10000000000
					min:   0
					title: "$namespace: $pod"
					unit:  "Bps"
				}
				mappings: []
				override: {}
				thresholds: [{
					color: "dark-green"
					index: 0
					value: null
				}, {
					color: "dark-yellow"
					index: 1
					value: 5000000000
				}, {
					color: "dark-red"
					index: 2
					value: 7000000000
				}]
				values: false
			}
			postfix:         ""
			postfixFontSize: "50%"
			prefix:          ""
			prefixFontSize:  "50%"
			rangeMaps: [{
				from: "null"
				text: "N/A"
				to:   "null"
			}]
			span: 12
			sparkline: {
				fillColor: "rgba(31, 118, 189, 0.18)"
				full:      false
				lineColor: "rgb(31, 120, 193)"
				show:      false
			}
			tableColumn: ""
			targets: [{
				expr:           "sum(irate(container_network_transmit_bytes_total{cluster=\"$cluster\",namespace=~\"$namespace\", pod=~\"$pod\"}[$interval:$resolution]))"
				format:         "time_series"
				instant:        null
				intervalFactor: 1
				legendFormat:   ""
				refId:          "A"
			}]
			thresholds:    ""
			timeFrom:      null
			timeShift:     null
			title:         "Current Rate of Bytes Transmitted"
			type:          "gauge"
			valueFontSize: "80%"
			valueMaps: [{
				op:    "="
				text:  "N/A"
				value: "null"
			}]
			valueName: "current"
		}, {
			collapse:  false
			collapsed: false
			gridPos: {
				h: 1
				w: 24
				x: 0
				y: 10
			}
			id: 5
			panels: []
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       true
			title:           "Bandwidth"
			titleSize:       "h6"
			type:            "row"
		}, {
			aliasColors: {}
			bars:         false
			dashLength:   10
			dashes:       false
			datasource:   "$datasource"
			fill:         2
			fillGradient: 0
			gridPos: {
				h: 9
				w: 12
				x: 0
				y: 11
			}
			id: 6
			legend: {
				alignAsTable: false
				avg:          false
				current:      false
				hideEmpty:    true
				hideZero:     true
				max:          false
				min:          false
				rightSide:    false
				show:         true
				sideWidth:    null
				total:        false
				values:       false
			}
			lines:     true
			linewidth: 2
			links: []
			minSpan:       12
			nullPointMode: "connected"
			paceLength:    10
			percentage:    false
			pointradius:   5
			points:        false
			renderer:      "flot"
			repeat:        null
			seriesOverrides: []
			spaceLength: 10
			span:        12
			stack:       true
			steppedLine: false
			targets: [{
				expr:           "sum(irate(container_network_receive_bytes_total{cluster=\"$cluster\",namespace=~\"$namespace\", pod=~\"$pod\"}[$interval:$resolution])) by (pod)"
				format:         "time_series"
				intervalFactor: 1
				legendFormat:   "{{pod}}"
				refId:          "A"
				step:           10
			}]
			thresholds: []
			timeFrom:  null
			timeShift: null
			title:     "Receive Bandwidth"
			tooltip: {
				shared:     true
				sort:       2
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
			yaxes: [{
				format:  "Bps"
				label:   null
				logBase: 1
				max:     null
				min:     0
				show:    true
			}, {
				format:  "Bps"
				label:   null
				logBase: 1
				max:     null
				min:     0
				show:    true
			}]
		}, {
			aliasColors: {}
			bars:         false
			dashLength:   10
			dashes:       false
			datasource:   "$datasource"
			fill:         2
			fillGradient: 0
			gridPos: {
				h: 9
				w: 12
				x: 12
				y: 11
			}
			id: 7
			legend: {
				alignAsTable: false
				avg:          false
				current:      false
				hideEmpty:    true
				hideZero:     true
				max:          false
				min:          false
				rightSide:    false
				show:         true
				sideWidth:    null
				total:        false
				values:       false
			}
			lines:     true
			linewidth: 2
			links: []
			minSpan:       12
			nullPointMode: "connected"
			paceLength:    10
			percentage:    false
			pointradius:   5
			points:        false
			renderer:      "flot"
			repeat:        null
			seriesOverrides: []
			spaceLength: 10
			span:        12
			stack:       true
			steppedLine: false
			targets: [{
				expr:           "sum(irate(container_network_transmit_bytes_total{cluster=\"$cluster\",namespace=~\"$namespace\", pod=~\"$pod\"}[$interval:$resolution])) by (pod)"
				format:         "time_series"
				intervalFactor: 1
				legendFormat:   "{{pod}}"
				refId:          "A"
				step:           10
			}]
			thresholds: []
			timeFrom:  null
			timeShift: null
			title:     "Transmit Bandwidth"
			tooltip: {
				shared:     true
				sort:       2
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
			yaxes: [{
				format:  "Bps"
				label:   null
				logBase: 1
				max:     null
				min:     0
				show:    true
			}, {
				format:  "Bps"
				label:   null
				logBase: 1
				max:     null
				min:     0
				show:    true
			}]
		}, {
			collapse:  true
			collapsed: true
			gridPos: {
				h: 1
				w: 24
				x: 0
				y: 20
			}
			id: 8
			panels: [{
				aliasColors: {}
				bars:         false
				dashLength:   10
				dashes:       false
				datasource:   "$datasource"
				fill:         2
				fillGradient: 0
				gridPos: {
					h: 10
					w: 12
					x: 0
					y: 21
				}
				id: 9
				legend: {
					alignAsTable: false
					avg:          false
					current:      false
					hideEmpty:    true
					hideZero:     true
					max:          false
					min:          false
					rightSide:    false
					show:         true
					sideWidth:    null
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 2
				links: []
				minSpan:       12
				nullPointMode: "connected"
				paceLength:    10
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				repeat:        null
				seriesOverrides: []
				spaceLength: 10
				span:        12
				stack:       true
				steppedLine: false
				targets: [{
					expr:           "sum(irate(container_network_receive_packets_total{cluster=\"$cluster\",namespace=~\"$namespace\", pod=~\"$pod\"}[$interval:$resolution])) by (pod)"
					format:         "time_series"
					intervalFactor: 1
					legendFormat:   "{{pod}}"
					refId:          "A"
					step:           10
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Rate of Received Packets"
				tooltip: {
					shared:     true
					sort:       2
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
				yaxes: [{
					format:  "pps"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "pps"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}]
			}, {
				aliasColors: {}
				bars:         false
				dashLength:   10
				dashes:       false
				datasource:   "$datasource"
				fill:         2
				fillGradient: 0
				gridPos: {
					h: 10
					w: 12
					x: 12
					y: 21
				}
				id: 10
				legend: {
					alignAsTable: false
					avg:          false
					current:      false
					hideEmpty:    true
					hideZero:     true
					max:          false
					min:          false
					rightSide:    false
					show:         true
					sideWidth:    null
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 2
				links: []
				minSpan:       12
				nullPointMode: "connected"
				paceLength:    10
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				repeat:        null
				seriesOverrides: []
				spaceLength: 10
				span:        12
				stack:       true
				steppedLine: false
				targets: [{
					expr:           "sum(irate(container_network_transmit_packets_total{cluster=\"$cluster\",namespace=~\"$namespace\", pod=~\"$pod\"}[$interval:$resolution])) by (pod)"
					format:         "time_series"
					intervalFactor: 1
					legendFormat:   "{{pod}}"
					refId:          "A"
					step:           10
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Rate of Transmitted Packets"
				tooltip: {
					shared:     true
					sort:       2
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
				yaxes: [{
					format:  "pps"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "pps"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}]
			}]
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       true
			title:           "Packets"
			titleSize:       "h6"
			type:            "row"
		}, {
			collapse:  true
			collapsed: true
			gridPos: {
				h: 1
				w: 24
				x: 0
				y: 21
			}
			id: 11
			panels: [{
				aliasColors: {}
				bars:         false
				dashLength:   10
				dashes:       false
				datasource:   "$datasource"
				fill:         2
				fillGradient: 0
				gridPos: {
					h: 10
					w: 12
					x: 0
					y: 32
				}
				id: 12
				legend: {
					alignAsTable: false
					avg:          false
					current:      false
					hideEmpty:    true
					hideZero:     true
					max:          false
					min:          false
					rightSide:    false
					show:         true
					sideWidth:    null
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 2
				links: []
				minSpan:       12
				nullPointMode: "connected"
				paceLength:    10
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				repeat:        null
				seriesOverrides: []
				spaceLength: 10
				span:        12
				stack:       true
				steppedLine: false
				targets: [{
					expr:           "sum(irate(container_network_receive_packets_dropped_total{cluster=\"$cluster\",namespace=~\"$namespace\", pod=~\"$pod\"}[$interval:$resolution])) by (pod)"
					format:         "time_series"
					intervalFactor: 1
					legendFormat:   "{{pod}}"
					refId:          "A"
					step:           10
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Rate of Received Packets Dropped"
				tooltip: {
					shared:     true
					sort:       2
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
				yaxes: [{
					format:  "pps"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "pps"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}]
			}, {
				aliasColors: {}
				bars:         false
				dashLength:   10
				dashes:       false
				datasource:   "$datasource"
				fill:         2
				fillGradient: 0
				gridPos: {
					h: 10
					w: 12
					x: 12
					y: 32
				}
				id: 13
				legend: {
					alignAsTable: false
					avg:          false
					current:      false
					hideEmpty:    true
					hideZero:     true
					max:          false
					min:          false
					rightSide:    false
					show:         true
					sideWidth:    null
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 2
				links: []
				minSpan:       12
				nullPointMode: "connected"
				paceLength:    10
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				repeat:        null
				seriesOverrides: []
				spaceLength: 10
				span:        12
				stack:       true
				steppedLine: false
				targets: [{
					expr:           "sum(irate(container_network_transmit_packets_dropped_total{cluster=\"$cluster\",namespace=~\"$namespace\", pod=~\"$pod\"}[$interval:$resolution])) by (pod)"
					format:         "time_series"
					intervalFactor: 1
					legendFormat:   "{{pod}}"
					refId:          "A"
					step:           10
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Rate of Transmitted Packets Dropped"
				tooltip: {
					shared:     true
					sort:       2
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
				yaxes: [{
					format:  "pps"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "pps"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}]
			}]
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       true
			title:           "Errors"
			titleSize:       "h6"
			type:            "row"
		}]
		refresh: "10s"
		rows: []
		schemaVersion: 18
		style:         "dark"
		tags: [
			"kubernetes-mixin",
		]
		templating: list: [{
			current: {
				text:  "default"
				value: "default"
			}
			hide:  0
			label: "Data Source"
			name:  "datasource"
			options: []
			query:   "prometheus"
			refresh: 1
			regex:   ""
			type:    "datasource"
		}, {
			allValue: null
			current: {}
			datasource: "$datasource"
			hide:       2
			includeAll: false
			label:      null
			multi:      false
			name:       "cluster"
			options: []
			query:          "label_values(up{job=\"kubelet\", metrics_path=\"/metrics/cadvisor\"}, cluster)"
			refresh:        2
			regex:          ""
			sort:           0
			tagValuesQuery: ""
			tags: []
			tagsQuery: ""
			type:      "query"
			useTags:   false
		}, {
			allValue:   ".+"
			auto:       false
			auto_count: 30
			auto_min:   "10s"
			current: {
				text:  "kube-system"
				value: "kube-system"
			}
			datasource: "$datasource"
			definition: "label_values(container_network_receive_packets_total{cluster=\"$cluster\"}, namespace)"
			hide:       0
			includeAll: true
			label:      null
			multi:      false
			name:       "namespace"
			options: []
			query:          "label_values(container_network_receive_packets_total{cluster=\"$cluster\"}, namespace)"
			refresh:        2
			regex:          ""
			skipUrlSync:    false
			sort:           1
			tagValuesQuery: ""
			tags: []
			tagsQuery: ""
			type:      "query"
			useTags:   false
		}, {
			allValue:   ".+"
			auto:       false
			auto_count: 30
			auto_min:   "10s"
			current: {
				text:  ""
				value: ""
			}
			datasource: "$datasource"
			definition: "label_values(container_network_receive_packets_total{cluster=\"$cluster\",namespace=~\"$namespace\"}, pod)"
			hide:       0
			includeAll: false
			label:      null
			multi:      false
			name:       "pod"
			options: []
			query:          "label_values(container_network_receive_packets_total{cluster=\"$cluster\",namespace=~\"$namespace\"}, pod)"
			refresh:        2
			regex:          ""
			skipUrlSync:    false
			sort:           1
			tagValuesQuery: ""
			tags: []
			tagsQuery: ""
			type:      "query"
			useTags:   false
		}, {
			allValue:   null
			auto:       false
			auto_count: 30
			auto_min:   "10s"
			current: {
				text:  "5m"
				value: "5m"
			}
			datasource: "$datasource"
			hide:       0
			includeAll: false
			label:      null
			multi:      false
			name:       "resolution"
			options: [{
				selected: false
				text:     "30s"
				value:    "30s"
			}, {
				selected: true
				text:     "5m"
				value:    "5m"
			}, {
				selected: false
				text:     "1h"
				value:    "1h"
			}]
			query:          "30s,5m,1h"
			refresh:        2
			regex:          ""
			skipUrlSync:    false
			sort:           1
			tagValuesQuery: ""
			tags: []
			tagsQuery: ""
			type:      "interval"
			useTags:   false
		}, {
			allValue:   null
			auto:       false
			auto_count: 30
			auto_min:   "10s"
			current: {
				text:  "5m"
				value: "5m"
			}
			datasource: "$datasource"
			hide:       2
			includeAll: false
			label:      null
			multi:      false
			name:       "interval"
			options: [{
				selected: true
				text:     "4h"
				value:    "4h"
			}]
			query:          "4h"
			refresh:        2
			regex:          ""
			skipUrlSync:    false
			sort:           1
			tagValuesQuery: ""
			tags: []
			tagsQuery: ""
			type:      "interval"
			useTags:   false
		}]
		time: {
			from: "now-1h"
			to:   "now"
		}
		timepicker: {
			refresh_intervals: ["5s", "10s", "30s", "1m", "5m", "15m", "30m", "1h", "2h", "1d"]
			time_options: ["5m", "15m", "1h", "6h", "12h", "24h", "2d", "7d", "30d"]
		}
		timezone: "UTC"
		title:    "Kubernetes / Networking / Pod"
		uid:      "7a18067ce943a40ae25454675c19ff5c"
		version:  0
	}
	"proxy.json": {
		"__inputs": []
		"__requires": []
		annotations: list: []
		editable:     false
		gnetId:       null
		graphTooltip: 0
		hideControls: false
		id:           null
		links: []
		refresh: "10s"
		rows: [{
			collapse:  false
			collapsed: false
			panels: [{
				cacheTimeout:    null
				colorBackground: false
				colorValue:      false
				colors: ["#299c46", "rgba(237, 129, 40, 0.89)", "#d44a3a"]
				datasource: "$datasource"
				format:     "none"
				gauge: {
					maxValue:         100
					minValue:         0
					show:             false
					thresholdLabels:  false
					thresholdMarkers: true
				}
				gridPos: {}
				id:       2
				interval: "1m"
				legend: {
					alignAsTable: true
					rightSide:    true
				}
				links: []
				mappingType: 1
				mappingTypes: [{
					name:  "value to text"
					value: 1
				}, {
					name:  "range to text"
					value: 2
				}]
				maxDataPoints:   100
				nullPointMode:   "connected"
				nullText:        null
				postfix:         ""
				postfixFontSize: "50%"
				prefix:          ""
				prefixFontSize:  "50%"
				rangeMaps: [{
					from: "null"
					text: "N/A"
					to:   "null"
				}]
				span: 2
				sparkline: {
					fillColor: "rgba(31, 118, 189, 0.18)"
					full:      false
					lineColor: "rgb(31, 120, 193)"
					show:      false
				}
				tableColumn: ""
				targets: [{
					expr:           "sum(up{cluster=\"$cluster\", job=\"kube-proxy\"})"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   ""
					refId:          "A"
				}]
				thresholds: ""
				title:      "Up"
				tooltip: shared: false
				type:          "singlestat"
				valueFontSize: "80%"
				valueMaps: [{
					op:    "="
					text:  "N/A"
					value: "null"
				}]
				valueName: "min"
			}, {
				aliasColors: {}
				bars:         false
				dashLength:   10
				dashes:       false
				datasource:   "$datasource"
				fill:         1
				fillGradient: 0
				gridPos: {}
				id:       3
				interval: "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					sideWidth:    null
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 1
				links: []
				nullPointMode: "null"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				repeat:        null
				seriesOverrides: []
				spaceLength: 10
				span:        5
				stack:       false
				steppedLine: false
				targets: [{
					expr:           "sum(rate(kubeproxy_sync_proxy_rules_duration_seconds_count{cluster=\"$cluster\", job=\"kube-proxy\", instance=~\"$instance\"}[$__rate_interval]))"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "rate"
					refId:          "A"
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Rules Sync Rate"
				tooltip: {
					shared:     false
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
				yaxes: [{
					format:  "ops"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "ops"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}]
			}, {
				aliasColors: {}
				bars:         false
				dashLength:   10
				dashes:       false
				datasource:   "$datasource"
				fill:         1
				fillGradient: 0
				gridPos: {}
				id:       4
				interval: "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      true
					max:          false
					min:          false
					rightSide:    true
					show:         true
					sideWidth:    null
					total:        false
					values:       true
				}
				lines:     true
				linewidth: 1
				links: []
				nullPointMode: "null"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				repeat:        null
				seriesOverrides: []
				spaceLength: 10
				span:        5
				stack:       false
				steppedLine: false
				targets: [{
					expr:           "histogram_quantile(0.99,rate(kubeproxy_sync_proxy_rules_duration_seconds_bucket{cluster=\"$cluster\", job=\"kube-proxy\", instance=~\"$instance\"}[$__rate_interval]))"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{instance}}"
					refId:          "A"
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Rule Sync Latency 99th Quantile"
				tooltip: {
					shared:     false
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
				yaxes: [{
					format:  "s"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "s"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}]
			}]
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       false
			title:           "Dashboard Row"
			titleSize:       "h6"
			type:            "row"
		}, {
			collapse:  false
			collapsed: false
			panels: [{
				aliasColors: {}
				bars:         false
				dashLength:   10
				dashes:       false
				datasource:   "$datasource"
				fill:         1
				fillGradient: 0
				gridPos: {}
				id:       5
				interval: "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					sideWidth:    null
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 1
				links: []
				nullPointMode: "null"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				repeat:        null
				seriesOverrides: []
				spaceLength: 10
				span:        6
				stack:       false
				steppedLine: false
				targets: [{
					expr:           "sum(rate(kubeproxy_network_programming_duration_seconds_count{cluster=\"$cluster\", job=\"kube-proxy\", instance=~\"$instance\"}[$__rate_interval]))"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "rate"
					refId:          "A"
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Network Programming Rate"
				tooltip: {
					shared:     false
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
				yaxes: [{
					format:  "ops"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "ops"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}]
			}, {
				aliasColors: {}
				bars:         false
				dashLength:   10
				dashes:       false
				datasource:   "$datasource"
				fill:         1
				fillGradient: 0
				gridPos: {}
				id:       6
				interval: "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      true
					max:          false
					min:          false
					rightSide:    true
					show:         true
					sideWidth:    null
					total:        false
					values:       true
				}
				lines:     true
				linewidth: 1
				links: []
				nullPointMode: "null"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				repeat:        null
				seriesOverrides: []
				spaceLength: 10
				span:        6
				stack:       false
				steppedLine: false
				targets: [{
					expr:           "histogram_quantile(0.99, sum(rate(kubeproxy_network_programming_duration_seconds_bucket{cluster=\"$cluster\", job=\"kube-proxy\", instance=~\"$instance\"}[$__rate_interval])) by (instance, le))"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{instance}}"
					refId:          "A"
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Network Programming Latency 99th Quantile"
				tooltip: {
					shared:     false
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
				yaxes: [{
					format:  "s"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "s"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}]
			}]
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       false
			title:           "Dashboard Row"
			titleSize:       "h6"
			type:            "row"
		}, {
			collapse:  false
			collapsed: false
			panels: [{
				aliasColors: {}
				bars:         false
				dashLength:   10
				dashes:       false
				datasource:   "$datasource"
				fill:         1
				fillGradient: 0
				gridPos: {}
				id:       7
				interval: "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					sideWidth:    null
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 1
				links: []
				nullPointMode: "null"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				repeat:        null
				seriesOverrides: []
				spaceLength: 10
				span:        4
				stack:       false
				steppedLine: false
				targets: [{
					expr:           "sum(rate(rest_client_requests_total{cluster=\"$cluster\", job=\"kube-proxy\", instance=~\"$instance\",code=~\"2..\"}[$__rate_interval]))"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "2xx"
					refId:          "A"
				}, {
					expr:           "sum(rate(rest_client_requests_total{cluster=\"$cluster\", job=\"kube-proxy\", instance=~\"$instance\",code=~\"3..\"}[$__rate_interval]))"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "3xx"
					refId:          "B"
				}, {
					expr:           "sum(rate(rest_client_requests_total{cluster=\"$cluster\", job=\"kube-proxy\", instance=~\"$instance\",code=~\"4..\"}[$__rate_interval]))"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "4xx"
					refId:          "C"
				}, {
					expr:           "sum(rate(rest_client_requests_total{cluster=\"$cluster\", job=\"kube-proxy\", instance=~\"$instance\",code=~\"5..\"}[$__rate_interval]))"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "5xx"
					refId:          "D"
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Kube API Request Rate"
				tooltip: {
					shared:     false
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
				yaxes: [{
					format:  "ops"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    true
				}, {
					format:  "ops"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    true
				}]
			}, {
				aliasColors: {}
				bars:         false
				dashLength:   10
				dashes:       false
				datasource:   "$datasource"
				fill:         1
				fillGradient: 0
				gridPos: {}
				id:       8
				interval: "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					sideWidth:    null
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 1
				links: []
				nullPointMode: "null"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				repeat:        null
				seriesOverrides: []
				spaceLength: 10
				span:        8
				stack:       false
				steppedLine: false
				targets: [{
					expr:           "histogram_quantile(0.99, sum(rate(rest_client_request_duration_seconds_bucket{cluster=\"$cluster\", job=\"kube-proxy\",instance=~\"$instance\",verb=\"POST\"}[$__rate_interval])) by (verb, url, le))"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{verb}} {{url}}"
					refId:          "A"
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Post Request Latency 99th Quantile"
				tooltip: {
					shared:     false
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
				yaxes: [{
					format:  "s"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "s"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}]
			}]
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       false
			title:           "Dashboard Row"
			titleSize:       "h6"
			type:            "row"
		}, {
			collapse:  false
			collapsed: false
			panels: [{
				aliasColors: {}
				bars:         false
				dashLength:   10
				dashes:       false
				datasource:   "$datasource"
				fill:         1
				fillGradient: 0
				gridPos: {}
				id:       9
				interval: "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      true
					max:          false
					min:          false
					rightSide:    true
					show:         true
					sideWidth:    null
					total:        false
					values:       true
				}
				lines:     true
				linewidth: 1
				links: []
				nullPointMode: "null"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				repeat:        null
				seriesOverrides: []
				spaceLength: 10
				span:        12
				stack:       false
				steppedLine: false
				targets: [{
					expr:           "histogram_quantile(0.99, sum(rate(rest_client_request_duration_seconds_bucket{cluster=\"$cluster\", job=\"kube-proxy\", instance=~\"$instance\", verb=\"GET\"}[$__rate_interval])) by (verb, url, le))"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{verb}} {{url}}"
					refId:          "A"
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Get Request Latency 99th Quantile"
				tooltip: {
					shared:     false
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
				yaxes: [{
					format:  "s"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "s"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}]
			}]
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       false
			title:           "Dashboard Row"
			titleSize:       "h6"
			type:            "row"
		}, {
			collapse:  false
			collapsed: false
			panels: [{
				aliasColors: {}
				bars:         false
				dashLength:   10
				dashes:       false
				datasource:   "$datasource"
				fill:         1
				fillGradient: 0
				gridPos: {}
				id:       10
				interval: "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					sideWidth:    null
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 1
				links: []
				nullPointMode: "null"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				repeat:        null
				seriesOverrides: []
				spaceLength: 10
				span:        4
				stack:       false
				steppedLine: false
				targets: [{
					expr:           "process_resident_memory_bytes{cluster=\"$cluster\", job=\"kube-proxy\",instance=~\"$instance\"}"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{instance}}"
					refId:          "A"
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Memory"
				tooltip: {
					shared:     false
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
				yaxes: [{
					format:  "bytes"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    true
				}, {
					format:  "bytes"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    true
				}]
			}, {
				aliasColors: {}
				bars:         false
				dashLength:   10
				dashes:       false
				datasource:   "$datasource"
				fill:         1
				fillGradient: 0
				gridPos: {}
				id:       11
				interval: "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					sideWidth:    null
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 1
				links: []
				nullPointMode: "null"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				repeat:        null
				seriesOverrides: []
				spaceLength: 10
				span:        4
				stack:       false
				steppedLine: false
				targets: [{
					expr:           "rate(process_cpu_seconds_total{cluster=\"$cluster\", job=\"kube-proxy\",instance=~\"$instance\"}[$__rate_interval])"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{instance}}"
					refId:          "A"
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "CPU usage"
				tooltip: {
					shared:     false
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
				yaxes: [{
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}]
			}, {
				aliasColors: {}
				bars:         false
				dashLength:   10
				dashes:       false
				datasource:   "$datasource"
				fill:         1
				fillGradient: 0
				gridPos: {}
				id:       12
				interval: "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					sideWidth:    null
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 1
				links: []
				nullPointMode: "null"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				repeat:        null
				seriesOverrides: []
				spaceLength: 10
				span:        4
				stack:       false
				steppedLine: false
				targets: [{
					expr:           "go_goroutines{cluster=\"$cluster\", job=\"kube-proxy\",instance=~\"$instance\"}"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{instance}}"
					refId:          "A"
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Goroutines"
				tooltip: {
					shared:     false
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
				yaxes: [{
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    true
				}, {
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    true
				}]
			}]
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       false
			title:           "Dashboard Row"
			titleSize:       "h6"
			type:            "row"
		}]
		schemaVersion: 14
		style:         "dark"
		tags: [
			"kubernetes-mixin",
		]
		templating: list: [{
			current: {
				text:  "default"
				value: "default"
			}
			hide:  0
			label: "Data Source"
			name:  "datasource"
			options: []
			query:   "prometheus"
			refresh: 1
			regex:   ""
			type:    "datasource"
		}, {
			allValue: null
			current: {}
			datasource: "$datasource"
			hide:       2
			includeAll: false
			label:      "cluster"
			multi:      false
			name:       "cluster"
			options: []
			query:          "label_values(up{job=\"kube-proxy\"}, cluster)"
			refresh:        2
			regex:          ""
			sort:           1
			tagValuesQuery: ""
			tags: []
			tagsQuery: ""
			type:      "query"
			useTags:   false
		}, {
			allValue: null
			current: {}
			datasource: "$datasource"
			hide:       0
			includeAll: true
			label:      null
			multi:      false
			name:       "instance"
			options: []
			query:          "label_values(up{job=\"kube-proxy\", cluster=\"$cluster\", job=\"kube-proxy\"}, instance)"
			refresh:        2
			regex:          ""
			sort:           1
			tagValuesQuery: ""
			tags: []
			tagsQuery: ""
			type:      "query"
			useTags:   false
		}]
		time: {
			from: "now-1h"
			to:   "now"
		}
		timepicker: {
			refresh_intervals: ["5s", "10s", "30s", "1m", "5m", "15m", "30m", "1h", "2h", "1d"]
			time_options: ["5m", "15m", "1h", "6h", "12h", "24h", "2d", "7d", "30d"]
		}
		timezone: "UTC"
		title:    "Kubernetes / Proxy"
		uid:      "632e265de029684c40b21cb76bca4f94"
		version:  0
	}
	"scheduler.json": {
		"__inputs": []
		"__requires": []
		annotations: list: []
		editable:     false
		gnetId:       null
		graphTooltip: 0
		hideControls: false
		id:           null
		links: []
		refresh: "10s"
		rows: [{
			collapse:  false
			collapsed: false
			panels: [{
				cacheTimeout:    null
				colorBackground: false
				colorValue:      false
				colors: ["#299c46", "rgba(237, 129, 40, 0.89)", "#d44a3a"]
				datasource: "$datasource"
				format:     "none"
				gauge: {
					maxValue:         100
					minValue:         0
					show:             false
					thresholdLabels:  false
					thresholdMarkers: true
				}
				gridPos: {}
				id:       2
				interval: "1m"
				legend: {
					alignAsTable: true
					rightSide:    true
				}
				links: []
				mappingType: 1
				mappingTypes: [{
					name:  "value to text"
					value: 1
				}, {
					name:  "range to text"
					value: 2
				}]
				maxDataPoints:   100
				nullPointMode:   "connected"
				nullText:        null
				postfix:         ""
				postfixFontSize: "50%"
				prefix:          ""
				prefixFontSize:  "50%"
				rangeMaps: [{
					from: "null"
					text: "N/A"
					to:   "null"
				}]
				span: 2
				sparkline: {
					fillColor: "rgba(31, 118, 189, 0.18)"
					full:      false
					lineColor: "rgb(31, 120, 193)"
					show:      false
				}
				tableColumn: ""
				targets: [{
					expr:           "sum(up{cluster=\"$cluster\", job=\"kube-scheduler\"})"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   ""
					refId:          "A"
				}]
				thresholds: ""
				title:      "Up"
				tooltip: shared: false
				type:          "singlestat"
				valueFontSize: "80%"
				valueMaps: [{
					op:    "="
					text:  "N/A"
					value: "null"
				}]
				valueName: "min"
			}, {
				aliasColors: {}
				bars:         false
				dashLength:   10
				dashes:       false
				datasource:   "$datasource"
				fill:         1
				fillGradient: 0
				gridPos: {}
				id:       3
				interval: "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      true
					max:          false
					min:          false
					rightSide:    true
					show:         true
					sideWidth:    null
					total:        false
					values:       true
				}
				lines:     true
				linewidth: 1
				links: []
				nullPointMode: "null"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				repeat:        null
				seriesOverrides: []
				spaceLength: 10
				span:        5
				stack:       false
				steppedLine: false
				targets: [{
					expr:           "sum(rate(scheduler_e2e_scheduling_duration_seconds_count{cluster=\"$cluster\", job=\"kube-scheduler\", instance=~\"$instance\"}[$__rate_interval])) by (cluster, instance)"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{cluster}} {{instance}} e2e"
					refId:          "A"
				}, {
					expr:           "sum(rate(scheduler_binding_duration_seconds_count{cluster=\"$cluster\", job=\"kube-scheduler\", instance=~\"$instance\"}[$__rate_interval])) by (cluster, instance)"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{cluster}} {{instance}} binding"
					refId:          "B"
				}, {
					expr:           "sum(rate(scheduler_scheduling_algorithm_duration_seconds_count{cluster=\"$cluster\", job=\"kube-scheduler\", instance=~\"$instance\"}[$__rate_interval])) by (cluster, instance)"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{cluster}} {{instance}} scheduling algorithm"
					refId:          "C"
				}, {
					expr:           "sum(rate(scheduler_volume_scheduling_duration_seconds_count{cluster=\"$cluster\", job=\"kube-scheduler\", instance=~\"$instance\"}[$__rate_interval])) by (cluster, instance)"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{cluster}} {{instance}} volume"
					refId:          "D"
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Scheduling Rate"
				tooltip: {
					shared:     false
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
				yaxes: [{
					format:  "ops"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "ops"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}]
			}, {
				aliasColors: {}
				bars:         false
				dashLength:   10
				dashes:       false
				datasource:   "$datasource"
				fill:         1
				fillGradient: 0
				gridPos: {}
				id:       4
				interval: "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      true
					max:          false
					min:          false
					rightSide:    true
					show:         true
					sideWidth:    null
					total:        false
					values:       true
				}
				lines:     true
				linewidth: 1
				links: []
				nullPointMode: "null"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				repeat:        null
				seriesOverrides: []
				spaceLength: 10
				span:        5
				stack:       false
				steppedLine: false
				targets: [{
					expr:           "histogram_quantile(0.99, sum(rate(scheduler_e2e_scheduling_duration_seconds_bucket{cluster=\"$cluster\", job=\"kube-scheduler\",instance=~\"$instance\"}[$__rate_interval])) by (cluster, instance, le))"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{cluster}} {{instance}} e2e"
					refId:          "A"
				}, {
					expr:           "histogram_quantile(0.99, sum(rate(scheduler_binding_duration_seconds_bucket{cluster=\"$cluster\", job=\"kube-scheduler\",instance=~\"$instance\"}[$__rate_interval])) by (cluster, instance, le))"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{cluster}} {{instance}} binding"
					refId:          "B"
				}, {
					expr:           "histogram_quantile(0.99, sum(rate(scheduler_scheduling_algorithm_duration_seconds_bucket{cluster=\"$cluster\", job=\"kube-scheduler\",instance=~\"$instance\"}[$__rate_interval])) by (cluster, instance, le))"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{cluster}} {{instance}} scheduling algorithm"
					refId:          "C"
				}, {
					expr:           "histogram_quantile(0.99, sum(rate(scheduler_volume_scheduling_duration_seconds_bucket{cluster=\"$cluster\", job=\"kube-scheduler\",instance=~\"$instance\"}[$__rate_interval])) by (cluster, instance, le))"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{cluster}} {{instance}} volume"
					refId:          "D"
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Scheduling latency 99th Quantile"
				tooltip: {
					shared:     false
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
				yaxes: [{
					format:  "s"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "s"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}]
			}]
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       false
			title:           "Dashboard Row"
			titleSize:       "h6"
			type:            "row"
		}, {
			collapse:  false
			collapsed: false
			panels: [{
				aliasColors: {}
				bars:         false
				dashLength:   10
				dashes:       false
				datasource:   "$datasource"
				fill:         1
				fillGradient: 0
				gridPos: {}
				id:       5
				interval: "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					sideWidth:    null
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 1
				links: []
				nullPointMode: "null"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				repeat:        null
				seriesOverrides: []
				spaceLength: 10
				span:        4
				stack:       false
				steppedLine: false
				targets: [{
					expr:           "sum(rate(rest_client_requests_total{cluster=\"$cluster\", job=\"kube-scheduler\", instance=~\"$instance\",code=~\"2..\"}[$__rate_interval]))"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "2xx"
					refId:          "A"
				}, {
					expr:           "sum(rate(rest_client_requests_total{cluster=\"$cluster\", job=\"kube-scheduler\", instance=~\"$instance\",code=~\"3..\"}[$__rate_interval]))"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "3xx"
					refId:          "B"
				}, {
					expr:           "sum(rate(rest_client_requests_total{cluster=\"$cluster\", job=\"kube-scheduler\", instance=~\"$instance\",code=~\"4..\"}[$__rate_interval]))"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "4xx"
					refId:          "C"
				}, {
					expr:           "sum(rate(rest_client_requests_total{cluster=\"$cluster\", job=\"kube-scheduler\", instance=~\"$instance\",code=~\"5..\"}[$__rate_interval]))"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "5xx"
					refId:          "D"
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Kube API Request Rate"
				tooltip: {
					shared:     false
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
				yaxes: [{
					format:  "ops"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "ops"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}]
			}, {
				aliasColors: {}
				bars:         false
				dashLength:   10
				dashes:       false
				datasource:   "$datasource"
				fill:         1
				fillGradient: 0
				gridPos: {}
				id:       6
				interval: "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					sideWidth:    null
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 1
				links: []
				nullPointMode: "null"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				repeat:        null
				seriesOverrides: []
				spaceLength: 10
				span:        8
				stack:       false
				steppedLine: false
				targets: [{
					expr:           "histogram_quantile(0.99, sum(rate(rest_client_request_duration_seconds_bucket{cluster=\"$cluster\", job=\"kube-scheduler\", instance=~\"$instance\", verb=\"POST\"}[$__rate_interval])) by (verb, url, le))"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{verb}} {{url}}"
					refId:          "A"
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Post Request Latency 99th Quantile"
				tooltip: {
					shared:     false
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
				yaxes: [{
					format:  "s"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "s"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}]
			}]
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       false
			title:           "Dashboard Row"
			titleSize:       "h6"
			type:            "row"
		}, {
			collapse:  false
			collapsed: false
			panels: [{
				aliasColors: {}
				bars:         false
				dashLength:   10
				dashes:       false
				datasource:   "$datasource"
				fill:         1
				fillGradient: 0
				gridPos: {}
				id:       7
				interval: "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      true
					max:          false
					min:          false
					rightSide:    true
					show:         true
					sideWidth:    null
					total:        false
					values:       true
				}
				lines:     true
				linewidth: 1
				links: []
				nullPointMode: "null"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				repeat:        null
				seriesOverrides: []
				spaceLength: 10
				span:        12
				stack:       false
				steppedLine: false
				targets: [{
					expr:           "histogram_quantile(0.99, sum(rate(rest_client_request_duration_seconds_bucket{cluster=\"$cluster\", job=\"kube-scheduler\", instance=~\"$instance\", verb=\"GET\"}[$__rate_interval])) by (verb, url, le))"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{verb}} {{url}}"
					refId:          "A"
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Get Request Latency 99th Quantile"
				tooltip: {
					shared:     false
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
				yaxes: [{
					format:  "s"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "s"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}]
			}]
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       false
			title:           "Dashboard Row"
			titleSize:       "h6"
			type:            "row"
		}, {
			collapse:  false
			collapsed: false
			panels: [{
				aliasColors: {}
				bars:         false
				dashLength:   10
				dashes:       false
				datasource:   "$datasource"
				fill:         1
				fillGradient: 0
				gridPos: {}
				id:       8
				interval: "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					sideWidth:    null
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 1
				links: []
				nullPointMode: "null"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				repeat:        null
				seriesOverrides: []
				spaceLength: 10
				span:        4
				stack:       false
				steppedLine: false
				targets: [{
					expr:           "process_resident_memory_bytes{cluster=\"$cluster\", job=\"kube-scheduler\", instance=~\"$instance\"}"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{instance}}"
					refId:          "A"
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Memory"
				tooltip: {
					shared:     false
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
				yaxes: [{
					format:  "bytes"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    true
				}, {
					format:  "bytes"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    true
				}]
			}, {
				aliasColors: {}
				bars:         false
				dashLength:   10
				dashes:       false
				datasource:   "$datasource"
				fill:         1
				fillGradient: 0
				gridPos: {}
				id:       9
				interval: "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					sideWidth:    null
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 1
				links: []
				nullPointMode: "null"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				repeat:        null
				seriesOverrides: []
				spaceLength: 10
				span:        4
				stack:       false
				steppedLine: false
				targets: [{
					expr:           "rate(process_cpu_seconds_total{cluster=\"$cluster\", job=\"kube-scheduler\", instance=~\"$instance\"}[$__rate_interval])"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{instance}}"
					refId:          "A"
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "CPU usage"
				tooltip: {
					shared:     false
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
				yaxes: [{
					format:  "bytes"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "bytes"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}]
			}, {
				aliasColors: {}
				bars:         false
				dashLength:   10
				dashes:       false
				datasource:   "$datasource"
				fill:         1
				fillGradient: 0
				gridPos: {}
				id:       10
				interval: "1m"
				legend: {
					alignAsTable: true
					avg:          false
					current:      false
					max:          false
					min:          false
					rightSide:    true
					show:         true
					sideWidth:    null
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 1
				links: []
				nullPointMode: "null"
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				repeat:        null
				seriesOverrides: []
				spaceLength: 10
				span:        4
				stack:       false
				steppedLine: false
				targets: [{
					expr:           "go_goroutines{cluster=\"$cluster\", job=\"kube-scheduler\",instance=~\"$instance\"}"
					format:         "time_series"
					intervalFactor: 2
					legendFormat:   "{{instance}}"
					refId:          "A"
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Goroutines"
				tooltip: {
					shared:     false
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
				yaxes: [{
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    true
				}, {
					format:  "short"
					label:   null
					logBase: 1
					max:     null
					min:     null
					show:    true
				}]
			}]
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       false
			title:           "Dashboard Row"
			titleSize:       "h6"
			type:            "row"
		}]
		schemaVersion: 14
		style:         "dark"
		tags: [
			"kubernetes-mixin",
		]
		templating: list: [{
			current: {
				text:  "default"
				value: "default"
			}
			hide:  0
			label: "Data Source"
			name:  "datasource"
			options: []
			query:   "prometheus"
			refresh: 1
			regex:   ""
			type:    "datasource"
		}, {
			allValue: null
			current: {}
			datasource: "$datasource"
			hide:       2
			includeAll: false
			label:      "cluster"
			multi:      false
			name:       "cluster"
			options: []
			query:          "label_values(up{job=\"kube-scheduler\"}, cluster)"
			refresh:        2
			regex:          ""
			sort:           1
			tagValuesQuery: ""
			tags: []
			tagsQuery: ""
			type:      "query"
			useTags:   false
		}, {
			allValue: null
			current: {}
			datasource: "$datasource"
			hide:       0
			includeAll: true
			label:      null
			multi:      false
			name:       "instance"
			options: []
			query:          "label_values(up{job=\"kube-scheduler\", cluster=\"$cluster\"}, instance)"
			refresh:        2
			regex:          ""
			sort:           1
			tagValuesQuery: ""
			tags: []
			tagsQuery: ""
			type:      "query"
			useTags:   false
		}]
		time: {
			from: "now-1h"
			to:   "now"
		}
		timepicker: {
			refresh_intervals: ["5s", "10s", "30s", "1m", "5m", "15m", "30m", "1h", "2h", "1d"]
			time_options: ["5m", "15m", "1h", "6h", "12h", "24h", "2d", "7d", "30d"]
		}
		timezone: "UTC"
		title:    "Kubernetes / Scheduler"
		uid:      "2e6b6a3b4bddf1427b3a55aa1311c656"
		version:  0
	}
	"workload-total.json": {
		"__inputs": []
		"__requires": []
		annotations: list: [{
			builtIn:    1
			datasource: "-- Grafana --"
			enable:     true
			hide:       true
			iconColor:  "rgba(0, 211, 255, 1)"
			name:       "Annotations & Alerts"
			type:       "dashboard"
		}]
		editable:     true
		gnetId:       null
		graphTooltip: 0
		hideControls: false
		id:           null
		links: []
		panels: [{
			collapse:  false
			collapsed: false
			gridPos: {
				h: 1
				w: 24
				x: 0
				y: 0
			}
			id: 2
			panels: []
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       true
			title:           "Current Bandwidth"
			titleSize:       "h6"
			type:            "row"
		}, {
			aliasColors: {}
			bars:         true
			dashLength:   10
			dashes:       false
			datasource:   "$datasource"
			fill:         2
			fillGradient: 0
			gridPos: {
				h: 9
				w: 12
				x: 0
				y: 1
			}
			id: 3
			legend: {
				alignAsTable: true
				avg:          false
				current:      true
				hideEmpty:    true
				hideZero:     true
				max:          false
				min:          false
				rightSide:    true
				show:         true
				sideWidth:    null
				sort:         "current"
				sortDesc:     true
				total:        false
				values:       true
			}
			lines:     false
			linewidth: 1
			links: []
			minSpan:       24
			nullPointMode: "null"
			paceLength:    10
			percentage:    false
			pointradius:   5
			points:        false
			renderer:      "flot"
			repeat:        null
			seriesOverrides: []
			spaceLength: 10
			span:        24
			stack:       false
			steppedLine: false
			targets: [{
				expr: """
					sort_desc(sum(irate(container_network_receive_bytes_total{job="kubelet", metrics_path="/metrics/cadvisor", cluster="$cluster",namespace=~"$namespace"}[$interval:$resolution])
					* on (namespace,pod)
					group_left(workload,workload_type) namespace_workload_pod:kube_pod_owner:relabel{cluster="$cluster",namespace=~"$namespace", workload=~"$workload", workload_type="$type"}) by (pod))

					"""
				format:         "time_series"
				intervalFactor: 1
				legendFormat:   "{{ pod }}"
				refId:          "A"
				step:           10
			}]
			thresholds: []
			timeFrom:  null
			timeShift: null
			title:     "Current Rate of Bytes Received"
			tooltip: {
				shared:     true
				sort:       2
				value_type: "individual"
			}
			type: "graph"
			xaxis: {
				buckets: null
				mode:    "series"
				name:    null
				show:    false
				values: ["current"]
			}
			yaxes: [{
				format:  "Bps"
				label:   null
				logBase: 1
				max:     null
				min:     0
				show:    true
			}, {
				format:  "Bps"
				label:   null
				logBase: 1
				max:     null
				min:     0
				show:    true
			}]
		}, {
			aliasColors: {}
			bars:         true
			dashLength:   10
			dashes:       false
			datasource:   "$datasource"
			fill:         2
			fillGradient: 0
			gridPos: {
				h: 9
				w: 12
				x: 12
				y: 1
			}
			id: 4
			legend: {
				alignAsTable: true
				avg:          false
				current:      true
				hideEmpty:    true
				hideZero:     true
				max:          false
				min:          false
				rightSide:    true
				show:         true
				sideWidth:    null
				sort:         "current"
				sortDesc:     true
				total:        false
				values:       true
			}
			lines:     false
			linewidth: 1
			links: []
			minSpan:       24
			nullPointMode: "null"
			paceLength:    10
			percentage:    false
			pointradius:   5
			points:        false
			renderer:      "flot"
			repeat:        null
			seriesOverrides: []
			spaceLength: 10
			span:        24
			stack:       false
			steppedLine: false
			targets: [{
				expr: """
					sort_desc(sum(irate(container_network_transmit_bytes_total{job="kubelet", metrics_path="/metrics/cadvisor", cluster="$cluster",namespace=~"$namespace"}[$interval:$resolution])
					* on (namespace,pod)
					group_left(workload,workload_type) namespace_workload_pod:kube_pod_owner:relabel{cluster="$cluster",namespace=~"$namespace", workload=~"$workload", workload_type="$type"}) by (pod))

					"""
				format:         "time_series"
				intervalFactor: 1
				legendFormat:   "{{ pod }}"
				refId:          "A"
				step:           10
			}]
			thresholds: []
			timeFrom:  null
			timeShift: null
			title:     "Current Rate of Bytes Transmitted"
			tooltip: {
				shared:     true
				sort:       2
				value_type: "individual"
			}
			type: "graph"
			xaxis: {
				buckets: null
				mode:    "series"
				name:    null
				show:    false
				values: ["current"]
			}
			yaxes: [{
				format:  "Bps"
				label:   null
				logBase: 1
				max:     null
				min:     0
				show:    true
			}, {
				format:  "Bps"
				label:   null
				logBase: 1
				max:     null
				min:     0
				show:    true
			}]
		}, {
			collapse:  true
			collapsed: true
			gridPos: {
				h: 1
				w: 24
				x: 0
				y: 10
			}
			id: 5
			panels: [{
				aliasColors: {}
				bars:         true
				dashLength:   10
				dashes:       false
				datasource:   "$datasource"
				fill:         2
				fillGradient: 0
				gridPos: {
					h: 9
					w: 12
					x: 0
					y: 11
				}
				id: 6
				legend: {
					alignAsTable: true
					avg:          false
					current:      true
					hideEmpty:    true
					hideZero:     true
					max:          false
					min:          false
					rightSide:    true
					show:         true
					sideWidth:    null
					sort:         "current"
					sortDesc:     true
					total:        false
					values:       true
				}
				lines:     false
				linewidth: 1
				links: []
				minSpan:       24
				nullPointMode: "null"
				paceLength:    10
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				repeat:        null
				seriesOverrides: []
				spaceLength: 10
				span:        24
				stack:       false
				steppedLine: false
				targets: [{
					expr: """
						sort_desc(avg(irate(container_network_receive_bytes_total{job="kubelet", metrics_path="/metrics/cadvisor", cluster="$cluster",namespace=~"$namespace"}[$interval:$resolution])
						* on (namespace,pod)
						group_left(workload,workload_type) namespace_workload_pod:kube_pod_owner:relabel{cluster="$cluster",namespace=~"$namespace", workload=~"$workload", workload_type="$type"}) by (pod))

						"""
					format:         "time_series"
					intervalFactor: 1
					legendFormat:   "{{ pod }}"
					refId:          "A"
					step:           10
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Average Rate of Bytes Received"
				tooltip: {
					shared:     true
					sort:       2
					value_type: "individual"
				}
				type: "graph"
				xaxis: {
					buckets: null
					mode:    "series"
					name:    null
					show:    false
					values: ["current"]
				}
				yaxes: [{
					format:  "Bps"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "Bps"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}]
			}, {
				aliasColors: {}
				bars:         true
				dashLength:   10
				dashes:       false
				datasource:   "$datasource"
				fill:         2
				fillGradient: 0
				gridPos: {
					h: 9
					w: 12
					x: 12
					y: 11
				}
				id: 7
				legend: {
					alignAsTable: true
					avg:          false
					current:      true
					hideEmpty:    true
					hideZero:     true
					max:          false
					min:          false
					rightSide:    true
					show:         true
					sideWidth:    null
					sort:         "current"
					sortDesc:     true
					total:        false
					values:       true
				}
				lines:     false
				linewidth: 1
				links: []
				minSpan:       24
				nullPointMode: "null"
				paceLength:    10
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				repeat:        null
				seriesOverrides: []
				spaceLength: 10
				span:        24
				stack:       false
				steppedLine: false
				targets: [{
					expr: """
						sort_desc(avg(irate(container_network_transmit_bytes_total{job="kubelet", metrics_path="/metrics/cadvisor", cluster="$cluster",namespace=~"$namespace"}[$interval:$resolution])
						* on (namespace,pod)
						group_left(workload,workload_type) namespace_workload_pod:kube_pod_owner:relabel{cluster="$cluster",namespace=~"$namespace", workload=~"$workload", workload_type="$type"}) by (pod))

						"""
					format:         "time_series"
					intervalFactor: 1
					legendFormat:   "{{ pod }}"
					refId:          "A"
					step:           10
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Average Rate of Bytes Transmitted"
				tooltip: {
					shared:     true
					sort:       2
					value_type: "individual"
				}
				type: "graph"
				xaxis: {
					buckets: null
					mode:    "series"
					name:    null
					show:    false
					values: ["current"]
				}
				yaxes: [{
					format:  "Bps"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "Bps"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}]
			}]
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       true
			title:           "Average Bandwidth"
			titleSize:       "h6"
			type:            "row"
		}, {
			collapse:  false
			collapsed: false
			gridPos: {
				h: 1
				w: 24
				x: 0
				y: 11
			}
			id: 8
			panels: []
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       true
			title:           "Bandwidth HIstory"
			titleSize:       "h6"
			type:            "row"
		}, {
			aliasColors: {}
			bars:         false
			dashLength:   10
			dashes:       false
			datasource:   "$datasource"
			fill:         2
			fillGradient: 0
			gridPos: {
				h: 9
				w: 12
				x: 0
				y: 12
			}
			id: 9
			legend: {
				alignAsTable: false
				avg:          false
				current:      false
				hideEmpty:    true
				hideZero:     true
				max:          false
				min:          false
				rightSide:    false
				show:         true
				sideWidth:    null
				total:        false
				values:       false
			}
			lines:     true
			linewidth: 2
			links: []
			minSpan:       12
			nullPointMode: "connected"
			paceLength:    10
			percentage:    false
			pointradius:   5
			points:        false
			renderer:      "flot"
			repeat:        null
			seriesOverrides: []
			spaceLength: 10
			span:        12
			stack:       true
			steppedLine: false
			targets: [{
				expr: """
					sort_desc(sum(irate(container_network_receive_bytes_total{job="kubelet", metrics_path="/metrics/cadvisor", cluster="$cluster",namespace=~"$namespace"}[$interval:$resolution])
					* on (namespace,pod)
					group_left(workload,workload_type) namespace_workload_pod:kube_pod_owner:relabel{cluster="$cluster",namespace=~"$namespace", workload=~"$workload", workload_type="$type"}) by (pod))

					"""
				format:         "time_series"
				intervalFactor: 1
				legendFormat:   "{{pod}}"
				refId:          "A"
				step:           10
			}]
			thresholds: []
			timeFrom:  null
			timeShift: null
			title:     "Receive Bandwidth"
			tooltip: {
				shared:     true
				sort:       2
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
			yaxes: [{
				format:  "Bps"
				label:   null
				logBase: 1
				max:     null
				min:     0
				show:    true
			}, {
				format:  "Bps"
				label:   null
				logBase: 1
				max:     null
				min:     0
				show:    true
			}]
		}, {
			aliasColors: {}
			bars:         false
			dashLength:   10
			dashes:       false
			datasource:   "$datasource"
			fill:         2
			fillGradient: 0
			gridPos: {
				h: 9
				w: 12
				x: 12
				y: 12
			}
			id: 10
			legend: {
				alignAsTable: false
				avg:          false
				current:      false
				hideEmpty:    true
				hideZero:     true
				max:          false
				min:          false
				rightSide:    false
				show:         true
				sideWidth:    null
				total:        false
				values:       false
			}
			lines:     true
			linewidth: 2
			links: []
			minSpan:       12
			nullPointMode: "connected"
			paceLength:    10
			percentage:    false
			pointradius:   5
			points:        false
			renderer:      "flot"
			repeat:        null
			seriesOverrides: []
			spaceLength: 10
			span:        12
			stack:       true
			steppedLine: false
			targets: [{
				expr: """
					sort_desc(sum(irate(container_network_transmit_bytes_total{job="kubelet", metrics_path="/metrics/cadvisor", cluster="$cluster",namespace=~"$namespace"}[$interval:$resolution])
					* on (namespace,pod)
					group_left(workload,workload_type) namespace_workload_pod:kube_pod_owner:relabel{cluster="$cluster",namespace=~"$namespace", workload=~"$workload", workload_type="$type"}) by (pod))

					"""
				format:         "time_series"
				intervalFactor: 1
				legendFormat:   "{{pod}}"
				refId:          "A"
				step:           10
			}]
			thresholds: []
			timeFrom:  null
			timeShift: null
			title:     "Transmit Bandwidth"
			tooltip: {
				shared:     true
				sort:       2
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
			yaxes: [{
				format:  "Bps"
				label:   null
				logBase: 1
				max:     null
				min:     0
				show:    true
			}, {
				format:  "Bps"
				label:   null
				logBase: 1
				max:     null
				min:     0
				show:    true
			}]
		}, {
			collapse:  true
			collapsed: true
			gridPos: {
				h: 1
				w: 24
				x: 0
				y: 21
			}
			id: 11
			panels: [{
				aliasColors: {}
				bars:         false
				dashLength:   10
				dashes:       false
				datasource:   "$datasource"
				fill:         2
				fillGradient: 0
				gridPos: {
					h: 9
					w: 12
					x: 0
					y: 22
				}
				id: 12
				legend: {
					alignAsTable: false
					avg:          false
					current:      false
					hideEmpty:    true
					hideZero:     true
					max:          false
					min:          false
					rightSide:    false
					show:         true
					sideWidth:    null
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 2
				links: []
				minSpan:       12
				nullPointMode: "connected"
				paceLength:    10
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				repeat:        null
				seriesOverrides: []
				spaceLength: 10
				span:        12
				stack:       true
				steppedLine: false
				targets: [{
					expr: """
						sort_desc(sum(irate(container_network_receive_packets_total{job="kubelet", metrics_path="/metrics/cadvisor", cluster="$cluster",namespace=~"$namespace"}[$interval:$resolution])
						* on (namespace,pod)
						group_left(workload,workload_type) namespace_workload_pod:kube_pod_owner:relabel{cluster="$cluster",namespace=~"$namespace", workload=~"$workload", workload_type="$type"}) by (pod))

						"""
					format:         "time_series"
					intervalFactor: 1
					legendFormat:   "{{pod}}"
					refId:          "A"
					step:           10
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Rate of Received Packets"
				tooltip: {
					shared:     true
					sort:       2
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
				yaxes: [{
					format:  "pps"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "pps"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}]
			}, {
				aliasColors: {}
				bars:         false
				dashLength:   10
				dashes:       false
				datasource:   "$datasource"
				fill:         2
				fillGradient: 0
				gridPos: {
					h: 9
					w: 12
					x: 12
					y: 22
				}
				id: 13
				legend: {
					alignAsTable: false
					avg:          false
					current:      false
					hideEmpty:    true
					hideZero:     true
					max:          false
					min:          false
					rightSide:    false
					show:         true
					sideWidth:    null
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 2
				links: []
				minSpan:       12
				nullPointMode: "connected"
				paceLength:    10
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				repeat:        null
				seriesOverrides: []
				spaceLength: 10
				span:        12
				stack:       true
				steppedLine: false
				targets: [{
					expr: """
						sort_desc(sum(irate(container_network_transmit_packets_total{job="kubelet", metrics_path="/metrics/cadvisor", cluster="$cluster",namespace=~"$namespace"}[$interval:$resolution])
						* on (namespace,pod)
						group_left(workload,workload_type) namespace_workload_pod:kube_pod_owner:relabel{cluster="$cluster",namespace=~"$namespace", workload=~"$workload", workload_type="$type"}) by (pod))

						"""
					format:         "time_series"
					intervalFactor: 1
					legendFormat:   "{{pod}}"
					refId:          "A"
					step:           10
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Rate of Transmitted Packets"
				tooltip: {
					shared:     true
					sort:       2
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
				yaxes: [{
					format:  "pps"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "pps"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}]
			}]
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       true
			title:           "Packets"
			titleSize:       "h6"
			type:            "row"
		}, {
			collapse:  true
			collapsed: true
			gridPos: {
				h: 1
				w: 24
				x: 0
				y: 22
			}
			id: 14
			panels: [{
				aliasColors: {}
				bars:         false
				dashLength:   10
				dashes:       false
				datasource:   "$datasource"
				fill:         2
				fillGradient: 0
				gridPos: {
					h: 9
					w: 12
					x: 0
					y: 23
				}
				id: 15
				legend: {
					alignAsTable: false
					avg:          false
					current:      false
					hideEmpty:    true
					hideZero:     true
					max:          false
					min:          false
					rightSide:    false
					show:         true
					sideWidth:    null
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 2
				links: []
				minSpan:       12
				nullPointMode: "connected"
				paceLength:    10
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				repeat:        null
				seriesOverrides: []
				spaceLength: 10
				span:        12
				stack:       true
				steppedLine: false
				targets: [{
					expr: """
						sort_desc(sum(irate(container_network_receive_packets_dropped_total{job="kubelet", metrics_path="/metrics/cadvisor", cluster="$cluster",namespace=~"$namespace"}[$interval:$resolution])
						* on (namespace,pod)
						group_left(workload,workload_type) namespace_workload_pod:kube_pod_owner:relabel{cluster="$cluster",namespace=~"$namespace", workload=~"$workload", workload_type="$type"}) by (pod))

						"""
					format:         "time_series"
					intervalFactor: 1
					legendFormat:   "{{pod}}"
					refId:          "A"
					step:           10
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Rate of Received Packets Dropped"
				tooltip: {
					shared:     true
					sort:       2
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
				yaxes: [{
					format:  "pps"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "pps"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}]
			}, {
				aliasColors: {}
				bars:         false
				dashLength:   10
				dashes:       false
				datasource:   "$datasource"
				fill:         2
				fillGradient: 0
				gridPos: {
					h: 9
					w: 12
					x: 12
					y: 23
				}
				id: 16
				legend: {
					alignAsTable: false
					avg:          false
					current:      false
					hideEmpty:    true
					hideZero:     true
					max:          false
					min:          false
					rightSide:    false
					show:         true
					sideWidth:    null
					total:        false
					values:       false
				}
				lines:     true
				linewidth: 2
				links: []
				minSpan:       12
				nullPointMode: "connected"
				paceLength:    10
				percentage:    false
				pointradius:   5
				points:        false
				renderer:      "flot"
				repeat:        null
				seriesOverrides: []
				spaceLength: 10
				span:        12
				stack:       true
				steppedLine: false
				targets: [{
					expr: """
						sort_desc(sum(irate(container_network_transmit_packets_dropped_total{job="kubelet", metrics_path="/metrics/cadvisor", cluster="$cluster",namespace=~"$namespace"}[$interval:$resolution])
						* on (namespace,pod)
						group_left(workload,workload_type) namespace_workload_pod:kube_pod_owner:relabel{cluster="$cluster",namespace=~"$namespace", workload=~"$workload", workload_type="$type"}) by (pod))

						"""
					format:         "time_series"
					intervalFactor: 1
					legendFormat:   "{{pod}}"
					refId:          "A"
					step:           10
				}]
				thresholds: []
				timeFrom:  null
				timeShift: null
				title:     "Rate of Transmitted Packets Dropped"
				tooltip: {
					shared:     true
					sort:       2
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
				yaxes: [{
					format:  "pps"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}, {
					format:  "pps"
					label:   null
					logBase: 1
					max:     null
					min:     0
					show:    true
				}]
			}]
			repeat:          null
			repeatIteration: null
			repeatRowId:     null
			showTitle:       true
			title:           "Errors"
			titleSize:       "h6"
			type:            "row"
		}]
		refresh: "10s"
		rows: []
		schemaVersion: 18
		style:         "dark"
		tags: [
			"kubernetes-mixin",
		]
		templating: list: [{
			current: {
				text:  "default"
				value: "default"
			}
			hide:  0
			label: "Data Source"
			name:  "datasource"
			options: []
			query:   "prometheus"
			refresh: 1
			regex:   ""
			type:    "datasource"
		}, {
			allValue: null
			current: {}
			datasource: "$datasource"
			hide:       2
			includeAll: false
			label:      null
			multi:      false
			name:       "cluster"
			options: []
			query:          "label_values(kube_pod_info{job=\"kube-state-metrics\"}, cluster)"
			refresh:        2
			regex:          ""
			sort:           0
			tagValuesQuery: ""
			tags: []
			tagsQuery: ""
			type:      "query"
			useTags:   false
		}, {
			allValue:   ".+"
			auto:       false
			auto_count: 30
			auto_min:   "10s"
			current: {
				text:  "kube-system"
				value: "kube-system"
			}
			datasource: "$datasource"
			definition: "label_values(container_network_receive_packets_total{job=\"kubelet\", metrics_path=\"/metrics/cadvisor\", cluster=\"$cluster\"}, namespace)"
			hide:       0
			includeAll: true
			label:      null
			multi:      false
			name:       "namespace"
			options: []
			query:          "label_values(container_network_receive_packets_total{job=\"kubelet\", metrics_path=\"/metrics/cadvisor\", cluster=\"$cluster\"}, namespace)"
			refresh:        2
			regex:          ""
			skipUrlSync:    false
			sort:           1
			tagValuesQuery: ""
			tags: []
			tagsQuery: ""
			type:      "query"
			useTags:   false
		}, {
			allValue:   null
			auto:       false
			auto_count: 30
			auto_min:   "10s"
			current: {
				text:  ""
				value: ""
			}
			datasource: "$datasource"
			definition: "label_values(namespace_workload_pod:kube_pod_owner:relabel{cluster=\"$cluster\",namespace=~\"$namespace\"}, workload)"
			hide:       0
			includeAll: false
			label:      null
			multi:      false
			name:       "workload"
			options: []
			query:          "label_values(namespace_workload_pod:kube_pod_owner:relabel{cluster=\"$cluster\",namespace=~\"$namespace\"}, workload)"
			refresh:        2
			regex:          ""
			skipUrlSync:    false
			sort:           1
			tagValuesQuery: ""
			tags: []
			tagsQuery: ""
			type:      "query"
			useTags:   false
		}, {
			allValue:   null
			auto:       false
			auto_count: 30
			auto_min:   "10s"
			current: {
				text:  "deployment"
				value: "deployment"
			}
			datasource: "$datasource"
			definition: "label_values(namespace_workload_pod:kube_pod_owner:relabel{cluster=\"$cluster\",namespace=~\"$namespace\", workload=~\"$workload\"}, workload_type)"
			hide:       0
			includeAll: false
			label:      null
			multi:      false
			name:       "type"
			options: []
			query:          "label_values(namespace_workload_pod:kube_pod_owner:relabel{cluster=\"$cluster\",namespace=~\"$namespace\", workload=~\"$workload\"}, workload_type)"
			refresh:        2
			regex:          ""
			skipUrlSync:    false
			sort:           0
			tagValuesQuery: ""
			tags: []
			tagsQuery: ""
			type:      "query"
			useTags:   false
		}, {
			allValue:   null
			auto:       false
			auto_count: 30
			auto_min:   "10s"
			current: {
				text:  "5m"
				value: "5m"
			}
			datasource: "$datasource"
			hide:       0
			includeAll: false
			label:      null
			multi:      false
			name:       "resolution"
			options: [{
				selected: false
				text:     "30s"
				value:    "30s"
			}, {
				selected: true
				text:     "5m"
				value:    "5m"
			}, {
				selected: false
				text:     "1h"
				value:    "1h"
			}]
			query:          "30s,5m,1h"
			refresh:        2
			regex:          ""
			skipUrlSync:    false
			sort:           1
			tagValuesQuery: ""
			tags: []
			tagsQuery: ""
			type:      "interval"
			useTags:   false
		}, {
			allValue:   null
			auto:       false
			auto_count: 30
			auto_min:   "10s"
			current: {
				text:  "5m"
				value: "5m"
			}
			datasource: "$datasource"
			hide:       2
			includeAll: false
			label:      null
			multi:      false
			name:       "interval"
			options: [{
				selected: true
				text:     "4h"
				value:    "4h"
			}]
			query:          "4h"
			refresh:        2
			regex:          ""
			skipUrlSync:    false
			sort:           1
			tagValuesQuery: ""
			tags: []
			tagsQuery: ""
			type:      "interval"
			useTags:   false
		}]
		time: {
			from: "now-1h"
			to:   "now"
		}
		timepicker: {
			refresh_intervals: ["5s", "10s", "30s", "1m", "5m", "15m", "30m", "1h", "2h", "1d"]
			time_options: ["5m", "15m", "1h", "6h", "12h", "24h", "2d", "7d", "30d"]
		}
		timezone: "UTC"
		title:    "Kubernetes / Networking / Workload"
		uid:      "728bf77cc1166d2f3133bf25846876cc"
		version:  0
	}
}