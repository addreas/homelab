#!/bin/sh

#go install github.com/google/go-jsonnet/cmd/jsonnet@latest
#go install github.com/jsonnet-bundler/jsonnet-bundler/cmd/jb@latest

cd kubernetes-mixin

git pull

jb install

make prometheus_alerts.yaml
make prometheus_rules.yaml
make dashboards_out

cue import -f -p dashboards --with-context -l 'path.Base(filename)' dashboards_out/*
cue import -f -p mixin -l '"alerts"' prometheus_alerts.yaml
cue import -f -p mixin -l '"rules"' prometheus_rules.yaml

mkdir -p ../../../../gen/github.com/kubernetes-monitoring/kubernetes-mixin/dashboards

mv *.cue ../../../../gen/github.com/kubernetes-monitoring/kubernetes-mixin/
mv dashboards_out/*.cue ../../../../gen/github.com/kubernetes-monitoring/kubernetes-mixin/dashboards

git clean -fd
