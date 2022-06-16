package kube

goModVersions: {
	"github.com/VictoriaMetrics/operator":                                    "v0.25.1"
	"github.com/VictoriaMetrics/operator/api":                                "v0.0.0-20220610062426-bd6cc1da1689"
	"github.com/addreas/cuebuild-controller/api":                             "v0.18.2-cue"
	"github.com/bitnami-labs/sealed-secrets":                                 "v0.18.0"
	"github.com/cert-manager/cert-manager":                                   "v1.8.0"
	"github.com/cilium/cilium":                                               "v1.11.5"
	"github.com/fluxcd/helm-controller/api":                                  "v0.22.1"
	"github.com/fluxcd/kustomize-controller/api":                             "v0.26.1"
	"github.com/fluxcd/source-controller/api":                                "v0.25.5"
	"github.com/grafana-operator/grafana-operator/v4":                        "v4.4.1"
	"github.com/k8snetworkplumbingwg/network-attachment-definition-client":   "v1.3.0"
	"github.com/ory/hydra-maester":                                           "v0.0.26"
	"github.com/pivotal/kpack":                                               "v0.6.0"
	"github.com/prometheus-operator/prometheus-operator/pkg/apis/monitoring": "v0.57.0"
	"k8s.io/api":                                                             "v0.24.1"
	"k8s.io/apimachinery":                                                    "v0.24.1"
	"k8s.io/kube-aggregator":                                                 "v0.24.1"
}
githubReleases: {
	"dani-garcia/vaultwarden":    "1.25.0"
	"grafana/grafana":            "v8.5.6"
	"home-assistant/core":        "2022.6.6"
	"jcmoraisjr/haproxy-ingress": "v0.13.7"
	"longhorn/longhorn":          "v1.3.0"
	"ory/hydra":                  "v1.11.8"
	"ory/kratos":                 "v0.10.1"
	"zwave-js/zwavejs2mqtt":      "v6.12.0"
}
some: {
	custom: tag: "1.2.3"
	optional?: "field"
	#def:      "field"
}
