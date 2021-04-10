module github.com/addreas/cuebernetes

go 1.15

require (
	github.com/addreas/cuebuild-controller/api v0.9.1-cue
	github.com/bitnami-labs/sealed-secrets v0.15.0
	github.com/cilium/cilium v1.9.5
	github.com/fluxcd/helm-controller/api v0.9.0
	github.com/fluxcd/kustomize-controller/api v0.11.0
	github.com/fluxcd/source-controller/api v0.11.0
	github.com/integr8ly/grafana-operator v1.4.0
	github.com/jetstack/cert-manager v1.3.0
	github.com/k8snetworkplumbingwg/network-attachment-definition-client v1.1.0
	github.com/prometheus-operator/prometheus-operator/pkg/apis/monitoring v0.46.0
	k8s.io/api v0.21.0
	k8s.io/apimachinery v0.21.0
)

replace (
	github.com/integr8ly/grafana-operator => github.com/HubertStefanski/grafana-operator v1.4.1-0.20210305130532-56f3db9c9987
	github.com/optiopay/kafka => github.com/cilium/kafka v0.0.0-20180809090225-01ce283b732b
	k8s.io/client-go => k8s.io/client-go v0.21.0
)
