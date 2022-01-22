module github.com/addreas/cuebernetes

go 1.15

require (
	github.com/VictoriaMetrics/operator v0.21.0
	github.com/addreas/cuebuild-controller/api v0.18.2-cue
	github.com/bitnami-labs/sealed-secrets v0.17.2
	github.com/cilium/cilium v1.11.1
	github.com/fluxcd/helm-controller/api v0.15.0
	github.com/fluxcd/kustomize-controller/api v0.19.1
	github.com/fluxcd/source-controller/api v0.21.0
	github.com/grafana-operator/grafana-operator/v4 v4.1.1
	github.com/jetstack/cert-manager v1.6.1
	github.com/k8snetworkplumbingwg/network-attachment-definition-client v1.2.0
	github.com/libgit2/git2go/v31 v31.4.14 // indirect
	github.com/ory/hydra-maester v0.0.26
	github.com/pivotal/kpack v0.5.0
	github.com/prometheus-operator/prometheus-operator/pkg/apis/monitoring v0.53.1
	k8s.io/api v0.23.2
	k8s.io/apimachinery v0.23.2
	k8s.io/kube-aggregator v0.23.2
)

replace (
	github.com/optiopay/kafka => github.com/cilium/kafka v0.0.0-20180809090225-01ce283b732b
	go.universe.tf/metallb => github.com/cilium/metallb v0.1.1-0.20210831235406-48667b93284d

	k8s.io/client-go => k8s.io/client-go v0.23.2
)
