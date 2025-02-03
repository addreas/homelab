package kube

import (
	_ "github.com/addreas/cue-controller/api/v1beta2"
	_ "github.com/bitnami-labs/sealed-secrets/pkg/apis/sealedsecrets/v1alpha1"
	_ "github.com/cert-manager/cert-manager/pkg/apis/certmanager/v1"
	_ "github.com/cilium/cilium/pkg/k8s/apis/cilium.io/v2"       // --exclude='HubbleStatus$,ControllerStatus(es)?$,ControllerList$,StatusResponse$,DebugInfo$,Endpoint(Status)?(Slice)?(List)?$'
	_ "github.com/cilium/cilium/pkg/k8s/apis/cilium.io/v2alpha1" // --exclude='HubbleStatus$,ControllerStatus(es)?$,ControllerList$,StatusResponse$,DebugInfo$,Endpoint(Status)?(Slice)?(List)?$'
	_ "github.com/fluxcd/helm-controller/api/v2beta2"
	_ "github.com/fluxcd/kustomize-controller/api/v1"
	_ "github.com/fluxcd/notification-controller/api/v1"
	_ "github.com/fluxcd/source-controller/api/v1"
	_ "github.com/grafana-operator/grafana-operator/v5/api/v1beta1"
	_ "github.com/k8snetworkplumbingwg/network-attachment-definition-client/pkg/apis/k8s.cni.cncf.io/v1"
	_ "github.com/ory/hydra-maester/api/v1alpha1"
	_ "github.com/prometheus-operator/prometheus-operator/pkg/apis/monitoring/v1"
	_ "k8s.io/api/apps/v1"
	_ "k8s.io/api/batch/v1"
	_ "k8s.io/api/batch/v1beta1"
	_ "k8s.io/api/core/v1"
	_ "k8s.io/api/discovery/v1beta1"
	_ "k8s.io/api/networking/v1"
	_ "k8s.io/api/policy/v1"
	_ "k8s.io/api/rbac/v1"
	_ "k8s.io/api/storage/v1"
	_ "k8s.io/apimachinery/pkg/apis/meta/v1"
	_ "k8s.io/kube-aggregator/pkg/apis/apiregistration/v1"
)
