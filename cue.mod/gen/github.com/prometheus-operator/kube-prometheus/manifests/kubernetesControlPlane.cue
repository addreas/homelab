package manifests

kubernetesControlPlane: {
	PrometheusRule: "kubernetes-monitoring-rules": {
		apiVersion: "monitoring.coreos.com/v1"
		kind:       "PrometheusRule"
		metadata: {
			labels: {
				"app.kubernetes.io/name":    "kube-prometheus"
				"app.kubernetes.io/part-of": "kube-prometheus"
				prometheus:                  "k8s"
				role:                        "alert-rules"
			}
			name:      "kubernetes-monitoring-rules"
			namespace: "monitoring"
		}
		spec: groups: [{
			name: "kubernetes-apps"
			rules: [{
				alert: "KubePodCrashLooping"
				annotations: {
					description: "Pod {{ $labels.namespace }}/{{ $labels.pod }} ({{ $labels.container }}) is in waiting state (reason: \"CrashLoopBackOff\")."
					runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubepodcrashlooping"
					summary:     "Pod is crash looping."
				}
				expr: """
					max_over_time(kube_pod_container_status_waiting_reason{reason="CrashLoopBackOff", job="kube-state-metrics"}[5m]) >= 1

					"""
				for: "15m"
				labels: severity: "warning"
			}, {
				alert: "KubePodNotReady"
				annotations: {
					description: "Pod {{ $labels.namespace }}/{{ $labels.pod }} has been in a non-ready state for longer than 15 minutes."
					runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubepodnotready"
					summary:     "Pod has been in a non-ready state for more than 15 minutes."
				}
				expr: """
					sum by (namespace, pod, cluster) (
					  max by(namespace, pod, cluster) (
					    kube_pod_status_phase{job="kube-state-metrics", phase=~"Pending|Unknown|Failed"}
					  ) * on(namespace, pod, cluster) group_left(owner_kind) topk by(namespace, pod, cluster) (
					    1, max by(namespace, pod, owner_kind, cluster) (kube_pod_owner{owner_kind!="Job"})
					  )
					) > 0

					"""
				for: "15m"
				labels: severity: "warning"
			}, {
				alert: "KubeDeploymentGenerationMismatch"
				annotations: {
					description: "Deployment generation for {{ $labels.namespace }}/{{ $labels.deployment }} does not match, this indicates that the Deployment has failed but has not been rolled back."
					runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubedeploymentgenerationmismatch"
					summary:     "Deployment generation mismatch due to possible roll-back"
				}
				expr: """
					kube_deployment_status_observed_generation{job="kube-state-metrics"}
					  !=
					kube_deployment_metadata_generation{job="kube-state-metrics"}

					"""
				for: "15m"
				labels: severity: "warning"
			}, {
				alert: "KubeDeploymentReplicasMismatch"
				annotations: {
					description: "Deployment {{ $labels.namespace }}/{{ $labels.deployment }} has not matched the expected number of replicas for longer than 15 minutes."
					runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubedeploymentreplicasmismatch"
					summary:     "Deployment has not matched the expected number of replicas."
				}
				expr: """
					(
					  kube_deployment_spec_replicas{job="kube-state-metrics"}
					    >
					  kube_deployment_status_replicas_available{job="kube-state-metrics"}
					) and (
					  changes(kube_deployment_status_replicas_updated{job="kube-state-metrics"}[10m])
					    ==
					  0
					)

					"""
				for: "15m"
				labels: severity: "warning"
			}, {
				alert: "KubeDeploymentRolloutStuck"
				annotations: {
					description: "Rollout of deployment {{ $labels.namespace }}/{{ $labels.deployment }} is not progressing for longer than 15 minutes."
					runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubedeploymentrolloutstuck"
					summary:     "Deployment rollout is not progressing."
				}
				expr: """
					kube_deployment_status_condition{condition="Progressing", status="false",job="kube-state-metrics"}
					!= 0

					"""
				for: "15m"
				labels: severity: "warning"
			}, {
				alert: "KubeStatefulSetReplicasMismatch"
				annotations: {
					description: "StatefulSet {{ $labels.namespace }}/{{ $labels.statefulset }} has not matched the expected number of replicas for longer than 15 minutes."
					runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubestatefulsetreplicasmismatch"
					summary:     "StatefulSet has not matched the expected number of replicas."
				}
				expr: """
					(
					  kube_statefulset_status_replicas_ready{job="kube-state-metrics"}
					    !=
					  kube_statefulset_status_replicas{job="kube-state-metrics"}
					) and (
					  changes(kube_statefulset_status_replicas_updated{job="kube-state-metrics"}[10m])
					    ==
					  0
					)

					"""
				for: "15m"
				labels: severity: "warning"
			}, {
				alert: "KubeStatefulSetGenerationMismatch"
				annotations: {
					description: "StatefulSet generation for {{ $labels.namespace }}/{{ $labels.statefulset }} does not match, this indicates that the StatefulSet has failed but has not been rolled back."
					runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubestatefulsetgenerationmismatch"
					summary:     "StatefulSet generation mismatch due to possible roll-back"
				}
				expr: """
					kube_statefulset_status_observed_generation{job="kube-state-metrics"}
					  !=
					kube_statefulset_metadata_generation{job="kube-state-metrics"}

					"""
				for: "15m"
				labels: severity: "warning"
			}, {
				alert: "KubeStatefulSetUpdateNotRolledOut"
				annotations: {
					description: "StatefulSet {{ $labels.namespace }}/{{ $labels.statefulset }} update has not been rolled out."
					runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubestatefulsetupdatenotrolledout"
					summary:     "StatefulSet update has not been rolled out."
				}
				expr: """
					(
					  max by(namespace, statefulset, job, cluster) (
					    kube_statefulset_status_current_revision{job="kube-state-metrics"}
					      unless
					    kube_statefulset_status_update_revision{job="kube-state-metrics"}
					  )
					    *
					  (
					    kube_statefulset_replicas{job="kube-state-metrics"}
					      !=
					    kube_statefulset_status_replicas_updated{job="kube-state-metrics"}
					  )
					)  and (
					  changes(kube_statefulset_status_replicas_updated{job="kube-state-metrics"}[5m])
					    ==
					  0
					)

					"""
				for: "15m"
				labels: severity: "warning"
			}, {
				alert: "KubeDaemonSetRolloutStuck"
				annotations: {
					description: "DaemonSet {{ $labels.namespace }}/{{ $labels.daemonset }} has not finished or progressed for at least 15 minutes."
					runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubedaemonsetrolloutstuck"
					summary:     "DaemonSet rollout is stuck."
				}
				expr: """
					(
					  (
					    kube_daemonset_status_current_number_scheduled{job="kube-state-metrics"}
					     !=
					    kube_daemonset_status_desired_number_scheduled{job="kube-state-metrics"}
					  ) or (
					    kube_daemonset_status_number_misscheduled{job="kube-state-metrics"}
					     !=
					    0
					  ) or (
					    kube_daemonset_status_updated_number_scheduled{job="kube-state-metrics"}
					     !=
					    kube_daemonset_status_desired_number_scheduled{job="kube-state-metrics"}
					  ) or (
					    kube_daemonset_status_number_available{job="kube-state-metrics"}
					     !=
					    kube_daemonset_status_desired_number_scheduled{job="kube-state-metrics"}
					  )
					) and (
					  changes(kube_daemonset_status_updated_number_scheduled{job="kube-state-metrics"}[5m])
					    ==
					  0
					)

					"""
				for: "15m"
				labels: severity: "warning"
			}, {
				alert: "KubeContainerWaiting"
				annotations: {
					description: "pod/{{ $labels.pod }} in namespace {{ $labels.namespace }} on container {{ $labels.container}} has been in waiting state for longer than 1 hour. (reason: \"{{ $labels.reason }}\")."
					runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubecontainerwaiting"
					summary:     "Pod container waiting longer than 1 hour"
				}
				expr: """
					kube_pod_container_status_waiting_reason{reason!="CrashLoopBackOff", job="kube-state-metrics"} > 0

					"""
				for: "1h"
				labels: severity: "warning"
			}, {
				alert: "KubeDaemonSetNotScheduled"
				annotations: {
					description: "{{ $value }} Pods of DaemonSet {{ $labels.namespace }}/{{ $labels.daemonset }} are not scheduled."
					runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubedaemonsetnotscheduled"
					summary:     "DaemonSet pods are not scheduled."
				}
				expr: """
					kube_daemonset_status_desired_number_scheduled{job="kube-state-metrics"}
					  -
					kube_daemonset_status_current_number_scheduled{job="kube-state-metrics"} > 0

					"""
				for: "10m"
				labels: severity: "warning"
			}, {
				alert: "KubeDaemonSetMisScheduled"
				annotations: {
					description: "{{ $value }} Pods of DaemonSet {{ $labels.namespace }}/{{ $labels.daemonset }} are running where they are not supposed to run."
					runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubedaemonsetmisscheduled"
					summary:     "DaemonSet pods are misscheduled."
				}
				expr: """
					kube_daemonset_status_number_misscheduled{job="kube-state-metrics"} > 0

					"""
				for: "15m"
				labels: severity: "warning"
			}, {
				alert: "KubeJobNotCompleted"
				annotations: {
					description: "Job {{ $labels.namespace }}/{{ $labels.job_name }} is taking more than {{ \"43200\" | humanizeDuration }} to complete."
					runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubejobnotcompleted"
					summary:     "Job did not complete in time"
				}
				expr: """
					time() - max by(namespace, job_name, cluster) (kube_job_status_start_time{job="kube-state-metrics"}
					  and
					kube_job_status_active{job="kube-state-metrics"} > 0) > 43200

					"""
				labels: severity: "warning"
			}, {
				alert: "KubeJobFailed"
				annotations: {
					description: "Job {{ $labels.namespace }}/{{ $labels.job_name }} failed to complete. Removing failed job after investigation should clear this alert."
					runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubejobfailed"
					summary:     "Job failed to complete."
				}
				expr: """
					kube_job_failed{job="kube-state-metrics"}  > 0

					"""
				for: "15m"
				labels: severity: "warning"
			}, {
				alert: "KubeHpaReplicasMismatch"
				annotations: {
					description: "HPA {{ $labels.namespace }}/{{ $labels.horizontalpodautoscaler  }} has not matched the desired number of replicas for longer than 15 minutes."
					runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubehpareplicasmismatch"
					summary:     "HPA has not matched desired number of replicas."
				}
				expr: """
					(kube_horizontalpodautoscaler_status_desired_replicas{job="kube-state-metrics"}
					  !=
					kube_horizontalpodautoscaler_status_current_replicas{job="kube-state-metrics"})
					  and
					(kube_horizontalpodautoscaler_status_current_replicas{job="kube-state-metrics"}
					  >
					kube_horizontalpodautoscaler_spec_min_replicas{job="kube-state-metrics"})
					  and
					(kube_horizontalpodautoscaler_status_current_replicas{job="kube-state-metrics"}
					  <
					kube_horizontalpodautoscaler_spec_max_replicas{job="kube-state-metrics"})
					  and
					changes(kube_horizontalpodautoscaler_status_current_replicas{job="kube-state-metrics"}[15m]) == 0

					"""
				for: "15m"
				labels: severity: "warning"
			}, {
				alert: "KubeHpaMaxedOut"
				annotations: {
					description: "HPA {{ $labels.namespace }}/{{ $labels.horizontalpodautoscaler  }} has been running at max replicas for longer than 15 minutes."
					runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubehpamaxedout"
					summary:     "HPA is running at max replicas"
				}
				expr: """
					kube_horizontalpodautoscaler_status_current_replicas{job="kube-state-metrics"}
					  ==
					kube_horizontalpodautoscaler_spec_max_replicas{job="kube-state-metrics"}

					"""
				for: "15m"
				labels: severity: "warning"
			}]
		}, {
			name: "kubernetes-resources"
			rules: [{
				alert: "KubeCPUOvercommit"
				annotations: {
					description: "Cluster {{ $labels.cluster }} has overcommitted CPU resource requests for Pods by {{ $value }} CPU shares and cannot tolerate node failure."
					runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubecpuovercommit"
					summary:     "Cluster has overcommitted CPU resource requests."
				}
				expr: """
					sum(namespace_cpu:kube_pod_container_resource_requests:sum{}) by (cluster) - (sum(kube_node_status_allocatable{job="kube-state-metrics",resource="cpu"}) by (cluster) - max(kube_node_status_allocatable{job="kube-state-metrics",resource="cpu"}) by (cluster)) > 0
					and
					(sum(kube_node_status_allocatable{job="kube-state-metrics",resource="cpu"}) by (cluster) - max(kube_node_status_allocatable{job="kube-state-metrics",resource="cpu"}) by (cluster)) > 0

					"""
				for: "10m"
				labels: severity: "warning"
			}, {
				alert: "KubeMemoryOvercommit"
				annotations: {
					description: "Cluster {{ $labels.cluster }} has overcommitted memory resource requests for Pods by {{ $value | humanize }} bytes and cannot tolerate node failure."
					runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubememoryovercommit"
					summary:     "Cluster has overcommitted memory resource requests."
				}
				expr: """
					sum(namespace_memory:kube_pod_container_resource_requests:sum{}) by (cluster) - (sum(kube_node_status_allocatable{resource="memory", job="kube-state-metrics"}) by (cluster) - max(kube_node_status_allocatable{resource="memory", job="kube-state-metrics"}) by (cluster)) > 0
					and
					(sum(kube_node_status_allocatable{resource="memory", job="kube-state-metrics"}) by (cluster) - max(kube_node_status_allocatable{resource="memory", job="kube-state-metrics"}) by (cluster)) > 0

					"""
				for: "10m"
				labels: severity: "warning"
			}, {
				alert: "KubeCPUQuotaOvercommit"
				annotations: {
					description: "Cluster {{ $labels.cluster }}  has overcommitted CPU resource requests for Namespaces."
					runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubecpuquotaovercommit"
					summary:     "Cluster has overcommitted CPU resource requests."
				}
				expr: """
					sum(min without(resource) (kube_resourcequota{job="kube-state-metrics", type="hard", resource=~"(cpu|requests.cpu)"})) by (cluster)
					  /
					sum(kube_node_status_allocatable{resource="cpu", job="kube-state-metrics"}) by (cluster)
					  > 1.5

					"""
				for: "5m"
				labels: severity: "warning"
			}, {
				alert: "KubeMemoryQuotaOvercommit"
				annotations: {
					description: "Cluster {{ $labels.cluster }}  has overcommitted memory resource requests for Namespaces."
					runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubememoryquotaovercommit"
					summary:     "Cluster has overcommitted memory resource requests."
				}
				expr: """
					sum(min without(resource) (kube_resourcequota{job="kube-state-metrics", type="hard", resource=~"(memory|requests.memory)"})) by (cluster)
					  /
					sum(kube_node_status_allocatable{resource="memory", job="kube-state-metrics"}) by (cluster)
					  > 1.5

					"""
				for: "5m"
				labels: severity: "warning"
			}, {
				alert: "KubeQuotaAlmostFull"
				annotations: {
					description: "Namespace {{ $labels.namespace }} is using {{ $value | humanizePercentage }} of its {{ $labels.resource }} quota."
					runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubequotaalmostfull"
					summary:     "Namespace quota is going to be full."
				}
				expr: """
					kube_resourcequota{job="kube-state-metrics", type="used"}
					  / ignoring(instance, job, type)
					(kube_resourcequota{job="kube-state-metrics", type="hard"} > 0)
					  > 0.9 < 1

					"""
				for: "15m"
				labels: severity: "info"
			}, {
				alert: "KubeQuotaFullyUsed"
				annotations: {
					description: "Namespace {{ $labels.namespace }} is using {{ $value | humanizePercentage }} of its {{ $labels.resource }} quota."
					runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubequotafullyused"
					summary:     "Namespace quota is fully used."
				}
				expr: """
					kube_resourcequota{job="kube-state-metrics", type="used"}
					  / ignoring(instance, job, type)
					(kube_resourcequota{job="kube-state-metrics", type="hard"} > 0)
					  == 1

					"""
				for: "15m"
				labels: severity: "info"
			}, {
				alert: "KubeQuotaExceeded"
				annotations: {
					description: "Namespace {{ $labels.namespace }} is using {{ $value | humanizePercentage }} of its {{ $labels.resource }} quota."
					runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubequotaexceeded"
					summary:     "Namespace quota has exceeded the limits."
				}
				expr: """
					kube_resourcequota{job="kube-state-metrics", type="used"}
					  / ignoring(instance, job, type)
					(kube_resourcequota{job="kube-state-metrics", type="hard"} > 0)
					  > 1

					"""
				for: "15m"
				labels: severity: "warning"
			}, {
				alert: "CPUThrottlingHigh"
				annotations: {
					description: "{{ $value | humanizePercentage }} throttling of CPU in namespace {{ $labels.namespace }} for container {{ $labels.container }} in pod {{ $labels.pod }}."
					runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/cputhrottlinghigh"
					summary:     "Processes experience elevated CPU throttling."
				}
				expr: """
					sum(increase(container_cpu_cfs_throttled_periods_total{container!="", job="kubelet", metrics_path="/metrics/cadvisor", }[5m])) without (id, metrics_path, name, image, endpoint, job, node)
					  /
					sum(increase(container_cpu_cfs_periods_total{job="kubelet", metrics_path="/metrics/cadvisor", }[5m])) without (id, metrics_path, name, image, endpoint, job, node)
					  > ( 25 / 100 )

					"""
				for: "15m"
				labels: severity: "info"
			}]
		}, {
			name: "kubernetes-storage"
			rules: [{
				alert: "KubePersistentVolumeFillingUp"
				annotations: {
					description: "The PersistentVolume claimed by {{ $labels.persistentvolumeclaim }} in Namespace {{ $labels.namespace }} {{ with $labels.cluster -}} on Cluster {{ . }} {{- end }} is only {{ $value | humanizePercentage }} free."
					runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubepersistentvolumefillingup"
					summary:     "PersistentVolume is filling up."
				}
				expr: """
					(
					  kubelet_volume_stats_available_bytes{job="kubelet", metrics_path="/metrics"}
					    /
					  kubelet_volume_stats_capacity_bytes{job="kubelet", metrics_path="/metrics"}
					) < 0.03
					and
					kubelet_volume_stats_used_bytes{job="kubelet", metrics_path="/metrics"} > 0
					unless on(cluster, namespace, persistentvolumeclaim)
					kube_persistentvolumeclaim_access_mode{ access_mode="ReadOnlyMany"} == 1
					unless on(cluster, namespace, persistentvolumeclaim)
					kube_persistentvolumeclaim_labels{label_excluded_from_alerts="true"} == 1

					"""
				for: "1m"
				labels: severity: "critical"
			}, {
				alert: "KubePersistentVolumeFillingUp"
				annotations: {
					description: "Based on recent sampling, the PersistentVolume claimed by {{ $labels.persistentvolumeclaim }} in Namespace {{ $labels.namespace }} {{ with $labels.cluster -}} on Cluster {{ . }} {{- end }} is expected to fill up within four days. Currently {{ $value | humanizePercentage }} is available."
					runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubepersistentvolumefillingup"
					summary:     "PersistentVolume is filling up."
				}
				expr: """
					(
					  kubelet_volume_stats_available_bytes{job="kubelet", metrics_path="/metrics"}
					    /
					  kubelet_volume_stats_capacity_bytes{job="kubelet", metrics_path="/metrics"}
					) < 0.15
					and
					kubelet_volume_stats_used_bytes{job="kubelet", metrics_path="/metrics"} > 0
					and
					predict_linear(kubelet_volume_stats_available_bytes{job="kubelet", metrics_path="/metrics"}[6h], 4 * 24 * 3600) < 0
					unless on(cluster, namespace, persistentvolumeclaim)
					kube_persistentvolumeclaim_access_mode{ access_mode="ReadOnlyMany"} == 1
					unless on(cluster, namespace, persistentvolumeclaim)
					kube_persistentvolumeclaim_labels{label_excluded_from_alerts="true"} == 1

					"""
				for: "1h"
				labels: severity: "warning"
			}, {
				alert: "KubePersistentVolumeInodesFillingUp"
				annotations: {
					description: "The PersistentVolume claimed by {{ $labels.persistentvolumeclaim }} in Namespace {{ $labels.namespace }} {{ with $labels.cluster -}} on Cluster {{ . }} {{- end }} only has {{ $value | humanizePercentage }} free inodes."
					runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubepersistentvolumeinodesfillingup"
					summary:     "PersistentVolumeInodes are filling up."
				}
				expr: """
					(
					  kubelet_volume_stats_inodes_free{job="kubelet", metrics_path="/metrics"}
					    /
					  kubelet_volume_stats_inodes{job="kubelet", metrics_path="/metrics"}
					) < 0.03
					and
					kubelet_volume_stats_inodes_used{job="kubelet", metrics_path="/metrics"} > 0
					unless on(cluster, namespace, persistentvolumeclaim)
					kube_persistentvolumeclaim_access_mode{ access_mode="ReadOnlyMany"} == 1
					unless on(cluster, namespace, persistentvolumeclaim)
					kube_persistentvolumeclaim_labels{label_excluded_from_alerts="true"} == 1

					"""
				for: "1m"
				labels: severity: "critical"
			}, {
				alert: "KubePersistentVolumeInodesFillingUp"
				annotations: {
					description: "Based on recent sampling, the PersistentVolume claimed by {{ $labels.persistentvolumeclaim }} in Namespace {{ $labels.namespace }} {{ with $labels.cluster -}} on Cluster {{ . }} {{- end }} is expected to run out of inodes within four days. Currently {{ $value | humanizePercentage }} of its inodes are free."
					runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubepersistentvolumeinodesfillingup"
					summary:     "PersistentVolumeInodes are filling up."
				}
				expr: """
					(
					  kubelet_volume_stats_inodes_free{job="kubelet", metrics_path="/metrics"}
					    /
					  kubelet_volume_stats_inodes{job="kubelet", metrics_path="/metrics"}
					) < 0.15
					and
					kubelet_volume_stats_inodes_used{job="kubelet", metrics_path="/metrics"} > 0
					and
					predict_linear(kubelet_volume_stats_inodes_free{job="kubelet", metrics_path="/metrics"}[6h], 4 * 24 * 3600) < 0
					unless on(cluster, namespace, persistentvolumeclaim)
					kube_persistentvolumeclaim_access_mode{ access_mode="ReadOnlyMany"} == 1
					unless on(cluster, namespace, persistentvolumeclaim)
					kube_persistentvolumeclaim_labels{label_excluded_from_alerts="true"} == 1

					"""
				for: "1h"
				labels: severity: "warning"
			}, {
				alert: "KubePersistentVolumeErrors"
				annotations: {
					description: "The persistent volume {{ $labels.persistentvolume }} {{ with $labels.cluster -}} on Cluster {{ . }} {{- end }} has status {{ $labels.phase }}."
					runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubepersistentvolumeerrors"
					summary:     "PersistentVolume is having issues with provisioning."
				}
				expr: """
					kube_persistentvolume_status_phase{phase=~"Failed|Pending",job="kube-state-metrics"} > 0

					"""
				for: "5m"
				labels: severity: "critical"
			}]
		}, {
			name: "kubernetes-system"
			rules: [{
				alert: "KubeVersionMismatch"
				annotations: {
					description: "There are {{ $value }} different semantic versions of Kubernetes components running."
					runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubeversionmismatch"
					summary:     "Different semantic versions of Kubernetes components running."
				}
				expr: """
					count by (cluster) (count by (git_version, cluster) (label_replace(kubernetes_build_info{job!~"kube-dns|coredns"},"git_version","$1","git_version","(v[0-9]*.[0-9]*).*"))) > 1

					"""
				for: "15m"
				labels: severity: "warning"
			}, {
				alert: "KubeClientErrors"
				annotations: {
					description: "Kubernetes API server client '{{ $labels.job }}/{{ $labels.instance }}' is experiencing {{ $value | humanizePercentage }} errors.'"
					runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubeclienterrors"
					summary:     "Kubernetes API server client is experiencing errors."
				}
				expr: """
					(sum(rate(rest_client_requests_total{job="apiserver",code=~"5.."}[5m])) by (cluster, instance, job, namespace)
					  /
					sum(rate(rest_client_requests_total{job="apiserver"}[5m])) by (cluster, instance, job, namespace))
					> 0.01

					"""
				for: "15m"
				labels: severity: "warning"
			}]
		}, {
			name: "kube-apiserver-slos"
			rules: [{
				alert: "KubeAPIErrorBudgetBurn"
				annotations: {
					description: "The API server is burning too much error budget."
					runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubeapierrorbudgetburn"
					summary:     "The API server is burning too much error budget."
				}
				expr: """
					sum by(cluster) (apiserver_request:burnrate1h) > (14.40 * 0.01000)
					and on(cluster)
					sum by(cluster) (apiserver_request:burnrate5m) > (14.40 * 0.01000)

					"""
				for: "2m"
				labels: {
					long:     "1h"
					severity: "critical"
					short:    "5m"
				}
			}, {
				alert: "KubeAPIErrorBudgetBurn"
				annotations: {
					description: "The API server is burning too much error budget."
					runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubeapierrorbudgetburn"
					summary:     "The API server is burning too much error budget."
				}
				expr: """
					sum by(cluster) (apiserver_request:burnrate6h) > (6.00 * 0.01000)
					and on(cluster)
					sum by(cluster) (apiserver_request:burnrate30m) > (6.00 * 0.01000)

					"""
				for: "15m"
				labels: {
					long:     "6h"
					severity: "critical"
					short:    "30m"
				}
			}, {
				alert: "KubeAPIErrorBudgetBurn"
				annotations: {
					description: "The API server is burning too much error budget."
					runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubeapierrorbudgetburn"
					summary:     "The API server is burning too much error budget."
				}
				expr: """
					sum by(cluster) (apiserver_request:burnrate1d) > (3.00 * 0.01000)
					and on(cluster)
					sum by(cluster) (apiserver_request:burnrate2h) > (3.00 * 0.01000)

					"""
				for: "1h"
				labels: {
					long:     "1d"
					severity: "warning"
					short:    "2h"
				}
			}, {
				alert: "KubeAPIErrorBudgetBurn"
				annotations: {
					description: "The API server is burning too much error budget."
					runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubeapierrorbudgetburn"
					summary:     "The API server is burning too much error budget."
				}
				expr: """
					sum by(cluster) (apiserver_request:burnrate3d) > (1.00 * 0.01000)
					and on(cluster)
					sum by(cluster) (apiserver_request:burnrate6h) > (1.00 * 0.01000)

					"""
				for: "3h"
				labels: {
					long:     "3d"
					severity: "warning"
					short:    "6h"
				}
			}]
		}, {
			name: "kubernetes-system-apiserver"
			rules: [{
				alert: "KubeClientCertificateExpiration"
				annotations: {
					description: "A client certificate used to authenticate to kubernetes apiserver is expiring in less than 7.0 days."
					runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubeclientcertificateexpiration"
					summary:     "Client certificate is about to expire."
				}
				expr: """
					histogram_quantile(0.01, sum without (namespace, service, endpoint) (rate(apiserver_client_certificate_expiration_seconds_bucket{job="apiserver"}[5m]))) < 604800
					and
					on(job, cluster, instance) apiserver_client_certificate_expiration_seconds_count{job="apiserver"} > 0

					"""
				for: "5m"
				labels: severity: "warning"
			}, {
				alert: "KubeClientCertificateExpiration"
				annotations: {
					description: "A client certificate used to authenticate to kubernetes apiserver is expiring in less than 24.0 hours."
					runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubeclientcertificateexpiration"
					summary:     "Client certificate is about to expire."
				}
				expr: """
					histogram_quantile(0.01, sum without (namespace, service, endpoint) (rate(apiserver_client_certificate_expiration_seconds_bucket{job="apiserver"}[5m]))) < 86400
					and
					on(job, cluster, instance) apiserver_client_certificate_expiration_seconds_count{job="apiserver"} > 0

					"""
				for: "5m"
				labels: severity: "critical"
			}, {
				alert: "KubeAggregatedAPIErrors"
				annotations: {
					description: "Kubernetes aggregated API {{ $labels.name }}/{{ $labels.namespace }} has reported errors. It has appeared unavailable {{ $value | humanize }} times averaged over the past 10m."
					runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubeaggregatedapierrors"
					summary:     "Kubernetes aggregated API has reported errors."
				}
				expr: """
					sum by(name, namespace, cluster)(increase(aggregator_unavailable_apiservice_total{job="apiserver"}[10m])) > 4

					"""
				labels: severity: "warning"
			}, {
				alert: "KubeAggregatedAPIDown"
				annotations: {
					description: "Kubernetes aggregated API {{ $labels.name }}/{{ $labels.namespace }} has been only {{ $value | humanize }}% available over the last 10m."
					runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubeaggregatedapidown"
					summary:     "Kubernetes aggregated API is down."
				}
				expr: """
					(1 - max by(name, namespace, cluster)(avg_over_time(aggregator_unavailable_apiservice{job="apiserver"}[10m]))) * 100 < 85

					"""
				for: "5m"
				labels: severity: "warning"
			}, {
				alert: "KubeAPIDown"
				annotations: {
					description: "KubeAPI has disappeared from Prometheus target discovery."
					runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubeapidown"
					summary:     "Target disappeared from Prometheus target discovery."
				}
				expr: """
					absent(up{job="apiserver"} == 1)

					"""
				for: "15m"
				labels: severity: "critical"
			}, {
				alert: "KubeAPITerminatedRequests"
				annotations: {
					description: "The kubernetes apiserver has terminated {{ $value | humanizePercentage }} of its incoming requests."
					runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubeapiterminatedrequests"
					summary:     "The kubernetes apiserver has terminated {{ $value | humanizePercentage }} of its incoming requests."
				}
				expr: """
					sum by(cluster) (rate(apiserver_request_terminations_total{job="apiserver"}[10m])) / ( sum by(cluster) (rate(apiserver_request_total{job="apiserver"}[10m])) + sum by(cluster) (rate(apiserver_request_terminations_total{job="apiserver"}[10m])) ) > 0.20

					"""
				for: "5m"
				labels: severity: "warning"
			}]
		}, {
			name: "kubernetes-system-kubelet"
			rules: [{
				alert: "KubeNodeNotReady"
				annotations: {
					description: "{{ $labels.node }} has been unready for more than 15 minutes."
					runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubenodenotready"
					summary:     "Node is not ready."
				}
				expr: """
					kube_node_status_condition{job="kube-state-metrics",condition="Ready",status="true"} == 0

					"""
				for: "15m"
				labels: severity: "warning"
			}, {
				alert: "KubeNodeUnreachable"
				annotations: {
					description: "{{ $labels.node }} is unreachable and some workloads may be rescheduled."
					runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubenodeunreachable"
					summary:     "Node is unreachable."
				}
				expr: """
					(kube_node_spec_taint{job="kube-state-metrics",key="node.kubernetes.io/unreachable",effect="NoSchedule"} unless ignoring(key,value) kube_node_spec_taint{job="kube-state-metrics",key=~"ToBeDeletedByClusterAutoscaler|cloud.google.com/impending-node-termination|aws-node-termination-handler/spot-itn"}) == 1

					"""
				for: "15m"
				labels: severity: "warning"
			}, {
				alert: "KubeletTooManyPods"
				annotations: {
					description: "Kubelet '{{ $labels.node }}' is running at {{ $value | humanizePercentage }} of its Pod capacity."
					runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubelettoomanypods"
					summary:     "Kubelet is running at capacity."
				}
				expr: """
					count by(cluster, node) (
					  (kube_pod_status_phase{job="kube-state-metrics",phase="Running"} == 1) * on(instance,pod,namespace,cluster) group_left(node) topk by(instance,pod,namespace,cluster) (1, kube_pod_info{job="kube-state-metrics"})
					)
					/
					max by(cluster, node) (
					  kube_node_status_capacity{job="kube-state-metrics",resource="pods"} != 1
					) > 0.95

					"""
				for: "15m"
				labels: severity: "info"
			}, {
				alert: "KubeNodeReadinessFlapping"
				annotations: {
					description: "The readiness status of node {{ $labels.node }} has changed {{ $value }} times in the last 15 minutes."
					runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubenodereadinessflapping"
					summary:     "Node readiness status is flapping."
				}
				expr: """
					sum(changes(kube_node_status_condition{job="kube-state-metrics",status="true",condition="Ready"}[15m])) by (cluster, node) > 2

					"""
				for: "15m"
				labels: severity: "warning"
			}, {
				alert: "KubeletPlegDurationHigh"
				annotations: {
					description: "The Kubelet Pod Lifecycle Event Generator has a 99th percentile duration of {{ $value }} seconds on node {{ $labels.node }}."
					runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubeletplegdurationhigh"
					summary:     "Kubelet Pod Lifecycle Event Generator is taking too long to relist."
				}
				expr: """
					node_quantile:kubelet_pleg_relist_duration_seconds:histogram_quantile{quantile="0.99"} >= 10

					"""
				for: "5m"
				labels: severity: "warning"
			}, {
				alert: "KubeletPodStartUpLatencyHigh"
				annotations: {
					description: "Kubelet Pod startup 99th percentile latency is {{ $value }} seconds on node {{ $labels.node }}."
					runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubeletpodstartuplatencyhigh"
					summary:     "Kubelet Pod startup latency is too high."
				}
				expr: """
					histogram_quantile(0.99, sum(rate(kubelet_pod_worker_duration_seconds_bucket{job="kubelet", metrics_path="/metrics"}[5m])) by (cluster, instance, le)) * on(cluster, instance) group_left(node) kubelet_node_name{job="kubelet", metrics_path="/metrics"} > 60

					"""
				for: "15m"
				labels: severity: "warning"
			}, {
				alert: "KubeletClientCertificateExpiration"
				annotations: {
					description: "Client certificate for Kubelet on node {{ $labels.node }} expires in {{ $value | humanizeDuration }}."
					runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubeletclientcertificateexpiration"
					summary:     "Kubelet client certificate is about to expire."
				}
				expr: """
					kubelet_certificate_manager_client_ttl_seconds < 604800

					"""
				labels: severity: "warning"
			}, {
				alert: "KubeletClientCertificateExpiration"
				annotations: {
					description: "Client certificate for Kubelet on node {{ $labels.node }} expires in {{ $value | humanizeDuration }}."
					runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubeletclientcertificateexpiration"
					summary:     "Kubelet client certificate is about to expire."
				}
				expr: """
					kubelet_certificate_manager_client_ttl_seconds < 86400

					"""
				labels: severity: "critical"
			}, {
				alert: "KubeletServerCertificateExpiration"
				annotations: {
					description: "Server certificate for Kubelet on node {{ $labels.node }} expires in {{ $value | humanizeDuration }}."
					runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubeletservercertificateexpiration"
					summary:     "Kubelet server certificate is about to expire."
				}
				expr: """
					kubelet_certificate_manager_server_ttl_seconds < 604800

					"""
				labels: severity: "warning"
			}, {
				alert: "KubeletServerCertificateExpiration"
				annotations: {
					description: "Server certificate for Kubelet on node {{ $labels.node }} expires in {{ $value | humanizeDuration }}."
					runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubeletservercertificateexpiration"
					summary:     "Kubelet server certificate is about to expire."
				}
				expr: """
					kubelet_certificate_manager_server_ttl_seconds < 86400

					"""
				labels: severity: "critical"
			}, {
				alert: "KubeletClientCertificateRenewalErrors"
				annotations: {
					description: "Kubelet on node {{ $labels.node }} has failed to renew its client certificate ({{ $value | humanize }} errors in the last 5 minutes)."
					runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubeletclientcertificaterenewalerrors"
					summary:     "Kubelet has failed to renew its client certificate."
				}
				expr: """
					increase(kubelet_certificate_manager_client_expiration_renew_errors[5m]) > 0

					"""
				for: "15m"
				labels: severity: "warning"
			}, {
				alert: "KubeletServerCertificateRenewalErrors"
				annotations: {
					description: "Kubelet on node {{ $labels.node }} has failed to renew its server certificate ({{ $value | humanize }} errors in the last 5 minutes)."
					runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubeletservercertificaterenewalerrors"
					summary:     "Kubelet has failed to renew its server certificate."
				}
				expr: """
					increase(kubelet_server_expiration_renew_errors[5m]) > 0

					"""
				for: "15m"
				labels: severity: "warning"
			}, {
				alert: "KubeletDown"
				annotations: {
					description: "Kubelet has disappeared from Prometheus target discovery."
					runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubeletdown"
					summary:     "Target disappeared from Prometheus target discovery."
				}
				expr: """
					absent(up{job="kubelet", metrics_path="/metrics"} == 1)

					"""
				for: "15m"
				labels: severity: "critical"
			}]
		}, {
			name: "kubernetes-system-scheduler"
			rules: [{
				alert: "KubeSchedulerDown"
				annotations: {
					description: "KubeScheduler has disappeared from Prometheus target discovery."
					runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubeschedulerdown"
					summary:     "Target disappeared from Prometheus target discovery."
				}
				expr: """
					absent(up{job="kube-scheduler"} == 1)

					"""
				for: "15m"
				labels: severity: "critical"
			}]
		}, {
			name: "kubernetes-system-controller-manager"
			rules: [{
				alert: "KubeControllerManagerDown"
				annotations: {
					description: "KubeControllerManager has disappeared from Prometheus target discovery."
					runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kubernetes/kubecontrollermanagerdown"
					summary:     "Target disappeared from Prometheus target discovery."
				}
				expr: """
					absent(up{job="kube-controller-manager"} == 1)

					"""
				for: "15m"
				labels: severity: "critical"
			}]
		}, {
			interval: "3m"
			name:     "kube-apiserver-availability.rules"
			rules: [{
				expr: """
					avg_over_time(code_verb:apiserver_request_total:increase1h[30d]) * 24 * 30

					"""
				record: "code_verb:apiserver_request_total:increase30d"
			}, {
				expr: """
					sum by (cluster, code) (code_verb:apiserver_request_total:increase30d{verb=~"LIST|GET"})

					"""
				labels: verb: "read"
				record: "code:apiserver_request_total:increase30d"
			}, {
				expr: """
					sum by (cluster, code) (code_verb:apiserver_request_total:increase30d{verb=~"POST|PUT|PATCH|DELETE"})

					"""
				labels: verb: "write"
				record: "code:apiserver_request_total:increase30d"
			}, {
				expr: """
					sum by (cluster, verb, scope, le) (increase(apiserver_request_sli_duration_seconds_bucket[1h]))

					"""
				record: "cluster_verb_scope_le:apiserver_request_sli_duration_seconds_bucket:increase1h"
			}, {
				expr: """
					sum by (cluster, verb, scope, le) (avg_over_time(cluster_verb_scope_le:apiserver_request_sli_duration_seconds_bucket:increase1h[30d]) * 24 * 30)

					"""
				record: "cluster_verb_scope_le:apiserver_request_sli_duration_seconds_bucket:increase30d"
			}, {
				expr: """
					sum by (cluster, verb, scope) (cluster_verb_scope_le:apiserver_request_sli_duration_seconds_bucket:increase1h{le="+Inf"})

					"""
				record: "cluster_verb_scope:apiserver_request_sli_duration_seconds_count:increase1h"
			}, {
				expr: """
					sum by (cluster, verb, scope) (cluster_verb_scope_le:apiserver_request_sli_duration_seconds_bucket:increase30d{le="+Inf"} * 24 * 30)

					"""
				record: "cluster_verb_scope:apiserver_request_sli_duration_seconds_count:increase30d"
			}, {
				expr: """
					1 - (
					  (
					    # write too slow
					    sum by (cluster) (cluster_verb_scope:apiserver_request_sli_duration_seconds_count:increase30d{verb=~"POST|PUT|PATCH|DELETE"})
					    -
					    sum by (cluster) (cluster_verb_scope_le:apiserver_request_sli_duration_seconds_bucket:increase30d{verb=~"POST|PUT|PATCH|DELETE",le="1"})
					  ) +
					  (
					    # read too slow
					    sum by (cluster) (cluster_verb_scope:apiserver_request_sli_duration_seconds_count:increase30d{verb=~"LIST|GET"})
					    -
					    (
					      (
					        sum by (cluster) (cluster_verb_scope_le:apiserver_request_sli_duration_seconds_bucket:increase30d{verb=~"LIST|GET",scope=~"resource|",le="1"})
					        or
					        vector(0)
					      )
					      +
					      sum by (cluster) (cluster_verb_scope_le:apiserver_request_sli_duration_seconds_bucket:increase30d{verb=~"LIST|GET",scope="namespace",le="5"})
					      +
					      sum by (cluster) (cluster_verb_scope_le:apiserver_request_sli_duration_seconds_bucket:increase30d{verb=~"LIST|GET",scope="cluster",le="30"})
					    )
					  ) +
					  # errors
					  sum by (cluster) (code:apiserver_request_total:increase30d{code=~"5.."} or vector(0))
					)
					/
					sum by (cluster) (code:apiserver_request_total:increase30d)

					"""
				labels: verb: "all"
				record: "apiserver_request:availability30d"
			}, {
				expr: """
					1 - (
					  sum by (cluster) (cluster_verb_scope:apiserver_request_sli_duration_seconds_count:increase30d{verb=~"LIST|GET"})
					  -
					  (
					    # too slow
					    (
					      sum by (cluster) (cluster_verb_scope_le:apiserver_request_sli_duration_seconds_bucket:increase30d{verb=~"LIST|GET",scope=~"resource|",le="1"})
					      or
					      vector(0)
					    )
					    +
					    sum by (cluster) (cluster_verb_scope_le:apiserver_request_sli_duration_seconds_bucket:increase30d{verb=~"LIST|GET",scope="namespace",le="5"})
					    +
					    sum by (cluster) (cluster_verb_scope_le:apiserver_request_sli_duration_seconds_bucket:increase30d{verb=~"LIST|GET",scope="cluster",le="30"})
					  )
					  +
					  # errors
					  sum by (cluster) (code:apiserver_request_total:increase30d{verb="read",code=~"5.."} or vector(0))
					)
					/
					sum by (cluster) (code:apiserver_request_total:increase30d{verb="read"})

					"""
				labels: verb: "read"
				record: "apiserver_request:availability30d"
			}, {
				expr: """
					1 - (
					  (
					    # too slow
					    sum by (cluster) (cluster_verb_scope:apiserver_request_sli_duration_seconds_count:increase30d{verb=~"POST|PUT|PATCH|DELETE"})
					    -
					    sum by (cluster) (cluster_verb_scope_le:apiserver_request_sli_duration_seconds_bucket:increase30d{verb=~"POST|PUT|PATCH|DELETE",le="1"})
					  )
					  +
					  # errors
					  sum by (cluster) (code:apiserver_request_total:increase30d{verb="write",code=~"5.."} or vector(0))
					)
					/
					sum by (cluster) (code:apiserver_request_total:increase30d{verb="write"})

					"""
				labels: verb: "write"
				record: "apiserver_request:availability30d"
			}, {
				expr: """
					sum by (cluster,code,resource) (rate(apiserver_request_total{job="apiserver",verb=~"LIST|GET"}[5m]))

					"""
				labels: verb: "read"
				record: "code_resource:apiserver_request_total:rate5m"
			}, {
				expr: """
					sum by (cluster,code,resource) (rate(apiserver_request_total{job="apiserver",verb=~"POST|PUT|PATCH|DELETE"}[5m]))

					"""
				labels: verb: "write"
				record: "code_resource:apiserver_request_total:rate5m"
			}, {
				expr: """
					sum by (cluster, code, verb) (increase(apiserver_request_total{job="apiserver",verb=~"LIST|GET|POST|PUT|PATCH|DELETE",code=~"2.."}[1h]))

					"""
				record: "code_verb:apiserver_request_total:increase1h"
			}, {
				expr: """
					sum by (cluster, code, verb) (increase(apiserver_request_total{job="apiserver",verb=~"LIST|GET|POST|PUT|PATCH|DELETE",code=~"3.."}[1h]))

					"""
				record: "code_verb:apiserver_request_total:increase1h"
			}, {
				expr: """
					sum by (cluster, code, verb) (increase(apiserver_request_total{job="apiserver",verb=~"LIST|GET|POST|PUT|PATCH|DELETE",code=~"4.."}[1h]))

					"""
				record: "code_verb:apiserver_request_total:increase1h"
			}, {
				expr: """
					sum by (cluster, code, verb) (increase(apiserver_request_total{job="apiserver",verb=~"LIST|GET|POST|PUT|PATCH|DELETE",code=~"5.."}[1h]))

					"""
				record: "code_verb:apiserver_request_total:increase1h"
			}]
		}, {
			name: "kube-apiserver-burnrate.rules"
			rules: [{
				expr: """
					(
					  (
					    # too slow
					    sum by (cluster) (rate(apiserver_request_sli_duration_seconds_count{job="apiserver",verb=~"LIST|GET",subresource!~"proxy|attach|log|exec|portforward"}[1d]))
					    -
					    (
					      (
					        sum by (cluster) (rate(apiserver_request_sli_duration_seconds_bucket{job="apiserver",verb=~"LIST|GET",subresource!~"proxy|attach|log|exec|portforward",scope=~"resource|",le="1"}[1d]))
					        or
					        vector(0)
					      )
					      +
					      sum by (cluster) (rate(apiserver_request_sli_duration_seconds_bucket{job="apiserver",verb=~"LIST|GET",subresource!~"proxy|attach|log|exec|portforward",scope="namespace",le="5"}[1d]))
					      +
					      sum by (cluster) (rate(apiserver_request_sli_duration_seconds_bucket{job="apiserver",verb=~"LIST|GET",subresource!~"proxy|attach|log|exec|portforward",scope="cluster",le="30"}[1d]))
					    )
					  )
					  +
					  # errors
					  sum by (cluster) (rate(apiserver_request_total{job="apiserver",verb=~"LIST|GET",code=~"5.."}[1d]))
					)
					/
					sum by (cluster) (rate(apiserver_request_total{job="apiserver",verb=~"LIST|GET"}[1d]))

					"""
				labels: verb: "read"
				record: "apiserver_request:burnrate1d"
			}, {
				expr: """
					(
					  (
					    # too slow
					    sum by (cluster) (rate(apiserver_request_sli_duration_seconds_count{job="apiserver",verb=~"LIST|GET",subresource!~"proxy|attach|log|exec|portforward"}[1h]))
					    -
					    (
					      (
					        sum by (cluster) (rate(apiserver_request_sli_duration_seconds_bucket{job="apiserver",verb=~"LIST|GET",subresource!~"proxy|attach|log|exec|portforward",scope=~"resource|",le="1"}[1h]))
					        or
					        vector(0)
					      )
					      +
					      sum by (cluster) (rate(apiserver_request_sli_duration_seconds_bucket{job="apiserver",verb=~"LIST|GET",subresource!~"proxy|attach|log|exec|portforward",scope="namespace",le="5"}[1h]))
					      +
					      sum by (cluster) (rate(apiserver_request_sli_duration_seconds_bucket{job="apiserver",verb=~"LIST|GET",subresource!~"proxy|attach|log|exec|portforward",scope="cluster",le="30"}[1h]))
					    )
					  )
					  +
					  # errors
					  sum by (cluster) (rate(apiserver_request_total{job="apiserver",verb=~"LIST|GET",code=~"5.."}[1h]))
					)
					/
					sum by (cluster) (rate(apiserver_request_total{job="apiserver",verb=~"LIST|GET"}[1h]))

					"""
				labels: verb: "read"
				record: "apiserver_request:burnrate1h"
			}, {
				expr: """
					(
					  (
					    # too slow
					    sum by (cluster) (rate(apiserver_request_sli_duration_seconds_count{job="apiserver",verb=~"LIST|GET",subresource!~"proxy|attach|log|exec|portforward"}[2h]))
					    -
					    (
					      (
					        sum by (cluster) (rate(apiserver_request_sli_duration_seconds_bucket{job="apiserver",verb=~"LIST|GET",subresource!~"proxy|attach|log|exec|portforward",scope=~"resource|",le="1"}[2h]))
					        or
					        vector(0)
					      )
					      +
					      sum by (cluster) (rate(apiserver_request_sli_duration_seconds_bucket{job="apiserver",verb=~"LIST|GET",subresource!~"proxy|attach|log|exec|portforward",scope="namespace",le="5"}[2h]))
					      +
					      sum by (cluster) (rate(apiserver_request_sli_duration_seconds_bucket{job="apiserver",verb=~"LIST|GET",subresource!~"proxy|attach|log|exec|portforward",scope="cluster",le="30"}[2h]))
					    )
					  )
					  +
					  # errors
					  sum by (cluster) (rate(apiserver_request_total{job="apiserver",verb=~"LIST|GET",code=~"5.."}[2h]))
					)
					/
					sum by (cluster) (rate(apiserver_request_total{job="apiserver",verb=~"LIST|GET"}[2h]))

					"""
				labels: verb: "read"
				record: "apiserver_request:burnrate2h"
			}, {
				expr: """
					(
					  (
					    # too slow
					    sum by (cluster) (rate(apiserver_request_sli_duration_seconds_count{job="apiserver",verb=~"LIST|GET",subresource!~"proxy|attach|log|exec|portforward"}[30m]))
					    -
					    (
					      (
					        sum by (cluster) (rate(apiserver_request_sli_duration_seconds_bucket{job="apiserver",verb=~"LIST|GET",subresource!~"proxy|attach|log|exec|portforward",scope=~"resource|",le="1"}[30m]))
					        or
					        vector(0)
					      )
					      +
					      sum by (cluster) (rate(apiserver_request_sli_duration_seconds_bucket{job="apiserver",verb=~"LIST|GET",subresource!~"proxy|attach|log|exec|portforward",scope="namespace",le="5"}[30m]))
					      +
					      sum by (cluster) (rate(apiserver_request_sli_duration_seconds_bucket{job="apiserver",verb=~"LIST|GET",subresource!~"proxy|attach|log|exec|portforward",scope="cluster",le="30"}[30m]))
					    )
					  )
					  +
					  # errors
					  sum by (cluster) (rate(apiserver_request_total{job="apiserver",verb=~"LIST|GET",code=~"5.."}[30m]))
					)
					/
					sum by (cluster) (rate(apiserver_request_total{job="apiserver",verb=~"LIST|GET"}[30m]))

					"""
				labels: verb: "read"
				record: "apiserver_request:burnrate30m"
			}, {
				expr: """
					(
					  (
					    # too slow
					    sum by (cluster) (rate(apiserver_request_sli_duration_seconds_count{job="apiserver",verb=~"LIST|GET",subresource!~"proxy|attach|log|exec|portforward"}[3d]))
					    -
					    (
					      (
					        sum by (cluster) (rate(apiserver_request_sli_duration_seconds_bucket{job="apiserver",verb=~"LIST|GET",subresource!~"proxy|attach|log|exec|portforward",scope=~"resource|",le="1"}[3d]))
					        or
					        vector(0)
					      )
					      +
					      sum by (cluster) (rate(apiserver_request_sli_duration_seconds_bucket{job="apiserver",verb=~"LIST|GET",subresource!~"proxy|attach|log|exec|portforward",scope="namespace",le="5"}[3d]))
					      +
					      sum by (cluster) (rate(apiserver_request_sli_duration_seconds_bucket{job="apiserver",verb=~"LIST|GET",subresource!~"proxy|attach|log|exec|portforward",scope="cluster",le="30"}[3d]))
					    )
					  )
					  +
					  # errors
					  sum by (cluster) (rate(apiserver_request_total{job="apiserver",verb=~"LIST|GET",code=~"5.."}[3d]))
					)
					/
					sum by (cluster) (rate(apiserver_request_total{job="apiserver",verb=~"LIST|GET"}[3d]))

					"""
				labels: verb: "read"
				record: "apiserver_request:burnrate3d"
			}, {
				expr: """
					(
					  (
					    # too slow
					    sum by (cluster) (rate(apiserver_request_sli_duration_seconds_count{job="apiserver",verb=~"LIST|GET",subresource!~"proxy|attach|log|exec|portforward"}[5m]))
					    -
					    (
					      (
					        sum by (cluster) (rate(apiserver_request_sli_duration_seconds_bucket{job="apiserver",verb=~"LIST|GET",subresource!~"proxy|attach|log|exec|portforward",scope=~"resource|",le="1"}[5m]))
					        or
					        vector(0)
					      )
					      +
					      sum by (cluster) (rate(apiserver_request_sli_duration_seconds_bucket{job="apiserver",verb=~"LIST|GET",subresource!~"proxy|attach|log|exec|portforward",scope="namespace",le="5"}[5m]))
					      +
					      sum by (cluster) (rate(apiserver_request_sli_duration_seconds_bucket{job="apiserver",verb=~"LIST|GET",subresource!~"proxy|attach|log|exec|portforward",scope="cluster",le="30"}[5m]))
					    )
					  )
					  +
					  # errors
					  sum by (cluster) (rate(apiserver_request_total{job="apiserver",verb=~"LIST|GET",code=~"5.."}[5m]))
					)
					/
					sum by (cluster) (rate(apiserver_request_total{job="apiserver",verb=~"LIST|GET"}[5m]))

					"""
				labels: verb: "read"
				record: "apiserver_request:burnrate5m"
			}, {
				expr: """
					(
					  (
					    # too slow
					    sum by (cluster) (rate(apiserver_request_sli_duration_seconds_count{job="apiserver",verb=~"LIST|GET",subresource!~"proxy|attach|log|exec|portforward"}[6h]))
					    -
					    (
					      (
					        sum by (cluster) (rate(apiserver_request_sli_duration_seconds_bucket{job="apiserver",verb=~"LIST|GET",subresource!~"proxy|attach|log|exec|portforward",scope=~"resource|",le="1"}[6h]))
					        or
					        vector(0)
					      )
					      +
					      sum by (cluster) (rate(apiserver_request_sli_duration_seconds_bucket{job="apiserver",verb=~"LIST|GET",subresource!~"proxy|attach|log|exec|portforward",scope="namespace",le="5"}[6h]))
					      +
					      sum by (cluster) (rate(apiserver_request_sli_duration_seconds_bucket{job="apiserver",verb=~"LIST|GET",subresource!~"proxy|attach|log|exec|portforward",scope="cluster",le="30"}[6h]))
					    )
					  )
					  +
					  # errors
					  sum by (cluster) (rate(apiserver_request_total{job="apiserver",verb=~"LIST|GET",code=~"5.."}[6h]))
					)
					/
					sum by (cluster) (rate(apiserver_request_total{job="apiserver",verb=~"LIST|GET"}[6h]))

					"""
				labels: verb: "read"
				record: "apiserver_request:burnrate6h"
			}, {
				expr: """
					(
					  (
					    # too slow
					    sum by (cluster) (rate(apiserver_request_sli_duration_seconds_count{job="apiserver",verb=~"POST|PUT|PATCH|DELETE",subresource!~"proxy|attach|log|exec|portforward"}[1d]))
					    -
					    sum by (cluster) (rate(apiserver_request_sli_duration_seconds_bucket{job="apiserver",verb=~"POST|PUT|PATCH|DELETE",subresource!~"proxy|attach|log|exec|portforward",le="1"}[1d]))
					  )
					  +
					  sum by (cluster) (rate(apiserver_request_total{job="apiserver",verb=~"POST|PUT|PATCH|DELETE",code=~"5.."}[1d]))
					)
					/
					sum by (cluster) (rate(apiserver_request_total{job="apiserver",verb=~"POST|PUT|PATCH|DELETE"}[1d]))

					"""
				labels: verb: "write"
				record: "apiserver_request:burnrate1d"
			}, {
				expr: """
					(
					  (
					    # too slow
					    sum by (cluster) (rate(apiserver_request_sli_duration_seconds_count{job="apiserver",verb=~"POST|PUT|PATCH|DELETE",subresource!~"proxy|attach|log|exec|portforward"}[1h]))
					    -
					    sum by (cluster) (rate(apiserver_request_sli_duration_seconds_bucket{job="apiserver",verb=~"POST|PUT|PATCH|DELETE",subresource!~"proxy|attach|log|exec|portforward",le="1"}[1h]))
					  )
					  +
					  sum by (cluster) (rate(apiserver_request_total{job="apiserver",verb=~"POST|PUT|PATCH|DELETE",code=~"5.."}[1h]))
					)
					/
					sum by (cluster) (rate(apiserver_request_total{job="apiserver",verb=~"POST|PUT|PATCH|DELETE"}[1h]))

					"""
				labels: verb: "write"
				record: "apiserver_request:burnrate1h"
			}, {
				expr: """
					(
					  (
					    # too slow
					    sum by (cluster) (rate(apiserver_request_sli_duration_seconds_count{job="apiserver",verb=~"POST|PUT|PATCH|DELETE",subresource!~"proxy|attach|log|exec|portforward"}[2h]))
					    -
					    sum by (cluster) (rate(apiserver_request_sli_duration_seconds_bucket{job="apiserver",verb=~"POST|PUT|PATCH|DELETE",subresource!~"proxy|attach|log|exec|portforward",le="1"}[2h]))
					  )
					  +
					  sum by (cluster) (rate(apiserver_request_total{job="apiserver",verb=~"POST|PUT|PATCH|DELETE",code=~"5.."}[2h]))
					)
					/
					sum by (cluster) (rate(apiserver_request_total{job="apiserver",verb=~"POST|PUT|PATCH|DELETE"}[2h]))

					"""
				labels: verb: "write"
				record: "apiserver_request:burnrate2h"
			}, {
				expr: """
					(
					  (
					    # too slow
					    sum by (cluster) (rate(apiserver_request_sli_duration_seconds_count{job="apiserver",verb=~"POST|PUT|PATCH|DELETE",subresource!~"proxy|attach|log|exec|portforward"}[30m]))
					    -
					    sum by (cluster) (rate(apiserver_request_sli_duration_seconds_bucket{job="apiserver",verb=~"POST|PUT|PATCH|DELETE",subresource!~"proxy|attach|log|exec|portforward",le="1"}[30m]))
					  )
					  +
					  sum by (cluster) (rate(apiserver_request_total{job="apiserver",verb=~"POST|PUT|PATCH|DELETE",code=~"5.."}[30m]))
					)
					/
					sum by (cluster) (rate(apiserver_request_total{job="apiserver",verb=~"POST|PUT|PATCH|DELETE"}[30m]))

					"""
				labels: verb: "write"
				record: "apiserver_request:burnrate30m"
			}, {
				expr: """
					(
					  (
					    # too slow
					    sum by (cluster) (rate(apiserver_request_sli_duration_seconds_count{job="apiserver",verb=~"POST|PUT|PATCH|DELETE",subresource!~"proxy|attach|log|exec|portforward"}[3d]))
					    -
					    sum by (cluster) (rate(apiserver_request_sli_duration_seconds_bucket{job="apiserver",verb=~"POST|PUT|PATCH|DELETE",subresource!~"proxy|attach|log|exec|portforward",le="1"}[3d]))
					  )
					  +
					  sum by (cluster) (rate(apiserver_request_total{job="apiserver",verb=~"POST|PUT|PATCH|DELETE",code=~"5.."}[3d]))
					)
					/
					sum by (cluster) (rate(apiserver_request_total{job="apiserver",verb=~"POST|PUT|PATCH|DELETE"}[3d]))

					"""
				labels: verb: "write"
				record: "apiserver_request:burnrate3d"
			}, {
				expr: """
					(
					  (
					    # too slow
					    sum by (cluster) (rate(apiserver_request_sli_duration_seconds_count{job="apiserver",verb=~"POST|PUT|PATCH|DELETE",subresource!~"proxy|attach|log|exec|portforward"}[5m]))
					    -
					    sum by (cluster) (rate(apiserver_request_sli_duration_seconds_bucket{job="apiserver",verb=~"POST|PUT|PATCH|DELETE",subresource!~"proxy|attach|log|exec|portforward",le="1"}[5m]))
					  )
					  +
					  sum by (cluster) (rate(apiserver_request_total{job="apiserver",verb=~"POST|PUT|PATCH|DELETE",code=~"5.."}[5m]))
					)
					/
					sum by (cluster) (rate(apiserver_request_total{job="apiserver",verb=~"POST|PUT|PATCH|DELETE"}[5m]))

					"""
				labels: verb: "write"
				record: "apiserver_request:burnrate5m"
			}, {
				expr: """
					(
					  (
					    # too slow
					    sum by (cluster) (rate(apiserver_request_sli_duration_seconds_count{job="apiserver",verb=~"POST|PUT|PATCH|DELETE",subresource!~"proxy|attach|log|exec|portforward"}[6h]))
					    -
					    sum by (cluster) (rate(apiserver_request_sli_duration_seconds_bucket{job="apiserver",verb=~"POST|PUT|PATCH|DELETE",subresource!~"proxy|attach|log|exec|portforward",le="1"}[6h]))
					  )
					  +
					  sum by (cluster) (rate(apiserver_request_total{job="apiserver",verb=~"POST|PUT|PATCH|DELETE",code=~"5.."}[6h]))
					)
					/
					sum by (cluster) (rate(apiserver_request_total{job="apiserver",verb=~"POST|PUT|PATCH|DELETE"}[6h]))

					"""
				labels: verb: "write"
				record: "apiserver_request:burnrate6h"
			}]
		}, {
			name: "kube-apiserver-histogram.rules"
			rules: [{
				expr: """
					histogram_quantile(0.99, sum by (cluster, le, resource) (rate(apiserver_request_sli_duration_seconds_bucket{job="apiserver",verb=~"LIST|GET",subresource!~"proxy|attach|log|exec|portforward"}[5m]))) > 0

					"""
				labels: {
					quantile: "0.99"
					verb:     "read"
				}
				record: "cluster_quantile:apiserver_request_sli_duration_seconds:histogram_quantile"
			}, {
				expr: """
					histogram_quantile(0.99, sum by (cluster, le, resource) (rate(apiserver_request_sli_duration_seconds_bucket{job="apiserver",verb=~"POST|PUT|PATCH|DELETE",subresource!~"proxy|attach|log|exec|portforward"}[5m]))) > 0

					"""
				labels: {
					quantile: "0.99"
					verb:     "write"
				}
				record: "cluster_quantile:apiserver_request_sli_duration_seconds:histogram_quantile"
			}]
		}, {
			name: "k8s.rules.container_cpu_usage_seconds_total"
			rules: [{
				expr: """
					sum by (cluster, namespace, pod, container) (
					  irate(container_cpu_usage_seconds_total{job="kubelet", metrics_path="/metrics/cadvisor", image!=""}[5m])
					) * on (cluster, namespace, pod) group_left(node) topk by (cluster, namespace, pod) (
					  1, max by(cluster, namespace, pod, node) (kube_pod_info{node!=""})
					)

					"""
				record: "node_namespace_pod_container:container_cpu_usage_seconds_total:sum_irate"
			}]
		}, {
			name: "k8s.rules.container_memory_working_set_bytes"
			rules: [{
				expr: """
					container_memory_working_set_bytes{job="kubelet", metrics_path="/metrics/cadvisor", image!=""}
					* on (cluster, namespace, pod) group_left(node) topk by(cluster, namespace, pod) (1,
					  max by(cluster, namespace, pod, node) (kube_pod_info{node!=""})
					)

					"""
				record: "node_namespace_pod_container:container_memory_working_set_bytes"
			}]
		}, {
			name: "k8s.rules.container_memory_rss"
			rules: [{
				expr: """
					container_memory_rss{job="kubelet", metrics_path="/metrics/cadvisor", image!=""}
					* on (cluster, namespace, pod) group_left(node) topk by(cluster, namespace, pod) (1,
					  max by(cluster, namespace, pod, node) (kube_pod_info{node!=""})
					)

					"""
				record: "node_namespace_pod_container:container_memory_rss"
			}]
		}, {
			name: "k8s.rules.container_memory_cache"
			rules: [{
				expr: """
					container_memory_cache{job="kubelet", metrics_path="/metrics/cadvisor", image!=""}
					* on (cluster, namespace, pod) group_left(node) topk by(cluster, namespace, pod) (1,
					  max by(cluster, namespace, pod, node) (kube_pod_info{node!=""})
					)

					"""
				record: "node_namespace_pod_container:container_memory_cache"
			}]
		}, {
			name: "k8s.rules.container_memory_swap"
			rules: [{
				expr: """
					container_memory_swap{job="kubelet", metrics_path="/metrics/cadvisor", image!=""}
					* on (cluster, namespace, pod) group_left(node) topk by(cluster, namespace, pod) (1,
					  max by(cluster, namespace, pod, node) (kube_pod_info{node!=""})
					)

					"""
				record: "node_namespace_pod_container:container_memory_swap"
			}]
		}, {
			name: "k8s.rules.container_memory_requests"
			rules: [{
				expr: """
					kube_pod_container_resource_requests{resource="memory",job="kube-state-metrics"}  * on (namespace, pod, cluster)
					group_left() max by (namespace, pod, cluster) (
					  (kube_pod_status_phase{phase=~"Pending|Running"} == 1)
					)

					"""
				record: "cluster:namespace:pod_memory:active:kube_pod_container_resource_requests"
			}, {
				expr: """
					sum by (namespace, cluster) (
					    sum by (namespace, pod, cluster) (
					        max by (namespace, pod, container, cluster) (
					          kube_pod_container_resource_requests{resource="memory",job="kube-state-metrics"}
					        ) * on(namespace, pod, cluster) group_left() max by (namespace, pod, cluster) (
					          kube_pod_status_phase{phase=~"Pending|Running"} == 1
					        )
					    )
					)

					"""
				record: "namespace_memory:kube_pod_container_resource_requests:sum"
			}]
		}, {
			name: "k8s.rules.container_cpu_requests"
			rules: [{
				expr: """
					kube_pod_container_resource_requests{resource="cpu",job="kube-state-metrics"}  * on (namespace, pod, cluster)
					group_left() max by (namespace, pod, cluster) (
					  (kube_pod_status_phase{phase=~"Pending|Running"} == 1)
					)

					"""
				record: "cluster:namespace:pod_cpu:active:kube_pod_container_resource_requests"
			}, {
				expr: """
					sum by (namespace, cluster) (
					    sum by (namespace, pod, cluster) (
					        max by (namespace, pod, container, cluster) (
					          kube_pod_container_resource_requests{resource="cpu",job="kube-state-metrics"}
					        ) * on(namespace, pod, cluster) group_left() max by (namespace, pod, cluster) (
					          kube_pod_status_phase{phase=~"Pending|Running"} == 1
					        )
					    )
					)

					"""
				record: "namespace_cpu:kube_pod_container_resource_requests:sum"
			}]
		}, {
			name: "k8s.rules.container_memory_limits"
			rules: [{
				expr: """
					kube_pod_container_resource_limits{resource="memory",job="kube-state-metrics"}  * on (namespace, pod, cluster)
					group_left() max by (namespace, pod, cluster) (
					  (kube_pod_status_phase{phase=~"Pending|Running"} == 1)
					)

					"""
				record: "cluster:namespace:pod_memory:active:kube_pod_container_resource_limits"
			}, {
				expr: """
					sum by (namespace, cluster) (
					    sum by (namespace, pod, cluster) (
					        max by (namespace, pod, container, cluster) (
					          kube_pod_container_resource_limits{resource="memory",job="kube-state-metrics"}
					        ) * on(namespace, pod, cluster) group_left() max by (namespace, pod, cluster) (
					          kube_pod_status_phase{phase=~"Pending|Running"} == 1
					        )
					    )
					)

					"""
				record: "namespace_memory:kube_pod_container_resource_limits:sum"
			}]
		}, {
			name: "k8s.rules.container_cpu_limits"
			rules: [{
				expr: """
					kube_pod_container_resource_limits{resource="cpu",job="kube-state-metrics"}  * on (namespace, pod, cluster)
					group_left() max by (namespace, pod, cluster) (
					 (kube_pod_status_phase{phase=~"Pending|Running"} == 1)
					 )

					"""
				record: "cluster:namespace:pod_cpu:active:kube_pod_container_resource_limits"
			}, {
				expr: """
					sum by (namespace, cluster) (
					    sum by (namespace, pod, cluster) (
					        max by (namespace, pod, container, cluster) (
					          kube_pod_container_resource_limits{resource="cpu",job="kube-state-metrics"}
					        ) * on(namespace, pod, cluster) group_left() max by (namespace, pod, cluster) (
					          kube_pod_status_phase{phase=~"Pending|Running"} == 1
					        )
					    )
					)

					"""
				record: "namespace_cpu:kube_pod_container_resource_limits:sum"
			}]
		}, {
			name: "k8s.rules.pod_owner"
			rules: [{
				expr: """
					max by (cluster, namespace, workload, pod) (
					  label_replace(
					    label_replace(
					      kube_pod_owner{job="kube-state-metrics", owner_kind="ReplicaSet"},
					      "replicaset", "$1", "owner_name", "(.*)"
					    ) * on(replicaset, namespace) group_left(owner_name) topk by(replicaset, namespace) (
					      1, max by (replicaset, namespace, owner_name) (
					        kube_replicaset_owner{job="kube-state-metrics"}
					      )
					    ),
					    "workload", "$1", "owner_name", "(.*)"
					  )
					)

					"""
				labels: workload_type: "deployment"
				record: "namespace_workload_pod:kube_pod_owner:relabel"
			}, {
				expr: """
					max by (cluster, namespace, workload, pod) (
					  label_replace(
					    kube_pod_owner{job="kube-state-metrics", owner_kind="DaemonSet"},
					    "workload", "$1", "owner_name", "(.*)"
					  )
					)

					"""
				labels: workload_type: "daemonset"
				record: "namespace_workload_pod:kube_pod_owner:relabel"
			}, {
				expr: """
					max by (cluster, namespace, workload, pod) (
					  label_replace(
					    kube_pod_owner{job="kube-state-metrics", owner_kind="StatefulSet"},
					    "workload", "$1", "owner_name", "(.*)"
					  )
					)

					"""
				labels: workload_type: "statefulset"
				record: "namespace_workload_pod:kube_pod_owner:relabel"
			}, {
				expr: """
					max by (cluster, namespace, workload, pod) (
					  label_replace(
					    kube_pod_owner{job="kube-state-metrics", owner_kind="Job"},
					    "workload", "$1", "owner_name", "(.*)"
					  )
					)

					"""
				labels: workload_type: "job"
				record: "namespace_workload_pod:kube_pod_owner:relabel"
			}]
		}, {
			name: "kube-scheduler.rules"
			rules: [{
				expr: """
					histogram_quantile(0.99, sum(rate(scheduler_e2e_scheduling_duration_seconds_bucket{job="kube-scheduler"}[5m])) without(instance, pod))

					"""
				labels: quantile: "0.99"
				record: "cluster_quantile:scheduler_e2e_scheduling_duration_seconds:histogram_quantile"
			}, {
				expr: """
					histogram_quantile(0.99, sum(rate(scheduler_scheduling_algorithm_duration_seconds_bucket{job="kube-scheduler"}[5m])) without(instance, pod))

					"""
				labels: quantile: "0.99"
				record: "cluster_quantile:scheduler_scheduling_algorithm_duration_seconds:histogram_quantile"
			}, {
				expr: """
					histogram_quantile(0.99, sum(rate(scheduler_binding_duration_seconds_bucket{job="kube-scheduler"}[5m])) without(instance, pod))

					"""
				labels: quantile: "0.99"
				record: "cluster_quantile:scheduler_binding_duration_seconds:histogram_quantile"
			}, {
				expr: """
					histogram_quantile(0.9, sum(rate(scheduler_e2e_scheduling_duration_seconds_bucket{job="kube-scheduler"}[5m])) without(instance, pod))

					"""
				labels: quantile: "0.9"
				record: "cluster_quantile:scheduler_e2e_scheduling_duration_seconds:histogram_quantile"
			}, {
				expr: """
					histogram_quantile(0.9, sum(rate(scheduler_scheduling_algorithm_duration_seconds_bucket{job="kube-scheduler"}[5m])) without(instance, pod))

					"""
				labels: quantile: "0.9"
				record: "cluster_quantile:scheduler_scheduling_algorithm_duration_seconds:histogram_quantile"
			}, {
				expr: """
					histogram_quantile(0.9, sum(rate(scheduler_binding_duration_seconds_bucket{job="kube-scheduler"}[5m])) without(instance, pod))

					"""
				labels: quantile: "0.9"
				record: "cluster_quantile:scheduler_binding_duration_seconds:histogram_quantile"
			}, {
				expr: """
					histogram_quantile(0.5, sum(rate(scheduler_e2e_scheduling_duration_seconds_bucket{job="kube-scheduler"}[5m])) without(instance, pod))

					"""
				labels: quantile: "0.5"
				record: "cluster_quantile:scheduler_e2e_scheduling_duration_seconds:histogram_quantile"
			}, {
				expr: """
					histogram_quantile(0.5, sum(rate(scheduler_scheduling_algorithm_duration_seconds_bucket{job="kube-scheduler"}[5m])) without(instance, pod))

					"""
				labels: quantile: "0.5"
				record: "cluster_quantile:scheduler_scheduling_algorithm_duration_seconds:histogram_quantile"
			}, {
				expr: """
					histogram_quantile(0.5, sum(rate(scheduler_binding_duration_seconds_bucket{job="kube-scheduler"}[5m])) without(instance, pod))

					"""
				labels: quantile: "0.5"
				record: "cluster_quantile:scheduler_binding_duration_seconds:histogram_quantile"
			}]
		}, {
			name: "node.rules"
			rules: [{
				expr: """
					topk by(cluster, namespace, pod) (1,
					  max by (cluster, node, namespace, pod) (
					    label_replace(kube_pod_info{job="kube-state-metrics",node!=""}, "pod", "$1", "pod", "(.*)")
					))

					"""
				record: "node_namespace_pod:kube_pod_info:"
			}, {
				expr: """
					count by (cluster, node) (
					  node_cpu_seconds_total{mode="idle",job="node-exporter"}
					  * on (cluster, namespace, pod) group_left(node)
					  topk by(cluster, namespace, pod) (1, node_namespace_pod:kube_pod_info:)
					)

					"""
				record: "node:node_num_cpu:sum"
			}, {
				expr: """
					sum(
					  node_memory_MemAvailable_bytes{job="node-exporter"} or
					  (
					    node_memory_Buffers_bytes{job="node-exporter"} +
					    node_memory_Cached_bytes{job="node-exporter"} +
					    node_memory_MemFree_bytes{job="node-exporter"} +
					    node_memory_Slab_bytes{job="node-exporter"}
					  )
					) by (cluster)

					"""
				record: ":node_memory_MemAvailable_bytes:sum"
			}, {
				expr: """
					avg by (cluster, node) (
					  sum without (mode) (
					    rate(node_cpu_seconds_total{mode!="idle",mode!="iowait",mode!="steal",job="node-exporter"}[5m])
					  )
					)

					"""
				record: "node:node_cpu_utilization:ratio_rate5m"
			}, {
				expr: """
					avg by (cluster) (
					  node:node_cpu_utilization:ratio_rate5m
					)

					"""
				record: "cluster:node_cpu:ratio_rate5m"
			}]
		}, {
			name: "kubelet.rules"
			rules: [{
				expr: """
					histogram_quantile(0.99, sum(rate(kubelet_pleg_relist_duration_seconds_bucket{job="kubelet", metrics_path="/metrics"}[5m])) by (cluster, instance, le) * on(cluster, instance) group_left(node) kubelet_node_name{job="kubelet", metrics_path="/metrics"})

					"""
				labels: quantile: "0.99"
				record: "node_quantile:kubelet_pleg_relist_duration_seconds:histogram_quantile"
			}, {
				expr: """
					histogram_quantile(0.9, sum(rate(kubelet_pleg_relist_duration_seconds_bucket{job="kubelet", metrics_path="/metrics"}[5m])) by (cluster, instance, le) * on(cluster, instance) group_left(node) kubelet_node_name{job="kubelet", metrics_path="/metrics"})

					"""
				labels: quantile: "0.9"
				record: "node_quantile:kubelet_pleg_relist_duration_seconds:histogram_quantile"
			}, {
				expr: """
					histogram_quantile(0.5, sum(rate(kubelet_pleg_relist_duration_seconds_bucket{job="kubelet", metrics_path="/metrics"}[5m])) by (cluster, instance, le) * on(cluster, instance) group_left(node) kubelet_node_name{job="kubelet", metrics_path="/metrics"})

					"""
				labels: quantile: "0.5"
				record: "node_quantile:kubelet_pleg_relist_duration_seconds:histogram_quantile"
			}]
		}]
	}
	ServiceMonitor: {
		coredns: {
			apiVersion: "monitoring.coreos.com/v1"
			kind:       "ServiceMonitor"
			metadata: {
				labels: {
					"app.kubernetes.io/name":    "coredns"
					"app.kubernetes.io/part-of": "kube-prometheus"
				}
				name:      "coredns"
				namespace: "monitoring"
			}
			spec: {
				endpoints: [{
					bearerTokenFile: "/var/run/secrets/kubernetes.io/serviceaccount/token"
					interval:        "15s"
					metricRelabelings: [{
						action: "drop"
						regex:  "coredns_cache_misses_total"
						sourceLabels: ["__name__"]
					}]
					port: "metrics"
				}]
				jobLabel: "app.kubernetes.io/name"
				namespaceSelector: matchNames: ["kube-system"]
				selector: matchLabels: "k8s-app": "kube-dns"
			}
		}
		"kube-apiserver": {
			apiVersion: "monitoring.coreos.com/v1"
			kind:       "ServiceMonitor"
			metadata: {
				labels: {
					"app.kubernetes.io/name":    "apiserver"
					"app.kubernetes.io/part-of": "kube-prometheus"
				}
				name:      "kube-apiserver"
				namespace: "monitoring"
			}
			spec: {
				endpoints: [{
					bearerTokenFile: "/var/run/secrets/kubernetes.io/serviceaccount/token"
					interval:        "30s"
					metricRelabelings: [{
						action: "drop"
						regex:  "kubelet_(pod_worker_latency_microseconds|pod_start_latency_microseconds|cgroup_manager_latency_microseconds|pod_worker_start_latency_microseconds|pleg_relist_latency_microseconds|pleg_relist_interval_microseconds|runtime_operations|runtime_operations_latency_microseconds|runtime_operations_errors|eviction_stats_age_microseconds|device_plugin_registration_count|device_plugin_alloc_latency_microseconds|network_plugin_operations_latency_microseconds)"
						sourceLabels: ["__name__"]
					}, {
						action: "drop"
						regex:  "scheduler_(e2e_scheduling_latency_microseconds|scheduling_algorithm_predicate_evaluation|scheduling_algorithm_priority_evaluation|scheduling_algorithm_preemption_evaluation|scheduling_algorithm_latency_microseconds|binding_latency_microseconds|scheduling_latency_seconds)"
						sourceLabels: ["__name__"]
					}, {
						action: "drop"
						regex:  "apiserver_(request_count|request_latencies|request_latencies_summary|dropped_requests|storage_data_key_generation_latencies_microseconds|storage_transformation_failures_total|storage_transformation_latencies_microseconds|proxy_tunnel_sync_latency_secs|longrunning_gauge|registered_watchers|storage_db_total_size_in_bytes|flowcontrol_request_concurrency_limit|flowcontrol_request_concurrency_in_use)"
						sourceLabels: ["__name__"]
					}, {
						action: "drop"
						regex:  "kubelet_docker_(operations|operations_latency_microseconds|operations_errors|operations_timeout)"
						sourceLabels: ["__name__"]
					}, {
						action: "drop"
						regex:  "reflector_(items_per_list|items_per_watch|list_duration_seconds|lists_total|short_watches_total|watch_duration_seconds|watches_total)"
						sourceLabels: ["__name__"]
					}, {
						action: "drop"
						regex:  "etcd_(helper_cache_hit_count|helper_cache_miss_count|helper_cache_entry_count|object_counts|request_cache_get_latencies_summary|request_cache_add_latencies_summary|request_latencies_summary)"
						sourceLabels: ["__name__"]
					}, {
						action: "drop"
						regex:  "transformation_(transformation_latencies_microseconds|failures_total)"
						sourceLabels: ["__name__"]
					}, {
						action: "drop"
						regex:  "(admission_quota_controller_adds|admission_quota_controller_depth|admission_quota_controller_longest_running_processor_microseconds|admission_quota_controller_queue_latency|admission_quota_controller_unfinished_work_seconds|admission_quota_controller_work_duration|APIServiceOpenAPIAggregationControllerQueue1_adds|APIServiceOpenAPIAggregationControllerQueue1_depth|APIServiceOpenAPIAggregationControllerQueue1_longest_running_processor_microseconds|APIServiceOpenAPIAggregationControllerQueue1_queue_latency|APIServiceOpenAPIAggregationControllerQueue1_retries|APIServiceOpenAPIAggregationControllerQueue1_unfinished_work_seconds|APIServiceOpenAPIAggregationControllerQueue1_work_duration|APIServiceRegistrationController_adds|APIServiceRegistrationController_depth|APIServiceRegistrationController_longest_running_processor_microseconds|APIServiceRegistrationController_queue_latency|APIServiceRegistrationController_retries|APIServiceRegistrationController_unfinished_work_seconds|APIServiceRegistrationController_work_duration|autoregister_adds|autoregister_depth|autoregister_longest_running_processor_microseconds|autoregister_queue_latency|autoregister_retries|autoregister_unfinished_work_seconds|autoregister_work_duration|AvailableConditionController_adds|AvailableConditionController_depth|AvailableConditionController_longest_running_processor_microseconds|AvailableConditionController_queue_latency|AvailableConditionController_retries|AvailableConditionController_unfinished_work_seconds|AvailableConditionController_work_duration|crd_autoregistration_controller_adds|crd_autoregistration_controller_depth|crd_autoregistration_controller_longest_running_processor_microseconds|crd_autoregistration_controller_queue_latency|crd_autoregistration_controller_retries|crd_autoregistration_controller_unfinished_work_seconds|crd_autoregistration_controller_work_duration|crdEstablishing_adds|crdEstablishing_depth|crdEstablishing_longest_running_processor_microseconds|crdEstablishing_queue_latency|crdEstablishing_retries|crdEstablishing_unfinished_work_seconds|crdEstablishing_work_duration|crd_finalizer_adds|crd_finalizer_depth|crd_finalizer_longest_running_processor_microseconds|crd_finalizer_queue_latency|crd_finalizer_retries|crd_finalizer_unfinished_work_seconds|crd_finalizer_work_duration|crd_naming_condition_controller_adds|crd_naming_condition_controller_depth|crd_naming_condition_controller_longest_running_processor_microseconds|crd_naming_condition_controller_queue_latency|crd_naming_condition_controller_retries|crd_naming_condition_controller_unfinished_work_seconds|crd_naming_condition_controller_work_duration|crd_openapi_controller_adds|crd_openapi_controller_depth|crd_openapi_controller_longest_running_processor_microseconds|crd_openapi_controller_queue_latency|crd_openapi_controller_retries|crd_openapi_controller_unfinished_work_seconds|crd_openapi_controller_work_duration|DiscoveryController_adds|DiscoveryController_depth|DiscoveryController_longest_running_processor_microseconds|DiscoveryController_queue_latency|DiscoveryController_retries|DiscoveryController_unfinished_work_seconds|DiscoveryController_work_duration|kubeproxy_sync_proxy_rules_latency_microseconds|non_structural_schema_condition_controller_adds|non_structural_schema_condition_controller_depth|non_structural_schema_condition_controller_longest_running_processor_microseconds|non_structural_schema_condition_controller_queue_latency|non_structural_schema_condition_controller_retries|non_structural_schema_condition_controller_unfinished_work_seconds|non_structural_schema_condition_controller_work_duration|rest_client_request_latency_seconds|storage_operation_errors_total|storage_operation_status_count)"
						sourceLabels: ["__name__"]
					}, {
						action: "drop"
						regex:  "etcd_(debugging|disk|server).*"
						sourceLabels: ["__name__"]
					}, {
						action: "drop"
						regex:  "apiserver_admission_controller_admission_latencies_seconds_.*"
						sourceLabels: ["__name__"]
					}, {
						action: "drop"
						regex:  "apiserver_admission_step_admission_latencies_seconds_.*"
						sourceLabels: ["__name__"]
					}, {
						action: "drop"
						regex:  "(apiserver_request|apiserver_request_sli|etcd_request)_duration_seconds_bucket;(0.15|0.25|0.3|0.35|0.4|0.45|0.6|0.7|0.8|0.9|1.25|1.5|1.75|2.5|3|3.5|4.5|6|7|8|9|15|25|30|50)"
						sourceLabels: ["__name__", "le"]
					}, {
						action: "drop"
						regex:  "apiserver_request_body_size_bytes_bucket;(150000|350000|550000|650000|850000|950000|(1\\.15|1\\.35|1\\.55|1\\.65|1\\.85|1\\.95|2\\.15|2\\.35|2\\.55|2\\.65|2\\.85|2\\.95)e\\+06)"
						sourceLabels: ["__name__", "le"]
					}]
					port:   "https"
					scheme: "https"
					tlsConfig: {
						caFile:     "/var/run/secrets/kubernetes.io/serviceaccount/ca.crt"
						serverName: "kubernetes"
					}
				}, {
					bearerTokenFile: "/var/run/secrets/kubernetes.io/serviceaccount/token"
					interval:        "5s"
					metricRelabelings: [{
						action: "drop"
						regex:  "process_start_time_seconds"
						sourceLabels: ["__name__"]
					}]
					path:   "/metrics/slis"
					port:   "https"
					scheme: "https"
					tlsConfig: {
						caFile:     "/var/run/secrets/kubernetes.io/serviceaccount/ca.crt"
						serverName: "kubernetes"
					}
				}]
				jobLabel: "component"
				namespaceSelector: matchNames: ["default"]
				selector: matchLabels: {
					component: "apiserver"
					provider:  "kubernetes"
				}
			}
		}
		"kube-controller-manager": {
			apiVersion: "monitoring.coreos.com/v1"
			kind:       "ServiceMonitor"
			metadata: {
				labels: {
					"app.kubernetes.io/name":    "kube-controller-manager"
					"app.kubernetes.io/part-of": "kube-prometheus"
				}
				name:      "kube-controller-manager"
				namespace: "monitoring"
			}
			spec: {
				endpoints: [{
					bearerTokenFile: "/var/run/secrets/kubernetes.io/serviceaccount/token"
					interval:        "30s"
					metricRelabelings: [{
						action: "drop"
						regex:  "kubelet_(pod_worker_latency_microseconds|pod_start_latency_microseconds|cgroup_manager_latency_microseconds|pod_worker_start_latency_microseconds|pleg_relist_latency_microseconds|pleg_relist_interval_microseconds|runtime_operations|runtime_operations_latency_microseconds|runtime_operations_errors|eviction_stats_age_microseconds|device_plugin_registration_count|device_plugin_alloc_latency_microseconds|network_plugin_operations_latency_microseconds)"
						sourceLabels: ["__name__"]
					}, {
						action: "drop"
						regex:  "scheduler_(e2e_scheduling_latency_microseconds|scheduling_algorithm_predicate_evaluation|scheduling_algorithm_priority_evaluation|scheduling_algorithm_preemption_evaluation|scheduling_algorithm_latency_microseconds|binding_latency_microseconds|scheduling_latency_seconds)"
						sourceLabels: ["__name__"]
					}, {
						action: "drop"
						regex:  "apiserver_(request_count|request_latencies|request_latencies_summary|dropped_requests|storage_data_key_generation_latencies_microseconds|storage_transformation_failures_total|storage_transformation_latencies_microseconds|proxy_tunnel_sync_latency_secs|longrunning_gauge|registered_watchers|storage_db_total_size_in_bytes|flowcontrol_request_concurrency_limit|flowcontrol_request_concurrency_in_use)"
						sourceLabels: ["__name__"]
					}, {
						action: "drop"
						regex:  "kubelet_docker_(operations|operations_latency_microseconds|operations_errors|operations_timeout)"
						sourceLabels: ["__name__"]
					}, {
						action: "drop"
						regex:  "reflector_(items_per_list|items_per_watch|list_duration_seconds|lists_total|short_watches_total|watch_duration_seconds|watches_total)"
						sourceLabels: ["__name__"]
					}, {
						action: "drop"
						regex:  "etcd_(helper_cache_hit_count|helper_cache_miss_count|helper_cache_entry_count|object_counts|request_cache_get_latencies_summary|request_cache_add_latencies_summary|request_latencies_summary)"
						sourceLabels: ["__name__"]
					}, {
						action: "drop"
						regex:  "transformation_(transformation_latencies_microseconds|failures_total)"
						sourceLabels: ["__name__"]
					}, {
						action: "drop"
						regex:  "(admission_quota_controller_adds|admission_quota_controller_depth|admission_quota_controller_longest_running_processor_microseconds|admission_quota_controller_queue_latency|admission_quota_controller_unfinished_work_seconds|admission_quota_controller_work_duration|APIServiceOpenAPIAggregationControllerQueue1_adds|APIServiceOpenAPIAggregationControllerQueue1_depth|APIServiceOpenAPIAggregationControllerQueue1_longest_running_processor_microseconds|APIServiceOpenAPIAggregationControllerQueue1_queue_latency|APIServiceOpenAPIAggregationControllerQueue1_retries|APIServiceOpenAPIAggregationControllerQueue1_unfinished_work_seconds|APIServiceOpenAPIAggregationControllerQueue1_work_duration|APIServiceRegistrationController_adds|APIServiceRegistrationController_depth|APIServiceRegistrationController_longest_running_processor_microseconds|APIServiceRegistrationController_queue_latency|APIServiceRegistrationController_retries|APIServiceRegistrationController_unfinished_work_seconds|APIServiceRegistrationController_work_duration|autoregister_adds|autoregister_depth|autoregister_longest_running_processor_microseconds|autoregister_queue_latency|autoregister_retries|autoregister_unfinished_work_seconds|autoregister_work_duration|AvailableConditionController_adds|AvailableConditionController_depth|AvailableConditionController_longest_running_processor_microseconds|AvailableConditionController_queue_latency|AvailableConditionController_retries|AvailableConditionController_unfinished_work_seconds|AvailableConditionController_work_duration|crd_autoregistration_controller_adds|crd_autoregistration_controller_depth|crd_autoregistration_controller_longest_running_processor_microseconds|crd_autoregistration_controller_queue_latency|crd_autoregistration_controller_retries|crd_autoregistration_controller_unfinished_work_seconds|crd_autoregistration_controller_work_duration|crdEstablishing_adds|crdEstablishing_depth|crdEstablishing_longest_running_processor_microseconds|crdEstablishing_queue_latency|crdEstablishing_retries|crdEstablishing_unfinished_work_seconds|crdEstablishing_work_duration|crd_finalizer_adds|crd_finalizer_depth|crd_finalizer_longest_running_processor_microseconds|crd_finalizer_queue_latency|crd_finalizer_retries|crd_finalizer_unfinished_work_seconds|crd_finalizer_work_duration|crd_naming_condition_controller_adds|crd_naming_condition_controller_depth|crd_naming_condition_controller_longest_running_processor_microseconds|crd_naming_condition_controller_queue_latency|crd_naming_condition_controller_retries|crd_naming_condition_controller_unfinished_work_seconds|crd_naming_condition_controller_work_duration|crd_openapi_controller_adds|crd_openapi_controller_depth|crd_openapi_controller_longest_running_processor_microseconds|crd_openapi_controller_queue_latency|crd_openapi_controller_retries|crd_openapi_controller_unfinished_work_seconds|crd_openapi_controller_work_duration|DiscoveryController_adds|DiscoveryController_depth|DiscoveryController_longest_running_processor_microseconds|DiscoveryController_queue_latency|DiscoveryController_retries|DiscoveryController_unfinished_work_seconds|DiscoveryController_work_duration|kubeproxy_sync_proxy_rules_latency_microseconds|non_structural_schema_condition_controller_adds|non_structural_schema_condition_controller_depth|non_structural_schema_condition_controller_longest_running_processor_microseconds|non_structural_schema_condition_controller_queue_latency|non_structural_schema_condition_controller_retries|non_structural_schema_condition_controller_unfinished_work_seconds|non_structural_schema_condition_controller_work_duration|rest_client_request_latency_seconds|storage_operation_errors_total|storage_operation_status_count)"
						sourceLabels: ["__name__"]
					}, {
						action: "drop"
						regex:  "etcd_(debugging|disk|request|server).*"
						sourceLabels: ["__name__"]
					}]
					port:   "https-metrics"
					scheme: "https"
					tlsConfig: insecureSkipVerify: true
				}, {
					bearerTokenFile: "/var/run/secrets/kubernetes.io/serviceaccount/token"
					interval:        "5s"
					metricRelabelings: [{
						action: "drop"
						regex:  "process_start_time_seconds"
						sourceLabels: ["__name__"]
					}]
					path:   "/metrics/slis"
					port:   "https-metrics"
					scheme: "https"
					tlsConfig: insecureSkipVerify: true
				}]
				jobLabel: "app.kubernetes.io/name"
				namespaceSelector: matchNames: ["kube-system"]
				selector: matchLabels: "app.kubernetes.io/name": "kube-controller-manager"
			}
		}
		"kube-scheduler": {
			apiVersion: "monitoring.coreos.com/v1"
			kind:       "ServiceMonitor"
			metadata: {
				labels: {
					"app.kubernetes.io/name":    "kube-scheduler"
					"app.kubernetes.io/part-of": "kube-prometheus"
				}
				name:      "kube-scheduler"
				namespace: "monitoring"
			}
			spec: {
				endpoints: [{
					bearerTokenFile: "/var/run/secrets/kubernetes.io/serviceaccount/token"
					interval:        "30s"
					port:            "https-metrics"
					scheme:          "https"
					tlsConfig: insecureSkipVerify: true
				}, {
					bearerTokenFile: "/var/run/secrets/kubernetes.io/serviceaccount/token"
					interval:        "5s"
					metricRelabelings: [{
						action: "drop"
						regex:  "process_start_time_seconds"
						sourceLabels: ["__name__"]
					}]
					path:   "/metrics/slis"
					port:   "https-metrics"
					scheme: "https"
					tlsConfig: insecureSkipVerify: true
				}]
				jobLabel: "app.kubernetes.io/name"
				namespaceSelector: matchNames: ["kube-system"]
				selector: matchLabels: "app.kubernetes.io/name": "kube-scheduler"
			}
		}
		kubelet: {
			apiVersion: "monitoring.coreos.com/v1"
			kind:       "ServiceMonitor"
			metadata: {
				labels: {
					"app.kubernetes.io/name":    "kubelet"
					"app.kubernetes.io/part-of": "kube-prometheus"
				}
				name:      "kubelet"
				namespace: "monitoring"
			}
			spec: {
				endpoints: [{
					bearerTokenFile: "/var/run/secrets/kubernetes.io/serviceaccount/token"
					honorLabels:     true
					interval:        "30s"
					metricRelabelings: [{
						action: "drop"
						regex:  "kubelet_(pod_worker_latency_microseconds|pod_start_latency_microseconds|cgroup_manager_latency_microseconds|pod_worker_start_latency_microseconds|pleg_relist_latency_microseconds|pleg_relist_interval_microseconds|runtime_operations|runtime_operations_latency_microseconds|runtime_operations_errors|eviction_stats_age_microseconds|device_plugin_registration_count|device_plugin_alloc_latency_microseconds|network_plugin_operations_latency_microseconds)"
						sourceLabels: ["__name__"]
					}, {
						action: "drop"
						regex:  "scheduler_(e2e_scheduling_latency_microseconds|scheduling_algorithm_predicate_evaluation|scheduling_algorithm_priority_evaluation|scheduling_algorithm_preemption_evaluation|scheduling_algorithm_latency_microseconds|binding_latency_microseconds|scheduling_latency_seconds)"
						sourceLabels: ["__name__"]
					}, {
						action: "drop"
						regex:  "apiserver_(request_count|request_latencies|request_latencies_summary|dropped_requests|storage_data_key_generation_latencies_microseconds|storage_transformation_failures_total|storage_transformation_latencies_microseconds|proxy_tunnel_sync_latency_secs|longrunning_gauge|registered_watchers|storage_db_total_size_in_bytes|flowcontrol_request_concurrency_limit|flowcontrol_request_concurrency_in_use)"
						sourceLabels: ["__name__"]
					}, {
						action: "drop"
						regex:  "kubelet_docker_(operations|operations_latency_microseconds|operations_errors|operations_timeout)"
						sourceLabels: ["__name__"]
					}, {
						action: "drop"
						regex:  "reflector_(items_per_list|items_per_watch|list_duration_seconds|lists_total|short_watches_total|watch_duration_seconds|watches_total)"
						sourceLabels: ["__name__"]
					}, {
						action: "drop"
						regex:  "etcd_(helper_cache_hit_count|helper_cache_miss_count|helper_cache_entry_count|object_counts|request_cache_get_latencies_summary|request_cache_add_latencies_summary|request_latencies_summary)"
						sourceLabels: ["__name__"]
					}, {
						action: "drop"
						regex:  "transformation_(transformation_latencies_microseconds|failures_total)"
						sourceLabels: ["__name__"]
					}, {
						action: "drop"
						regex:  "(admission_quota_controller_adds|admission_quota_controller_depth|admission_quota_controller_longest_running_processor_microseconds|admission_quota_controller_queue_latency|admission_quota_controller_unfinished_work_seconds|admission_quota_controller_work_duration|APIServiceOpenAPIAggregationControllerQueue1_adds|APIServiceOpenAPIAggregationControllerQueue1_depth|APIServiceOpenAPIAggregationControllerQueue1_longest_running_processor_microseconds|APIServiceOpenAPIAggregationControllerQueue1_queue_latency|APIServiceOpenAPIAggregationControllerQueue1_retries|APIServiceOpenAPIAggregationControllerQueue1_unfinished_work_seconds|APIServiceOpenAPIAggregationControllerQueue1_work_duration|APIServiceRegistrationController_adds|APIServiceRegistrationController_depth|APIServiceRegistrationController_longest_running_processor_microseconds|APIServiceRegistrationController_queue_latency|APIServiceRegistrationController_retries|APIServiceRegistrationController_unfinished_work_seconds|APIServiceRegistrationController_work_duration|autoregister_adds|autoregister_depth|autoregister_longest_running_processor_microseconds|autoregister_queue_latency|autoregister_retries|autoregister_unfinished_work_seconds|autoregister_work_duration|AvailableConditionController_adds|AvailableConditionController_depth|AvailableConditionController_longest_running_processor_microseconds|AvailableConditionController_queue_latency|AvailableConditionController_retries|AvailableConditionController_unfinished_work_seconds|AvailableConditionController_work_duration|crd_autoregistration_controller_adds|crd_autoregistration_controller_depth|crd_autoregistration_controller_longest_running_processor_microseconds|crd_autoregistration_controller_queue_latency|crd_autoregistration_controller_retries|crd_autoregistration_controller_unfinished_work_seconds|crd_autoregistration_controller_work_duration|crdEstablishing_adds|crdEstablishing_depth|crdEstablishing_longest_running_processor_microseconds|crdEstablishing_queue_latency|crdEstablishing_retries|crdEstablishing_unfinished_work_seconds|crdEstablishing_work_duration|crd_finalizer_adds|crd_finalizer_depth|crd_finalizer_longest_running_processor_microseconds|crd_finalizer_queue_latency|crd_finalizer_retries|crd_finalizer_unfinished_work_seconds|crd_finalizer_work_duration|crd_naming_condition_controller_adds|crd_naming_condition_controller_depth|crd_naming_condition_controller_longest_running_processor_microseconds|crd_naming_condition_controller_queue_latency|crd_naming_condition_controller_retries|crd_naming_condition_controller_unfinished_work_seconds|crd_naming_condition_controller_work_duration|crd_openapi_controller_adds|crd_openapi_controller_depth|crd_openapi_controller_longest_running_processor_microseconds|crd_openapi_controller_queue_latency|crd_openapi_controller_retries|crd_openapi_controller_unfinished_work_seconds|crd_openapi_controller_work_duration|DiscoveryController_adds|DiscoveryController_depth|DiscoveryController_longest_running_processor_microseconds|DiscoveryController_queue_latency|DiscoveryController_retries|DiscoveryController_unfinished_work_seconds|DiscoveryController_work_duration|kubeproxy_sync_proxy_rules_latency_microseconds|non_structural_schema_condition_controller_adds|non_structural_schema_condition_controller_depth|non_structural_schema_condition_controller_longest_running_processor_microseconds|non_structural_schema_condition_controller_queue_latency|non_structural_schema_condition_controller_retries|non_structural_schema_condition_controller_unfinished_work_seconds|non_structural_schema_condition_controller_work_duration|rest_client_request_latency_seconds|storage_operation_errors_total|storage_operation_status_count)"
						sourceLabels: ["__name__"]
					}]
					port: "https-metrics"
					relabelings: [{
						action: "replace"
						sourceLabels: ["__metrics_path__"]
						targetLabel: "metrics_path"
					}]
					scheme: "https"
					tlsConfig: insecureSkipVerify: true
				}, {
					bearerTokenFile: "/var/run/secrets/kubernetes.io/serviceaccount/token"
					honorLabels:     true
					honorTimestamps: false
					interval:        "30s"
					metricRelabelings: [{
						action: "drop"
						regex:  "container_(network_tcp_usage_total|network_udp_usage_total|tasks_state|cpu_load_average_10s)"
						sourceLabels: ["__name__"]
					}, {
						action: "drop"
						regex:  "(container_spec_.*|container_file_descriptors|container_sockets|container_threads_max|container_threads|container_start_time_seconds|container_last_seen);;"
						sourceLabels: ["__name__", "pod", "namespace"]
					}, {
						action: "drop"
						regex:  "(container_blkio_device_usage_total);.+"
						sourceLabels: ["__name__", "container"]
					}]
					path: "/metrics/cadvisor"
					port: "https-metrics"
					relabelings: [{
						action: "replace"
						sourceLabels: ["__metrics_path__"]
						targetLabel: "metrics_path"
					}]
					scheme: "https"
					tlsConfig: insecureSkipVerify: true
				}, {
					bearerTokenFile: "/var/run/secrets/kubernetes.io/serviceaccount/token"
					honorLabels:     true
					interval:        "30s"
					path:            "/metrics/probes"
					port:            "https-metrics"
					relabelings: [{
						action: "replace"
						sourceLabels: ["__metrics_path__"]
						targetLabel: "metrics_path"
					}]
					scheme: "https"
					tlsConfig: insecureSkipVerify: true
				}, {
					bearerTokenFile: "/var/run/secrets/kubernetes.io/serviceaccount/token"
					honorLabels:     true
					interval:        "5s"
					metricRelabelings: [{
						action: "drop"
						regex:  "process_start_time_seconds"
						sourceLabels: ["__name__"]
					}]
					path: "/metrics/slis"
					port: "https-metrics"
					relabelings: [{
						action: "replace"
						sourceLabels: ["__metrics_path__"]
						targetLabel: "metrics_path"
					}]
					scheme: "https"
					tlsConfig: insecureSkipVerify: true
				}]
				jobLabel: "app.kubernetes.io/name"
				namespaceSelector: matchNames: ["kube-system"]
				selector: matchLabels: "app.kubernetes.io/name": "kubelet"
			}
		}
	}
}
