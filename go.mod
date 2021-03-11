module github.com/addreas/cuebernetes

go 1.15

require (
	github.com/addreas/cuebuild-controller/api v0.9.1-cue
	github.com/bitnami-labs/sealed-secrets v0.15.0
	github.com/cilium/cilium v1.9.4
	github.com/fluxcd/helm-controller/api v0.8.0
	github.com/fluxcd/kustomize-controller/api v0.9.1
	github.com/fluxcd/source-controller/api v0.9.0
	github.com/jetstack/cert-manager v1.2.0
	github.com/k8snetworkplumbingwg/network-attachment-definition-client v1.1.0
	github.com/prometheus-operator/prometheus-operator/pkg/apis/monitoring v0.46.0
	k8s.io/api v0.20.4
	k8s.io/apimachinery v0.20.4
)

replace github.com/optiopay/kafka => github.com/cilium/kafka v0.0.0-20180809090225-01ce283b732b
