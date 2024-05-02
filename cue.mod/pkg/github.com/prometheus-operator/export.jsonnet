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

      nodeExporter+: {
        kubeRbacProxy+: { resources+: { limits+: { cpu: '140m' } } }
      },

      alertmanager+: {
          config+: {
            local critical = {
                name: "Critical",
                webhook_configs: [{
                  send_resolved: false,
                  url: "http://hass.default.svc.cluster.local:8123/api/webhook/alertmanager-critical"
                }]
            },
            local warning = {
                name: "Warning",
                webhook_configs: [{
                  send_resolved: false,
                  url: "http://hass.default.svc.cluster.local:8123/api/webhook/alertmanager-warning"
                }]
            },
            receivers: std.map(function(x) if x.name == "Critical" then critical else x, super.receivers) + [warning],
            route+: {
              routes: super.routes + [{
                matchers: ["severity = warning"],
                receiver: "Warning"
              }]
            }
          },
      },
    },


    nodeExporter+: {
      daemonset+: {
        spec+: {
          template+: {
            spec+: {
              local nodeExporterContainer = super.containers[0],
              containers: [
                nodeExporterContainer + {
                  args:
                    std.filter(function(x) !std.member([
                                            '--no-collector.btrfs',
                                            '--no-collector.hwmon'
                                          ], x),
                               nodeExporterContainer.args)
                    + [
                      '--collector.systemd'
                    ],
                    volumeMounts: nodeExporterContainer.volumeMounts + [{
                      name: 'systemd-dbus',
                      mountPath: '/var/run/dbus/system_bus_socket'
                    }],
                },
                super.containers[1]
              ],
              volumes: super.volumes + [{
                name: 'systemd-dbus',
                hostPath: { path: '/var/run/dbus/system_bus_socket' }
              }],
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
 "alertmanager.json": resources("alertmanager", function(r) r.kind != "NetworkPolicy"),
 "blackboxExporter.json": resources("blackboxExporter", function(r) r.kind != "NetworkPolicy"),
 "kubePrometheus.json": resources("kubePrometheus", function(r) r.metadata.name == "kube-prometheus-rules"),
 "kubeStateMetrics.json": resources("kubeStateMetrics", function(r) r.kind != "NetworkPolicy"),
 "kubernetesControlPlane.json": resources("kubernetesControlPlane"),
 "nodeExporter.json": resources("nodeExporter", function(r) r.kind != "NetworkPolicy"),
 "prometheus.json": resources("prometheus", function(r) r.kind != "NetworkPolicy"),
 "prometheusAdapter.json": resources("prometheusAdapter", function(r) r.kind != "NetworkPolicy"),
 "prometheusOperator.json": resources("prometheusOperator", function(r) r.kind != "NetworkPolicy"),

 "grafanaDashboards.json": { grafanaDashboards:
    kp.alertmanager.mixin.grafanaDashboards + 
    kp.kubernetesControlPlane.mixin.grafanaDashboards + 
    kp.nodeExporter.mixin.grafanaDashboards +
    kp.prometheus.mixin.grafanaDashboards
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
