package kube

goModVersions: {
	"github.com/VictoriaMetrics/operator":                                    "v0.29.0"
	"github.com/VictoriaMetrics/operator/api":                                "v0.0.0-20221024162246-3b7806b8ef7d"
	"github.com/addreas/cuebuild-controller/api":                             "v0.18.2-cue"
	"github.com/bitnami-labs/sealed-secrets":                                 "v0.18.1"
	"github.com/cert-manager/cert-manager":                                   "v1.10.0"
	"github.com/cilium/cilium":                                               "v1.12.3"
	"github.com/fluxcd/helm-controller/api":                                  "v0.26.0"
	"github.com/fluxcd/kustomize-controller/api":                             "v0.30.0"
	"github.com/fluxcd/notification-controller/api":                          "v0.28.0"
	"github.com/fluxcd/source-controller/api":                                "v0.31.0"
	"github.com/grafana-operator/grafana-operator/v4":                        "v4.7.1"
	"github.com/k8snetworkplumbingwg/network-attachment-definition-client":   "v1.3.0"
	"github.com/ory/hydra-maester":                                           "v0.0.26"
	"github.com/pivotal/kpack":                                               "v0.7.2"
	"github.com/prometheus-operator/prometheus-operator/pkg/apis/monitoring": "v0.60.1"
	"k8s.io/api":                                                             "v0.25.3"
	"k8s.io/apimachinery":                                                    "v0.25.3"
	"k8s.io/kube-aggregator":                                                 "v0.25.3"
}
githubReleases: {
	"cloudflare/cloudflared":     "2022.10.3"
	"dani-garcia/vaultwarden":    "1.26.0"
	"grafana/grafana":            "v9.2.3"
	"home-assistant/core":        "2022.11.1"
	"jcmoraisjr/haproxy-ingress": "v0.13.9"
	"longhorn/longhorn":          "v1.3.2"
	"ory/hydra":                  "v2.0.1"
	"ory/kratos":                 "v0.10.1"
	"zwave-js/zwave-js-ui":       "v8.3.0"
}
some: {
	custom: tag: "1.2.3"
	optional?: _ | *"field"
	#def:      "field"
}
