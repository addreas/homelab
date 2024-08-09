package kube

import (
	"strings"

	apps_v1 "k8s.io/api/apps/v1"
	batch_v1 "k8s.io/api/batch/v1"
	batch_v1beta1 "k8s.io/api/batch/v1beta1"
	core_v1 "k8s.io/api/core/v1"
	discovery_v1beta1 "k8s.io/api/discovery/v1beta1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
	networking_v1 "k8s.io/api/networking/v1"
	policy_v1 "k8s.io/api/policy/v1"
	rbac_v1 "k8s.io/api/rbac/v1"
	storage_v1 "k8s.io/api/storage/v1"
	apiextensions_v1 "k8s.io/apiextensions-apiserver/pkg/apis/apiextensions/v1"
	apiregistration_v1 "k8s.io/kube-aggregator/pkg/apis/apiregistration/v1"

	source_controller_v1 "github.com/fluxcd/source-controller/api/v1"
	source_controller_v1beta2 "github.com/fluxcd/source-controller/api/v1beta2"
	notification_controller_v1beta1 "github.com/fluxcd/notification-controller/api/v1beta1"
	kustomize_controller_v1 "github.com/fluxcd/kustomize-controller/api/v1"
	cuebuild_controller_v1alpha2 "github.com/addreas/cuebuild-controller/api/v1alpha2"
	cue_controller_v1beta2 "github.com/addreas/cue-controller/api/v1beta2"
	helm_controller_v2beta1 "github.com/fluxcd/helm-controller/api/v2beta1"

	sealed_secrets_v1alpha1 "github.com/bitnami-labs/sealed-secrets/pkg/apis/sealedsecrets/v1alpha1"

	grafana_operator_v1beta1 "github.com/grafana-operator/grafana-operator/v5/api/v1beta1"

	certmanager_v1 "github.com/cert-manager/cert-manager/pkg/apis/certmanager/v1"

	networkattachment_v1 "github.com/k8snetworkplumbingwg/network-attachment-definition-client/pkg/apis/k8s.cni.cncf.io/v1"

	monitoring_v1 "github.com/prometheus-operator/prometheus-operator/pkg/apis/monitoring/v1"

	cilium_v2 "github.com/cilium/cilium/pkg/k8s/apis/cilium.io/v2"
	cilium_v2alpha1 "github.com/cilium/cilium/pkg/k8s/apis/cilium.io/v2alpha1"

	hydra_v1alpha1 "github.com/ory/hydra-maester/api/v1alpha1"
)

