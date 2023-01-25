package kube

goModVersions: {
	"github.com/VictoriaMetrics/operator":                                    "v0.30.3"
	"github.com/VictoriaMetrics/operator/api":                                "v0.0.0-20230124212905-66ee8e544f48"
	"github.com/addreas/cuebuild-controller/api":                             "v0.18.2-cue"
	"github.com/bitnami-labs/sealed-secrets":                                 "v0.19.4"
	"github.com/cert-manager/cert-manager":                                   "v1.11.0"
	"github.com/cilium/cilium":                                               "v1.12.5"
	"github.com/fluxcd/helm-controller/api":                                  "v0.28.1"
	"github.com/fluxcd/kustomize-controller/api":                             "v0.32.0"
	"github.com/fluxcd/notification-controller/api":                          "v0.30.2"
	"github.com/fluxcd/source-controller/api":                                "v0.33.0"
	"github.com/grafana-operator/grafana-operator/v4":                        "v4.8.0"
	"github.com/k8snetworkplumbingwg/network-attachment-definition-client":   "v1.4.0"
	"github.com/ory/hydra-maester":                                           "v0.0.26"
	"github.com/pivotal/kpack":                                               "v0.9.2"
	"github.com/prometheus-operator/prometheus-operator/pkg/apis/monitoring": "v0.62.0"
	"k8s.io/api":                                                             "v0.26.1"
	"k8s.io/apimachinery":                                                    "v0.26.1"
	"k8s.io/kube-aggregator":                                                 "v0.26.1"
}
githubReleases: {
	"cloudflare/cloudflared":     "2022.12.1"
	"dani-garcia/vaultwarden":    "1.27.0"
	"esphome/esphome":            "2022.12.3"
	"grafana/grafana":            "v9.3.2"
	"home-assistant/core":        "2023.1.4"
	"jcmoraisjr/haproxy-ingress": "v0.14.0"
	"kubereboot/charts":          "kured-4.2.0"
	"longhorn/longhorn":          "v1.4.0"
	"ory/hydra":                  "v2.0.3"
	"ory/kratos":                 "v0.11.1"
	"zwave-js/zwave-js-ui":       "v8.6.3"
}
some: {
	custom: tag: "1.2.3"
	optional?: _ | *"field"
	#def:      "field"
}
