package kube

goModVersions: {
	"github.com/addreas/cue-controller/api":                                  "v1.0.0-rc1-cue"
	"github.com/cert-manager/cert-manager":                                   "v1.16.1"
	"github.com/fluxcd/helm-controller/api":                                  "v1.1.0"
	"github.com/fluxcd/kustomize-controller/api":                             "v1.4.0"
	"github.com/fluxcd/notification-controller/api":                          "v1.4.0"
	"github.com/fluxcd/source-controller/api":                                "v1.4.1"
	"github.com/k8snetworkplumbingwg/network-attachment-definition-client":   "v1.7.5"
	"github.com/ory/hydra-maester":                                           "v0.0.35"
	"github.com/prometheus-operator/prometheus-operator/pkg/apis/monitoring": "v0.77.2"
	"k8s.io/api":                                                             "v0.31.2"
	"k8s.io/apimachinery":                                                    "v0.31.2"
	"k8s.io/kube-aggregator":                                                 "v0.31.2"
	"github.com/bitnami-labs/sealed-secrets":                                 "v0.27.1"
	"github.com/cilium/cilium":                                               "v1.16.3"
	"github.com/grafana-operator/grafana-operator/v5":                        "v5.14.0"
}
githubReleases: {
	"cloudflare/cloudflared":     "2024.10.1"
	"dani-garcia/vaultwarden":    "1.32.2"
	"esphome/esphome":            "2024.10.2"
	"grafana/grafana":            "v11.3.0"
	"home-assistant/core":        "2024.10.4"
	"jcmoraisjr/haproxy-ingress": "v0.14.7"
	"kubereboot/charts":          "kured-5.5.0"
	"longhorn/longhorn":          "v1.7.2"
	"ory/hydra":                  "v2.2.0"
	"ory/kratos":                 "v1.3.0"
	"zwave-js/zwave-js-ui":       "v9.25.0"
}
otherTags: {
	"grafana/helm-charts/agent-operator": "0.2.15"
	"fluxcd/flux2":                       "v2.2.2"
}
