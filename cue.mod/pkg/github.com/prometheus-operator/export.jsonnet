local kp =
  (import 'kube-prometheus/main.libsonnet') +
  {
    values+:: {
      common+: {
        namespace: 'monitoring',
      },

      prometheusAdapter+: {
        prometheusURL: "http://vmsingle-main.monitoring.svc:8429"
      },

      kubernetesControlPlane+: {
        kubeProxy: false,
      },
    },
  };

local resources(name, filter = function(r) true) = std.foldr(
  function(r, acc) acc + { [name]+: { [r.kind]+: { [r.metadata.name]: r } } },
  [r for r in std.objectValues(kp[name]) if filter(r)],
  {});

{
 "prometheusOperator.json": resources("prometheusOperator", function(r) r.kind == "CustomResourceDefinition"),
 "prometheusAdapter.json": resources("prometheusAdapter"),
 "kubeStateMetrics.json": resources("kubeStateMetrics"),
 "kubernetesControlPlane.json": resources("kubernetesControlPlane", function(r) r.kind == "ServiceMonitor"),
 "kubePrometheus.json": resources("kubePrometheus", function(r) r.metadata.name == "kube-prometheus-rules")
}

//{["prometheusOperator" + name + ".json"]: kp.prometheusOperator[name] for name in std.objectFields(kp.prometheusOperator) if std.endsWith(name, "CustomResourceDefinition")} +
//{["prometheusAdapter" + name + ".json"]: kp.prometheusAdapter[name] for name in std.objectFields(kp.prometheusAdapter)} +
//{["kubeStateMetrics" + name + ".json"]: kp.kubeStateMetrics[name] for name in std.objectFields(kp.kubeStateMetrics)} +

//{[name + ".json"]: kp.kubePrometheus[name] for name in std.objectFields(kp.kubePrometheus)} +
//{[name + ".json"]: kp.nodeExporter[name] for name in std.objectFields(kp.nodeExporter)} +
//{[name + ".json"]: kp.prometheus[name] for name in std.objectFields(kp.prometheus)} +

// {
 //"serviceMonitorApiserver.json": kp.kubernetesControlPlane.serviceMonitorApiserver,
 //"serviceMonitorCoreDNS.json": kp.kubernetesControlPlane.serviceMonitorCoreDNS,
 //"serviceMonitorKubeControllerManager.json": kp.kubernetesControlPlane.serviceMonitorKubeControllerManager,
 //"serviceMonitorKubeScheduler.json": kp.kubernetesControlPlane.serviceMonitorKubeScheduler,
 //"serviceMonitorKubelet.json": kp.kubernetesControlPlane.serviceMonitorKubelet,

 //"podMonitorKubeProxy.json": kp.kubernetesControlPlane.podMonitorKubeProxy,

 //"prometheusRuleKubePrometheus.json": kp.kubePrometheus.prometheusRule,
// }
