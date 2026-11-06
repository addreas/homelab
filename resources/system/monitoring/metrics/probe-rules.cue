package kube

k: PrometheusRule: "probes": {
	metadata: labels: ruler: "metrics"
	spec: groups: [{
		name: "probes.rules"
		rules: [{
			alert: "ProbeFail"
			annotations: {
				description: "Probe of {{ $labels.instance }} (job {{ $labels.job }}) has been failing for 5 minutes."
				summary:     "Probe target is failing."
			}
			expr: "probe_success == 0"
			for:  "5m"
			labels: severity: "warning"
		}]
	}]
}
