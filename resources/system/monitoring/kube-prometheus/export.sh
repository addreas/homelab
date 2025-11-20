#!/bin/sh

if [ ! -d vendor ]; then
  jb init
  jb install github.com/prometheus-operator/kube-prometheus/jsonnet/kube-prometheus@main
fi

jsonnet -J vendor -m manifests -c export.jsonnet

cue import -p kube -f ./manifests/*.json

mv manifests/*.cue .
rm -r manifests

rm -r vendor jsonnetfile.*
