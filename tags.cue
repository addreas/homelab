package kube

goModVersions: {
	"github.com/addreas/cue-controller/api":                                  "v1.0.0-rc1-cue"
	"github.com/bitnami-labs/sealed-secrets":                                 "v0.24.5"
	"github.com/cert-manager/cert-manager":                                   "v1.15.1"
	"github.com/cilium/cilium":                                               "v1.16.1"
	"github.com/fluxcd/helm-controller/api":                                  "v1.0.1"
	"github.com/fluxcd/kustomize-controller/api":                             "v1.3.0"
	"github.com/fluxcd/notification-controller/api":                          "v1.3.0"
	"github.com/fluxcd/source-controller/api":                                "v1.3.0"
	"github.com/grafana-operator/grafana-operator/v5":                        "v5.6.0"
	"github.com/k8snetworkplumbingwg/network-attachment-definition-client":   "v1.7.0"
	"github.com/ory/hydra-maester":                                           "v0.0.34"
	"github.com/prometheus-operator/prometheus-operator/pkg/apis/monitoring": "v0.75.0"
	"k8s.io/api":                                                             "v0.30.2"
	"k8s.io/apimachinery":                                                    "v0.30.2"
	"k8s.io/kube-aggregator":                                                 "v0.30.2"
}
githubReleases: {
	"cloudflare/cloudflared":     "2024.6.1"
	"dani-garcia/vaultwarden":    "1.30.5"
	"esphome/esphome":            "2024.6.4"
	"grafana/grafana":            "v11.1.0"
	"home-assistant/core":        "2024.7.0b2"
	"jcmoraisjr/haproxy-ingress": "v0.14.7"
	"kubereboot/charts":          "kured-5.4.5"
	"longhorn/longhorn":          "v1.6.2"
	"ory/hydra":                  "v2.2.0"
	"ory/kratos":                 "v1.2.0"
	"zwave-js/zwave-js-ui":       "v9.14.4"
}
otherTags: {
	"grafana/helm-charts/agent-operator": "0.2.15"
	"fluxcd/flux2":                       "v2.2.2"
}
