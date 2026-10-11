local base = (import 'kube-prometheus/main.libsonnet') + {
  values+:: {
    common+: {
      namespace: 'monitoring',
    },

    kubernetesControlPlane+: {
      kubeProxy: false,
    },
  },
};

local endpointFieldRename = {
  relabelings: 'relabelConfigs',
  metricRelabelings: 'metricRelabelConfigs',
};

local kubeletVMNodeScrape(e, sm=base.kubernetesControlPlane.serviceMonitorKubelet) = {
  apiVersion: 'operator.victoriametrics.com/v1beta1',
  kind: 'VMNodeScrape',
  metadata: sm.metadata + {
    name: sm.metadata.name + std.strReplace(std.get(e, 'path', '/metrics'), '/', '-'),
  },
  spec: {
    [std.get(endpointFieldRename, k, k)]: e[k]
    for k in std.objectFields(e)
    if k != 'port'
  } + {
    path: std.get(e, 'path', '/metrics'),
    port: '10250',
    max_scrape_size: '64MB',
    selector: {},
    relabelConfigs: [{ targetLabel: 'job', replacement: 'kubelet' }] + e.relabelings,
  },
};

local kp = base + {
  kubernetesControlPlane+: {
    [kubeletVMNodeScrape(e).metadata.name]: kubeletVMNodeScrape(e)
    for e in base.kubernetesControlPlane.serviceMonitorKubelet.spec.endpoints
  },
};

local resources(name, filter = function(r) true, extraLabels = {}) = std.foldr(
  function(r, acc) acc + {
    k+: if !std.endsWith(r.kind, 'List') then {
      [r.kind]+: {
        [r.metadata.name]: r + { metadata+: { labels+: extraLabels } }
      }
    } else {
      [std.strReplace(r.kind, 'List', '')]+: {
        [rr.metadata.namespace + '/' + rr.metadata.name]: rr for rr in r.items
      }
    }
  },
  [r for r in std.objectValues(kp[name]) if filter(r)],
  {});

{
  // kube-prometheus-rules PrometheusRule (upstream: kubePrometheus-prometheusRule.yaml)
  'kubePrometheus.gen.json': resources('kubePrometheus', function(r) r.metadata.name == 'kube-prometheus-rules', { ruler: 'metrics' }),

  // kubernetes-monitoring-rules PrometheusRule + control-plane ServiceMonitors
  // (upstream: kubernetesControlPlane-prometheusRule.yaml, kubernetesControlPlane-serviceMonitor*.yaml)
  'kubernetesControlPlane.gen.json': resources('kubernetesControlPlane', function(r)
    !(r.kind == 'ServiceMonitor' && r.metadata.name == 'kubelet')
  , { ruler: 'metrics' }),
}
