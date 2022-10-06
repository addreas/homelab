package kube

goModVersions: {
	"github.com/VictoriaMetrics/operator":                                    "v0.26.3"
	"github.com/VictoriaMetrics/operator/api":                                "v0.0.0-20220726081834-58ec58fef476"
	"github.com/addreas/cuebuild-controller/api":                             "v0.18.2-cue"
	"github.com/bitnami-labs/sealed-secrets":                                 "v0.18.1"
	"github.com/cert-manager/cert-manager":                                   "v1.9.1"
	"github.com/cilium/cilium":                                               "v1.12.0"
	"github.com/fluxcd/helm-controller/api":                                  "v0.22.2"
	"github.com/fluxcd/kustomize-controller/api":                             "v0.26.3"
	"github.com/fluxcd/notification-controller/api":                          "v0.24.1"
	"github.com/fluxcd/source-controller/api":                                "v0.25.11"
	"github.com/grafana-operator/grafana-operator/v4":                        "v4.5.1"
	"github.com/k8snetworkplumbingwg/network-attachment-definition-client":   "v1.3.0"
	"github.com/ory/hydra-maester":                                           "v0.0.26"
	"github.com/pivotal/kpack":                                               "v0.6.1"
	"github.com/prometheus-operator/prometheus-operator/pkg/apis/monitoring": "v0.58.0"
	"k8s.io/api":                                                             "v0.24.3"
	"k8s.io/apimachinery":                                                    "v0.24.3"
	"k8s.io/kube-aggregator":                                                 "v0.24.3"
}
githubReleases: {
	"cloudflare/cloudflared":     "2022.10.0"
	"dani-garcia/vaultwarden":    "1.25.2"
	"grafana/grafana":            "v9.1.7"
	"home-assistant/core":        "2022.10.0"
	"jcmoraisjr/haproxy-ingress": "v0.13.9"
	"longhorn/longhorn":          "v1.2.5"
	"ory/hydra":                  "v1.11.10"
	"ory/kratos":                 "v0.10.1"
	"zwave-js/zwavejs2mqtt":      "v8.1.0"
}
some: {
	custom: tag: "1.2.3"
	optional?: _ | *"field"
	#def:      "field"
}
