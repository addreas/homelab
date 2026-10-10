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
    },
  };

// jsonnet object `+` replaces same-name fields, so the accumulator field must
// be declared `+:` to merge with what previous steps accumulated.
local resources(name, filter = function(r) true) = std.foldr(
  function(r, acc) acc + {
    k+: if !std.endsWith(r.kind, 'List') then {
      [r.kind]+: {
        [r.metadata.name]: r
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
  'kubePrometheus.gen.json': resources('kubePrometheus', function(r) r.metadata.name == 'kube-prometheus-rules'),

  // kubernetes-monitoring-rules PrometheusRule + control-plane ServiceMonitors
  // (upstream: kubernetesControlPlane-prometheusRule.yaml, kubernetesControlPlane-serviceMonitor*.yaml)
  'kubernetesControlPlane.gen.json': resources('kubernetesControlPlane'),
}
