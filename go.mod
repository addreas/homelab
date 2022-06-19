module github.com/addreas/cuebernetes

go 1.15

require (
	github.com/VictoriaMetrics/operator v0.25.1
	github.com/VictoriaMetrics/operator/api v0.0.0-20220610062426-bd6cc1da1689
	github.com/addreas/cuebuild-controller/api v0.18.2-cue
	github.com/bitnami-labs/sealed-secrets v0.18.0
	github.com/cert-manager/cert-manager v1.8.0
	github.com/cilium/cilium v1.11.5
	github.com/fluxcd/helm-controller/api v0.22.1
	github.com/fluxcd/kustomize-controller/api v0.26.1
	github.com/fluxcd/notification-controller/api v0.24.0
	github.com/fluxcd/pkg/runtime v0.12.4 // indirect
	github.com/fluxcd/source-controller/api v0.25.5
	github.com/grafana-operator/grafana-operator/v4 v4.4.1
	github.com/k8snetworkplumbingwg/network-attachment-definition-client v1.3.0
	github.com/openshift/api v3.9.0+incompatible // indirect
	github.com/ory/hydra-maester v0.0.26
	github.com/pivotal/kpack v0.6.0
	github.com/prometheus-operator/prometheus-operator/pkg/apis/monitoring v0.57.0
	k8s.io/api v0.24.1
	k8s.io/apimachinery v0.24.1
	k8s.io/kube-aggregator v0.24.1
)

replace (
	github.com/optiopay/kafka => github.com/cilium/kafka v0.0.0-20180809090225-01ce283b732b
	go.universe.tf/metallb => github.com/cilium/metallb v0.1.1-0.20210831235406-48667b93284d

	k8s.io/client-go => k8s.io/client-go v0.23.2
)
