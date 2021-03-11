#!/bin/bash

go mod init github.com/addreas/cuebernetes
cue mod init github.com/addreas/cuebernetes

GO_PKG_URLS=(
    "github.com/bitnami-labs/sealed-secrets/pkg/apis/sealed-secrets/v1alpha1"
    "github.com/cilium/cilium/pkg/k8s/apis/cilium.io/v2"
    "github.com/fluxcd/helm-controller/api/v2beta1"
    "github.com/fluxcd/kustomize-controller/api/v1beta1"
    "github.com/fluxcd/source-controller/api/v1beta1"
    "github.com/jetstack/cert-manager/pkg/apis/certmanager/v1"
    "github.com/k8snetworkplumbingwg/network-attachment-definition-client/pkg/apis/k8s.cni.cncf.io/v1"
    "github.com/prometheus-operator/prometheus-operator/pkg/apis/monitoring/v1"
    "k8s.io/api/apps/v1"
    "k8s.io/api/batch/v1"
    "k8s.io/api/batch/v2alpha1"
    "k8s.io/api/core/v1"
    "k8s.io/api/discovery/v1beta1"
    "k8s.io/api/networking/v1"
    "k8s.io/api/policy/v1beta1"
    "k8s.io/api/rbac/v1"
    "k8s.io/api/storage/v1"
    "k8s.io/apimachinery/pkg/apis/meta/v1"
)

for URL in ${GO_PKG_URLS[@]}; do
    printf "$URL..."
    go get $URL
    cue get go $URL
    printf "done\n"
done

# need to get rid of reference to "reflect" in ./cue.mod/gen/github.com/go-openapi/strfmt/format_go_gen.cue

cue import -p kube -l '"k"' -l 'kind' -l metadata.name -f -R ./**/*.yaml
