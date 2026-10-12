local kp = (import 'kube-prometheus/main.libsonnet') + {
  values+:: {
    common+: {
      namespace: 'monitoring',
      ruleLabels+: { ruler: 'metrics' },
    },

    kubernetesControlPlane+: {
      kubeProxy: false,
    },
  },

  kubernetesControlPlane+: {
    serviceMonitorKubeScheduler:: {},
    serviceMonitorKubeControllerManager:: {},

    mixin+:: {
      prometheusAlerts+:: {
        groups: std.filter(
          function(g) g.name != 'kubernetes-system-scheduler'
          && g.name != 'kubernetes-system-controller-manager',
          super.groups
        ),
      },
      prometheusRules+:: {
        groups: std.filter(
          function(g) g.name != 'kube-scheduler.rules',
          super.groups
        ),
      },
    },
  },
};

local kubeletVMNodeScrape(e, sm=kp.kubernetesControlPlane.serviceMonitorKubelet) = {
  local path = std.get(e, 'path', '/metrics'),
  apiVersion: 'operator.victoriametrics.com/v1beta1',
  kind: 'VMNodeScrape',
  metadata: sm.metadata + {
    name: sm.metadata.name + std.strReplace(path, '/', '-'),
  },
  spec: {
    [std.get({
      relabelings: 'relabelConfigs',
      metricRelabelings: 'metricRelabelConfigs',
    }, k, k)]: e[k]
    for k in std.objectFields(e)
    if k != 'port'
  } + {
    port: '10250',
    max_scrape_size: '64MB',
    relabelConfigs+: [{ targetLabel: 'job', replacement: 'kubelet' }],
  },
};

local resources = [
  r
  for r in std.objectValues(kp.kubePrometheus)
  + std.objectValues(kp.kubernetesControlPlane)
  if std.objectHas(r, 'kind')
  && r.kind != 'Namespace'
  && r.metadata.name != 'kubelet'
] + [
  kubeletVMNodeScrape(e)
  for e in kp.kubernetesControlPlane.serviceMonitorKubelet.spec.endpoints
];

{ ['%s.gen.json' % r.metadata.name]: r for r in resources }
