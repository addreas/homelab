package kube

k: HelmRepository: "grafana": spec: url: "https://grafana.github.io/helm-charts"

k: HelmRepository: "prometheus-community": spec: url: "https://prometheus-community.github.io/helm-charts"
