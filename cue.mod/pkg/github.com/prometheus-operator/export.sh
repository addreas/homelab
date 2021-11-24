#!/bin/sh

#go install github.com/google/go-jsonnet/cmd/jsonnet@latest
#go install github.com/jsonnet-bundler/jsonnet-bundler/cmd/jb@latest

cd kube-prometheus

git pull

jb install

jsonnet -J vendor -m manifests -c ../export.jsonnet

cue import -p manifests -l kind -l metadata.name -f ./manifests/*.json

mkdir -p ../../../../gen/github.com/prometheus-operator/kube-prometheus/manifests
mv manifests/*.cue ../../../../gen/github.com/prometheus-operator/kube-prometheus/manifests

git clean -fd
