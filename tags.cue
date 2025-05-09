package kube

goModVersions: {
	"github.com/addreas/cue-controller/api":                                  "v1.0.0-rc1-cue"
	"github.com/cert-manager/cert-manager":                                   "v1.17.2"
	"github.com/fluxcd/helm-controller/api":                                  "v1.2.0"
	"github.com/fluxcd/kustomize-controller/api":                             "v1.5.1"
	"github.com/fluxcd/notification-controller/api":                          "v1.5.0"
	"github.com/fluxcd/source-controller/api":                                "v1.5.0"
	"github.com/k8snetworkplumbingwg/network-attachment-definition-client":   "v1.7.6"
	"github.com/ory/hydra-maester":                                           "v0.0.36"
	"github.com/prometheus-operator/prometheus-operator/pkg/apis/monitoring": "v0.82.0"
	"k8s.io/api":                                                             "v0.33.0"
	"k8s.io/apimachinery":                                                    "v0.33.0"
	"k8s.io/kube-aggregator":                                                 "v0.33.0"
	"github.com/bitnami-labs/sealed-secrets":                                 "v0.29.0"
	"github.com/cilium/cilium":                                               "v1.17.3"
	"github.com/grafana-operator/grafana-operator/v5":                        "v5.17.1"
}
githubReleases: {
	"cloudflare/cloudflared":     "2025.4.2"
	"dani-garcia/vaultwarden":    "1.33.2"
	"esphome/esphome":            "2025.4.1"
	"grafana/grafana":            "v11.6.1"
	"home-assistant/core":        "2025.4.4"
	"jcmoraisjr/haproxy-ingress": "v0.14.8"
	"kubereboot/charts":          "kured-5.6.1"
	"longhorn/longhorn":          "v1.8.1"
	"ory/hydra":                  "v2.3.0"
	"ory/kratos":                 "v1.3.1"
	"zwave-js/zwave-js-ui":       "v10.3.3"
}
otherTags: {
	"grafana/helm-charts/agent-operator": "0.2.15"
	"fluxcd/flux2":                       "v2.4.0"
}
