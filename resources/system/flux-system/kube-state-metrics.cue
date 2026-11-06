package kube

#fluxResource: {
	groupVersionKind: {
		group:   string
		version: string
		kind:    string
	}
	metricNamePrefix: "gotk"
	metrics: [{
		name: "resource_info"
		help: string
		each: {
			type: "Info"
			info: labelsFromPath: name: ["metadata", "name"]
		}
		labelsFromPath: {
			exported_namespace: ["metadata", "namespace"]
			ready: ["status", "conditions", "[type=Ready]", "status"]
			suspended: ["spec", "suspend"]
			...
		}
	}]
}

// renovate: registryUrl=https://prometheus-community.github.io/helm-charts
k: HelmRelease: "kube-state-metrics-flux": spec: {
	chart: spec: {
		chart:   "kube-state-metrics"
		version: "8.6.0"
		sourceRef: {
			name:      "prometheus-community"
			namespace: "monitoring"
		}
	}
	values: {
		collectors: []
		extraArgs: ["--custom-resource-state-only=true"]
		prometheus: monitor: {
			enabled:     true
			honorLabels: true
			jobLabel:    "app.kubernetes.io/instance"
		}
		rbac: extraRules: [{
			apiGroups: [
				"source.toolkit.fluxcd.io",
				"kustomize.toolkit.fluxcd.io",
				"helm.toolkit.fluxcd.io",
				"notification.toolkit.fluxcd.io",
				"image.toolkit.fluxcd.io",
			]
			resources: [
				"buckets",
				"gitrepositories",
				"helmcharts",
				"helmrepositories",
				"ocirepositories",
				"kustomizations",
				"helmreleases",
				"alerts",
				"providers",
				"receivers",
				"imagerepositories",
				"imagepolicies",
				"imageupdateautomations",
			]
			verbs: ["list", "watch"]
		}]
		customResourceState: {
			enabled: true
			config: spec: resources: [
				#fluxResource & {
					groupVersionKind: {group: "kustomize.toolkit.fluxcd.io", version: "v1", kind: "Kustomization"}
					metrics: [{
						help: "The current state of a Flux Kustomization resource."
						labelsFromPath: {
							revision: ["status", "lastAppliedRevision"]
							source_name: ["spec", "sourceRef", "name"]
						}
					}]
				},
				#fluxResource & {
					groupVersionKind: {group: "helm.toolkit.fluxcd.io", version: "v2", kind: "HelmRelease"}
					metrics: [{
						help: "The current state of a Flux HelmRelease resource."
						labelsFromPath: {
							revision: ["status", "history", "0", "chartVersion"]
							chart_name: ["status", "history", "0", "chartName"]
							chart_app_version: ["status", "history", "0", "appVersion"]
							chart_ref_name: ["spec", "chartRef", "name"]
							chart_source_name: ["spec", "chart", "spec", "sourceRef", "name"]
						}
					}]
				},
				#fluxResource & {
					groupVersionKind: {group: "source.toolkit.fluxcd.io", version: "v1", kind: "GitRepository"}
					metrics: [{
						help: "The current state of a Flux GitRepository resource."
						labelsFromPath: {
							revision: ["status", "artifact", "revision"]
							url: ["spec", "url"]
						}
					}]
				},
				#fluxResource & {
					groupVersionKind: {group: "source.toolkit.fluxcd.io", version: "v1", kind: "Bucket"}
					metrics: [{
						help: "The current state of a Flux Bucket resource."
						labelsFromPath: {
							revision: ["status", "artifact", "revision"]
							endpoint: ["spec", "endpoint"]
							bucket_name: ["spec", "bucketName"]
						}
					}]
				},
				#fluxResource & {
					groupVersionKind: {group: "source.toolkit.fluxcd.io", version: "v1", kind: "HelmRepository"}
					metrics: [{
						help: "The current state of a Flux HelmRepository resource."
						labelsFromPath: {
							revision: ["status", "artifact", "revision"]
							url: ["spec", "url"]
						}
					}]
				},
				#fluxResource & {
					groupVersionKind: {group: "source.toolkit.fluxcd.io", version: "v1", kind: "HelmChart"}
					metrics: [{
						help: "The current state of a Flux HelmChart resource."
						labelsFromPath: {
							revision: ["status", "artifact", "revision"]
							chart_name: ["spec", "chart"]
							chart_version: ["spec", "version"]
						}
					}]
				},
				#fluxResource & {
					groupVersionKind: {group: "source.toolkit.fluxcd.io", version: "v1", kind: "OCIRepository"}
					metrics: [{
						help: "The current state of a Flux OCIRepository resource."
						labelsFromPath: {
							revision: ["status", "artifact", "revision"]
							url: ["spec", "url"]
						}
					}]
				},
				#fluxResource & {
					groupVersionKind: {group: "notification.toolkit.fluxcd.io", version: "v1beta3", kind: "Alert"}
					metrics: [{
						help: "The current state of a Flux Alert resource."
					}]
				},
				#fluxResource & {
					groupVersionKind: {group: "notification.toolkit.fluxcd.io", version: "v1beta3", kind: "Provider"}
					metrics: [{
						help: "The current state of a Flux Provider resource."
					}]
				},
				#fluxResource & {
					groupVersionKind: {group: "notification.toolkit.fluxcd.io", version: "v1", kind: "Receiver"}
					metrics: [{
						help: "The current state of a Flux Receiver resource."
						labelsFromPath: webhook_path: ["status", "webhookPath"]
					}]
				},
				#fluxResource & {
					groupVersionKind: {group: "image.toolkit.fluxcd.io", version: "v1", kind: "ImageRepository"}
					metrics: [{
						help: "The current state of a Flux ImageRepository resource."
						labelsFromPath: image: ["spec", "image"]
					}]
				},
				#fluxResource & {
					groupVersionKind: {group: "image.toolkit.fluxcd.io", version: "v1", kind: "ImagePolicy"}
					metrics: [{
						help: "The current state of a Flux ImagePolicy resource."
						labelsFromPath: source_name: ["spec", "imageRepositoryRef", "name"]
					}]
				},
				#fluxResource & {
					groupVersionKind: {group: "image.toolkit.fluxcd.io", version: "v1", kind: "ImageUpdateAutomation"}
					metrics: [{
						help: "The current state of a Flux ImageUpdateAutomation resource."
						labelsFromPath: source_name: ["spec", "sourceRef", "name"]
					}]
				},
			]
		}
	}
}
