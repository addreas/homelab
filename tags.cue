package kube

goModVersions: {
	"github.com/VictoriaMetrics/operator":                                    "v0.32.1"
	"github.com/VictoriaMetrics/operator/api":                                "v0.0.0-20230317154527-2d9c7c5fd84e"
	"github.com/addreas/cue-controller/api":                                  "v0.35.0-cue"
	"github.com/addreas/cuebuild-controller/api":                             "v0.18.2-cue"
	"github.com/bitnami-labs/sealed-secrets":                                 "v0.20.1"
	"github.com/cert-manager/cert-manager":                                   "v1.11.0"
	"github.com/cilium/cilium":                                               "v1.13.1"
	"github.com/fluxcd/helm-controller/api":                                  "v0.31.1"
	"github.com/fluxcd/kustomize-controller/api":                             "v0.35.0"
	"github.com/fluxcd/notification-controller/api":                          "v0.33.0"
	"github.com/fluxcd/source-controller/api":                                "v0.36.0"
	"github.com/grafana-operator/grafana-operator/v4":                        "v4.10.0"
	"github.com/k8snetworkplumbingwg/network-attachment-definition-client":   "v1.4.0"
	"github.com/ory/hydra-maester":                                           "v0.0.26"
	"github.com/pivotal/kpack":                                               "v0.10.1"
	"github.com/prometheus-operator/prometheus-operator/pkg/apis/monitoring": "v0.63.0"
	"k8s.io/api":                                                             "v0.26.3"
	"k8s.io/apimachinery":                                                    "v0.26.3"
	"k8s.io/kube-aggregator":                                                 "v0.26.3"
}
githubReleases: {
	"cloudflare/cloudflared":      "2023.3.1"
	"dani-garcia/vaultwarden":     "1.27.0"
	"esphome/esphome":             "2023.3.0"
	"grafana/grafana":             "v9.4.3"
	"home-assistant/core":         "2023.3.5"
	"jcmoraisjr/haproxy-ingress":  "v0.14.2"
	"kubereboot/charts":           "kured-4.4.2"
	"longhorn/longhorn":           "v1.4.1"
	"ory/hydra":                   "v2.0.3"
	"ory/kratos":                  "v0.11.1"
	"zwave-js/zwave-js-ui":        "v8.11.0"
	"jonasdahl/logger":            "sha-8b0ced1"
	"jonasdahl/soltidtabellen.se": "sha-dcbe383"
}
some: {
	custom: tag: "1.2.3"
	optional?: _ | *"field"
	#def:      "field"
}
