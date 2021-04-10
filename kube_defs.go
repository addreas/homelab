package kube

import (
	_ "github.com/addreas/cuebuild-controller/api/v1alpha1"
	_ "github.com/bitnami-labs/sealed-secrets/pkg/apis/sealed-secrets/v1alpha1"
	_ "github.com/cilium/cilium/pkg/k8s/apis/cilium.io/v2"
	_ "github.com/fluxcd/helm-controller/api/v2beta1"
	_ "github.com/fluxcd/kustomize-controller/api/v1beta1"
	_ "github.com/fluxcd/source-controller/api/v1beta1"
	_ "github.com/integr8ly/grafana-operator/api/integreatly/v1alpha1"
	_ "github.com/jetstack/cert-manager/pkg/apis/certmanager/v1"
	_ "github.com/k8snetworkplumbingwg/network-attachment-definition-client/pkg/apis/k8s.cni.cncf.io/v1"
	_ "github.com/prometheus-operator/prometheus-operator/pkg/apis/monitoring/v1"
	_ "k8s.io/api/apps/v1"
	_ "k8s.io/api/batch/v1"
	_ "k8s.io/api/batch/v1beta1"
	_ "k8s.io/api/core/v1"
	_ "k8s.io/api/discovery/v1beta1"
	_ "k8s.io/api/networking/v1"
	_ "k8s.io/api/policy/v1beta1"
	_ "k8s.io/api/rbac/v1"
	_ "k8s.io/api/storage/v1"
	_ "k8s.io/apimachinery/pkg/apis/meta/v1"
)
