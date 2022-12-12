package kube

goModVersions: {
	"github.com/VictoriaMetrics/operator":                                    "v0.29.2"
	"github.com/VictoriaMetrics/operator/api":                                "v0.0.0-20221208160124-1d9067a035d2"
	"github.com/addreas/cuebuild-controller/api":                             "v0.18.2-cue"
	"github.com/bitnami-labs/sealed-secrets":                                 "v0.19.2"
	"github.com/cert-manager/cert-manager":                                   "v1.10.1"
	"github.com/cilium/cilium":                                               "v1.12.4"
	"github.com/fluxcd/helm-controller/api":                                  "v0.27.0"
	"github.com/fluxcd/kustomize-controller/api":                             "v0.31.0"
	"github.com/fluxcd/notification-controller/api":                          "v0.29.1"
	"github.com/fluxcd/source-controller/api":                                "v0.32.1"
	"github.com/grafana-operator/grafana-operator/v4":                        "v4.8.0"
	"github.com/k8snetworkplumbingwg/network-attachment-definition-client":   "v1.4.0"
	"github.com/ory/hydra-maester":                                           "v0.0.26"
	"github.com/pivotal/kpack":                                               "v0.8.2"
	"github.com/prometheus-operator/prometheus-operator/pkg/apis/monitoring": "v0.61.1"
	"k8s.io/api":                                                             "v0.26.0"
	"k8s.io/apimachinery":                                                    "v0.26.0"
	"k8s.io/kube-aggregator":                                                 "v0.26.0"
}
githubReleases: {
	"cloudflare/cloudflared":     "2022.11.1"
	"dani-garcia/vaultwarden":    "1.26.0"
	"grafana/grafana":            "v9.3.1"
	"home-assistant/core":        "2022.12.3"
	"jcmoraisjr/haproxy-ingress": "v0.13.9"
	"longhorn/longhorn":          "v1.3.2"
	"ory/hydra":                  "v2.0.3"
	"ory/kratos":                 "v0.11.0"
	"zwave-js/zwave-js-ui":       "v8.6.0"
}
some: {
	custom: tag: "1.2.3"
	optional?: _ | *"field"
	#def:      "field"
}
