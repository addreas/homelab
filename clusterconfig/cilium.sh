#!/bin/sh

kubectl create -f https://raw.githubusercontent.com/cilium/cilium/v1.9/install/kubernetes/quick-install.yaml
kubectl apply -f https://raw.githubusercontent.com/cilium/cilium/v1.9/install/kubernetes/quick-hubble-install.yaml

# perhaps?
# https://archive.fosdem.org/2020/schedule/event/containers_bpf/
# https://docs.cilium.io/en/v1.9/gettingstarted/kubeproxy-free/