k: close({
	for ApiVersion, kinds in _kubernetesAPIs {
		for Kind, Type in kinds {
			"\(Kind)": [Name=string]: Type & {
				apiVersion: ApiVersion
				kind:       Kind
				metadata:   metav1.#ObjectMeta & {
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
	}
})

_kubernetesAPIs: {
	v1: {
		Namespace:             core_v1.#Namespace
		ConfigMap:             core_v1.#ConfigMap
		Endpoints:             core_v1.#Endpoints
		Secret:                core_v1.#Secret
		Service:               core_v1.#Service
		ServiceAccount:        core_v1.#ServiceAccount
		Pod:                   core_v1.#Pod
		PersistentVolume:      core_v1.#PersistentVolume
		PersistentVolumeClaim: core_v1.#PersistentVolumeClaim
		LimitRange:            core_v1.#LimitRange
		ResourceQuota:         core_v1.#ResourceQuota
	}

	"apps/v1": {
		DaemonSet:   apps_v1.#DaemonSet
		Deployment:  apps_v1.#Deployment
		StatefulSet: apps_v1.#StatefulSet
	}

	"batch/v1": Job:          batch_v1.#Job
	"batch/v1beta1": CronJob: batch_v1beta1.#CronJob

	"discovery.k8s.io/v1beta1": EndpointSlice: discovery_v1beta1.#EndpointSlice

	"networking.k8s.io/v1": {
		Ingress:       networking_v1.#Ingress
		IngressClass:  networking_v1.#IngressClass
		NetworkPolicy: networking_v1.#NetworkPolicy
	}

	"policy/v1": {
		PodDisruptionBudget: policy_v1.#PodDisruptionBudget
		PodSecurityPolicy:   policy_v1.#PodSecurityPolicy
	}

	"rbac.authorization.k8s.io/v1": {
		Role:               rbac_v1.#Role
		RoleBinding:        rbac_v1.#RoleBinding
		ClusterRole:        rbac_v1.#ClusterRole
		ClusterRoleBinding: rbac_v1.#ClusterRoleBinding
	}

	"storage.k8s.io/v1": {
		CSIDriver:    storage_v1.#CSIDriver
		StorageClass: storage_v1.#StorageClass
	}

	"apiextensions.k8s.io/v1": CustomResourceDefinition: apiextensions_v1.#CustomResourceDefinition

	"apiregistration.k8s.io/v1": APIService: apiregistration_v1.#APIService

	"source.toolkit.fluxcd.io/v1": GitRepository:       source_controller_v1.#GitRepository
	"source.toolkit.fluxcd.io/v1beta1": HelmRepository: source_controller_v1beta2.#HelmRepository

	"notification.toolkit.fluxcd.io/v1beta1": {
		Alert:    notification_controller_v1beta1.#Alert
		Provider: notification_controller_v1beta1.#Provider
		Receiver: notification_controller_v1beta1.#Receiver
	}

	"kustomize.toolkit.fluxcd.io/v1": Kustomization: kustomize_controller_v1.#Kustomization

	"cuebuild.toolkit.fluxcd.io/v1alpha1": CueBuild: cuebuild_controller_v1alpha2.#CueBuild

	"cue.toolkit.fluxcd.io/v1beta2": CueExport: cue_controller_v1beta2.#CueExport

	"helm.toolkit.fluxcd.io/v2beta1": HelmRelease: helm_controller_v2beta1.#HelmRelease

	"bitnami.com/v1alpha1": SealedSecret: sealed_secrets_v1alpha1.#SealedSecret

	"grafana.integreatly.org/v1beta1": {
		Grafana:           grafana_operator_v1beta1.#Grafana
		GrafanaDashboard:  grafana_operator_v1beta1.#GrafanaDashboard
		GrafanaDatasource: grafana_operator_v1beta1.#GrafanaDatasource
	}

	"cert-manager.io/v1": {
		Certificate:   certmanager_v1.#Certificate
		ClusterIssuer: certmanager_v1.#ClusterIssuer
		Issuer:        certmanager_v1.#Issuer
	}

	"k8s.cni.cncf.io/v1": NetworkAttachmentDefinition: networkattachment_v1.#NetworkAttachmentDefinition

	"monitoring.coreos.com/v1": {
		Alertmanager:       monitoring_v1.#Alertmanager
		AlertmanagerConfig: monitoring_v1.#AlertmanagerConfig
		PodMonitor:         monitoring_v1.#PodMonitor
		ServiceMonitor:     monitoring_v1.#ServiceMonitor
		Prometheus:         monitoring_v1.#Prometheus
		PrometheusRule:     monitoring_v1.#PrometheusRule
	}

	"cilium.io/v2": {
		CiliumClusterwideNetworkPolicy: cilium_v2.#CiliumClusterwideNetworkPolicy
		CiliumEndpoint:                 cilium_v2.#CiliumEndpoint
		CiliumExternalWorkload:         cilium_v2.#CiliumExternalWorkload
		CiliumIdentity:                 cilium_v2.#CiliumIdentity
		CiliumLocalRedirectPolicy:      cilium_v2.#CiliumLocalRedirectPolicy
		CiliumNetworkPolicy:            cilium_v2.#CiliumNetworkPolicy
		CiliumNode:                     cilium_v2.#CiliumNode
	}

	"cilium.io/v2alpha1": {
		CiliumBGPPeeringPolicy:     cilium_v2alpha1.#CiliumBGPPeeringPolicy
		CiliumEgressNATPolicy:      cilium_v2alpha1.#CiliumEgressNATPolicy
		CiliumL2AnnouncementPolicy: cilium_v2alpha1.#CiliumL2AnnouncementPolicy
		CiliumLoadBalancerIPPool:   cilium_v2alpha1.#CiliumLoadBalancerIPPool
		CiliumNodeConfig:           cilium_v2alpha1.#CiliumNodeConfig
	}

	"hydra.ory.sh/v1alpha1": OAuth2Client: hydra_v1alpha1.#OAuth2Client
}
