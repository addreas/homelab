package kube

k: HelmRepository: "prometheus-community": spec: url: "https://prometheus-community.github.io/helm-charts"

k: HelmRelease: "prometheus-operator-crds": spec: chart: spec: {
	chart:   "prometheus-operator-crds"
	version: "32.0.1"
	sourceRef: name: "prometheus-community"
}

k: GitRepository: "kube-prometheus": spec: {
	interval: "30m"
	url:      "https://github.com/prometheus-operator/kube-prometheus"
	ref: tag: "v0.18.0"

	ignore: """
		/*
		!/manifests
		/manifests/*
		!/manifests/kubePrometheus-prometheusRule.yaml
		!/manifests/kubernetesControlPlane-prometheusRule.yaml
		!/manifests/kubernetesControlPlane-serviceMonitorApiserver.yaml
		!/manifests/kubernetesControlPlane-serviceMonitorCoreDNS.yaml
		!/manifests/kubernetesControlPlane-serviceMonitorKubeControllerManager.yaml
		!/manifests/kubernetesControlPlane-serviceMonitorKubelet.yaml
		!/manifests/kubernetesControlPlane-serviceMonitorKubeScheduler.yaml
		"""
}

k: Kustomization: "kube-prometheus": spec: {
	interval: "30m"
	timeout:  "2m"
	prune:    true
	wait:     false
	sourceRef: {
		kind: "GitRepository"
		name: "kube-prometheus"
	}
	path: "manifests"
}

k: HelmRelease: "kube-state-metrics": spec: {
	chart: spec: {
		chart:   "kube-state-metrics"
		version: "8.6.0"
		sourceRef: name: "prometheus-community"
	}
	values: prometheus: monitor: enabled: true
}

k: HelmRelease: "node-exporter": spec: {
	chart: spec: {
		chart:   "prometheus-node-exporter"
		version: "4.59.0"
		sourceRef: name: "prometheus-community"
	}
	values: {
		prometheus: monitor: enabled: true
		extraArgs: ["--no-collector.systemd"]
	}
}
