package kube

goModVersions: {
	"github.com/VictoriaMetrics/operator":                                    "v0.30.4"
	"github.com/VictoriaMetrics/operator/api":                                "v0.0.0-20230127011203-f0a634174e3d"
	"github.com/addreas/cuebuild-controller/api":                             "v0.18.2-cue"
	"github.com/bitnami-labs/sealed-secrets":                                 "v0.19.4"
	"github.com/cert-manager/cert-manager":                                   "v1.11.0"
	"github.com/cilium/cilium":                                               "v1.12.6"
	"github.com/fluxcd/helm-controller/api":                                  "v0.29.0"
	"github.com/fluxcd/kustomize-controller/api":                             "v0.33.0"
	"github.com/fluxcd/notification-controller/api":                          "v0.31.0"
	"github.com/fluxcd/source-controller/api":                                "v0.34.0"
	"github.com/grafana-operator/grafana-operator/v4":                        "v4.8.0"
	"github.com/k8snetworkplumbingwg/network-attachment-definition-client":   "v1.4.0"
	"github.com/ory/hydra-maester":                                           "v0.0.26"
	"github.com/pivotal/kpack":                                               "v0.9.2"
	"github.com/prometheus-operator/prometheus-operator/pkg/apis/monitoring": "v0.63.0"
	"k8s.io/api":                                                             "v0.26.1"
	"k8s.io/apimachinery":                                                    "v0.26.1"
	"k8s.io/kube-aggregator":                                                 "v0.26.1"
}
githubReleases: {
	"cloudflare/cloudflared":     "2023.2.1"
	"dani-garcia/vaultwarden":    "1.27.0"
	"esphome/esphome":            "2022.12.8"
	"grafana/grafana":            "v9.3.6"
	"home-assistant/core":        "2023.2.3"
	"jcmoraisjr/haproxy-ingress": "v0.14.0"
	"kubereboot/charts":          "kured-4.4.1"
	"longhorn/longhorn":          "v1.4.0"
	"ory/hydra":                  "v2.0.3"
	"ory/kratos":                 "v0.11.1"
	"zwave-js/zwave-js-ui":       "v8.8.5"
}
some: {
	custom: tag: "1.2.3"
	optional?: _ | *"field"
	#def:      "field"
}
