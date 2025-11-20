package kube

import (
	"strings"

	apps_v1 "cue.dev/x/k8s.io/api/apps/v1"
	batch_v1 "cue.dev/x/k8s.io/api/batch/v1"
	core_v1 "cue.dev/x/k8s.io/api/core/v1"
	discovery_v1 "cue.dev/x/k8s.io/api/discovery/v1"
	meta_v1 "cue.dev/x/k8s.io/apimachinery/pkg/apis/meta/v1"
	networking_v1 "cue.dev/x/k8s.io/api/networking/v1"
	policy_v1 "cue.dev/x/k8s.io/api/policy/v1"
	rbac_v1 "cue.dev/x/k8s.io/api/rbac/v1"
	storage_v1 "cue.dev/x/k8s.io/api/storage/v1"
	apiextensions_v1 "cue.dev/x/k8s.io/apiextensions-apiserver/pkg/apis/apiextensions/v1"
	apiregistration_v1 "cue.dev/x/k8s.io/kube-aggregator/pkg/apis/apiregistration/v1"

	flux_source_v1 "cue.dev/x/crd/fluxcd.io/source/v1"
	flux_notification_v1 "cue.dev/x/crd/fluxcd.io/notification/v1"
	flux_notification_v1beta3 "cue.dev/x/crd/fluxcd.io/notification/v1beta3"
	flux_kustomize_v1 "cue.dev/x/crd/fluxcd.io/kustomize/v1"
	flux_helm_v2 "cue.dev/x/crd/fluxcd.io/helm/v2"

	sealed_secrets_v1alpha1 "cue.dev/x/crd/bitnami.com/sealed-secrets/v1alpha1"

	certmanager_v1 "cue.dev/x/crd/cert-manager.io/v1"
	monitoring_v1 "cue.dev/x/crd/monitoring.coreos.com/v1"
	monitoring_v1alpha1 "cue.dev/x/crd/monitoring.coreos.com/v1alpha1"

	cilium_v2 "cilium.io/v2"
	cilium_v2alpha1 "cilium.io/v2alpha1"
	cue_v1beta2 "cue.toolkit.fluxcd.io/v1beta2"
	grafana_v1beta1 "grafana.integreatly.org/v1beta1"
	hydra_v1alpha1 "hydra.ory.sh/v1alpha1"
	cni_v1 "k8s.cni.cncf.io/v1"
)

let resourceSchemas = [
	core_v1.#Namespace,
	core_v1.#ConfigMap,
	core_v1.#Endpoints,
	core_v1.#Secret,
	core_v1.#Service,
	core_v1.#ServiceAccount,
	core_v1.#Pod,
	core_v1.#PersistentVolume,
	core_v1.#PersistentVolumeClaim,
	core_v1.#LimitRange,
	core_v1.#ResourceQuota,

	apps_v1.#DaemonSet,
	apps_v1.#Deployment,
	apps_v1.#StatefulSet,

	batch_v1.#Job,
	batch_v1.#CronJob,

	discovery_v1.#EndpointSlice,

	networking_v1.#Ingress,
	networking_v1.#IngressClass,
	networking_v1.#NetworkPolicy,

	policy_v1.#PodDisruptionBudget,

	rbac_v1.#Role,
	rbac_v1.#RoleBinding,
	rbac_v1.#ClusterRole,
	rbac_v1.#ClusterRoleBinding,

	storage_v1.#CSIDriver,
	storage_v1.#StorageClass,

	apiextensions_v1.#CustomResourceDefinition,

	apiregistration_v1.#APIService,

	flux_source_v1.#GitRepository,
	flux_source_v1.#HelmRepository,

	flux_notification_v1beta3.#Alert,
	flux_notification_v1beta3.#Provider,
	flux_notification_v1.#Receiver,

	flux_kustomize_v1.#Kustomization,

	flux_helm_v2.#HelmRelease,

	sealed_secrets_v1alpha1.#SealedSecret,

	certmanager_v1.#Certificate,
	certmanager_v1.#ClusterIssuer,
	certmanager_v1.#Issuer,

	monitoring_v1.#Alertmanager,
	monitoring_v1alpha1.#AlertmanagerConfig,
	monitoring_v1.#PodMonitor,
	monitoring_v1.#ServiceMonitor,
	monitoring_v1.#Prometheus,
	monitoring_v1.#PrometheusRule,

	cue_v1beta2.#CueExport,

	grafana_v1beta1.#Grafana,
	grafana_v1beta1.#GrafanaDashboard,
	grafana_v1beta1.#GrafanaDatasource,

	cni_v1.#NetworkAttachmentDefinition,

	cilium_v2.#CiliumClusterwideNetworkPolicy,
	cilium_v2.#CiliumEndpoint,
	cilium_v2.#CiliumExternalWorkload,
	cilium_v2.#CiliumIdentity,
	cilium_v2.#CiliumLocalRedirectPolicy,
	cilium_v2.#CiliumNetworkPolicy,
	cilium_v2.#CiliumNode,
	cilium_v2.#CiliumLoadBalancerIPPool,
	cilium_v2.#CiliumBGPClusterConfig,
	cilium_v2.#CiliumBGPPeerConfig,
	cilium_v2.#CiliumBGPAdvertisement,

	cilium_v2alpha1.#CiliumEgressNATPolicy,
	cilium_v2alpha1.#CiliumL2AnnouncementPolicy,
	cilium_v2alpha1.#CiliumNodeConfig,

	hydra_v1alpha1.#OAuth2Client,
]

k: close({
	for resource in resourceSchemas {
		(resource.kind): [Name=string]: resource & {
			metadata: meta_v1.#ObjectMeta & {
				name: _ | *Name
			}

			if strings.Contains(Name, "/") {
				let splitName = strings.Split(Name, "/")
				metadata: {
					namespace: splitName[0]
					name:      splitName[1]
				}
			}
		}
	}
})

_kindfilter: string | *".*" @tag(kind)
_namefilter: string | *".*" @tag(name)

_list: {
	apiVersion: "v1"
	kind:       "List"
	items: [
		for kind, resources in k
		for resource in resources if resource.kind =~ _kindfilter && resource.metadata.name =~ _namefilter {
			resource
		},
	]
}
