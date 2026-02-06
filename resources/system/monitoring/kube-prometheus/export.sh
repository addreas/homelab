#!/bin/sh
set -eu

command -v jsonnet >/dev/null 2>&1 || go install github.com/google/go-jsonnet/cmd/jsonnet@latest
command -v jb      >/dev/null 2>&1 || go install github.com/jsonnet-bundler/jsonnet-bundler/cmd/jb@latest
command -v cue     >/dev/null 2>&1 || go install cuelang.org/go/cmd/cue@latest

export PATH="$PATH:$(go env GOPATH 2>/dev/null)/bin"

cd "$(dirname "$0")"

# renovate: depName=prometheus-operator/kube-prometheus datasource=github-releases
VERSION=v0.16.0

if [ ! -d vendor ]; then
  jb init
  jb install "github.com/prometheus-operator/kube-prometheus/jsonnet/kube-prometheus@${VERSION}"
fi

jsonnet -J vendor -m manifests -c export.jsonnet

cue import -p kube -f ./manifests/*.json

mv manifests/*.cue .
rm -r manifests

rm -r vendor jsonnetfile.*
