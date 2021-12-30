local kp =
  (import 'kube-prometheus/main.libsonnet') +
  {
    values+:: {
      common+: {
        namespace: 'monitoring',
      },

      kubernetesControlPlane+: {
        kubeProxy: true,
      },
    },
  };

{
 "serviceMonitorApiserver.json": kp.kubernetesControlPlane.serviceMonitorApiserver,
 "serviceMonitorCoreDNS.json": kp.kubernetesControlPlane.serviceMonitorCoreDNS,
 "serviceMonitorKubeControllerManager.json": kp.kubernetesControlPlane.serviceMonitorKubeControllerManager,
 "serviceMonitorKubeScheduler.json": kp.kubernetesControlPlane.serviceMonitorKubeScheduler,
 "serviceMonitorKubelet.json": kp.kubernetesControlPlane.serviceMonitorKubelet,

 "podMonitorKubeProxy.json": kp.kubernetesControlPlane.podMonitorKubeProxy,

 "clusterRoleKubeStateMetrics.json": kp.kubeStateMetrics.clusterRole,
 "clusterRoleBindingKubeStateMetrics.json": kp.kubeStateMetrics.clusterRoleBinding,
 "deploymentKubeStateMetrics.json": kp.kubeStateMetrics.deployment,
 "serviceKubeStateMetrics.json": kp.kubeStateMetrics.service,
 "serviceAccountKubeStateMetrics.json": kp.kubeStateMetrics.serviceAccount,
 "serviceMonitorKubeStateMetrics.json": kp.kubeStateMetrics.serviceMonitor,

 "prometheusRuleKubeStateMetrics.json": kp.kubeStateMetrics.prometheusRule,
 "prometheusRuleKubePrometheus.json": kp.kubePrometheus.prometheusRule,

 "0servicemonitorCustomResourceDefinition.json":  kp.prometheusOperator["0servicemonitorCustomResourceDefinition"],
 "0podmonitorCustomResourceDefinition.json": kp.prometheusOperator["0podmonitorCustomResourceDefinition"],
 "0probeCustomResourceDefinition.json": kp.prometheusOperator["0probeCustomResourceDefinition"],
 "0prometheusruleCustomResourceDefinition.json": kp.prometheusOperator["0prometheusruleCustomResourceDefinition"]
}
