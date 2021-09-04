package kube

import (
	apps_v1 "k8s.io/api/apps/v1"
	batch_v1 "k8s.io/api/batch/v1"
	batch_v1beta1 "k8s.io/api/batch/v1beta1"
	core_v1 "k8s.io/api/core/v1"
	discovery_v1beta1 "k8s.io/api/discovery/v1beta1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
	networking_v1 "k8s.io/api/networking/v1"
	policy_v1beta1 "k8s.io/api/policy/v1beta1"
	rbac_v1 "k8s.io/api/rbac/v1"
	storage_v1 "k8s.io/api/storage/v1"
	apiextensions_v1 "k8s.io/apiextensions-apiserver/pkg/apis/apiextensions/v1"

	source_controller_v1beta1 "github.com/fluxcd/source-controller/api/v1beta1"
	kustomize_controller_v1beta1 "github.com/fluxcd/kustomize-controller/api/v1beta1"
	cuebuild_controller_v1alpha1 "github.com/addreas/cuebuild-controller/api/v1alpha1"
	helm_controller_v2beta1 "github.com/fluxcd/helm-controller/api/v2beta1"

	sealed_secrets_v1alpha1 "github.com/bitnami-labs/sealed-secrets/pkg/apis/sealed-secrets/v1alpha1"

	grafana_v1alpha1 "github.com/integr8ly/grafana-operator/api/integreatly/v1alpha1"

	certmanager_v1 "github.com/jetstack/cert-manager/pkg/apis/certmanager/v1"

	networkattachment_v1 "github.com/k8snetworkplumbingwg/network-attachment-definition-client/pkg/apis/k8s.cni.cncf.io/v1"

	monitoring_v1 "github.com/prometheus-operator/prometheus-operator/pkg/apis/monitoring/v1"

	cilium_v2 "github.com/cilium/cilium/pkg/k8s/apis/cilium.io/v2"

	victoriametrics_v1beta1 "github.com/VictoriaMetrics/operator/api/v1beta1"

	kpack_v1alpha1 "github.com/pivotal/kpack/pkg/apis/build/v1alpha1"
)

k: close({
	for ApiVersion, kinds in _kubernetesAPIs {
		for Kind, Type in kinds {
			"\(Kind)": [Name=string]: Type & {
				apiVersion: ApiVersion
				kind:       Kind
				metadata:   metav1.#ObjectMeta & {
					name: Name
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

	"policy/v1beta1": {
		PodDisruptionBudget: policy_v1beta1.#PodDisruptionBudget
		PodSecurityPolicy:   policy_v1beta1.#PodSecurityPolicy
	}

	"rbac.authorization.k8s.io/v1": {
		Role:               rbac_v1.#Role
		RoleBinding:        rbac_v1.#RoleBinding
		ClusterRole:        rbac_v1.#ClusterRole
		ClusterRoleBinding: rbac_v1.#ClusterRoleBinding
	}

	"storage.k8s.io/v1": StorageClass: storage_v1.#StorageClass

	"apiextensions.k8s.io/v1": CustomResourceDefinition: apiextensions_v1.#CustomResourceDefinition

	"source.toolkit.fluxcd.io/v1beta1": {
		GitRepository:  source_controller_v1beta1.#GitRepository
		HelmRepository: source_controller_v1beta1.#HelmRepository
	}
	"kustomize.toolkit.fluxcd.io/v1beta1": Kustomization: kustomize_controller_v1beta1.#Kustomization
	"cuebuild.toolkit.fluxcd.io/v1alpha1": CueBuild:      cuebuild_controller_v1alpha1.#CueBuild
	"helm.toolkit.fluxcd.io/v2beta1": HelmRelease:        helm_controller_v2beta1.#HelmRelease

	"bitnami.com/v1alpha1": SealedSecret: sealed_secrets_v1alpha1.#SealedSecret

	"integreatly.org/v1alpha1": {
		Grafana:           grafana_v1alpha1.#Grafana
		GrafanaDashboard:  grafana_v1alpha1.#GrafanaDashboard
		GrafanaDataSource: grafana_v1alpha1.#GrafanaDataSource
	}

	"cert-manager.io/v1": {
		Certificate:   certmanager_v1.#Certificate
		ClusterIssuer: certmanager_v1.#ClusterIssuer
		Issuer:        certmanager_v1.#Issuer
	}

	"k8s.cni.cncf.io/v1": NetworkAttachmentDefinition: networkattachment_v1.#NetworkAttachmentDefinition

	"monitoring.coreos.com/v1": {
		PodMonitor:     monitoring_v1.#PodMonitor
		ServiceMonitor: monitoring_v1.#ServiceMonitor
		PrometheusRule: monitoring_v1.#PrometheusRule
	}

	"cilium.io/v2": CiliumNetworkPolicy: cilium_v2.#CiliumNetworkPolicy

	"operator.victoriametrics.com/v1beta1": {
		VMAgent:         victoriametrics_v1beta1.#VMAgent
		VMAlert:         victoriametrics_v1beta1.#VMAlert
		VMAlertmanager:  victoriametrics_v1beta1.#VMAlertmanager
		VMCluster:       victoriametrics_v1beta1.#VMCluster
		VMNodeScrape:    victoriametrics_v1beta1.#VMNodeScrape
		VMPodScrape:     victoriametrics_v1beta1.#VMPodScrape
		VMProbe:         victoriametrics_v1beta1.#VMProbe
		VMRule:          victoriametrics_v1beta1.#VMRule
		VMServiceScrape: victoriametrics_v1beta1.#VMServiceScrape
		VMSingle:        victoriametrics_v1beta1.#VMSingle
		VMStaticScrape:  victoriametrics_v1beta1.#VMStaticScrape
	}

	"kpack.io/v1alpha1": {
		Build:          kpack_v1alpha1.#Build
		Builder:        kpack_v1alpha1.#Builder
		ClusterBuilder: kpack_v1alpha1.#ClusterBuilder
		ClusterStack:   kpack_v1alpha1.#ClusterStack
		ClusterStore:   kpack_v1alpha1.#ClusterStore
		Image:          kpack_v1alpha1.#Image
		ImageBuilder:   kpack_v1alpha1.#ImageBuilder
		SourceResolver: kpack_v1alpha1.#SourceResolver
	}
}
