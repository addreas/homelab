package dashboards

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
				expr:           "sum(container_memory_rss{job=\"cadvisor\", cluster=\"$cluster\", container!=\"\"}) by (namespace)"
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
				expr:           "sum(container_memory_rss{job=\"cadvisor\", cluster=\"$cluster\", container!=\"\"}) by (namespace)"
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
				expr:           "sum(container_memory_rss{job=\"cadvisor\", cluster=\"$cluster\", container!=\"\"}) by (namespace) / sum(namespace_memory:kube_pod_container_resource_requests:sum{cluster=\"$cluster\"}) by (namespace)"
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
				expr:           "sum(container_memory_rss{job=\"cadvisor\", cluster=\"$cluster\", container!=\"\"}) by (namespace) / sum(namespace_memory:kube_pod_container_resource_limits:sum{cluster=\"$cluster\"}) by (namespace)"
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
				expr:           "sum(irate(container_network_receive_bytes_total{job=\"cadvisor\", cluster=\"$cluster\", namespace=~\".+\"}[$__rate_interval])) by (namespace)"
				format:         "table"
				instant:        true
				intervalFactor: 2
				legendFormat:   ""
				refId:          "A"
				step:           10
			}, {
				expr:           "sum(irate(container_network_transmit_bytes_total{job=\"cadvisor\", cluster=\"$cluster\", namespace=~\".+\"}[$__rate_interval])) by (namespace)"
				format:         "table"
				instant:        true
				intervalFactor: 2
				legendFormat:   ""
				refId:          "B"
				step:           10
			}, {
				expr:           "sum(irate(container_network_receive_packets_total{job=\"cadvisor\", cluster=\"$cluster\", namespace=~\".+\"}[$__rate_interval])) by (namespace)"
				format:         "table"
				instant:        true
				intervalFactor: 2
				legendFormat:   ""
				refId:          "C"
				step:           10
			}, {
				expr:           "sum(irate(container_network_transmit_packets_total{job=\"cadvisor\", cluster=\"$cluster\", namespace=~\".+\"}[$__rate_interval])) by (namespace)"
				format:         "table"
				instant:        true
				intervalFactor: 2
				legendFormat:   ""
				refId:          "D"
				step:           10
			}, {
				expr:           "sum(irate(container_network_receive_packets_dropped_total{job=\"cadvisor\", cluster=\"$cluster\", namespace=~\".+\"}[$__rate_interval])) by (namespace)"
				format:         "table"
				instant:        true
				intervalFactor: 2
				legendFormat:   ""
				refId:          "E"
				step:           10
			}, {
				expr:           "sum(irate(container_network_transmit_packets_dropped_total{job=\"cadvisor\", cluster=\"$cluster\", namespace=~\".+\"}[$__rate_interval])) by (namespace)"
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
				expr:           "sum(irate(container_network_receive_bytes_total{job=\"cadvisor\", cluster=\"$cluster\", namespace=~\".+\"}[$__rate_interval])) by (namespace)"
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
				expr:           "sum(irate(container_network_transmit_bytes_total{job=\"cadvisor\", cluster=\"$cluster\", namespace=~\".+\"}[$__rate_interval])) by (namespace)"
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
				expr:           "avg(irate(container_network_receive_bytes_total{job=\"cadvisor\", cluster=\"$cluster\", namespace=~\".+\"}[$__rate_interval])) by (namespace)"
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
				expr:           "avg(irate(container_network_transmit_bytes_total{job=\"cadvisor\", cluster=\"$cluster\", namespace=~\".+\"}[$__rate_interval])) by (namespace)"
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
				expr:           "sum(irate(container_network_receive_packets_total{job=\"cadvisor\", cluster=\"$cluster\", namespace=~\".+\"}[$__rate_interval])) by (namespace)"
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
				expr:           "sum(irate(container_network_transmit_packets_total{job=\"cadvisor\", cluster=\"$cluster\", namespace=~\".+\"}[$__rate_interval])) by (namespace)"
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
				expr:           "sum(irate(container_network_receive_packets_dropped_total{job=\"cadvisor\", cluster=\"$cluster\", namespace=~\".+\"}[$__rate_interval])) by (namespace)"
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
				expr:           "sum(irate(container_network_transmit_packets_dropped_total{job=\"cadvisor\", cluster=\"$cluster\", namespace=~\".+\"}[$__rate_interval])) by (namespace)"
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
				expr:           "ceil(sum by(namespace) (rate(container_fs_reads_total{job=\"cadvisor\", container!=\"\", cluster=\"$cluster\"}[$__rate_interval]) + rate(container_fs_writes_total{job=\"cadvisor\", container!=\"\", cluster=\"$cluster\"}[$__rate_interval])))"
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
				expr:           "sum by(namespace) (rate(container_fs_reads_bytes_total{job=\"cadvisor\", container!=\"\", cluster=\"$cluster\"}[$__rate_interval]) + rate(container_fs_writes_bytes_total{job=\"cadvisor\", container!=\"\", cluster=\"$cluster\"}[$__rate_interval]))"
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
				expr:           "sum by(namespace) (rate(container_fs_reads_total{job=\"cadvisor\", container!=\"\", cluster=\"$cluster\"}[$__rate_interval]))"
				format:         "table"
				instant:        true
				intervalFactor: 2
				legendFormat:   ""
				refId:          "A"
				step:           10
			}, {
				expr:           "sum by(namespace) (rate(container_fs_writes_total{job=\"cadvisor\", container!=\"\", cluster=\"$cluster\"}[$__rate_interval]))"
				format:         "table"
				instant:        true
				intervalFactor: 2
				legendFormat:   ""
				refId:          "B"
				step:           10
			}, {
				expr:           "sum by(namespace) (rate(container_fs_reads_total{job=\"cadvisor\", container!=\"\", cluster=\"$cluster\"}[$__rate_interval]) + rate(container_fs_writes_total{job=\"cadvisor\", container!=\"\", cluster=\"$cluster\"}[$__rate_interval]))"
				format:         "table"
				instant:        true
				intervalFactor: 2
				legendFormat:   ""
				refId:          "C"
				step:           10
			}, {
				expr:           "sum by(namespace) (rate(container_fs_reads_bytes_total{job=\"cadvisor\", container!=\"\", cluster=\"$cluster\"}[$__rate_interval]))"
				format:         "table"
				instant:        true
				intervalFactor: 2
				legendFormat:   ""
				refId:          "D"
				step:           10
			}, {
				expr:           "sum by(namespace) (rate(container_fs_writes_bytes_total{job=\"cadvisor\", container!=\"\", cluster=\"$cluster\"}[$__rate_interval]))"
				format:         "table"
				instant:        true
				intervalFactor: 2
				legendFormat:   ""
				refId:          "E"
				step:           10
			}, {
				expr:           "sum by(namespace) (rate(container_fs_reads_bytes_total{job=\"cadvisor\", container!=\"\", cluster=\"$cluster\"}[$__rate_interval]) + rate(container_fs_writes_bytes_total{job=\"cadvisor\", container!=\"\", cluster=\"$cluster\"}[$__rate_interval]))"
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
		query:          "label_values(up{job=\"cadvisor\"}, cluster)"
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