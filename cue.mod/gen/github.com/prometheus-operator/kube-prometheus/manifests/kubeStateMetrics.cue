package manifests

kubeStateMetrics: {
	ClusterRole: "kube-state-metrics": {
		apiVersion: "rbac.authorization.k8s.io/v1"
		kind:       "ClusterRole"
		metadata: {
			labels: {
				"app.kubernetes.io/component": "exporter"
				"app.kubernetes.io/name":      "kube-state-metrics"
				"app.kubernetes.io/part-of":   "kube-prometheus"
				"app.kubernetes.io/version":   "2.8.2"
			}
			name: "kube-state-metrics"
		}
		rules: [{
			apiGroups: [
				"",
			]
			resources: ["configmaps", "secrets", "nodes", "pods", "services", "serviceaccounts", "resourcequotas", "replicationcontrollers", "limitranges", "persistentvolumeclaims", "persistentvolumes", "namespaces", "endpoints"]
			verbs: ["list", "watch"]
		}, {
			apiGroups: [
				"apps",
			]
			resources: ["statefulsets", "daemonsets", "deployments", "replicasets"]
			verbs: ["list", "watch"]
		}, {
			apiGroups: [
				"batch",
			]
			resources: ["cronjobs", "jobs"]
			verbs: ["list", "watch"]
		}, {
			apiGroups: ["autoscaling"]
			resources: ["horizontalpodautoscalers"]
			verbs: ["list", "watch"]
		}, {
			apiGroups: ["authentication.k8s.io"]
			resources: ["tokenreviews"]
			verbs: ["create"]
		}, {
			apiGroups: ["authorization.k8s.io"]
			resources: ["subjectaccessreviews"]
			verbs: ["create"]
		}, {
			apiGroups: ["policy"]
			resources: ["poddisruptionbudgets"]
			verbs: ["list", "watch"]
		}, {
			apiGroups: ["certificates.k8s.io"]
			resources: ["certificatesigningrequests"]
			verbs: ["list", "watch"]
		}, {
			apiGroups: ["discovery.k8s.io"]
			resources: ["endpointslices"]
			verbs: ["list", "watch"]
		}, {
			apiGroups: ["storage.k8s.io"]
			resources: ["storageclasses", "volumeattachments"]
			verbs: ["list", "watch"]
		}, {
			apiGroups: ["admissionregistration.k8s.io"]
			resources: ["mutatingwebhookconfigurations", "validatingwebhookconfigurations"]
			verbs: ["list", "watch"]
		}, {
			apiGroups: ["networking.k8s.io"]
			resources: ["networkpolicies", "ingressclasses", "ingresses"]
			verbs: ["list", "watch"]
		}, {
			apiGroups: ["coordination.k8s.io"]
			resources: ["leases"]
			verbs: ["list", "watch"]
		}, {
			apiGroups: ["rbac.authorization.k8s.io"]
			resources: ["clusterrolebindings", "clusterroles", "rolebindings", "roles"]
			verbs: ["list", "watch"]
		}]
	}
	ClusterRoleBinding: "kube-state-metrics": {
		apiVersion: "rbac.authorization.k8s.io/v1"
		kind:       "ClusterRoleBinding"
		metadata: {
			labels: {
				"app.kubernetes.io/component": "exporter"
				"app.kubernetes.io/name":      "kube-state-metrics"
				"app.kubernetes.io/part-of":   "kube-prometheus"
				"app.kubernetes.io/version":   "2.8.2"
			}
			name: "kube-state-metrics"
		}
		roleRef: {
			apiGroup: "rbac.authorization.k8s.io"
			kind:     "ClusterRole"
			name:     "kube-state-metrics"
		}
		subjects: [{
			kind:      "ServiceAccount"
			name:      "kube-state-metrics"
			namespace: "monitoring"
		}]
	}
	Deployment: "kube-state-metrics": {
		apiVersion: "apps/v1"
		kind:       "Deployment"
		metadata: {
			labels: {
				"app.kubernetes.io/component": "exporter"
				"app.kubernetes.io/name":      "kube-state-metrics"
				"app.kubernetes.io/part-of":   "kube-prometheus"
				"app.kubernetes.io/version":   "2.8.2"
			}
			name:      "kube-state-metrics"
			namespace: "monitoring"
		}
		spec: {
			replicas: 1
			selector: matchLabels: {
				"app.kubernetes.io/component": "exporter"
				"app.kubernetes.io/name":      "kube-state-metrics"
				"app.kubernetes.io/part-of":   "kube-prometheus"
			}
			template: {
				metadata: {
					annotations: "kubectl.kubernetes.io/default-container": "kube-state-metrics"
					labels: {
						"app.kubernetes.io/component": "exporter"
						"app.kubernetes.io/name":      "kube-state-metrics"
						"app.kubernetes.io/part-of":   "kube-prometheus"
						"app.kubernetes.io/version":   "2.8.2"
					}
				}
				spec: {
					automountServiceAccountToken: true
					containers: [{
						args: ["--host=127.0.0.1", "--port=8081", "--telemetry-host=127.0.0.1", "--telemetry-port=8082"]
						image: "registry.k8s.io/kube-state-metrics/kube-state-metrics:v2.8.2"
						name:  "kube-state-metrics"
						resources: {
							limits: {
								cpu:    "100m"
								memory: "250Mi"
							}
							requests: {
								cpu:    "10m"
								memory: "190Mi"
							}
						}
						securityContext: {
							allowPrivilegeEscalation: false
							capabilities: drop: ["ALL"]
							readOnlyRootFilesystem: true
							runAsNonRoot:           true
							runAsUser:              65534
							seccompProfile: type: "RuntimeDefault"
						}
					}, {
						args: ["--logtostderr", "--secure-listen-address=:8443", "--tls-cipher-suites=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256,TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256,TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384,TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384,TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305,TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305", "--upstream=http://127.0.0.1:8081/"]
						image: "quay.io/brancz/kube-rbac-proxy:v0.14.1"
						name:  "kube-rbac-proxy-main"
						ports: [{
							containerPort: 8443
							name:          "https-main"
						}]
						resources: {
							limits: {
								cpu:    "140m"
								memory: "40Mi"
							}
							requests: {
								cpu:    "20m"
								memory: "20Mi"
							}
						}
						securityContext: {
							allowPrivilegeEscalation: false
							capabilities: drop: ["ALL"]
							readOnlyRootFilesystem: true
							runAsGroup:             65532
							runAsNonRoot:           true
							runAsUser:              65532
						}
					}, {
						args: ["--logtostderr", "--secure-listen-address=:9443", "--tls-cipher-suites=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256,TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256,TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384,TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384,TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305,TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305", "--upstream=http://127.0.0.1:8082/"]
						image: "quay.io/brancz/kube-rbac-proxy:v0.14.1"
						name:  "kube-rbac-proxy-self"
						ports: [{
							containerPort: 9443
							name:          "https-self"
						}]
						resources: {
							limits: {
								cpu:    "20m"
								memory: "40Mi"
							}
							requests: {
								cpu:    "10m"
								memory: "20Mi"
							}
						}
						securityContext: {
							allowPrivilegeEscalation: false
							capabilities: drop: ["ALL"]
							readOnlyRootFilesystem: true
							runAsGroup:             65532
							runAsNonRoot:           true
							runAsUser:              65532
						}
					}]
					nodeSelector: "kubernetes.io/os": "linux"
					serviceAccountName: "kube-state-metrics"
				}
			}
		}
	}
	NetworkPolicy: "kube-state-metrics": {
		apiVersion: "networking.k8s.io/v1"
		kind:       "NetworkPolicy"
		metadata: {
			labels: {
				"app.kubernetes.io/component": "exporter"
				"app.kubernetes.io/name":      "kube-state-metrics"
				"app.kubernetes.io/part-of":   "kube-prometheus"
				"app.kubernetes.io/version":   "2.8.2"
			}
			name:      "kube-state-metrics"
			namespace: "monitoring"
		}
		spec: {
			egress: [{},
			]
			ingress: [{
				from: [{
					podSelector: matchLabels: "app.kubernetes.io/name": "prometheus"
				}]
				ports: [{
					port:     8443
					protocol: "TCP"
				}, {
					port:     9443
					protocol: "TCP"
				}]
			}]
			podSelector: matchLabels: {
				"app.kubernetes.io/component": "exporter"
				"app.kubernetes.io/name":      "kube-state-metrics"
				"app.kubernetes.io/part-of":   "kube-prometheus"
			}
			policyTypes: ["Egress", "Ingress"]
		}
	}
	PrometheusRule: "kube-state-metrics-rules": {
		apiVersion: "monitoring.coreos.com/v1"
		kind:       "PrometheusRule"
		metadata: {
			labels: {
				"app.kubernetes.io/component": "exporter"
				"app.kubernetes.io/name":      "kube-state-metrics"
				"app.kubernetes.io/part-of":   "kube-prometheus"
				"app.kubernetes.io/version":   "2.8.2"
				prometheus:                    "k8s"
				role:                          "alert-rules"
			}
			name:      "kube-state-metrics-rules"
			namespace: "monitoring"
		}
		spec: groups: [{
			name: "kube-state-metrics"
			rules: [{
				alert: "KubeStateMetricsListErrors"
				annotations: {
					description: "kube-state-metrics is experiencing errors at an elevated rate in list operations. This is likely causing it to not be able to expose metrics about Kubernetes objects correctly or at all."
					runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kube-state-metrics/kubestatemetricslisterrors"
					summary:     "kube-state-metrics is experiencing errors in list operations."
				}
				expr: """
					(sum(rate(kube_state_metrics_list_total{job="kube-state-metrics",result="error"}[5m]))
					  /
					sum(rate(kube_state_metrics_list_total{job="kube-state-metrics"}[5m])))
					> 0.01

					"""
				for: "15m"
				labels: severity: "critical"
			}, {
				alert: "KubeStateMetricsWatchErrors"
				annotations: {
					description: "kube-state-metrics is experiencing errors at an elevated rate in watch operations. This is likely causing it to not be able to expose metrics about Kubernetes objects correctly or at all."
					runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kube-state-metrics/kubestatemetricswatcherrors"
					summary:     "kube-state-metrics is experiencing errors in watch operations."
				}
				expr: """
					(sum(rate(kube_state_metrics_watch_total{job="kube-state-metrics",result="error"}[5m]))
					  /
					sum(rate(kube_state_metrics_watch_total{job="kube-state-metrics"}[5m])))
					> 0.01

					"""
				for: "15m"
				labels: severity: "critical"
			}, {
				alert: "KubeStateMetricsShardingMismatch"
				annotations: {
					description: "kube-state-metrics pods are running with different --total-shards configuration, some Kubernetes objects may be exposed multiple times or not exposed at all."
					runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kube-state-metrics/kubestatemetricsshardingmismatch"
					summary:     "kube-state-metrics sharding is misconfigured."
				}
				expr: """
					stdvar (kube_state_metrics_total_shards{job="kube-state-metrics"}) != 0

					"""
				for: "15m"
				labels: severity: "critical"
			}, {
				alert: "KubeStateMetricsShardsMissing"
				annotations: {
					description: "kube-state-metrics shards are missing, some Kubernetes objects are not being exposed."
					runbook_url: "https://runbooks.prometheus-operator.dev/runbooks/kube-state-metrics/kubestatemetricsshardsmissing"
					summary:     "kube-state-metrics shards are missing."
				}
				expr: """
					2^max(kube_state_metrics_total_shards{job="kube-state-metrics"}) - 1
					  -
					sum( 2 ^ max by (shard_ordinal) (kube_state_metrics_shard_ordinal{job="kube-state-metrics"}) )
					!= 0

					"""
				for: "15m"
				labels: severity: "critical"
			}]
		}]
	}
	Service: "kube-state-metrics": {
		apiVersion: "v1"
		kind:       "Service"
		metadata: {
			labels: {
				"app.kubernetes.io/component": "exporter"
				"app.kubernetes.io/name":      "kube-state-metrics"
				"app.kubernetes.io/part-of":   "kube-prometheus"
				"app.kubernetes.io/version":   "2.8.2"
			}
			name:      "kube-state-metrics"
			namespace: "monitoring"
		}
		spec: {
			clusterIP: "None"
			ports: [{
				name:       "https-main"
				port:       8443
				targetPort: "https-main"
			}, {
				name:       "https-self"
				port:       9443
				targetPort: "https-self"
			}]
			selector: {
				"app.kubernetes.io/component": "exporter"
				"app.kubernetes.io/name":      "kube-state-metrics"
				"app.kubernetes.io/part-of":   "kube-prometheus"
			}
		}
	}
	ServiceAccount: "kube-state-metrics": {
		apiVersion:                   "v1"
		automountServiceAccountToken: false
		kind:                         "ServiceAccount"
		metadata: {
			labels: {
				"app.kubernetes.io/component": "exporter"
				"app.kubernetes.io/name":      "kube-state-metrics"
				"app.kubernetes.io/part-of":   "kube-prometheus"
				"app.kubernetes.io/version":   "2.8.2"
			}
			name:      "kube-state-metrics"
			namespace: "monitoring"
		}
	}
	ServiceMonitor: "kube-state-metrics": {
		apiVersion: "monitoring.coreos.com/v1"
		kind:       "ServiceMonitor"
		metadata: {
			labels: {
				"app.kubernetes.io/component": "exporter"
				"app.kubernetes.io/name":      "kube-state-metrics"
				"app.kubernetes.io/part-of":   "kube-prometheus"
				"app.kubernetes.io/version":   "2.8.2"
			}
			name:      "kube-state-metrics"
			namespace: "monitoring"
		}
		spec: {
			endpoints: [{
				bearerTokenFile: "/var/run/secrets/kubernetes.io/serviceaccount/token"
				honorLabels:     true
				interval:        "30s"
				metricRelabelings: [{
					action: "drop"
					regex:  "kube_endpoint_address_not_ready|kube_endpoint_address_available"
					sourceLabels: ["__name__"]
				}]
				port: "https-main"
				relabelings: [{
					action: "labeldrop"
					regex:  "(pod|service|endpoint|namespace)"
				}]
				scheme:        "https"
				scrapeTimeout: "30s"
				tlsConfig: insecureSkipVerify: true
			}, {
				bearerTokenFile: "/var/run/secrets/kubernetes.io/serviceaccount/token"
				interval:        "30s"
				port:            "https-self"
				scheme:          "https"
				tlsConfig: insecureSkipVerify: true
			}]
			jobLabel: "app.kubernetes.io/name"
			selector: matchLabels: {
				"app.kubernetes.io/component": "exporter"
				"app.kubernetes.io/name":      "kube-state-metrics"
				"app.kubernetes.io/part-of":   "kube-prometheus"
			}
		}
	}
}
