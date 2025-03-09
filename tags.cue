package kube

goModVersions: {
	"github.com/addreas/cue-controller/api":                                  "v1.0.0-rc1-cue"
	"github.com/cert-manager/cert-manager":                                   "v1.17.1"
	"github.com/fluxcd/helm-controller/api":                                  "v1.2.0"
	"github.com/fluxcd/kustomize-controller/api":                             "v1.5.1"
	"github.com/fluxcd/notification-controller/api":                          "v1.5.0"
	"github.com/fluxcd/source-controller/api":                                "v1.5.0"
	"github.com/k8snetworkplumbingwg/network-attachment-definition-client":   "v1.7.5"
	"github.com/ory/hydra-maester":                                           "v0.0.36"
	"github.com/prometheus-operator/prometheus-operator/pkg/apis/monitoring": "v0.80.1"
	"k8s.io/api":                                                             "v0.32.2"
	"k8s.io/apimachinery":                                                    "v0.32.2"
	"k8s.io/kube-aggregator":                                                 "v0.32.2"
	"github.com/bitnami-labs/sealed-secrets":                                 "v0.28.0"
	"github.com/cilium/cilium":                                               "v1.17.1"
	"github.com/grafana-operator/grafana-operator/v5":                        "v5.16.0"
}
githubReleases: {
	"cloudflare/cloudflared":     "2025.2.1"
	"dani-garcia/vaultwarden":    "1.33.2"
	"esphome/esphome":            "2025.2.2"
	"grafana/grafana":            "v11.5.2"
	"home-assistant/core":        "2025.3.1"
	"jcmoraisjr/haproxy-ingress": "v0.14.7"
	"kubereboot/charts":          "kured-5.6.1"
	"longhorn/longhorn":          "v1.8.1"
	"ory/hydra":                  "v2.3.0"
	"ory/kratos":                 "v1.3.1"
	"zwave-js/zwave-js-ui":       "v9.31.0"
}
otherTags: {
	"grafana/helm-charts/agent-operator": "0.2.15"
	"fluxcd/flux2":                       "v2.4.0"
}
