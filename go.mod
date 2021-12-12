module github.com/addreas/cuebernetes

go 1.15

require (
	github.com/VictoriaMetrics/operator v0.21.0
	github.com/addreas/cuebuild-controller/api v0.16.0-cue
	github.com/bitnami-labs/sealed-secrets v0.17.0
	github.com/cilium/cilium v1.10.6
	github.com/fluxcd/helm-controller/api v0.14.1
	github.com/fluxcd/kustomize-controller/api v0.18.2
	github.com/fluxcd/source-controller/api v0.19.2
	github.com/grafana-operator/grafana-operator/v4 v4.1.0
	github.com/jetstack/cert-manager v1.6.1
	github.com/k8snetworkplumbingwg/network-attachment-definition-client v1.2.0
	github.com/pivotal/kpack v0.4.3
	github.com/prometheus-operator/prometheus-operator/pkg/apis/monitoring v0.52.1
	k8s.io/api v0.22.4
	k8s.io/apimachinery v0.22.4
)

replace (
	github.com/optiopay/kafka => github.com/cilium/kafka v0.0.0-20180809090225-01ce283b732b
	k8s.io/client-go => k8s.io/client-go v0.22.4
)
