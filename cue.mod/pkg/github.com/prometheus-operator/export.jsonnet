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
