module github.com/addreas/cuebernetes

go 1.15

require (
	github.com/VictoriaMetrics/operator v0.19.1
	github.com/addreas/cuebuild-controller/api v0.9.1-cue
	github.com/bitnami-labs/sealed-secrets v0.16.0
	github.com/cilium/cilium v1.10.5
	github.com/fluxcd/helm-controller/api v0.12.1
	github.com/fluxcd/kustomize-controller/api v0.16.0
	github.com/fluxcd/source-controller/api v0.16.0
	github.com/integr8ly/grafana-operator v1.4.1-0.20210512082324-fe0020ab7b75
	github.com/jetstack/cert-manager v1.5.4
	github.com/k8snetworkplumbingwg/network-attachment-definition-client v1.2.0
	github.com/pivotal/kpack v0.4.0
	github.com/prometheus-operator/prometheus-operator/pkg/apis/monitoring v0.51.2
	k8s.io/api v0.22.2
	k8s.io/apimachinery v0.22.2
)

replace (
	github.com/optiopay/kafka => github.com/cilium/kafka v0.0.0-20180809090225-01ce283b732b
	k8s.io/client-go => k8s.io/client-go v0.22.2
)
