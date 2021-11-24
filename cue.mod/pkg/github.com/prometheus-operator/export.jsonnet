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
 "kubePrometheusRules.json": kp.kubePrometheus.prometheusRule
}
