module github.com/addreas/cuebernetes

go 1.15

require (
	github.com/VictoriaMetrics/operator v0.29.0
	github.com/VictoriaMetrics/operator/api v0.0.0-20221024162246-3b7806b8ef7d
	github.com/addreas/cuebuild-controller/api v0.18.2-cue
	github.com/bitnami-labs/sealed-secrets v0.18.1
	github.com/cert-manager/cert-manager v1.10.0
	github.com/cilium/cilium v1.12.3
	github.com/fluxcd/helm-controller/api v0.26.0
	github.com/fluxcd/kustomize-controller/api v0.30.0
	github.com/fluxcd/notification-controller/api v0.28.0
	github.com/fluxcd/pkg/runtime v0.12.4 // indirect
	github.com/fluxcd/source-controller/api v0.31.0
	github.com/google/go-containerregistry/pkg/authn/kubernetes v0.0.0-20220516044946-14395f1b4b4e // indirect
	github.com/google/go-github/v42 v42.0.0 // indirect
	github.com/grafana-operator/grafana-operator/v4 v4.7.1
	github.com/hashicorp/vault/api/auth/approle v0.1.1 // indirect
	github.com/k8snetworkplumbingwg/network-attachment-definition-client v1.3.0
	github.com/openshift/api v3.9.0+incompatible // indirect
	github.com/ory/hydra-maester v0.0.26
	github.com/pavel-v-chernykh/keystore-go/v4 v4.2.0 // indirect
	github.com/pivotal/kpack v0.7.2
	github.com/prometheus-operator/prometheus-operator/pkg/apis/monitoring v0.60.1
	gopkg.in/go-playground/assert.v1 v1.2.1 // indirect
	gopkg.in/go-playground/validator.v9 v9.29.1 // indirect
	k8s.io/api v0.25.3
	k8s.io/apimachinery v0.25.3
	k8s.io/kube-aggregator v0.25.3
	k8s.io/legacy-cloud-providers v0.24.1 // indirect
)

replace (
	github.com/optiopay/kafka => github.com/cilium/kafka v0.0.0-20180809090225-01ce283b732b
	go.universe.tf/metallb => github.com/cilium/metallb v0.1.1-0.20210831235406-48667b93284d

	k8s.io/client-go => k8s.io/client-go v0.23.2
)
