package manifests

blackboxExporter: {
	ClusterRole: "blackbox-exporter": {
		apiVersion: "rbac.authorization.k8s.io/v1"
		kind:       "ClusterRole"
		metadata: name: "blackbox-exporter"
		rules: [{
			apiGroups: ["authentication.k8s.io"]
			resources: ["tokenreviews"]
			verbs: ["create"]
		}, {
			apiGroups: ["authorization.k8s.io"]
			resources: ["subjectaccessreviews"]
			verbs: ["create"]
		}]
	}
	ClusterRoleBinding: "blackbox-exporter": {
		apiVersion: "rbac.authorization.k8s.io/v1"
		kind:       "ClusterRoleBinding"
		metadata: {
			labels: {
				"app.kubernetes.io/component": "exporter"
				"app.kubernetes.io/name":      "blackbox-exporter"
				"app.kubernetes.io/part-of":   "kube-prometheus"
				"app.kubernetes.io/version":   "0.23.0"
			}
			name:      "blackbox-exporter"
			namespace: "monitoring"
		}
		roleRef: {
			apiGroup: "rbac.authorization.k8s.io"
			kind:     "ClusterRole"
			name:     "blackbox-exporter"
		}
		subjects: [{
			kind:      "ServiceAccount"
			name:      "blackbox-exporter"
			namespace: "monitoring"
		}]
	}
	ConfigMap: "blackbox-exporter-configuration": {
		apiVersion: "v1"
		data: "config.yml": """
			"modules":
			  "http_2xx":
			    "http":
			      "preferred_ip_protocol": "ip4"
			    "prober": "http"
			  "http_post_2xx":
			    "http":
			      "method": "POST"
			      "preferred_ip_protocol": "ip4"
			    "prober": "http"
			  "irc_banner":
			    "prober": "tcp"
			    "tcp":
			      "preferred_ip_protocol": "ip4"
			      "query_response":
			      - "send": "NICK prober"
			      - "send": "USER prober prober prober :prober"
			      - "expect": "PING :([^ ]+)"
			        "send": "PONG ${1}"
			      - "expect": "^:[^ ]+ 001"
			  "pop3s_banner":
			    "prober": "tcp"
			    "tcp":
			      "preferred_ip_protocol": "ip4"
			      "query_response":
			      - "expect": "^+OK"
			      "tls": true
			      "tls_config":
			        "insecure_skip_verify": false
			  "ssh_banner":
			    "prober": "tcp"
			    "tcp":
			      "preferred_ip_protocol": "ip4"
			      "query_response":
			      - "expect": "^SSH-2.0-"
			  "tcp_connect":
			    "prober": "tcp"
			    "tcp":
			      "preferred_ip_protocol": "ip4"
			"""
		kind: "ConfigMap"
		metadata: {
			labels: {
				"app.kubernetes.io/component": "exporter"
				"app.kubernetes.io/name":      "blackbox-exporter"
				"app.kubernetes.io/part-of":   "kube-prometheus"
				"app.kubernetes.io/version":   "0.23.0"
			}
			name:      "blackbox-exporter-configuration"
			namespace: "monitoring"
		}
	}
	Deployment: "blackbox-exporter": {
		apiVersion: "apps/v1"
		kind:       "Deployment"
		metadata: {
			labels: {
				"app.kubernetes.io/component": "exporter"
				"app.kubernetes.io/name":      "blackbox-exporter"
				"app.kubernetes.io/part-of":   "kube-prometheus"
				"app.kubernetes.io/version":   "0.23.0"
			}
			name:      "blackbox-exporter"
			namespace: "monitoring"
		}
		spec: {
			replicas: 1
			selector: matchLabels: {
				"app.kubernetes.io/component": "exporter"
				"app.kubernetes.io/name":      "blackbox-exporter"
				"app.kubernetes.io/part-of":   "kube-prometheus"
			}
			template: {
				metadata: {
					annotations: "kubectl.kubernetes.io/default-container": "blackbox-exporter"
					labels: {
						"app.kubernetes.io/component": "exporter"
						"app.kubernetes.io/name":      "blackbox-exporter"
						"app.kubernetes.io/part-of":   "kube-prometheus"
						"app.kubernetes.io/version":   "0.23.0"
					}
				}
				spec: {
					automountServiceAccountToken: true
					containers: [{
						args: ["--config.file=/etc/blackbox_exporter/config.yml", "--web.listen-address=:19115"]
						image: "quay.io/prometheus/blackbox-exporter:v0.23.0"
						name:  "blackbox-exporter"
						ports: [{
							containerPort: 19115
							name:          "http"
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
							runAsNonRoot:           true
							runAsUser:              65534
						}
						volumeMounts: [{
							mountPath: "/etc/blackbox_exporter/"
							name:      "config"
							readOnly:  true
						}]
					}, {
						args: ["--webhook-url=http://localhost:19115/-/reload", "--volume-dir=/etc/blackbox_exporter/"]
						image: "jimmidyson/configmap-reload:v0.5.0"
						name:  "module-configmap-reloader"
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
							runAsNonRoot:           true
							runAsUser:              65534
						}
						terminationMessagePath:   "/dev/termination-log"
						terminationMessagePolicy: "FallbackToLogsOnError"
						volumeMounts: [{
							mountPath: "/etc/blackbox_exporter/"
							name:      "config"
							readOnly:  true
						}]
					}, {
						args: ["--logtostderr", "--secure-listen-address=:9115", "--tls-cipher-suites=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256,TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256,TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384,TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384,TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305,TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305", "--upstream=http://127.0.0.1:19115/"]
						image: "quay.io/brancz/kube-rbac-proxy:v0.14.1"
						name:  "kube-rbac-proxy"
						ports: [{
							containerPort: 9115
							name:          "https"
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
					serviceAccountName: "blackbox-exporter"
					volumes: [{
						configMap: name: "blackbox-exporter-configuration"
						name: "config"
					}]
				}
			}
		}
	}
	NetworkPolicy: "blackbox-exporter": {
		apiVersion: "networking.k8s.io/v1"
		kind:       "NetworkPolicy"
		metadata: {
			labels: {
				"app.kubernetes.io/component": "exporter"
				"app.kubernetes.io/name":      "blackbox-exporter"
				"app.kubernetes.io/part-of":   "kube-prometheus"
				"app.kubernetes.io/version":   "0.23.0"
			}
			name:      "blackbox-exporter"
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
					port:     9115
					protocol: "TCP"
				}, {
					port:     19115
					protocol: "TCP"
				}]
			}]
			podSelector: matchLabels: {
				"app.kubernetes.io/component": "exporter"
				"app.kubernetes.io/name":      "blackbox-exporter"
				"app.kubernetes.io/part-of":   "kube-prometheus"
			}
			policyTypes: ["Egress", "Ingress"]
		}
	}
	Service: "blackbox-exporter": {
		apiVersion: "v1"
		kind:       "Service"
		metadata: {
			labels: {
				"app.kubernetes.io/component": "exporter"
				"app.kubernetes.io/name":      "blackbox-exporter"
				"app.kubernetes.io/part-of":   "kube-prometheus"
				"app.kubernetes.io/version":   "0.23.0"
			}
			name:      "blackbox-exporter"
			namespace: "monitoring"
		}
		spec: {
			ports: [{
				name:       "https"
				port:       9115
				targetPort: "https"
			}, {
				name:       "probe"
				port:       19115
				targetPort: "http"
			}]
			selector: {
				"app.kubernetes.io/component": "exporter"
				"app.kubernetes.io/name":      "blackbox-exporter"
				"app.kubernetes.io/part-of":   "kube-prometheus"
			}
		}
	}
	ServiceAccount: "blackbox-exporter": {
		apiVersion:                   "v1"
		automountServiceAccountToken: false
		kind:                         "ServiceAccount"
		metadata: {
			labels: {
				"app.kubernetes.io/component": "exporter"
				"app.kubernetes.io/name":      "blackbox-exporter"
				"app.kubernetes.io/part-of":   "kube-prometheus"
				"app.kubernetes.io/version":   "0.23.0"
			}
			name:      "blackbox-exporter"
			namespace: "monitoring"
		}
	}
	ServiceMonitor: "blackbox-exporter": {
		apiVersion: "monitoring.coreos.com/v1"
		kind:       "ServiceMonitor"
		metadata: {
			labels: {
				"app.kubernetes.io/component": "exporter"
				"app.kubernetes.io/name":      "blackbox-exporter"
				"app.kubernetes.io/part-of":   "kube-prometheus"
				"app.kubernetes.io/version":   "0.23.0"
			}
			name:      "blackbox-exporter"
			namespace: "monitoring"
		}
		spec: {
			endpoints: [{
				bearerTokenFile: "/var/run/secrets/kubernetes.io/serviceaccount/token"
				interval:        "30s"
				path:            "/metrics"
				port:            "https"
				scheme:          "https"
				tlsConfig: insecureSkipVerify: true
			}]
			selector: matchLabels: {
				"app.kubernetes.io/component": "exporter"
				"app.kubernetes.io/name":      "blackbox-exporter"
				"app.kubernetes.io/part-of":   "kube-prometheus"
			}
		}
	}
}
