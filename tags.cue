package kube

goModVersions: {
	"github.com/addreas/cue-controller/api":                                  "v1.0.0-rc1-cue"
	"github.com/cert-manager/cert-manager":                                   "v1.16.3"
	"github.com/fluxcd/helm-controller/api":                                  "v1.1.0"
	"github.com/fluxcd/kustomize-controller/api":                             "v1.4.0"
	"github.com/fluxcd/notification-controller/api":                          "v1.4.0"
	"github.com/fluxcd/source-controller/api":                                "v1.4.1"
	"github.com/k8snetworkplumbingwg/network-attachment-definition-client":   "v1.7.5"
	"github.com/ory/hydra-maester":                                           "v0.0.36"
	"github.com/prometheus-operator/prometheus-operator/pkg/apis/monitoring": "v0.79.2"
	"k8s.io/api":                                                             "v0.32.1"
	"k8s.io/apimachinery":                                                    "v0.32.1"
	"k8s.io/kube-aggregator":                                                 "v0.32.1"
	"github.com/bitnami-labs/sealed-secrets":                                 "v0.27.3"
	"github.com/cilium/cilium":                                               "v1.16.5"
	"github.com/grafana-operator/grafana-operator/v5":                        "v5.15.1"
}
githubReleases: {
	"cloudflare/cloudflared":     "2025.1.0"
	"dani-garcia/vaultwarden":    "1.32.7"
	"esphome/esphome":            "2024.12.4"
	"grafana/grafana":            "v11.4.0"
	"home-assistant/core":        "2025.1.2"
	"jcmoraisjr/haproxy-ingress": "v0.14.7"
	"kubereboot/charts":          "kured-5.6.0"
	"longhorn/longhorn":          "v1.7.2"
	"ory/hydra":                  "v2.3.0"
	"ory/kratos":                 "v1.3.1"
	"zwave-js/zwave-js-ui":       "v9.29.1"
}
otherTags: {
	"grafana/helm-charts/agent-operator": "0.2.15"
	"fluxcd/flux2":                       "v2.2.2"
}
