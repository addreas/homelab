package kube

import (
	"strings"
	"tool/file"
	"tool/exec"
)

command: dependencies: {
	task: {
		readDefsGo: file.Read & {
			filename: "kube_defs.go"
			contents: string
		}
		let packages = [ for field in strings.Fields(task.readDefsGo.contents) if strings.Contains(field, "\"") {strings.Trim(field, "\"")}]
		getGo: exec.Run & {
			cmd: ["sh", "-c", strings.Join([ for package in packages {
				strings.Join([
					"echo -n \(package)..",
					"go get \(package)",
					"echo -n .",
					"cue get go \(package)",
					"echo done."],
				"&&")
			}], "\n")]
		}
		deleteReflect: exec.Run & {
			$after: [getGo]
			cmd: "sed -i /reflect/d ./cue.mod/gen/github.com/go-openapi/strfmt/format_go_gen.cue"
		}
	}
}

command: dependencies: task: {
	"kubernetes-mixin": exec.Run & {
		dir: "cue.mod/pkg/github.com/kubernetes-monitoring/kubernetes-mixin"
		cmd: ["sh", "-c", """
			#go install github.com/google/go-jsonnet/cmd/jsonnet@latest
			#go install github.com/jsonnet-bundler/jsonnet-bundler/cmd/jb@latest

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
			"""]
	}
}

command: dependencies: task: {
	"kube-prometheus-export": file.Create & {
		filename: "cue.mod/pkg/github.com/prometheus-operator/export.jsonnet"
		contents: """
			local kp =
				(import 'kube-prometheus/main.libsonnet') +
				{
					values+:: {
						common+: {
							namespace: 'monitoring',
						},
					},
				};

			{
				"serviceMonitorApiserver.json": kp.kubernetesControlPlane.serviceMonitorApiserver,
				"serviceMonitorCoreDNS.json": kp.kubernetesControlPlane.serviceMonitorCoreDNS,
				"serviceMonitorKubeControllerManager.json": kp.kubernetesControlPlane.serviceMonitorKubeControllerManager,
				"serviceMonitorKubeScheduler.json": kp.kubernetesControlPlane.serviceMonitorKubeScheduler,
				"serviceMonitorKubelet.json": kp.kubernetesControlPlane.serviceMonitorKubelet,
				"kubePrometheusRules.json": kp.kubePrometheus.prometheusRule,
				"0servicemonitorCustomResourceDefinition.json":  kp.prometheusOperator["0servicemonitorCustomResourceDefinition"],
				"0podmonitorCustomResourceDefinition.json": kp.prometheusOperator["0podmonitorCustomResourceDefinition"],
				"0probeCustomResourceDefinition.json": kp.prometheusOperator["0probeCustomResourceDefinition"],
				"0prometheusruleCustomResourceDefinition.json": kp.prometheusOperator["0prometheusruleCustomResourceDefinition"]
			}
			"""
	}
	"kube-prometheus": exec.Run & {
		dir: "cue.mod/pkg/github.com/prometheus-operator/kube-prometheus"
		cmd: ["sh", "-c", """
			#go install github.com/google/go-jsonnet/cmd/jsonnet@latest
			#go install github.com/jsonnet-bundler/jsonnet-bundler/cmd/jb@latest

			git pull

			jb install

			jsonnet -J vendor -m manifests -c ../export.jsonnet

			cue import -p manifests -l kind -l metadata.name -f ./manifests/*.json

			mkdir -p ../../../../gen/github.com/prometheus-operator/kube-prometheus/manifests
			mv manifests/*.cue ../../../../gen/github.com/prometheus-operator/kube-prometheus/manifests

			git clean -fd
			"""]
	}
}
