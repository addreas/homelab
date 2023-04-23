local kp =
  (import 'kube-prometheus/main.libsonnet') +
  {
    values+:: {
      common+: {
        namespace: 'monitoring',
      },

      kubernetesControlPlane+: {
        kubeProxy: false,
      },

      kubeStateMetrics+: {
        kubeRbacProxyMain+: {
          resources+: {
            limits+: { cpu: '140m' },
          }
        },
      },
    },

    nodeExporter+: {
      daemonset+: {
        spec+: {
          template+: {
            spec+: {
              local args = super.containers[0].args,
              containers: [
                super.containers[0] + { args: std.filter(function(x) x != "--no-collector.hwmon", args) },
                super.containers[1] + { resources+: { limits+: { cpu: '140m' } } },
              ],
            },
          },
        },
      },
    },
  };

local resources(name, filter = function(r) true) = std.foldr(
  function(r, acc) acc + {
    [name]+: if !std.endsWith(r.kind, "List") then {
      [r.kind]+: {
        [r.metadata.name]: r
      }
    } else {
      [std.strReplace(r.kind, "List", "")]+: {
        [rr.metadata.namespace + "/" + rr.metadata.name]+: rr for rr in r.items
      }
    }
  },
  [r for r in std.objectValues(kp[name]) if filter(r)],
  {});

{
 "alertmanager.json": resources("alertmanager"),
 "blackboxExporter.json": resources("blackboxExporter"),
 "prometheus.json": resources("prometheus"),
 "prometheusOperator.json": resources("prometheusOperator"),
 "prometheusAdapter.json": resources("prometheusAdapter"),
 "kubeStateMetrics.json": resources("kubeStateMetrics"),
 "nodeExporter.json": resources("nodeExporter"),
 "kubernetesControlPlane.json": resources("kubernetesControlPlane", function(r) std.member(["ServiceMonitor", "PrometheusRule"], r.kind)),
 "kubePrometheus.json": resources("kubePrometheus", function(r) r.metadata.name == "kube-prometheus-rules"),
 "grafanaDashboards.json": { grafanaDashboards:
    kp.nodeExporter.mixin.grafanaDashboards +
    kp.kubernetesControlPlane.mixin.grafanaDashboards
  }
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
