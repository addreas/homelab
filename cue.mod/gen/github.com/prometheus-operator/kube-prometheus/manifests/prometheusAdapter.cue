package manifests

prometheusAdapter: {
	APIService: "v1beta1.metrics.k8s.io": {
		apiVersion: "apiregistration.k8s.io/v1"
		kind:       "APIService"
		metadata: {
			labels: {
				"app.kubernetes.io/component": "metrics-adapter"
				"app.kubernetes.io/name":      "prometheus-adapter"
				"app.kubernetes.io/part-of":   "kube-prometheus"
				"app.kubernetes.io/version":   "0.11.2"
			}
			name: "v1beta1.metrics.k8s.io"
		}
		spec: {
			group:                 "metrics.k8s.io"
			groupPriorityMinimum:  100
			insecureSkipTLSVerify: true
			service: {
				name:      "prometheus-adapter"
				namespace: "monitoring"
			}
			version:         "v1beta1"
			versionPriority: 100
		}
	}
	ClusterRole: {
		"prometheus-adapter": {
			apiVersion: "rbac.authorization.k8s.io/v1"
			kind:       "ClusterRole"
			metadata: {
				labels: {
					"app.kubernetes.io/component": "metrics-adapter"
					"app.kubernetes.io/name":      "prometheus-adapter"
					"app.kubernetes.io/part-of":   "kube-prometheus"
					"app.kubernetes.io/version":   "0.11.2"
				}
				name: "prometheus-adapter"
			}
			rules: [{
				apiGroups: [
					"",
				]
				resources: ["nodes", "namespaces", "pods", "services"]
				verbs: ["get", "list", "watch"]
			}]
		}
		"resource-metrics-server-resources": {
			apiVersion: "rbac.authorization.k8s.io/v1"
			kind:       "ClusterRole"
			metadata: {
				labels: {
					"app.kubernetes.io/component": "metrics-adapter"
					"app.kubernetes.io/name":      "prometheus-adapter"
					"app.kubernetes.io/part-of":   "kube-prometheus"
					"app.kubernetes.io/version":   "0.11.2"
				}
				name: "resource-metrics-server-resources"
			}
			rules: [{
				apiGroups: ["metrics.k8s.io"]
				resources: [
					"*",
				]
				verbs: [
					"*",
				]
			}]
		}
		"system:aggregated-metrics-reader": {
			apiVersion: "rbac.authorization.k8s.io/v1"
			kind:       "ClusterRole"
			metadata: {
				labels: {
					"app.kubernetes.io/component":                  "metrics-adapter"
					"app.kubernetes.io/name":                       "prometheus-adapter"
					"app.kubernetes.io/part-of":                    "kube-prometheus"
					"app.kubernetes.io/version":                    "0.11.2"
					"rbac.authorization.k8s.io/aggregate-to-admin": "true"
					"rbac.authorization.k8s.io/aggregate-to-edit":  "true"
					"rbac.authorization.k8s.io/aggregate-to-view":  "true"
				}
				name: "system:aggregated-metrics-reader"
			}
			rules: [{
				apiGroups: ["metrics.k8s.io"]
				resources: ["pods", "nodes"]
				verbs: ["get", "list", "watch"]
			}]
		}
	}
	ClusterRoleBinding: {
		"prometheus-adapter": {
			apiVersion: "rbac.authorization.k8s.io/v1"
			kind:       "ClusterRoleBinding"
			metadata: {
				labels: {
					"app.kubernetes.io/component": "metrics-adapter"
					"app.kubernetes.io/name":      "prometheus-adapter"
					"app.kubernetes.io/part-of":   "kube-prometheus"
					"app.kubernetes.io/version":   "0.11.2"
				}
				name: "prometheus-adapter"
			}
			roleRef: {
				apiGroup: "rbac.authorization.k8s.io"
				kind:     "ClusterRole"
				name:     "prometheus-adapter"
			}
			subjects: [{
				kind:      "ServiceAccount"
				name:      "prometheus-adapter"
				namespace: "monitoring"
			}]
		}
		"resource-metrics:system:auth-delegator": {
			apiVersion: "rbac.authorization.k8s.io/v1"
			kind:       "ClusterRoleBinding"
			metadata: {
				labels: {
					"app.kubernetes.io/component": "metrics-adapter"
					"app.kubernetes.io/name":      "prometheus-adapter"
					"app.kubernetes.io/part-of":   "kube-prometheus"
					"app.kubernetes.io/version":   "0.11.2"
				}
				name: "resource-metrics:system:auth-delegator"
			}
			roleRef: {
				apiGroup: "rbac.authorization.k8s.io"
				kind:     "ClusterRole"
				name:     "system:auth-delegator"
			}
			subjects: [{
				kind:      "ServiceAccount"
				name:      "prometheus-adapter"
				namespace: "monitoring"
			}]
		}
	}
	ConfigMap: "adapter-config": {
		apiVersion: "v1"
		data: "config.yaml": """
			"resourceRules":
			  "cpu":
			    "containerLabel": "container"
			    "containerQuery": |
			      sum by (<<.GroupBy>>) (
			        irate (
			            container_cpu_usage_seconds_total{<<.LabelMatchers>>,container!="",pod!=""}[120s]
			        )
			      )
			    "nodeQuery": |
			      sum by (<<.GroupBy>>) (
			        1 - irate(
			          node_cpu_seconds_total{mode="idle"}[60s]
			        )
			        * on(namespace, pod) group_left(node) (
			          node_namespace_pod:kube_pod_info:{<<.LabelMatchers>>}
			        )
			      )
			      or sum by (<<.GroupBy>>) (
			        1 - irate(
			          windows_cpu_time_total{mode="idle", job="windows-exporter",<<.LabelMatchers>>}[4m]
			        )
			      )
			    "resources":
			      "overrides":
			        "namespace":
			          "resource": "namespace"
			        "node":
			          "resource": "node"
			        "pod":
			          "resource": "pod"
			  "memory":
			    "containerLabel": "container"
			    "containerQuery": |
			      sum by (<<.GroupBy>>) (
			        container_memory_working_set_bytes{<<.LabelMatchers>>,container!="",pod!=""}
			      )
			    "nodeQuery": |
			      sum by (<<.GroupBy>>) (
			        node_memory_MemTotal_bytes{job="node-exporter",<<.LabelMatchers>>}
			        -
			        node_memory_MemAvailable_bytes{job="node-exporter",<<.LabelMatchers>>}
			      )
			      or sum by (<<.GroupBy>>) (
			        windows_cs_physical_memory_bytes{job="windows-exporter",<<.LabelMatchers>>}
			        -
			        windows_memory_available_bytes{job="windows-exporter",<<.LabelMatchers>>}
			      )
			    "resources":
			      "overrides":
			        "instance":
			          "resource": "node"
			        "namespace":
			          "resource": "namespace"
			        "pod":
			          "resource": "pod"
			  "window": "5m"
			"""
		kind: "ConfigMap"
		metadata: {
			labels: {
				"app.kubernetes.io/component": "metrics-adapter"
				"app.kubernetes.io/name":      "prometheus-adapter"
				"app.kubernetes.io/part-of":   "kube-prometheus"
				"app.kubernetes.io/version":   "0.11.2"
			}
			name:      "adapter-config"
			namespace: "monitoring"
		}
	}
	Deployment: "prometheus-adapter": {
		apiVersion: "apps/v1"
		kind:       "Deployment"
		metadata: {
			labels: {
				"app.kubernetes.io/component": "metrics-adapter"
				"app.kubernetes.io/name":      "prometheus-adapter"
				"app.kubernetes.io/part-of":   "kube-prometheus"
				"app.kubernetes.io/version":   "0.11.2"
			}
			name:      "prometheus-adapter"
			namespace: "monitoring"
		}
		spec: {
			replicas: 2
			selector: matchLabels: {
				"app.kubernetes.io/component": "metrics-adapter"
				"app.kubernetes.io/name":      "prometheus-adapter"
				"app.kubernetes.io/part-of":   "kube-prometheus"
			}
			strategy: rollingUpdate: {
				maxSurge:       1
				maxUnavailable: 1
			}
			template: {
				metadata: {
					annotations: "checksum.config/md5": "3b1ebf7df0232d1675896f67b66373db"
					labels: {
						"app.kubernetes.io/component": "metrics-adapter"
						"app.kubernetes.io/name":      "prometheus-adapter"
						"app.kubernetes.io/part-of":   "kube-prometheus"
						"app.kubernetes.io/version":   "0.11.2"
					}
				}
				spec: {
					automountServiceAccountToken: true
					containers: [{
						args: ["--cert-dir=/var/run/serving-cert", "--config=/etc/adapter/config.yaml", "--metrics-relist-interval=1m", "--prometheus-url=http://prometheus-k8s.monitoring.svc:9090/", "--secure-port=6443", "--tls-cipher-suites=TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305,TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305,TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256,TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384,TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256,TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384,TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA,TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA256,TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA,TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA,TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA,TLS_RSA_WITH_AES_128_GCM_SHA256,TLS_RSA_WITH_AES_256_GCM_SHA384,TLS_RSA_WITH_AES_128_CBC_SHA,TLS_RSA_WITH_AES_256_CBC_SHA"]
						image: "registry.k8s.io/prometheus-adapter/prometheus-adapter:v0.11.2"
						livenessProbe: {
							failureThreshold: 5
							httpGet: {
								path:   "/livez"
								port:   "https"
								scheme: "HTTPS"
							}
							periodSeconds: 5
						}
						name: "prometheus-adapter"
						ports: [{
							containerPort: 6443
							name:          "https"
						}]
						readinessProbe: {
							failureThreshold: 5
							httpGet: {
								path:   "/readyz"
								port:   "https"
								scheme: "HTTPS"
							}
							periodSeconds: 5
						}
						resources: {
							limits: {
								cpu:    "250m"
								memory: "180Mi"
							}
							requests: {
								cpu:    "102m"
								memory: "180Mi"
							}
						}
						securityContext: {
							allowPrivilegeEscalation: false
							capabilities: drop: ["ALL"]
							readOnlyRootFilesystem: true
							runAsNonRoot:           true
							seccompProfile: type: "RuntimeDefault"
						}
						startupProbe: {
							failureThreshold: 18
							httpGet: {
								path:   "/livez"
								port:   "https"
								scheme: "HTTPS"
							}
							periodSeconds: 10
						}
						volumeMounts: [{
							mountPath: "/tmp"
							name:      "tmpfs"
							readOnly:  false
						}, {
							mountPath: "/var/run/serving-cert"
							name:      "volume-serving-cert"
							readOnly:  false
						}, {
							mountPath: "/etc/adapter"
							name:      "config"
							readOnly:  false
						}]
					}]
					nodeSelector: "kubernetes.io/os": "linux"
					serviceAccountName: "prometheus-adapter"
					volumes: [{
						emptyDir: {}
						name: "tmpfs"
					}, {
						emptyDir: {}
						name: "volume-serving-cert"
					}, {
						configMap: name: "adapter-config"
						name: "config"
					}]
				}
			}
		}
	}
	PodDisruptionBudget: "prometheus-adapter": {
		apiVersion: "policy/v1"
		kind:       "PodDisruptionBudget"
		metadata: {
			labels: {
				"app.kubernetes.io/component": "metrics-adapter"
				"app.kubernetes.io/name":      "prometheus-adapter"
				"app.kubernetes.io/part-of":   "kube-prometheus"
				"app.kubernetes.io/version":   "0.11.2"
			}
			name:      "prometheus-adapter"
			namespace: "monitoring"
		}
		spec: {
			minAvailable: 1
			selector: matchLabels: {
				"app.kubernetes.io/component": "metrics-adapter"
				"app.kubernetes.io/name":      "prometheus-adapter"
				"app.kubernetes.io/part-of":   "kube-prometheus"
			}
		}
	}
	RoleBinding: "resource-metrics-auth-reader": {
		apiVersion: "rbac.authorization.k8s.io/v1"
		kind:       "RoleBinding"
		metadata: {
			labels: {
				"app.kubernetes.io/component": "metrics-adapter"
				"app.kubernetes.io/name":      "prometheus-adapter"
				"app.kubernetes.io/part-of":   "kube-prometheus"
				"app.kubernetes.io/version":   "0.11.2"
			}
			name:      "resource-metrics-auth-reader"
			namespace: "kube-system"
		}
		roleRef: {
			apiGroup: "rbac.authorization.k8s.io"
			kind:     "Role"
			name:     "extension-apiserver-authentication-reader"
		}
		subjects: [{
			kind:      "ServiceAccount"
			name:      "prometheus-adapter"
			namespace: "monitoring"
		}]
	}
	Service: "prometheus-adapter": {
		apiVersion: "v1"
		kind:       "Service"
		metadata: {
			labels: {
				"app.kubernetes.io/component": "metrics-adapter"
				"app.kubernetes.io/name":      "prometheus-adapter"
				"app.kubernetes.io/part-of":   "kube-prometheus"
				"app.kubernetes.io/version":   "0.11.2"
			}
			name:      "prometheus-adapter"
			namespace: "monitoring"
		}
		spec: {
			ports: [{
				name:       "https"
				port:       443
				targetPort: 6443
			}]
			selector: {
				"app.kubernetes.io/component": "metrics-adapter"
				"app.kubernetes.io/name":      "prometheus-adapter"
				"app.kubernetes.io/part-of":   "kube-prometheus"
			}
		}
	}
	ServiceAccount: "prometheus-adapter": {
		apiVersion:                   "v1"
		automountServiceAccountToken: false
		kind:                         "ServiceAccount"
		metadata: {
			labels: {
				"app.kubernetes.io/component": "metrics-adapter"
				"app.kubernetes.io/name":      "prometheus-adapter"
				"app.kubernetes.io/part-of":   "kube-prometheus"
				"app.kubernetes.io/version":   "0.11.2"
			}
			name:      "prometheus-adapter"
			namespace: "monitoring"
		}
	}
	ServiceMonitor: "prometheus-adapter": {
		apiVersion: "monitoring.coreos.com/v1"
		kind:       "ServiceMonitor"
		metadata: {
			labels: {
				"app.kubernetes.io/component": "metrics-adapter"
				"app.kubernetes.io/name":      "prometheus-adapter"
				"app.kubernetes.io/part-of":   "kube-prometheus"
				"app.kubernetes.io/version":   "0.11.2"
			}
			name:      "prometheus-adapter"
			namespace: "monitoring"
		}
		spec: {
			endpoints: [{
				bearerTokenFile: "/var/run/secrets/kubernetes.io/serviceaccount/token"
				interval:        "30s"
				metricRelabelings: [{
					action: "drop"
					regex:  "(apiserver_client_certificate_.*|apiserver_envelope_.*|apiserver_flowcontrol_.*|apiserver_storage_.*|apiserver_webhooks_.*|workqueue_.*)"
					sourceLabels: ["__name__"]
				}]
				port:   "https"
				scheme: "https"
				tlsConfig: insecureSkipVerify: true
			}]
			selector: matchLabels: {
				"app.kubernetes.io/component": "metrics-adapter"
				"app.kubernetes.io/name":      "prometheus-adapter"
				"app.kubernetes.io/part-of":   "kube-prometheus"
			}
		}
	}
}
