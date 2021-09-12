module github.com/addreas/cuebernetes

go 1.15

require (
	github.com/VictoriaMetrics/operator v0.14.2
	github.com/addreas/cuebuild-controller/api v0.9.1-cue
	github.com/bitnami-labs/sealed-secrets v0.16.0
	github.com/cilium/cilium v1.9.7
	github.com/fluxcd/helm-controller/api v0.10.1
	github.com/fluxcd/kustomize-controller/api v0.12.0
	github.com/fluxcd/source-controller/api v0.12.2
	github.com/integr8ly/grafana-operator v1.4.1-0.20210512082324-fe0020ab7b75
	github.com/jetstack/cert-manager v1.3.1
	github.com/k8snetworkplumbingwg/network-attachment-definition-client v1.1.0
	github.com/pivotal/kpack v0.3.2-0.20210909190601-3e978d54b5f9
	github.com/prometheus-operator/prometheus-operator/pkg/apis/monitoring v0.47.1
	k8s.io/api v0.21.0
	k8s.io/apimachinery v0.21.0
)

replace (
	github.com/optiopay/kafka => github.com/cilium/kafka v0.0.0-20180809090225-01ce283b732b
	k8s.io/client-go => k8s.io/client-go v0.21.0
)
