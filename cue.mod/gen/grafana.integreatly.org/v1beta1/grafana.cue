package v1beta1

import (
	"list"
	"strings"
	"time"
)

#Grafana: {
	_embeddedResource

	// APIVersion defines the versioned schema of this representation of an object.
	// Servers should convert recognized schemas to the latest internal value, and
	// may reject unrecognized values.
	// More info:
	// https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
	apiVersion?: string

	// Kind is a string value representing the REST resource this object represents.
	// Servers may infer this from the endpoint the client submits requests to.
	// Cannot be updated.
	// In CamelCase.
	// More info:
	// https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
	kind?: string
	metadata?: {}

	// GrafanaSpec defines the desired state of Grafana
	spec!: {
		// Client defines how the grafana-operator talks to the grafana instance.
		client?: {
			// Custom HTTP headers to use when interacting with this Grafana.
			headers?: [string]: string

			// If the operator should send it's request through the grafana instances
			// ingress object instead of through the service.
			preferIngress?:
				null | bool
			timeout?:
				null | int

			// TLS Configuration used to talk with the grafana instance.
			tls?: {
				// Use a secret as a reference to give TLS Certificate information
				certSecretRef?: {
					// name is unique within a namespace to reference a secret resource.
					name?: string

					// namespace defines the space within which the secret name must be unique.
					namespace?: string
				}

				// Disable the CA check of the server
				insecureSkipVerify?: bool
			}

			// Use Kubernetes Serviceaccount as authentication
			// Requires configuring [auth.jwt] in the instance
			useKubeAuth?: bool
		}

		// Config defines how your grafana ini file should looks like.
		config?: {
			[string]: {
				[string]: string
				...
			}
			...
		}

		// Deployment sets how the deployment object should look like with your grafana
		// instance, contains a number of defaults.
		deployment?: {
			metadata?: {
				annotations?: [string]: string
				labels?: [string]:      string
			}
			spec?: {
				minReadySeconds?:         int32 & int
				paused?:                  bool
				progressDeadlineSeconds?: int32 & int
				replicas?:                int32 & int
				revisionHistoryLimit?:    int32 & int
				selector?: {
					matchExpressions?: [...{
						key!:      string
						operator!: string
						values?: [...string]
					}]
					matchLabels?: [string]: string
				}
				strategy?: {
					rollingUpdate?: {
						maxSurge?: matchN(>=1, [int, string]) & (int | string)
						maxUnavailable?: matchN(>=1, [int, string]) & (int | string)
					}
					type?: string
				}
				template?: {
					metadata?: {
						annotations?: [string]: string
						labels?: [string]:      string
					}
					spec?: {
						activeDeadlineSeconds?: int64 & int
						affinity?: {
							nodeAffinity?: {
								preferredDuringSchedulingIgnoredDuringExecution?: [...{
									preference!: {
										matchExpressions?: [...{
											key!:      string
											operator!: string
											values?: [...string]
										}]
										matchFields?: [...{
											key!:      string
											operator!: string
											values?: [...string]
										}]
									}
									weight!: int32 & int
								}]
								requiredDuringSchedulingIgnoredDuringExecution?: nodeSelectorTerms!: [...{
									matchExpressions?: [...{
										key!:      string
										operator!: string
										values?: [...string]
									}]
									matchFields?: [...{
										key!:      string
										operator!: string
										values?: [...string]
									}]
								}]
							}
							podAffinity?: {
								preferredDuringSchedulingIgnoredDuringExecution?: [...{
									podAffinityTerm!: {
										labelSelector?: {
											matchExpressions?: [...{
												key!:      string
												operator!: string
												values?: [...string]
											}]
											matchLabels?: [string]: string
										}
										matchLabelKeys?: [...string]
										mismatchLabelKeys?: [...string]
										namespaceSelector?: {
											matchExpressions?: [...{
												key!:      string
												operator!: string
												values?: [...string]
											}]
											matchLabels?: [string]: string
										}
										namespaces?: [...string]
										topologyKey!: string
									}
									weight!: int32 & int
								}]
								requiredDuringSchedulingIgnoredDuringExecution?: [...{
									labelSelector?: {
										matchExpressions?: [...{
											key!:      string
											operator!: string
											values?: [...string]
										}]
										matchLabels?: [string]: string
									}
									matchLabelKeys?: [...string]
									mismatchLabelKeys?: [...string]
									namespaceSelector?: {
										matchExpressions?: [...{
											key!:      string
											operator!: string
											values?: [...string]
										}]
										matchLabels?: [string]: string
									}
									namespaces?: [...string]
									topologyKey!: string
								}]
							}
							podAntiAffinity?: {
								preferredDuringSchedulingIgnoredDuringExecution?: [...{
									podAffinityTerm!: {
										labelSelector?: {
											matchExpressions?: [...{
												key!:      string
												operator!: string
												values?: [...string]
											}]
											matchLabels?: [string]: string
										}
										matchLabelKeys?: [...string]
										mismatchLabelKeys?: [...string]
										namespaceSelector?: {
											matchExpressions?: [...{
												key!:      string
												operator!: string
												values?: [...string]
											}]
											matchLabels?: [string]: string
										}
										namespaces?: [...string]
										topologyKey!: string
									}
									weight!: int32 & int
								}]
								requiredDuringSchedulingIgnoredDuringExecution?: [...{
									labelSelector?: {
										matchExpressions?: [...{
											key!:      string
											operator!: string
											values?: [...string]
										}]
										matchLabels?: [string]: string
									}
									matchLabelKeys?: [...string]
									mismatchLabelKeys?: [...string]
									namespaceSelector?: {
										matchExpressions?: [...{
											key!:      string
											operator!: string
											values?: [...string]
										}]
										matchLabels?: [string]: string
									}
									namespaces?: [...string]
									topologyKey!: string
								}]
							}
						}
						automountServiceAccountToken?: bool
						containers?: [...{
							args?: [...string]
							command?: [...string]
							env?: [...{
								name!:  string
								value?: string
								valueFrom?: {
									configMapKeyRef?: {
										key!:      string
										name?:     string
										optional?: bool
									}
									fieldRef?: {
										apiVersion?: string
										fieldPath!:  string
									}
									fileKeyRef?: {
										key!:        string
										optional?:   bool
										path!:       string
										volumeName!: string
									}
									resourceFieldRef?: {
										containerName?: string
										divisor?: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")
										resource!: string
									}
									secretKeyRef?: {
										key!:      string
										name?:     string
										optional?: bool
									}
								}
							}]
							envFrom?: [...{
								configMapRef?: {
									name?:     string
									optional?: bool
								}
								prefix?: string
								secretRef?: {
									name?:     string
									optional?: bool
								}
							}]
							image?:           string
							imagePullPolicy?: string
							lifecycle?: {
								postStart?: {
									exec?: command?: [...string]
									httpGet?: {
										host?: string
										httpHeaders?: [...{
											name!:  string
											value!: string
										}]
										path?: string
										port!: matchN(>=1, [int, string]) & (int | string)
										scheme?: string
									}
									sleep?: seconds!: int64 & int
									tcpSocket?: {
										host?: string
										port!: matchN(>=1, [int, string]) & (int | string)
									}
								}
								preStop?: {
									exec?: command?: [...string]
									httpGet?: {
										host?: string
										httpHeaders?: [...{
											name!:  string
											value!: string
										}]
										path?: string
										port!: matchN(>=1, [int, string]) & (int | string)
										scheme?: string
									}
									sleep?: seconds!: int64 & int
									tcpSocket?: {
										host?: string
										port!: matchN(>=1, [int, string]) & (int | string)
									}
								}
								stopSignal?: string
							}
							livenessProbe?: {
								exec?: command?: [...string]
								failureThreshold?: int32 & int
								grpc?: {
									port!:    int32 & int
									service?: string
								}
								httpGet?: {
									host?: string
									httpHeaders?: [...{
										name!:  string
										value!: string
									}]
									path?: string
									port!: matchN(>=1, [int, string]) & (int | string)
									scheme?: string
								}
								initialDelaySeconds?: int32 & int
								periodSeconds?:       int32 & int
								successThreshold?:    int32 & int
								tcpSocket?: {
									host?: string
									port!: matchN(>=1, [int, string]) & (int | string)
								}
								terminationGracePeriodSeconds?: int64 & int
								timeoutSeconds?:                int32 & int
							}
							name!: string
							ports?: [...{
								containerPort!: int32 & int
								hostIP?:        string
								hostPort?:      int32 & int
								name?:          string
								protocol?:      string
							}]
							readinessProbe?: {
								exec?: command?: [...string]
								failureThreshold?: int32 & int
								grpc?: {
									port!:    int32 & int
									service?: string
								}
								httpGet?: {
									host?: string
									httpHeaders?: [...{
										name!:  string
										value!: string
									}]
									path?: string
									port!: matchN(>=1, [int, string]) & (int | string)
									scheme?: string
								}
								initialDelaySeconds?: int32 & int
								periodSeconds?:       int32 & int
								successThreshold?:    int32 & int
								tcpSocket?: {
									host?: string
									port!: matchN(>=1, [int, string]) & (int | string)
								}
								terminationGracePeriodSeconds?: int64 & int
								timeoutSeconds?:                int32 & int
							}
							resizePolicy?: [...{
								resourceName!:  string
								restartPolicy!: string
							}]
							resources?: {
								claims?: [...{
									name!:    string
									request?: string
								}]
								limits?: [string]: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")
								requests?: [string]: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")
							}
							restartPolicy?: string
							restartPolicyRules?: [...{
								action!: string
								exitCodes?: {
									operator!: string
									values?: [...int32 & int]
								}
							}]
							securityContext?: {
								allowPrivilegeEscalation?: bool
								appArmorProfile?: {
									localhostProfile?: string
									type!:             string
								}
								capabilities?: {
									add?: [...string]
									drop?: [...string]
								}
								privileged?:             bool
								procMount?:              string
								readOnlyRootFilesystem?: bool
								runAsGroup?:             int64 & int
								runAsNonRoot?:           bool
								runAsUser?:              int64 & int
								seLinuxOptions?: {
									level?: string
									role?:  string
									type?:  string
									user?:  string
								}
								seccompProfile?: {
									localhostProfile?: string
									type!:             string
								}
								windowsOptions?: {
									gmsaCredentialSpec?:     string
									gmsaCredentialSpecName?: string
									hostProcess?:            bool
									runAsUserName?:          string
								}
							}
							startupProbe?: {
								exec?: command?: [...string]
								failureThreshold?: int32 & int
								grpc?: {
									port!:    int32 & int
									service?: string
								}
								httpGet?: {
									host?: string
									httpHeaders?: [...{
										name!:  string
										value!: string
									}]
									path?: string
									port!: matchN(>=1, [int, string]) & (int | string)
									scheme?: string
								}
								initialDelaySeconds?: int32 & int
								periodSeconds?:       int32 & int
								successThreshold?:    int32 & int
								tcpSocket?: {
									host?: string
									port!: matchN(>=1, [int, string]) & (int | string)
								}
								terminationGracePeriodSeconds?: int64 & int
								timeoutSeconds?:                int32 & int
							}
							stdin?:                    bool
							stdinOnce?:                bool
							terminationMessagePath?:   string
							terminationMessagePolicy?: string
							tty?:                      bool
							volumeDevices?: [...{
								devicePath!: string
								name!:       string
							}]
							volumeMounts?: [...{
								mountPath!:         string
								mountPropagation?:  string
								name!:              string
								readOnly?:          bool
								recursiveReadOnly?: string
								subPath?:           string
								subPathExpr?:       string
							}]
							workingDir?: string
						}]
						dnsConfig?: {
							nameservers?: [...string]
							options?: [...{
								name?:  string
								value?: string
							}]
							searches?: [...string]
						}
						dnsPolicy?:          string
						enableServiceLinks?: bool
						ephemeralContainers?: [...{
							args?: [...string]
							command?: [...string]
							env?: [...{
								name!:  string
								value?: string
								valueFrom?: {
									configMapKeyRef?: {
										key!:      string
										name?:     string
										optional?: bool
									}
									fieldRef?: {
										apiVersion?: string
										fieldPath!:  string
									}
									fileKeyRef?: {
										key!:        string
										optional?:   bool
										path!:       string
										volumeName!: string
									}
									resourceFieldRef?: {
										containerName?: string
										divisor?: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")
										resource!: string
									}
									secretKeyRef?: {
										key!:      string
										name?:     string
										optional?: bool
									}
								}
							}]
							envFrom?: [...{
								configMapRef?: {
									name?:     string
									optional?: bool
								}
								prefix?: string
								secretRef?: {
									name?:     string
									optional?: bool
								}
							}]
							image?:           string
							imagePullPolicy?: string
							lifecycle?: {
								postStart?: {
									exec?: command?: [...string]
									httpGet?: {
										host?: string
										httpHeaders?: [...{
											name!:  string
											value!: string
										}]
										path?: string
										port!: matchN(>=1, [int, string]) & (int | string)
										scheme?: string
									}
									sleep?: seconds!: int64 & int
									tcpSocket?: {
										host?: string
										port!: matchN(>=1, [int, string]) & (int | string)
									}
								}
								preStop?: {
									exec?: command?: [...string]
									httpGet?: {
										host?: string
										httpHeaders?: [...{
											name!:  string
											value!: string
										}]
										path?: string
										port!: matchN(>=1, [int, string]) & (int | string)
										scheme?: string
									}
									sleep?: seconds!: int64 & int
									tcpSocket?: {
										host?: string
										port!: matchN(>=1, [int, string]) & (int | string)
									}
								}
								stopSignal?: string
							}
							livenessProbe?: {
								exec?: command?: [...string]
								failureThreshold?: int32 & int
								grpc?: {
									port!:    int32 & int
									service?: string
								}
								httpGet?: {
									host?: string
									httpHeaders?: [...{
										name!:  string
										value!: string
									}]
									path?: string
									port!: matchN(>=1, [int, string]) & (int | string)
									scheme?: string
								}
								initialDelaySeconds?: int32 & int
								periodSeconds?:       int32 & int
								successThreshold?:    int32 & int
								tcpSocket?: {
									host?: string
									port!: matchN(>=1, [int, string]) & (int | string)
								}
								terminationGracePeriodSeconds?: int64 & int
								timeoutSeconds?:                int32 & int
							}
							name!: string
							ports?: [...{
								containerPort!: int32 & int
								hostIP?:        string
								hostPort?:      int32 & int
								name?:          string
								protocol?:      string
							}]
							readinessProbe?: {
								exec?: command?: [...string]
								failureThreshold?: int32 & int
								grpc?: {
									port!:    int32 & int
									service?: string
								}
								httpGet?: {
									host?: string
									httpHeaders?: [...{
										name!:  string
										value!: string
									}]
									path?: string
									port!: matchN(>=1, [int, string]) & (int | string)
									scheme?: string
								}
								initialDelaySeconds?: int32 & int
								periodSeconds?:       int32 & int
								successThreshold?:    int32 & int
								tcpSocket?: {
									host?: string
									port!: matchN(>=1, [int, string]) & (int | string)
								}
								terminationGracePeriodSeconds?: int64 & int
								timeoutSeconds?:                int32 & int
							}
							resizePolicy?: [...{
								resourceName!:  string
								restartPolicy!: string
							}]
							resources?: {
								claims?: [...{
									name!:    string
									request?: string
								}]
								limits?: [string]: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")
								requests?: [string]: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")
							}
							restartPolicy?: string
							restartPolicyRules?: [...{
								action!: string
								exitCodes?: {
									operator!: string
									values?: [...int32 & int]
								}
							}]
							securityContext?: {
								allowPrivilegeEscalation?: bool
								appArmorProfile?: {
									localhostProfile?: string
									type!:             string
								}
								capabilities?: {
									add?: [...string]
									drop?: [...string]
								}
								privileged?:             bool
								procMount?:              string
								readOnlyRootFilesystem?: bool
								runAsGroup?:             int64 & int
								runAsNonRoot?:           bool
								runAsUser?:              int64 & int
								seLinuxOptions?: {
									level?: string
									role?:  string
									type?:  string
									user?:  string
								}
								seccompProfile?: {
									localhostProfile?: string
									type!:             string
								}
								windowsOptions?: {
									gmsaCredentialSpec?:     string
									gmsaCredentialSpecName?: string
									hostProcess?:            bool
									runAsUserName?:          string
								}
							}
							startupProbe?: {
								exec?: command?: [...string]
								failureThreshold?: int32 & int
								grpc?: {
									port!:    int32 & int
									service?: string
								}
								httpGet?: {
									host?: string
									httpHeaders?: [...{
										name!:  string
										value!: string
									}]
									path?: string
									port!: matchN(>=1, [int, string]) & (int | string)
									scheme?: string
								}
								initialDelaySeconds?: int32 & int
								periodSeconds?:       int32 & int
								successThreshold?:    int32 & int
								tcpSocket?: {
									host?: string
									port!: matchN(>=1, [int, string]) & (int | string)
								}
								terminationGracePeriodSeconds?: int64 & int
								timeoutSeconds?:                int32 & int
							}
							stdin?:                    bool
							stdinOnce?:                bool
							targetContainerName?:      string
							terminationMessagePath?:   string
							terminationMessagePolicy?: string
							tty?:                      bool
							volumeDevices?: [...{
								devicePath!: string
								name!:       string
							}]
							volumeMounts?: [...{
								mountPath!:         string
								mountPropagation?:  string
								name!:              string
								readOnly?:          bool
								recursiveReadOnly?: string
								subPath?:           string
								subPathExpr?:       string
							}]
							workingDir?: string
						}]
						hostAliases?: [...{
							hostnames?: [...string]
							ip!: string
						}]
						hostIPC?:     bool
						hostNetwork?: bool
						hostPID?:     bool
						hostUsers?:   bool
						hostname?:    string
						imagePullSecrets?: [...{
							name?: string
						}]
						initContainers?: [...{
							args?: [...string]
							command?: [...string]
							env?: [...{
								name!:  string
								value?: string
								valueFrom?: {
									configMapKeyRef?: {
										key!:      string
										name?:     string
										optional?: bool
									}
									fieldRef?: {
										apiVersion?: string
										fieldPath!:  string
									}
									fileKeyRef?: {
										key!:        string
										optional?:   bool
										path!:       string
										volumeName!: string
									}
									resourceFieldRef?: {
										containerName?: string
										divisor?: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")
										resource!: string
									}
									secretKeyRef?: {
										key!:      string
										name?:     string
										optional?: bool
									}
								}
							}]
							envFrom?: [...{
								configMapRef?: {
									name?:     string
									optional?: bool
								}
								prefix?: string
								secretRef?: {
									name?:     string
									optional?: bool
								}
							}]
							image?:           string
							imagePullPolicy?: string
							lifecycle?: {
								postStart?: {
									exec?: command?: [...string]
									httpGet?: {
										host?: string
										httpHeaders?: [...{
											name!:  string
											value!: string
										}]
										path?: string
										port!: matchN(>=1, [int, string]) & (int | string)
										scheme?: string
									}
									sleep?: seconds!: int64 & int
									tcpSocket?: {
										host?: string
										port!: matchN(>=1, [int, string]) & (int | string)
									}
								}
								preStop?: {
									exec?: command?: [...string]
									httpGet?: {
										host?: string
										httpHeaders?: [...{
											name!:  string
											value!: string
										}]
										path?: string
										port!: matchN(>=1, [int, string]) & (int | string)
										scheme?: string
									}
									sleep?: seconds!: int64 & int
									tcpSocket?: {
										host?: string
										port!: matchN(>=1, [int, string]) & (int | string)
									}
								}
								stopSignal?: string
							}
							livenessProbe?: {
								exec?: command?: [...string]
								failureThreshold?: int32 & int
								grpc?: {
									port!:    int32 & int
									service?: string
								}
								httpGet?: {
									host?: string
									httpHeaders?: [...{
										name!:  string
										value!: string
									}]
									path?: string
									port!: matchN(>=1, [int, string]) & (int | string)
									scheme?: string
								}
								initialDelaySeconds?: int32 & int
								periodSeconds?:       int32 & int
								successThreshold?:    int32 & int
								tcpSocket?: {
									host?: string
									port!: matchN(>=1, [int, string]) & (int | string)
								}
								terminationGracePeriodSeconds?: int64 & int
								timeoutSeconds?:                int32 & int
							}
							name!: string
							ports?: [...{
								containerPort!: int32 & int
								hostIP?:        string
								hostPort?:      int32 & int
								name?:          string
								protocol?:      string
							}]
							readinessProbe?: {
								exec?: command?: [...string]
								failureThreshold?: int32 & int
								grpc?: {
									port!:    int32 & int
									service?: string
								}
								httpGet?: {
									host?: string
									httpHeaders?: [...{
										name!:  string
										value!: string
									}]
									path?: string
									port!: matchN(>=1, [int, string]) & (int | string)
									scheme?: string
								}
								initialDelaySeconds?: int32 & int
								periodSeconds?:       int32 & int
								successThreshold?:    int32 & int
								tcpSocket?: {
									host?: string
									port!: matchN(>=1, [int, string]) & (int | string)
								}
								terminationGracePeriodSeconds?: int64 & int
								timeoutSeconds?:                int32 & int
							}
							resizePolicy?: [...{
								resourceName!:  string
								restartPolicy!: string
							}]
							resources?: {
								claims?: [...{
									name!:    string
									request?: string
								}]
								limits?: [string]: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")
								requests?: [string]: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")
							}
							restartPolicy?: string
							restartPolicyRules?: [...{
								action!: string
								exitCodes?: {
									operator!: string
									values?: [...int32 & int]
								}
							}]
							securityContext?: {
								allowPrivilegeEscalation?: bool
								appArmorProfile?: {
									localhostProfile?: string
									type!:             string
								}
								capabilities?: {
									add?: [...string]
									drop?: [...string]
								}
								privileged?:             bool
								procMount?:              string
								readOnlyRootFilesystem?: bool
								runAsGroup?:             int64 & int
								runAsNonRoot?:           bool
								runAsUser?:              int64 & int
								seLinuxOptions?: {
									level?: string
									role?:  string
									type?:  string
									user?:  string
								}
								seccompProfile?: {
									localhostProfile?: string
									type!:             string
								}
								windowsOptions?: {
									gmsaCredentialSpec?:     string
									gmsaCredentialSpecName?: string
									hostProcess?:            bool
									runAsUserName?:          string
								}
							}
							startupProbe?: {
								exec?: command?: [...string]
								failureThreshold?: int32 & int
								grpc?: {
									port!:    int32 & int
									service?: string
								}
								httpGet?: {
									host?: string
									httpHeaders?: [...{
										name!:  string
										value!: string
									}]
									path?: string
									port!: matchN(>=1, [int, string]) & (int | string)
									scheme?: string
								}
								initialDelaySeconds?: int32 & int
								periodSeconds?:       int32 & int
								successThreshold?:    int32 & int
								tcpSocket?: {
									host?: string
									port!: matchN(>=1, [int, string]) & (int | string)
								}
								terminationGracePeriodSeconds?: int64 & int
								timeoutSeconds?:                int32 & int
							}
							stdin?:                    bool
							stdinOnce?:                bool
							terminationMessagePath?:   string
							terminationMessagePolicy?: string
							tty?:                      bool
							volumeDevices?: [...{
								devicePath!: string
								name!:       string
							}]
							volumeMounts?: [...{
								mountPath!:         string
								mountPropagation?:  string
								name!:              string
								readOnly?:          bool
								recursiveReadOnly?: string
								subPath?:           string
								subPathExpr?:       string
							}]
							workingDir?: string
						}]
						nodeName?: string
						nodeSelector?: [string]: string
						os?: name!:              string
						overhead?: [string]: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")
						preemptionPolicy?:  string
						priority?:          int32 & int
						priorityClassName?: string
						readinessGates?: [...{
							conditionType!: string
						}]
						restartPolicy?:    string
						runtimeClassName?: string
						schedulerName?:    string
						securityContext?: {
							appArmorProfile?: {
								localhostProfile?: string
								type!:             string
							}
							fsGroup?:             int64 & int
							fsGroupChangePolicy?: string
							runAsGroup?:          int64 & int
							runAsNonRoot?:        bool
							runAsUser?:           int64 & int
							seLinuxChangePolicy?: string
							seLinuxOptions?: {
								level?: string
								role?:  string
								type?:  string
								user?:  string
							}
							seccompProfile?: {
								localhostProfile?: string
								type!:             string
							}
							supplementalGroups?: [...int64 & int]
							supplementalGroupsPolicy?: string
							sysctls?: [...{
								name!:  string
								value!: string
							}]
							windowsOptions?: {
								gmsaCredentialSpec?:     string
								gmsaCredentialSpecName?: string
								hostProcess?:            bool
								runAsUserName?:          string
							}
						}
						serviceAccount?:                string
						serviceAccountName?:            string
						setHostnameAsFQDN?:             bool
						shareProcessNamespace?:         bool
						subdomain?:                     string
						terminationGracePeriodSeconds?: int64 & int
						tolerations?: [...{
							effect?:            string
							key?:               string
							operator?:          string
							tolerationSeconds?: int64 & int
							value?:             string
						}]
						topologySpreadConstraints?: [...{
							labelSelector?: {
								matchExpressions?: [...{
									key!:      string
									operator!: string
									values?: [...string]
								}]
								matchLabels?: [string]: string
							}
							matchLabelKeys?: [...string]
							maxSkew!:            int32 & int
							minDomains?:         int32 & int
							nodeAffinityPolicy?: string
							nodeTaintsPolicy?:   string
							topologyKey!:        string
							whenUnsatisfiable!:  string
						}]
						volumes?: [...{
							awsElasticBlockStore?: {
								fsType?:    string
								partition?: int32 & int
								readOnly?:  bool
								volumeID!:  string
							}
							azureDisk?: {
								cachingMode?: string
								diskName!:    string
								diskURI!:     string
								fsType?:      string
								kind?:        string
								readOnly?:    bool
							}
							azureFile?: {
								readOnly?:   bool
								secretName!: string
								shareName!:  string
							}
							cephfs?: {
								monitors!: [...string]
								path?:       string
								readOnly?:   bool
								secretFile?: string
								secretRef?: name?: string
								user?: string
							}
							cinder?: {
								fsType?:   string
								readOnly?: bool
								secretRef?: name?: string
								volumeID!: string
							}
							configMap?: {
								defaultMode?: int32 & int
								items?: [...{
									key!:  string
									mode?: int32 & int
									path!: string
								}]
								name?:     string
								optional?: bool
							}
							csi?: {
								driver!: string
								fsType?: string
								nodePublishSecretRef?: name?: string
								readOnly?: bool
								volumeAttributes?: [string]: string
							}
							downwardAPI?: {
								defaultMode?: int32 & int
								items?: [...{
									fieldRef?: {
										apiVersion?: string
										fieldPath!:  string
									}
									mode?: int32 & int
									path!: string
									resourceFieldRef?: {
										containerName?: string
										divisor?: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")
										resource!: string
									}
								}]
							}
							emptyDir?: {
								medium?: string
								sizeLimit?: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")
							}
							ephemeral?: volumeClaimTemplate?: {
								metadata?: {}
								spec!: {
									accessModes?: [...string]
									dataSource?: {
										apiGroup?: string
										kind!:     string
										name!:     string
									}
									dataSourceRef?: {
										apiGroup?:  string
										kind!:      string
										name!:      string
										namespace?: string
									}
									resources?: {
										limits?: [string]: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")
										requests?: [string]: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")
									}
									selector?: {
										matchExpressions?: [...{
											key!:      string
											operator!: string
											values?: [...string]
										}]
										matchLabels?: [string]: string
									}
									storageClassName?:          string
									volumeAttributesClassName?: string
									volumeMode?:                string
									volumeName?:                string
								}
							}
							fc?: {
								fsType?:   string
								lun?:      int32 & int
								readOnly?: bool
								targetWWNs?: [...string]
								wwids?: [...string]
							}
							flexVolume?: {
								driver!: string
								fsType?: string
								options?: [string]: string
								readOnly?: bool
								secretRef?: name?: string
							}
							flocker?: {
								datasetName?: string
								datasetUUID?: string
							}
							gcePersistentDisk?: {
								fsType?:    string
								partition?: int32 & int
								pdName!:    string
								readOnly?:  bool
							}
							gitRepo?: {
								directory?:  string
								repository!: string
								revision?:   string
							}
							glusterfs?: {
								endpoints!: string
								path!:      string
								readOnly?:  bool
							}
							hostPath?: {
								path!: string
								type?: string
							}
							image?: {
								pullPolicy?: string
								reference?:  string
							}
							iscsi?: {
								chapAuthDiscovery?: bool
								chapAuthSession?:   bool
								fsType?:            string
								initiatorName?:     string
								iqn!:               string
								iscsiInterface?:    string
								lun!:               int32 & int
								portals?: [...string]
								readOnly?: bool
								secretRef?: name?: string
								targetPortal!: string
							}
							name!: string
							nfs?: {
								path!:     string
								readOnly?: bool
								server!:   string
							}
							persistentVolumeClaim?: {
								claimName!: string
								readOnly?:  bool
							}
							photonPersistentDisk?: {
								fsType?: string
								pdID!:   string
							}
							portworxVolume?: {
								fsType?:   string
								readOnly?: bool
								volumeID!: string
							}
							projected?: {
								defaultMode?: int32 & int
								sources?: [...{
									clusterTrustBundle?: {
										labelSelector?: {
											matchExpressions?: [...{
												key!:      string
												operator!: string
												values?: [...string]
											}]
											matchLabels?: [string]: string
										}
										name?:       string
										optional?:   bool
										path!:       string
										signerName?: string
									}
									configMap?: {
										items?: [...{
											key!:  string
											mode?: int32 & int
											path!: string
										}]
										name?:     string
										optional?: bool
									}
									downwardAPI?: items?: [...{
										fieldRef?: {
											apiVersion?: string
											fieldPath!:  string
										}
										mode?: int32 & int
										path!: string
										resourceFieldRef?: {
											containerName?: string
											divisor?: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")
											resource!: string
										}
									}]
									podCertificate?: {
										certificateChainPath?: string
										credentialBundlePath?: string
										keyPath?:              string
										keyType!:              string
										maxExpirationSeconds?: int32 & int
										signerName!:           string
										userAnnotations?: [string]: string
									}
									secret?: {
										items?: [...{
											key!:  string
											mode?: int32 & int
											path!: string
										}]
										name?:     string
										optional?: bool
									}
									serviceAccountToken?: {
										audience?:          string
										expirationSeconds?: int64 & int
										path!:              string
									}
								}]
							}
							quobyte?: {
								group?:    string
								readOnly?: bool
								registry!: string
								tenant?:   string
								user?:     string
								volume!:   string
							}
							rbd?: {
								fsType?:  string
								image!:   string
								keyring?: string
								monitors!: [...string]
								pool?:     string
								readOnly?: bool
								secretRef?: name?: string
								user?: string
							}
							scaleIO?: {
								fsType?:           string
								gateway!:          string
								protectionDomain?: string
								readOnly?:         bool
								secretRef!: name?: string
								sslEnabled?:  bool
								storageMode?: string
								storagePool?: string
								system!:      string
								volumeName?:  string
							}
							secret?: {
								defaultMode?: int32 & int
								items?: [...{
									key!:  string
									mode?: int32 & int
									path!: string
								}]
								optional?:   bool
								secretName?: string
							}
							storageos?: {
								fsType?:   string
								readOnly?: bool
								secretRef?: name?: string
								volumeName?:      string
								volumeNamespace?: string
							}
							vsphereVolume?: {
								fsType?:            string
								storagePolicyID?:   string
								storagePolicyName?: string
								volumePath!:        string
							}
						}]
					}
				}
			}
		}

		// DisableDefaultAdminSecret prevents operator from creating default admin-credentials secret
		disableDefaultAdminSecret?: bool

		// DisableDefaultSecurityContext prevents the operator from populating
		// securityContext on deployments
		disableDefaultSecurityContext?: "Pod" | "Container" | "All"

		// External enables you to configure external grafana instances that is not managed by the operator.
		external?: {
			// AdminPassword key to talk to the external grafana instance.
			adminPassword?: {
				// The key of the secret to select from. Must be a valid secret key.
				key!: string

				// Name of the referent.
				// This field is effectively required, but due to backwards compatibility is
				// allowed to be empty. Instances of this type with an empty value here are
				// almost certainly wrong.
				// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
				name?: string

				// Specify whether the Secret or its key must be defined
				optional?: bool
			}

			// AdminUser key to talk to the external grafana instance.
			adminUser?: {
				// The key of the secret to select from. Must be a valid secret key.
				key!: string

				// Name of the referent.
				// This field is effectively required, but due to backwards compatibility is
				// allowed to be empty. Instances of this type with an empty value here are
				// almost certainly wrong.
				// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
				name?: string

				// Specify whether the Secret or its key must be defined
				optional?: bool
			}

			// The API key to talk to the external grafana instance, you need to define
			// ether apiKey or adminUser/adminPassword.
			apiKey?: {
				// The key of the secret to select from. Must be a valid secret key.
				key!: string

				// Name of the referent.
				// This field is effectively required, but due to backwards compatibility is
				// allowed to be empty. Instances of this type with an empty value here are
				// almost certainly wrong.
				// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
				name?: string

				// Specify whether the Secret or its key must be defined
				optional?: bool
			}

			// TenantNamespace is used as the `namespace` value for GrafanaManifest
			// resources in multi-tenant scenarios
			// defaults to `default`
			tenantNamespace?: string

			// DEPRECATED, use top level `tls` instead.
			tls?: {
				// Use a secret as a reference to give TLS Certificate information
				certSecretRef?: {
					// name is unique within a namespace to reference a secret resource.
					name?: string

					// namespace defines the space within which the secret name must be unique.
					namespace?: string
				}

				// Disable the CA check of the server
				insecureSkipVerify?: bool
			}

			// URL of the external grafana instance you want to manage.
			url!: =~"^https?://.+$"
		}

		// HTTPRoute customizes the GatewayAPI HTTPRoute Object. It will not be created if this is not set
		httpRoute?: {
			// ObjectMeta contains only a [subset of the fields included in
			// k8s.io/apimachinery/pkg/apis/meta/v1.ObjectMeta](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.27/#objectmeta-v1-meta).
			metadata?: {
				annotations?: [string]: string
				labels?: [string]:      string
			}

			// HTTPRouteSpec defines the desired state of HTTPRoute
			spec?: {
				// Hostnames defines a set of hostnames that should match against the HTTP Host
				// header to select a HTTPRoute used to process the request. Implementations
				// MUST ignore any port value specified in the HTTP Host header while
				// performing a match and (absent of any applicable header modification
				// configuration) MUST forward this header unmodified to the backend.
				//
				// Valid values for Hostnames are determined by RFC 1123 definition of a
				// hostname with 2 notable exceptions:
				//
				// 1. IPs are not allowed.
				// 2. A hostname may be prefixed with a wildcard label (`*.`). The wildcard
				// label must appear by itself as the first label.
				//
				// If a hostname is specified by both the Listener and HTTPRoute, there
				// must be at least one intersecting hostname for the HTTPRoute to be
				// attached to the Listener. For example:
				//
				// * A Listener with `test.example.com` as the hostname matches HTTPRoutes
				// that have either not specified any hostnames, or have specified at
				// least one of `test.example.com` or `*.example.com`.
				// * A Listener with `*.example.com` as the hostname matches HTTPRoutes
				// that have either not specified any hostnames or have specified at least
				// one hostname that matches the Listener hostname. For example,
				// `*.example.com`, `test.example.com`, and `foo.test.example.com` would
				// all match. On the other hand, `example.com` and `test.example.net` would
				// not match.
				//
				// Hostnames that are prefixed with a wildcard label (`*.`) are interpreted
				// as a suffix match. That means that a match for `*.example.com` would match
				// both `test.example.com`, and `foo.test.example.com`, but not `example.com`.
				//
				// If both the Listener and HTTPRoute have specified hostnames, any
				// HTTPRoute hostnames that do not match the Listener hostname MUST be
				// ignored. For example, if a Listener specified `*.example.com`, and the
				// HTTPRoute specified `test.example.com` and `test.example.net`,
				// `test.example.net` must not be considered for a match.
				//
				// If both the Listener and HTTPRoute have specified hostnames, and none
				// match with the criteria above, then the HTTPRoute is not accepted. The
				// implementation must raise an 'Accepted' Condition with a status of
				// `False` in the corresponding RouteParentStatus.
				//
				// In the event that multiple HTTPRoutes specify intersecting hostnames (e.g.
				// overlapping wildcard matching and exact matching hostnames), precedence must
				// be given to rules from the HTTPRoute with the largest number of:
				//
				// * Characters in a matching non-wildcard hostname.
				// * Characters in a matching hostname.
				//
				// If ties exist across multiple Routes, the matching precedence rules for
				// HTTPRouteMatches takes over.
				//
				// Support: Core
				hostnames?: list.MaxItems(16) & [...strings.MaxRunes(
					253) & strings.MinRunes(
					1) & =~"^(\\*\\.)?[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"]

				// ParentRefs references the resources (usually Gateways) that a Route wants
				// to be attached to. Note that the referenced parent resource needs to
				// allow this for the attachment to be complete. For Gateways, that means
				// the Gateway needs to allow attachment from Routes of this kind and
				// namespace. For Services, that means the Service must either be in the same
				// namespace for a "producer" route, or the mesh implementation must support
				// and allow "consumer" routes for the referenced Service. ReferenceGrant is
				// not applicable for governing ParentRefs to Services - it is not possible to
				// create a "producer" route for a Service in a different namespace from the
				// Route.
				//
				// There are two kinds of parent resources with "Core" support:
				//
				// * Gateway (Gateway conformance profile)
				// * Service (Mesh conformance profile, ClusterIP Services only)
				//
				// This API may be extended in the future to support additional kinds of parent
				// resources.
				//
				// ParentRefs must be _distinct_. This means either that:
				//
				// * They select different objects. If this is the case, then parentRef
				// entries are distinct. In terms of fields, this means that the
				// multi-part key defined by `group`, `kind`, `namespace`, and `name` must
				// be unique across all parentRef entries in the Route.
				// * They do not select different objects, but for each optional field used,
				// each ParentRef that selects the same object must set the same set of
				// optional fields to different values. If one ParentRef sets a
				// combination of optional fields, all must set the same combination.
				//
				// Some examples:
				//
				// * If one ParentRef sets `sectionName`, all ParentRefs referencing the
				// same object must also set `sectionName`.
				// * If one ParentRef sets `port`, all ParentRefs referencing the same
				// object must also set `port`.
				// * If one ParentRef sets `sectionName` and `port`, all ParentRefs
				// referencing the same object must also set `sectionName` and `port`.
				//
				// It is possible to separately reference multiple distinct objects that may
				// be collapsed by an implementation. For example, some implementations may
				// choose to merge compatible Gateway Listeners together. If that is the
				// case, the list of routes attached to those resources should also be
				// merged.
				//
				// Note that for ParentRefs that cross namespace boundaries, there are specific
				// rules. Cross-namespace references are only valid if they are explicitly
				// allowed by something in the namespace they are referring to. For example,
				// Gateway has the AllowedRoutes field, and ReferenceGrant provides a
				// generic way to enable other kinds of cross-namespace reference.
				//
				// <gateway:experimental:description>
				// ParentRefs from a Route to a Service in the same namespace are "producer"
				// routes, which apply default routing rules to inbound connections from
				// any namespace to the Service.
				//
				// ParentRefs from a Route to a Service in a different namespace are
				// "consumer" routes, and these routing rules are only applied to outbound
				// connections originating from the same namespace as the Route, for which
				// the intended destination of the connections are a Service targeted as a
				// ParentRef of the Route.
				// </gateway:experimental:description>
				// <gateway:standard:validation:XValidation:message="sectionName must be
				// specified when parentRefs includes 2 or more references to the same
				// parent",rule="self.all(p1, self.all(p2, p1.group == p2.group && p1.kind ==
				// p2.kind && p1.name == p2.name && (((!has(p1.__namespace__) ||
				// p1.__namespace__ == '') && (!has(p2.__namespace__) || p2.__namespace__ ==
				// '')) || (has(p1.__namespace__) && has(p2.__namespace__) && p1.__namespace__
				// == p2.__namespace__ )) ? ((!has(p1.sectionName) || p1.sectionName == '') ==
				// (!has(p2.sectionName) || p2.sectionName == '')) : true))">
				// <gateway:standard:validation:XValidation:message="sectionName must be unique
				// when parentRefs includes 2 or more references to the same
				// parent",rule="self.all(p1, self.exists_one(p2, p1.group == p2.group &&
				// p1.kind == p2.kind && p1.name == p2.name && (((!has(p1.__namespace__) ||
				// p1.__namespace__ == '') && (!has(p2.__namespace__) || p2.__namespace__ ==
				// '')) || (has(p1.__namespace__) && has(p2.__namespace__) && p1.__namespace__
				// == p2.__namespace__ )) && (((!has(p1.sectionName) || p1.sectionName == '')
				// && (!has(p2.sectionName) || p2.sectionName == '')) || (has(p1.sectionName)
				// && has(p2.sectionName) && p1.sectionName == p2.sectionName))))">
				// <gateway:experimental:validation:XValidation:message="sectionName or port
				// must be specified when parentRefs includes 2 or more references to the same
				// parent",rule="self.all(p1, self.all(p2, p1.group == p2.group && p1.kind ==
				// p2.kind && p1.name == p2.name && (((!has(p1.__namespace__) ||
				// p1.__namespace__ == '') && (!has(p2.__namespace__) || p2.__namespace__ ==
				// '')) || (has(p1.__namespace__) && has(p2.__namespace__) && p1.__namespace__
				// == p2.__namespace__)) ? ((!has(p1.sectionName) || p1.sectionName == '') ==
				// (!has(p2.sectionName) || p2.sectionName == '') && (!has(p1.port) || p1.port
				// == 0) == (!has(p2.port) || p2.port == 0)): true))">
				// <gateway:experimental:validation:XValidation:message="sectionName or port
				// must be unique when parentRefs includes 2 or more references to the same
				// parent",rule="self.all(p1, self.exists_one(p2, p1.group == p2.group &&
				// p1.kind == p2.kind && p1.name == p2.name && (((!has(p1.__namespace__) ||
				// p1.__namespace__ == '') && (!has(p2.__namespace__) || p2.__namespace__ ==
				// '')) || (has(p1.__namespace__) && has(p2.__namespace__) && p1.__namespace__
				// == p2.__namespace__ )) && (((!has(p1.sectionName) || p1.sectionName == '')
				// && (!has(p2.sectionName) || p2.sectionName == '')) || ( has(p1.sectionName)
				// && has(p2.sectionName) && p1.sectionName == p2.sectionName)) &&
				// (((!has(p1.port) || p1.port == 0) && (!has(p2.port) || p2.port == 0)) ||
				// (has(p1.port) && has(p2.port) && p1.port == p2.port))))">
				parentRefs?: list.MaxItems(32) & [...{
					// Group is the group of the referent.
					// When unspecified, "gateway.networking.k8s.io" is inferred.
					// To set the core API group (such as for a "Service" kind referent),
					// Group must be explicitly set to "" (empty string).
					//
					// Support: Core
					group?: strings.MaxRunes(
						253) & =~"^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

					// Kind is kind of the referent.
					//
					// There are two kinds of parent resources with "Core" support:
					//
					// * Gateway (Gateway conformance profile)
					// * Service (Mesh conformance profile, ClusterIP Services only)
					//
					// Support for other resources is Implementation-Specific.
					kind?: strings.MaxRunes(
						63) & strings.MinRunes(
						1) & =~"^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"

					// Name is the name of the referent.
					//
					// Support: Core
					name!: strings.MaxRunes(
						253) & strings.MinRunes(
						1)

					// Namespace is the namespace of the referent. When unspecified, this refers
					// to the local namespace of the Route.
					//
					// Note that there are specific rules for ParentRefs which cross namespace
					// boundaries. Cross-namespace references are only valid if they are explicitly
					// allowed by something in the namespace they are referring to. For example:
					// Gateway has the AllowedRoutes field, and ReferenceGrant provides a
					// generic way to enable any other kind of cross-namespace reference.
					//
					// <gateway:experimental:description>
					// ParentRefs from a Route to a Service in the same namespace are "producer"
					// routes, which apply default routing rules to inbound connections from
					// any namespace to the Service.
					//
					// ParentRefs from a Route to a Service in a different namespace are
					// "consumer" routes, and these routing rules are only applied to outbound
					// connections originating from the same namespace as the Route, for which
					// the intended destination of the connections are a Service targeted as a
					// ParentRef of the Route.
					// </gateway:experimental:description>
					//
					// Support: Core
					namespace?: strings.MaxRunes(
							63) & strings.MinRunes(
							1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"

					// Port is the network port this Route targets. It can be interpreted
					// differently based on the type of parent resource.
					//
					// When the parent resource is a Gateway, this targets all listeners
					// listening on the specified port that also support this kind of Route(and
					// select this Route). It's not recommended to set `Port` unless the
					// networking behaviors specified in a Route must apply to a specific port
					// as opposed to a listener(s) whose port(s) may be changed. When both Port
					// and SectionName are specified, the name and port of the selected listener
					// must match both specified values.
					//
					// <gateway:experimental:description>
					// When the parent resource is a Service, this targets a specific port in the
					// Service spec. When both Port (experimental) and SectionName are specified,
					// the name and port of the selected port must match both specified values.
					// </gateway:experimental:description>
					//
					// Implementations MAY choose to support other parent resources.
					// Implementations supporting other types of parent resources MUST clearly
					// document how/if Port is interpreted.
					//
					// For the purpose of status, an attachment is considered successful as
					// long as the parent resource accepts it partially. For example, Gateway
					// listeners can restrict which Routes can attach to them by Route kind,
					// namespace, or hostname. If 1 of 2 Gateway listeners accept attachment
					// from the referencing Route, the Route MUST be considered successfully
					// attached. If no Gateway listeners accept attachment from this Route,
					// the Route MUST be considered detached from the Gateway.
					//
					// Support: Extended
					port?: int32 & int & <=65535 & >=1

					// SectionName is the name of a section within the target resource. In the
					// following resources, SectionName is interpreted as the following:
					//
					// * Gateway: Listener name. When both Port (experimental) and SectionName
					// are specified, the name and port of the selected listener must match
					// both specified values.
					// * Service: Port name. When both Port (experimental) and SectionName
					// are specified, the name and port of the selected listener must match
					// both specified values.
					//
					// Implementations MAY choose to support attaching Routes to other resources.
					// If that is the case, they MUST clearly document how SectionName is
					// interpreted.
					//
					// When unspecified (empty string), this will reference the entire resource.
					// For the purpose of status, an attachment is considered successful if at
					// least one section in the parent resource accepts it. For example, Gateway
					// listeners can restrict which Routes can attach to them by Route kind,
					// namespace, or hostname. If 1 of 2 Gateway listeners accept attachment from
					// the referencing Route, the Route MUST be considered successfully
					// attached. If no Gateway listeners accept attachment from this Route, the
					// Route MUST be considered detached from the Gateway.
					//
					// Support: Core
					sectionName?: strings.MaxRunes(
							253) & strings.MinRunes(
							1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
				}]

				// Rules are a list of HTTP matchers, filters and actions.
				//
				// <gateway:experimental:validation:XValidation:message="Rule name must be
				// unique within the route",rule="self.all(l1, !has(l1.name) ||
				// self.exists_one(l2, has(l2.name) && l1.name == l2.name))">
				rules?: list.MaxItems(16) & [...{
					// BackendRefs defines the backend(s) where matching requests should be
					// sent.
					//
					// Failure behavior here depends on how many BackendRefs are specified and
					// how many are invalid.
					//
					// If *all* entries in BackendRefs are invalid, and there are also no filters
					// specified in this route rule, *all* traffic which matches this rule MUST
					// receive a 500 status code.
					//
					// See the HTTPBackendRef definition for the rules about what makes a single
					// HTTPBackendRef invalid.
					//
					// When a HTTPBackendRef is invalid, 500 status codes MUST be returned for
					// requests that would have otherwise been routed to an invalid backend. If
					// multiple backends are specified, and some are invalid, the proportion of
					// requests that would otherwise have been routed to an invalid backend
					// MUST receive a 500 status code.
					//
					// For example, if two backends are specified with equal weights, and one is
					// invalid, 50 percent of traffic must receive a 500. Implementations may
					// choose how that 50 percent is determined.
					//
					// When a HTTPBackendRef refers to a Service that has no ready endpoints,
					// implementations SHOULD return a 503 for requests to that backend instead.
					// If an implementation chooses to do this, all of the above rules for 500 responses
					// MUST also apply for responses that return a 503.
					//
					// Support: Core for Kubernetes Service
					//
					// Support: Extended for Kubernetes ServiceImport
					//
					// Support: Implementation-specific for any other resource
					//
					// Support for weight: Core
					backendRefs?: list.MaxItems(16) & [...{
						// Filters defined at this level should be executed if and only if the
						// request is being forwarded to the backend defined here.
						//
						// Support: Implementation-specific (For broader support of filters, use the
						// Filters field in HTTPRouteRule.)
						filters?: list.MaxItems(16) & [...{
							// CORS defines a schema for a filter that responds to the
							// cross-origin request based on HTTP response header.
							//
							// Support: Extended
							cors?: {
								// AllowCredentials indicates whether the actual cross-origin request allows
								// to include credentials.
								//
								// When set to true, the gateway will include the `Access-Control-Allow-Credentials`
								// response header with value true (case-sensitive).
								//
								// When set to false or omitted the gateway will omit the header
								// `Access-Control-Allow-Credentials` entirely (this is the standard CORS
								// behavior).
								//
								// Support: Extended
								allowCredentials?: bool

								// AllowHeaders indicates which HTTP request headers are supported for
								// accessing the requested resource.
								//
								// Header names are not case-sensitive.
								//
								// Multiple header names in the value of the `Access-Control-Allow-Headers`
								// response header are separated by a comma (",").
								//
								// When the `allowHeaders` field is configured with one or more headers, the
								// gateway must return the `Access-Control-Allow-Headers` response header
								// which value is present in the `allowHeaders` field.
								//
								// If any header name in the `Access-Control-Request-Headers` request header
								// is not included in the list of header names specified by the response
								// header `Access-Control-Allow-Headers`, it will present an error on the
								// client side.
								//
								// If any header name in the `Access-Control-Allow-Headers` response header
								// does not recognize by the client, it will also occur an error on the
								// client side.
								//
								// A wildcard indicates that the requests with all HTTP headers are allowed.
								//
								// If the configuration contains the wildcard `*` in `allowHeaders` and
								// `allowCredentials` is set to `false`, the `Access-Control-Allow-Headers`
								// response header may either contain the wildcard `*` or echo the value
								// of the `Access-Control-Request-Headers` request header.
								//
								// If the configuration contains the wildcard `*` in `allowHeaders` and
								// `allowCredentials` is set to `true`, the gateway must not return `*`
								// in the `Access-Control-Allow-Headers` response header. Instead, it must
								// return one or more header names matching the value of the
								// `Access-Control-Request-Headers` request header.
								// If the `Access-Control-Request-Headers` header is not present in the
								// request, the gateway must omit the `Access-Control-Allow-Headers`
								// response header.
								//
								// Support: Extended
								allowHeaders?: list.MaxItems(64) & [...strings.MaxRunes(
									256) & strings.MinRunes(
									1) & =~"^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"]

								// AllowMethods indicates which HTTP methods are supported for accessing the
								// requested resource.
								//
								// Valid values are any method defined by RFC9110, along with the special
								// value `*`, which represents all HTTP methods are allowed.
								//
								// Method names are case-sensitive, so these values are also case-sensitive.
								// (See https://www.rfc-editor.org/rfc/rfc2616#section-5.1.1)
								//
								// Multiple method names in the value of the `Access-Control-Allow-Methods`
								// response header are separated by a comma (",").
								//
								// A CORS-safelisted method is a method that is `GET`, `HEAD`, or `POST`.
								// (See https://fetch.spec.whatwg.org/#cors-safelisted-method) The
								// CORS-safelisted methods are always allowed, regardless of whether they
								// are specified in the `allowMethods` field.
								//
								// When the `allowMethods` field is configured with one or more methods, the
								// gateway must return the `Access-Control-Allow-Methods` response header
								// which value is present in the `allowMethods` field.
								//
								// If the HTTP method of the `Access-Control-Request-Method` request header
								// is not included in the list of methods specified by the response header
								// `Access-Control-Allow-Methods`, it will present an error on the client
								// side.
								//
								// If the configuration contains the wildcard `*` in `allowMethods` and
								// `allowCredentials` is set to `false`, the `Access-Control-Allow-Methods`
								// response header may either contain the wildcard `*` or echo the value
								// of the `Access-Control-Request-Method` request header.
								//
								// If the configuration contains the wildcard `*` in `allowMethods` and
								// `allowCredentials` is set to `true`, the gateway must not return `*`
								// in the `Access-Control-Allow-Methods` response header. Instead, it must
								// return a single HTTP method matching the value of the
								// `Access-Control-Request-Method` request header.
								// If the `Access-Control-Request-Method` header is not present in the request,
								// the gateway must omit the `Access-Control-Allow-Methods` response header.
								//
								// Support: Extended
								allowMethods?: list.MaxItems(9) & [..."GET" | "HEAD" | "POST" | "PUT" | "DELETE" | "CONNECT" | "OPTIONS" | "TRACE" | "PATCH" | "*"]

								// AllowOrigins indicates whether the response can be shared with requested
								// resource from the given `Origin`.
								//
								// The `Origin` consists of a scheme and a host, with an optional port, and
								// takes the form `<scheme>://<host>(:<port>)`.
								//
								// Valid values for scheme are: `http` and `https`.
								//
								// Valid values for port are any integer between 1 and 65535 (the list of
								// available TCP/UDP ports). Note that, if not included, port `80` is
								// assumed for `http` scheme origins, and port `443` is assumed for `https`
								// origins. This may affect origin matching.
								//
								// The host part of the origin may contain the wildcard character `*`. These
								// wildcard characters behave as follows:
								//
								// * `*` is a greedy match to the _left_, including any number of
								// DNS labels to the left of its position. This also means that
								// `*` will include any number of period `.` characters to the
								// left of its position.
								// * A wildcard by itself matches all hosts.
								//
								// An origin value that includes _only_ the `*` character indicates requests
								// from all `Origin`s are allowed.
								//
								// When the `allowOrigins` field is configured with multiple origins, it
								// means the server supports clients from multiple origins. If the request
								// `Origin` matches the configured allowed origins, the gateway must return
								// the given `Origin` and sets value of the header
								// `Access-Control-Allow-Origin` same as the `Origin` header provided by the
								// client.
								//
								// The status code of a successful response to a "preflight" request is
								// always an OK status (i.e., 204 or 200).
								//
								// If the request `Origin` does not match the configured allowed origins,
								// the gateway returns 204/200 response but doesn't set the relevant
								// cross-origin response headers. Alternatively, the gateway responds with
								// 403 status to the "preflight" request is denied, coupled with omitting
								// the CORS headers. The cross-origin request fails on the client side.
								// Therefore, the client doesn't attempt the actual cross-origin request.
								//
								// Conversely, if the request `Origin` matches one of the configured
								// allowed origins, the gateway sets the response header
								// `Access-Control-Allow-Origin` to the same value as the `Origin`
								// header provided by the client.
								//
								// If the configuration contains the wildcard `*` in `allowOrigins` and
								// `allowCredentials` is set to `false`, the `Access-Control-Allow-Origin`
								// response header may either contain the wildcard `*` or echo the value
								// of the `Origin` request header.
								//
								// If the configuration contains the wildcard `*` in `allowOrigins` and
								// `allowCredentials` is set to `true`, the gateway must not return `*`
								// in the `Access-Control-Allow-Origin` response header. Instead, it must
								// return a single origin matching the value of the `Origin` request header.
								//
								// Support: Extended
								allowOrigins?: list.MaxItems(64) & [...strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"(^\\*$)|(^(http(s)?):\\/\\/(((\\*\\.)?([a-zA-Z0-9\\-]+\\.)*[a-zA-Z0-9-]+|\\*)(:([0-9]{1,5}))?)$)"]

								// ExposeHeaders indicates which HTTP response headers can be exposed
								// to client-side scripts in response to a cross-origin request.
								//
								// A CORS-safelisted response header is an HTTP header in a CORS response
								// that it is considered safe to expose to the client scripts.
								// The CORS-safelisted response headers include the following headers:
								// `Cache-Control`
								// `Content-Language`
								// `Content-Length`
								// `Content-Type`
								// `Expires`
								// `Last-Modified`
								// `Pragma`
								// (See https://fetch.spec.whatwg.org/#cors-safelisted-response-header-name)
								// The CORS-safelisted response headers are exposed to client by default.
								//
								// When an HTTP header name is specified using the `exposeHeaders` field,
								// this additional header will be exposed as part of the response to the
								// client.
								//
								// Header names are not case-sensitive.
								//
								// Multiple header names in the value of the `Access-Control-Expose-Headers`
								// response header are separated by a comma (",").
								//
								// A wildcard indicates that the responses with all HTTP headers are exposed
								// to clients.
								//
								// If the configuration contains the wildcard `*` in `exposeHeaders` and
								// `allowCredentials` is set to `false`, the `Access-Control-Expose-Headers`
								// response header can contain the wildcard `*`.
								//
								// If the configuration contains the wildcard `*` in `exposeHeaders` and
								// `allowCredentials` is set to `true`, the gateway cannot use the `*`
								// in the `Access-Control-Expose-Headers` response header.
								//
								// Support: Extended
								exposeHeaders?: list.MaxItems(64) & [...strings.MaxRunes(
									256) & strings.MinRunes(
									1) & =~"^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"]

								// MaxAge indicates the duration (in seconds) for the client to cache the
								// results of a "preflight" request.
								//
								// The information provided by the `Access-Control-Allow-Methods` and
								// `Access-Control-Allow-Headers` response headers can be cached by the
								// client until the time specified by `Access-Control-Max-Age` elapses.
								//
								// The default value of `Access-Control-Max-Age` response header is 5
								// (seconds).
								//
								// When the `MaxAge` field is unspecified, the gateway sets the response
								// header "Access-Control-Max-Age: 5" by default.
								maxAge?: int32 & int & >=1
							}

							// ExtensionRef is an optional, implementation-specific extension to the
							// "filter" behavior. For example, resource "myroutefilter" in group
							// "networking.example.net"). ExtensionRef MUST NOT be used for core and
							// extended filters.
							//
							// This filter can be used multiple times within the same rule.
							//
							// Support: Implementation-specific
							extensionRef?: {
								// Group is the group of the referent. For example, "gateway.networking.k8s.io".
								// When unspecified or empty string, core API group is inferred.
								group!: strings.MaxRunes(
									253) & =~"^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

								// Kind is kind of the referent. For example "HTTPRoute" or "Service".
								kind!: strings.MaxRunes(
									63) & strings.MinRunes(
									1) & =~"^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"

								// Name is the name of the referent.
								name!: strings.MaxRunes(
									253) & strings.MinRunes(
									1)
							}

							// ExternalAuth configures settings related to sending request details
							// to an external auth service. The external service MUST authenticate
							// the request, and MAY authorize the request as well.
							//
							// If there is any problem communicating with the external service,
							// this filter MUST fail closed.
							//
							// Support: Extended
							//
							// <gateway:experimental>
							externalAuth?: {
								// BackendRef is a reference to a backend to send authorization
								// requests to.
								//
								// The backend must speak the selected protocol (GRPC or HTTP) on the
								// referenced port.
								//
								// If the backend service requires TLS, use BackendTLSPolicy to tell the
								// implementation to supply the TLS details to be used to connect to that
								// backend.
								backendRef!: {
									// Group is the group of the referent. For example, "gateway.networking.k8s.io".
									// When unspecified or empty string, core API group is inferred.
									group?: strings.MaxRunes(
										253) & =~"^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

									// Kind is the Kubernetes resource kind of the referent. For example
									// "Service".
									//
									// Defaults to "Service" when not specified.
									//
									// ExternalName services can refer to CNAME DNS records that may live
									// outside of the cluster and as such are difficult to reason about in
									// terms of conformance. They also may not be safe to forward to (see
									// CVE-2021-25740 for more information). Implementations SHOULD NOT
									// support ExternalName Services.
									//
									// Support: Core (Services with a type other than ExternalName)
									//
									// Support: Implementation-specific (Services with type ExternalName)
									kind?: strings.MaxRunes(
										63) & strings.MinRunes(
										1) & =~"^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"

									// Name is the name of the referent.
									name!: strings.MaxRunes(
										253) & strings.MinRunes(
										1)

									// Namespace is the namespace of the backend. When unspecified, the local
									// namespace is inferred.
									//
									// Note that when a namespace different than the local namespace is specified,
									// a ReferenceGrant object is required in the referent namespace to allow that
									// namespace's owner to accept the reference. See the ReferenceGrant
									// documentation for details.
									//
									// Support: Core
									namespace?: strings.MaxRunes(
											63) & strings.MinRunes(
											1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"

									// Port specifies the destination port number to use for this resource.
									// Port is required when the referent is a Kubernetes Service. In this
									// case, the port number is the service port number, not the target port.
									// For other resources, destination port might be derived from the referent
									// resource or this field.
									port?: int32 & int & <=65535 & >=1
								}

								// ForwardBody controls if requests to the authorization server should include
								// the body of the client request; and if so, how big that body is allowed
								// to be.
								//
								// It is expected that implementations will buffer the request body up to
								// `forwardBody.maxSize` bytes. Bodies over that size must be rejected with a
								// 4xx series error (413 or 403 are common examples), and fail processing
								// of the filter.
								//
								// If unset, or `forwardBody.maxSize` is set to `0`, then the body will not
								// be forwarded.
								//
								// Feature Name: HTTPRouteExternalAuthForwardBody
								forwardBody?: {
									// MaxSize specifies how large in bytes the largest body that will be buffered
									// and sent to the authorization server. If the body size is larger than
									// `maxSize`, then the body sent to the authorization server must be
									// truncated to `maxSize` bytes.
									//
									// Experimental note: This behavior needs to be checked against
									// various dataplanes; it may need to be changed.
									// See https://github.com/kubernetes-sigs/gateway-api/pull/4001#discussion_r2291405746
									// for more.
									//
									// If 0, the body will not be sent to the authorization server.
									maxSize?: int
								}

								// GRPCAuthConfig contains configuration for communication with ext_authz
								// protocol-speaking backends.
								//
								// If unset, implementations must assume the default behavior for each
								// included field is intended.
								grpc?: {
									// AllowedRequestHeaders specifies what headers from the client request
									// will be sent to the authorization server.
									//
									// If this list is empty, then all headers must be sent.
									//
									// If the list has entries, only those entries must be sent.
									allowedHeaders?: list.MaxItems(64) & [...string]
								}

								// HTTPAuthConfig contains configuration for communication with HTTP-speaking
								// backends.
								//
								// If unset, implementations must assume the default behavior for each
								// included field is intended.
								http?: {
									// AllowedRequestHeaders specifies what additional headers from the client request
									// will be sent to the authorization server.
									//
									// The following headers must always be sent to the authorization server,
									// regardless of this setting:
									//
									// * `Host`
									// * `Method`
									// * `Path`
									// * `Content-Length`
									// * `Authorization`
									//
									// If this list is empty, then only those headers must be sent.
									//
									// Note that `Content-Length` has a special behavior, in that the length
									// sent must be correct for the actual request to the external authorization
									// server - that is, it must reflect the actual number of bytes sent in the
									// body of the request to the authorization server.
									//
									// So if the `forwardBody` stanza is unset, or `forwardBody.maxSize` is set
									// to `0`, then `Content-Length` must be `0`. If `forwardBody.maxSize` is set
									// to anything other than `0`, then the `Content-Length` of the authorization
									// request must be set to the actual number of bytes forwarded.
									allowedHeaders?: list.MaxItems(64) & [...string]

									// AllowedResponseHeaders specifies what headers from the authorization response
									// will be copied into the request to the backend.
									//
									// If this list is empty, then all headers from the authorization server
									// except Authority or Host must be copied.
									allowedResponseHeaders?: list.MaxItems(64) & [...string]

									// Path sets the prefix that paths from the client request will have added
									// when forwarded to the authorization server.
									//
									// When empty or unspecified, no prefix is added.
									//
									// Valid values are the same as the "value" regex for path values in the `match`
									// stanza, and the validation regex will screen out invalid paths in the same way.
									// Even with the validation, implementations MUST sanitize this input before using it
									// directly.
									path?: strings.MaxRunes(
										1024) & =~"^(?:[-A-Za-z0-9/._~!$&'()*+,;=:@]|[%][0-9a-fA-F]{2})+$"
								}

								// ExternalAuthProtocol describes which protocol to use when communicating with an
								// ext_authz authorization server.
								//
								// When this is set to GRPC, each backend must use the Envoy ext_authz protocol
								// on the port specified in `backendRefs`. Requests and responses are defined
								// in the protobufs explained at:
								// https://www.envoyproxy.io/docs/envoy/latest/api-v3/service/auth/v3/external_auth.proto
								//
								// When this is set to HTTP, each backend must respond with a `200` status
								// code in on a successful authorization. Any other code is considered
								// an authorization failure.
								//
								// Feature Names:
								// GRPC Support - HTTPRouteExternalAuthGRPC
								// HTTP Support - HTTPRouteExternalAuthHTTP
								protocol!: "HTTP" | "GRPC"
							}

							// RequestHeaderModifier defines a schema for a filter that modifies request
							// headers.
							//
							// Support: Core
							requestHeaderModifier?: {
								// Add adds the given header(s) (name, value) to the request
								// before the action. It appends to any existing values associated
								// with the header name.
								//
								// Input:
								// GET /foo HTTP/1.1
								// my-header: foo
								//
								// Config:
								// add:
								// - name: "my-header"
								// value: "bar,baz"
								//
								// Output:
								// GET /foo HTTP/1.1
								// my-header: foo,bar,baz
								add?: list.MaxItems(16) & [...{
									// Name is the name of the HTTP Header to be matched. Name matching MUST be
									// case-insensitive. (See https://tools.ietf.org/html/rfc7230#section-3.2).
									//
									// If multiple entries specify equivalent header names, the first entry with
									// an equivalent name MUST be considered for a match. Subsequent entries
									// with an equivalent header name MUST be ignored. Due to the
									// case-insensitivity of header names, "foo" and "Foo" are considered
									// equivalent.
									name!: strings.MaxRunes(
										256) & strings.MinRunes(
										1) & =~"^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"

									// Value is the value of HTTP Header to be matched.
									// <gateway:experimental:description>
									// Must consist of printable US-ASCII characters, optionally separated
									// by single tabs or spaces. See: https://tools.ietf.org/html/rfc7230#section-3.2
									// </gateway:experimental:description>
									//
									// <gateway:experimental:validation:Pattern=`^[!-~]+([\t ]?[!-~]+)*$`>
									value!: strings.MaxRunes(
										4096) & strings.MinRunes(
										1)
								}]

								// Remove the given header(s) from the HTTP request before the action. The
								// value of Remove is a list of HTTP header names. Note that the header
								// names are case-insensitive (see
								// https://datatracker.ietf.org/doc/html/rfc2616#section-4.2).
								//
								// Input:
								// GET /foo HTTP/1.1
								// my-header1: foo
								// my-header2: bar
								// my-header3: baz
								//
								// Config:
								// remove: ["my-header1", "my-header3"]
								//
								// Output:
								// GET /foo HTTP/1.1
								// my-header2: bar
								remove?: list.MaxItems(16) & [...string]

								// Set overwrites the request with the given header (name, value)
								// before the action.
								//
								// Input:
								// GET /foo HTTP/1.1
								// my-header: foo
								//
								// Config:
								// set:
								// - name: "my-header"
								// value: "bar"
								//
								// Output:
								// GET /foo HTTP/1.1
								// my-header: bar
								set?: list.MaxItems(16) & [...{
									// Name is the name of the HTTP Header to be matched. Name matching MUST be
									// case-insensitive. (See https://tools.ietf.org/html/rfc7230#section-3.2).
									//
									// If multiple entries specify equivalent header names, the first entry with
									// an equivalent name MUST be considered for a match. Subsequent entries
									// with an equivalent header name MUST be ignored. Due to the
									// case-insensitivity of header names, "foo" and "Foo" are considered
									// equivalent.
									name!: strings.MaxRunes(
										256) & strings.MinRunes(
										1) & =~"^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"

									// Value is the value of HTTP Header to be matched.
									// <gateway:experimental:description>
									// Must consist of printable US-ASCII characters, optionally separated
									// by single tabs or spaces. See: https://tools.ietf.org/html/rfc7230#section-3.2
									// </gateway:experimental:description>
									//
									// <gateway:experimental:validation:Pattern=`^[!-~]+([\t ]?[!-~]+)*$`>
									value!: strings.MaxRunes(
										4096) & strings.MinRunes(
										1)
								}]
							}

							// RequestMirror defines a schema for a filter that mirrors requests.
							// Requests are sent to the specified destination, but responses from
							// that destination are ignored.
							//
							// This filter can be used multiple times within the same rule. Note that
							// not all implementations will be able to support mirroring to multiple
							// backends.
							//
							// Support: Extended
							requestMirror?: {
								// BackendRef references a resource where mirrored requests are sent.
								//
								// Mirrored requests must be sent only to a single destination endpoint
								// within this BackendRef, irrespective of how many endpoints are present
								// within this BackendRef.
								//
								// If the referent cannot be found, this BackendRef is invalid and must be
								// dropped from the Gateway. The controller must ensure the "ResolvedRefs"
								// condition on the Route status is set to `status: False` and not configure
								// this backend in the underlying implementation.
								//
								// If there is a cross-namespace reference to an *existing* object
								// that is not allowed by a ReferenceGrant, the controller must ensure the
								// "ResolvedRefs" condition on the Route is set to `status: False`,
								// with the "RefNotPermitted" reason and not configure this backend in the
								// underlying implementation.
								//
								// In either error case, the Message of the `ResolvedRefs` Condition
								// should be used to provide more detail about the problem.
								//
								// Support: Extended for Kubernetes Service
								//
								// Support: Implementation-specific for any other resource
								//
								// If the backend service requires TLS, use BackendTLSPolicy to tell the
								// implementation to supply the TLS details to be used to connect to that
								// backend.
								backendRef!: {
									// Group is the group of the referent. For example, "gateway.networking.k8s.io".
									// When unspecified or empty string, core API group is inferred.
									group?: strings.MaxRunes(
										253) & =~"^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

									// Kind is the Kubernetes resource kind of the referent. For example
									// "Service".
									//
									// Defaults to "Service" when not specified.
									//
									// ExternalName services can refer to CNAME DNS records that may live
									// outside of the cluster and as such are difficult to reason about in
									// terms of conformance. They also may not be safe to forward to (see
									// CVE-2021-25740 for more information). Implementations SHOULD NOT
									// support ExternalName Services.
									//
									// Support: Core (Services with a type other than ExternalName)
									//
									// Support: Implementation-specific (Services with type ExternalName)
									kind?: strings.MaxRunes(
										63) & strings.MinRunes(
										1) & =~"^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"

									// Name is the name of the referent.
									name!: strings.MaxRunes(
										253) & strings.MinRunes(
										1)

									// Namespace is the namespace of the backend. When unspecified, the local
									// namespace is inferred.
									//
									// Note that when a namespace different than the local namespace is specified,
									// a ReferenceGrant object is required in the referent namespace to allow that
									// namespace's owner to accept the reference. See the ReferenceGrant
									// documentation for details.
									//
									// Support: Core
									namespace?: strings.MaxRunes(
											63) & strings.MinRunes(
											1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"

									// Port specifies the destination port number to use for this resource.
									// Port is required when the referent is a Kubernetes Service. In this
									// case, the port number is the service port number, not the target port.
									// For other resources, destination port might be derived from the referent
									// resource or this field.
									port?: int32 & int & <=65535 & >=1
								}

								// Fraction represents the fraction of requests that should be
								// mirrored to BackendRef.
								//
								// Only one of Fraction or Percent may be specified. If neither field
								// is specified, 100% of requests will be mirrored.
								fraction?: {
									denominator?: int32 & int & >=1
									numerator!:   int32 & int & >=0
								}

								// Percent represents the percentage of requests that should be
								// mirrored to BackendRef. Its minimum value is 0 (indicating 0% of
								// requests) and its maximum value is 100 (indicating 100% of requests).
								//
								// Only one of Fraction or Percent may be specified. If neither field
								// is specified, 100% of requests will be mirrored.
								percent?: int32 & int & <=100 & >=0
							}

							// RequestRedirect defines a schema for a filter that responds to the
							// request with an HTTP redirection.
							//
							// Support: Core
							requestRedirect?: {
								// Hostname is the hostname to be used in the value of the `Location`
								// header in the response.
								// When empty, the hostname in the `Host` header of the request is used.
								//
								// Support: Core
								hostname?: strings.MaxRunes(
										253) & strings.MinRunes(
										1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

								// Path defines parameters used to modify the path of the incoming request.
								// The modified path is then used to construct the `Location` header. When
								// empty, the request path is used as-is.
								//
								// Support: Extended
								path?: {
									// ReplaceFullPath specifies the value with which to replace the full path
									// of a request during a rewrite or redirect.
									replaceFullPath?: strings.MaxRunes(
												1024)

									// ReplacePrefixMatch specifies the value with which to replace the prefix
									// match of a request during a rewrite or redirect. For example, a request
									// to "/foo/bar" with a prefix match of "/foo" and a ReplacePrefixMatch
									// of "/xyz" would be modified to "/xyz/bar".
									//
									// Note that this matches the behavior of the PathPrefix match type. This
									// matches full path elements. A path element refers to the list of labels
									// in the path split by the `/` separator. When specified, a trailing `/` is
									// ignored. For example, the paths `/abc`, `/abc/`, and `/abc/def` would all
									// match the prefix `/abc`, but the path `/abcd` would not.
									//
									// ReplacePrefixMatch is only compatible with a `PathPrefix` HTTPRouteMatch.
									// Using any other HTTPRouteMatch type on the same HTTPRouteRule will result in
									// the implementation setting the Accepted Condition for the Route to `status: False`.
									//
									// Request Path | Prefix Match | Replace Prefix | Modified Path
									replacePrefixMatch?: strings.MaxRunes(
												1024)

									// Type defines the type of path modifier. Additional types may be
									// added in a future release of the API.
									//
									// Note that values may be added to this enum, implementations
									// must ensure that unknown values will not cause a crash.
									//
									// Unknown values here must result in the implementation setting the
									// Accepted Condition for the Route to `status: False`, with a
									// Reason of `UnsupportedValue`.
									type!: "ReplaceFullPath" | "ReplacePrefixMatch"
								}

								// Port is the port to be used in the value of the `Location`
								// header in the response.
								//
								// If no port is specified, the redirect port MUST be derived using the
								// following rules:
								//
								// * If redirect scheme is not-empty, the redirect port MUST be the well-known
								// port associated with the redirect scheme. Specifically "http" to port 80
								// and "https" to port 443. If the redirect scheme does not have a
								// well-known port, the listener port of the Gateway SHOULD be used.
								// * If redirect scheme is empty, the redirect port MUST be the Gateway
								// Listener port.
								//
								// Implementations SHOULD NOT add the port number in the 'Location'
								// header in the following cases:
								//
								// * A Location header that will use HTTP (whether that is determined via
								// the Listener protocol or the Scheme field) _and_ use port 80.
								// * A Location header that will use HTTPS (whether that is determined via
								// the Listener protocol or the Scheme field) _and_ use port 443.
								//
								// Support: Extended
								port?: int32 & int & <=65535 & >=1

								// Scheme is the scheme to be used in the value of the `Location` header in
								// the response. When empty, the scheme of the request is used.
								//
								// Scheme redirects can affect the port of the redirect, for more information,
								// refer to the documentation for the port field of this filter.
								//
								// Note that values may be added to this enum, implementations
								// must ensure that unknown values will not cause a crash.
								//
								// Unknown values here must result in the implementation setting the
								// Accepted Condition for the Route to `status: False`, with a
								// Reason of `UnsupportedValue`.
								//
								// Support: Extended
								scheme?: "http" | "https"

								// StatusCode is the HTTP status code to be used in response.
								//
								// Note that values may be added to this enum, implementations
								// must ensure that unknown values will not cause a crash.
								//
								// Unknown values here must result in the implementation setting the
								// Accepted Condition for the Route to `status: False`, with a
								// Reason of `UnsupportedValue`.
								//
								// Support: Core
								statusCode?: (301 | 302 | 303 | 307 | 308) & int
							}

							// ResponseHeaderModifier defines a schema for a filter that modifies response
							// headers.
							//
							// Support: Extended
							responseHeaderModifier?: {
								// Add adds the given header(s) (name, value) to the request
								// before the action. It appends to any existing values associated
								// with the header name.
								//
								// Input:
								// GET /foo HTTP/1.1
								// my-header: foo
								//
								// Config:
								// add:
								// - name: "my-header"
								// value: "bar,baz"
								//
								// Output:
								// GET /foo HTTP/1.1
								// my-header: foo,bar,baz
								add?: list.MaxItems(16) & [...{
									// Name is the name of the HTTP Header to be matched. Name matching MUST be
									// case-insensitive. (See https://tools.ietf.org/html/rfc7230#section-3.2).
									//
									// If multiple entries specify equivalent header names, the first entry with
									// an equivalent name MUST be considered for a match. Subsequent entries
									// with an equivalent header name MUST be ignored. Due to the
									// case-insensitivity of header names, "foo" and "Foo" are considered
									// equivalent.
									name!: strings.MaxRunes(
										256) & strings.MinRunes(
										1) & =~"^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"

									// Value is the value of HTTP Header to be matched.
									// <gateway:experimental:description>
									// Must consist of printable US-ASCII characters, optionally separated
									// by single tabs or spaces. See: https://tools.ietf.org/html/rfc7230#section-3.2
									// </gateway:experimental:description>
									//
									// <gateway:experimental:validation:Pattern=`^[!-~]+([\t ]?[!-~]+)*$`>
									value!: strings.MaxRunes(
										4096) & strings.MinRunes(
										1)
								}]

								// Remove the given header(s) from the HTTP request before the action. The
								// value of Remove is a list of HTTP header names. Note that the header
								// names are case-insensitive (see
								// https://datatracker.ietf.org/doc/html/rfc2616#section-4.2).
								//
								// Input:
								// GET /foo HTTP/1.1
								// my-header1: foo
								// my-header2: bar
								// my-header3: baz
								//
								// Config:
								// remove: ["my-header1", "my-header3"]
								//
								// Output:
								// GET /foo HTTP/1.1
								// my-header2: bar
								remove?: list.MaxItems(16) & [...string]

								// Set overwrites the request with the given header (name, value)
								// before the action.
								//
								// Input:
								// GET /foo HTTP/1.1
								// my-header: foo
								//
								// Config:
								// set:
								// - name: "my-header"
								// value: "bar"
								//
								// Output:
								// GET /foo HTTP/1.1
								// my-header: bar
								set?: list.MaxItems(16) & [...{
									// Name is the name of the HTTP Header to be matched. Name matching MUST be
									// case-insensitive. (See https://tools.ietf.org/html/rfc7230#section-3.2).
									//
									// If multiple entries specify equivalent header names, the first entry with
									// an equivalent name MUST be considered for a match. Subsequent entries
									// with an equivalent header name MUST be ignored. Due to the
									// case-insensitivity of header names, "foo" and "Foo" are considered
									// equivalent.
									name!: strings.MaxRunes(
										256) & strings.MinRunes(
										1) & =~"^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"

									// Value is the value of HTTP Header to be matched.
									// <gateway:experimental:description>
									// Must consist of printable US-ASCII characters, optionally separated
									// by single tabs or spaces. See: https://tools.ietf.org/html/rfc7230#section-3.2
									// </gateway:experimental:description>
									//
									// <gateway:experimental:validation:Pattern=`^[!-~]+([\t ]?[!-~]+)*$`>
									value!: strings.MaxRunes(
										4096) & strings.MinRunes(
										1)
								}]
							}

							// Type identifies the type of filter to apply. As with other API fields,
							// types are classified into three conformance levels:
							//
							// - Core: Filter types and their corresponding configuration defined by
							// "Support: Core" in this package, e.g. "RequestHeaderModifier". All
							// implementations must support core filters.
							//
							// - Extended: Filter types and their corresponding configuration defined by
							// "Support: Extended" in this package, e.g. "RequestMirror". Implementers
							// are encouraged to support extended filters.
							//
							// - Implementation-specific: Filters that are defined and supported by
							// specific vendors.
							// In the future, filters showing convergence in behavior across multiple
							// implementations will be considered for inclusion in extended or core
							// conformance levels. Filter-specific configuration for such filters
							// is specified using the ExtensionRef field. `Type` should be set to
							// "ExtensionRef" for custom filters.
							//
							// Implementers are encouraged to define custom implementation types to
							// extend the core API with implementation-specific behavior.
							//
							// If a reference to a custom filter type cannot be resolved, the filter
							// MUST NOT be skipped. Instead, requests that would have been processed by
							// that filter MUST receive a HTTP error response.
							//
							// Note that values may be added to this enum, implementations
							// must ensure that unknown values will not cause a crash.
							//
							// Unknown values here must result in the implementation setting the
							// Accepted Condition for the Route to `status: False`, with a
							// Reason of `UnsupportedValue`.
							//
							// <gateway:experimental:validation:Enum=RequestHeaderModifier;ResponseHeaderModifier;RequestMirror;RequestRedirect;URLRewrite;ExtensionRef;CORS;ExternalAuth>
							type!: "RequestHeaderModifier" | "ResponseHeaderModifier" | "RequestMirror" | "RequestRedirect" | "URLRewrite" | "ExtensionRef" | "CORS"

							// URLRewrite defines a schema for a filter that modifies a request during forwarding.
							//
							// Support: Extended
							urlRewrite?: {
								// Hostname is the value to be used to replace the Host header value during
								// forwarding.
								//
								// Support: Extended
								hostname?: strings.MaxRunes(
										253) & strings.MinRunes(
										1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

								// Path defines a path rewrite.
								//
								// Support: Extended
								path?: {
									// ReplaceFullPath specifies the value with which to replace the full path
									// of a request during a rewrite or redirect.
									replaceFullPath?: strings.MaxRunes(
												1024)

									// ReplacePrefixMatch specifies the value with which to replace the prefix
									// match of a request during a rewrite or redirect. For example, a request
									// to "/foo/bar" with a prefix match of "/foo" and a ReplacePrefixMatch
									// of "/xyz" would be modified to "/xyz/bar".
									//
									// Note that this matches the behavior of the PathPrefix match type. This
									// matches full path elements. A path element refers to the list of labels
									// in the path split by the `/` separator. When specified, a trailing `/` is
									// ignored. For example, the paths `/abc`, `/abc/`, and `/abc/def` would all
									// match the prefix `/abc`, but the path `/abcd` would not.
									//
									// ReplacePrefixMatch is only compatible with a `PathPrefix` HTTPRouteMatch.
									// Using any other HTTPRouteMatch type on the same HTTPRouteRule will result in
									// the implementation setting the Accepted Condition for the Route to `status: False`.
									//
									// Request Path | Prefix Match | Replace Prefix | Modified Path
									replacePrefixMatch?: strings.MaxRunes(
												1024)

									// Type defines the type of path modifier. Additional types may be
									// added in a future release of the API.
									//
									// Note that values may be added to this enum, implementations
									// must ensure that unknown values will not cause a crash.
									//
									// Unknown values here must result in the implementation setting the
									// Accepted Condition for the Route to `status: False`, with a
									// Reason of `UnsupportedValue`.
									type!: "ReplaceFullPath" | "ReplacePrefixMatch"
								}
							}
						}]

						// Group is the group of the referent. For example, "gateway.networking.k8s.io".
						// When unspecified or empty string, core API group is inferred.
						group?: strings.MaxRunes(
							253) & =~"^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

						// Kind is the Kubernetes resource kind of the referent. For example
						// "Service".
						//
						// Defaults to "Service" when not specified.
						//
						// ExternalName services can refer to CNAME DNS records that may live
						// outside of the cluster and as such are difficult to reason about in
						// terms of conformance. They also may not be safe to forward to (see
						// CVE-2021-25740 for more information). Implementations SHOULD NOT
						// support ExternalName Services.
						//
						// Support: Core (Services with a type other than ExternalName)
						//
						// Support: Implementation-specific (Services with type ExternalName)
						kind?: strings.MaxRunes(
							63) & strings.MinRunes(
							1) & =~"^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"

						// Name is the name of the referent.
						name!: strings.MaxRunes(
							253) & strings.MinRunes(
							1)

						// Namespace is the namespace of the backend. When unspecified, the local
						// namespace is inferred.
						//
						// Note that when a namespace different than the local namespace is specified,
						// a ReferenceGrant object is required in the referent namespace to allow that
						// namespace's owner to accept the reference. See the ReferenceGrant
						// documentation for details.
						//
						// Support: Core
						namespace?: strings.MaxRunes(
								63) & strings.MinRunes(
								1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"

						// Port specifies the destination port number to use for this resource.
						// Port is required when the referent is a Kubernetes Service. In this
						// case, the port number is the service port number, not the target port.
						// For other resources, destination port might be derived from the referent
						// resource or this field.
						port?: int32 & int & <=65535 & >=1

						// Weight specifies the proportion of requests forwarded to the referenced
						// backend. This is computed as weight/(sum of all weights in this
						// BackendRefs list). For non-zero values, there may be some epsilon from
						// the exact proportion defined here depending on the precision an
						// implementation supports. Weight is not a percentage and the sum of
						// weights does not need to equal 100.
						//
						// If only one backend is specified and it has a weight greater than 0, 100%
						// of the traffic is forwarded to that backend. If weight is set to 0, no
						// traffic should be forwarded for this entry. If unspecified, weight
						// defaults to 1.
						//
						// Support for this field varies based on the context where used.
						weight?: int32 & int & <=1000000 & >=0
					}]

					// Filters define the filters that are applied to requests that match
					// this rule.
					//
					// Wherever possible, implementations SHOULD implement filters in the order
					// they are specified.
					//
					// Implementations MAY choose to implement this ordering strictly, rejecting
					// any combination or order of filters that cannot be supported. If implementations
					// choose a strict interpretation of filter ordering, they MUST clearly document
					// that behavior.
					//
					// To reject an invalid combination or order of filters, implementations SHOULD
					// consider the Route Rules with this configuration invalid. If all Route Rules
					// in a Route are invalid, the entire Route would be considered invalid. If only
					// a portion of Route Rules are invalid, implementations MUST set the
					// "PartiallyInvalid" condition for the Route.
					//
					// Conformance-levels at this level are defined based on the type of filter:
					//
					// - ALL core filters MUST be supported by all implementations.
					// - Implementers are encouraged to support extended filters.
					// - Implementation-specific custom filters have no API guarantees across
					// implementations.
					//
					// Specifying the same filter multiple times is not supported unless explicitly
					// indicated in the filter.
					//
					// All filters are expected to be compatible with each other except for the
					// URLRewrite and RequestRedirect filters, which may not be combined. If an
					// implementation cannot support other combinations of filters, they must clearly
					// document that limitation. In cases where incompatible or unsupported
					// filters are specified and cause the `Accepted` condition to be set to status
					// `False`, implementations may use the `IncompatibleFilters` reason to specify
					// this configuration error.
					//
					// Support: Core
					filters?: list.MaxItems(16) & [...{
						// CORS defines a schema for a filter that responds to the
						// cross-origin request based on HTTP response header.
						//
						// Support: Extended
						cors?: {
							// AllowCredentials indicates whether the actual cross-origin request allows
							// to include credentials.
							//
							// When set to true, the gateway will include the `Access-Control-Allow-Credentials`
							// response header with value true (case-sensitive).
							//
							// When set to false or omitted the gateway will omit the header
							// `Access-Control-Allow-Credentials` entirely (this is the standard CORS
							// behavior).
							//
							// Support: Extended
							allowCredentials?: bool

							// AllowHeaders indicates which HTTP request headers are supported for
							// accessing the requested resource.
							//
							// Header names are not case-sensitive.
							//
							// Multiple header names in the value of the `Access-Control-Allow-Headers`
							// response header are separated by a comma (",").
							//
							// When the `allowHeaders` field is configured with one or more headers, the
							// gateway must return the `Access-Control-Allow-Headers` response header
							// which value is present in the `allowHeaders` field.
							//
							// If any header name in the `Access-Control-Request-Headers` request header
							// is not included in the list of header names specified by the response
							// header `Access-Control-Allow-Headers`, it will present an error on the
							// client side.
							//
							// If any header name in the `Access-Control-Allow-Headers` response header
							// does not recognize by the client, it will also occur an error on the
							// client side.
							//
							// A wildcard indicates that the requests with all HTTP headers are allowed.
							//
							// If the configuration contains the wildcard `*` in `allowHeaders` and
							// `allowCredentials` is set to `false`, the `Access-Control-Allow-Headers`
							// response header may either contain the wildcard `*` or echo the value
							// of the `Access-Control-Request-Headers` request header.
							//
							// If the configuration contains the wildcard `*` in `allowHeaders` and
							// `allowCredentials` is set to `true`, the gateway must not return `*`
							// in the `Access-Control-Allow-Headers` response header. Instead, it must
							// return one or more header names matching the value of the
							// `Access-Control-Request-Headers` request header.
							// If the `Access-Control-Request-Headers` header is not present in the
							// request, the gateway must omit the `Access-Control-Allow-Headers`
							// response header.
							//
							// Support: Extended
							allowHeaders?: list.MaxItems(64) & [...strings.MaxRunes(
								256) & strings.MinRunes(
								1) & =~"^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"]

							// AllowMethods indicates which HTTP methods are supported for accessing the
							// requested resource.
							//
							// Valid values are any method defined by RFC9110, along with the special
							// value `*`, which represents all HTTP methods are allowed.
							//
							// Method names are case-sensitive, so these values are also case-sensitive.
							// (See https://www.rfc-editor.org/rfc/rfc2616#section-5.1.1)
							//
							// Multiple method names in the value of the `Access-Control-Allow-Methods`
							// response header are separated by a comma (",").
							//
							// A CORS-safelisted method is a method that is `GET`, `HEAD`, or `POST`.
							// (See https://fetch.spec.whatwg.org/#cors-safelisted-method) The
							// CORS-safelisted methods are always allowed, regardless of whether they
							// are specified in the `allowMethods` field.
							//
							// When the `allowMethods` field is configured with one or more methods, the
							// gateway must return the `Access-Control-Allow-Methods` response header
							// which value is present in the `allowMethods` field.
							//
							// If the HTTP method of the `Access-Control-Request-Method` request header
							// is not included in the list of methods specified by the response header
							// `Access-Control-Allow-Methods`, it will present an error on the client
							// side.
							//
							// If the configuration contains the wildcard `*` in `allowMethods` and
							// `allowCredentials` is set to `false`, the `Access-Control-Allow-Methods`
							// response header may either contain the wildcard `*` or echo the value
							// of the `Access-Control-Request-Method` request header.
							//
							// If the configuration contains the wildcard `*` in `allowMethods` and
							// `allowCredentials` is set to `true`, the gateway must not return `*`
							// in the `Access-Control-Allow-Methods` response header. Instead, it must
							// return a single HTTP method matching the value of the
							// `Access-Control-Request-Method` request header.
							// If the `Access-Control-Request-Method` header is not present in the request,
							// the gateway must omit the `Access-Control-Allow-Methods` response header.
							//
							// Support: Extended
							allowMethods?: list.MaxItems(9) & [..."GET" | "HEAD" | "POST" | "PUT" | "DELETE" | "CONNECT" | "OPTIONS" | "TRACE" | "PATCH" | "*"]

							// AllowOrigins indicates whether the response can be shared with requested
							// resource from the given `Origin`.
							//
							// The `Origin` consists of a scheme and a host, with an optional port, and
							// takes the form `<scheme>://<host>(:<port>)`.
							//
							// Valid values for scheme are: `http` and `https`.
							//
							// Valid values for port are any integer between 1 and 65535 (the list of
							// available TCP/UDP ports). Note that, if not included, port `80` is
							// assumed for `http` scheme origins, and port `443` is assumed for `https`
							// origins. This may affect origin matching.
							//
							// The host part of the origin may contain the wildcard character `*`. These
							// wildcard characters behave as follows:
							//
							// * `*` is a greedy match to the _left_, including any number of
							// DNS labels to the left of its position. This also means that
							// `*` will include any number of period `.` characters to the
							// left of its position.
							// * A wildcard by itself matches all hosts.
							//
							// An origin value that includes _only_ the `*` character indicates requests
							// from all `Origin`s are allowed.
							//
							// When the `allowOrigins` field is configured with multiple origins, it
							// means the server supports clients from multiple origins. If the request
							// `Origin` matches the configured allowed origins, the gateway must return
							// the given `Origin` and sets value of the header
							// `Access-Control-Allow-Origin` same as the `Origin` header provided by the
							// client.
							//
							// The status code of a successful response to a "preflight" request is
							// always an OK status (i.e., 204 or 200).
							//
							// If the request `Origin` does not match the configured allowed origins,
							// the gateway returns 204/200 response but doesn't set the relevant
							// cross-origin response headers. Alternatively, the gateway responds with
							// 403 status to the "preflight" request is denied, coupled with omitting
							// the CORS headers. The cross-origin request fails on the client side.
							// Therefore, the client doesn't attempt the actual cross-origin request.
							//
							// Conversely, if the request `Origin` matches one of the configured
							// allowed origins, the gateway sets the response header
							// `Access-Control-Allow-Origin` to the same value as the `Origin`
							// header provided by the client.
							//
							// If the configuration contains the wildcard `*` in `allowOrigins` and
							// `allowCredentials` is set to `false`, the `Access-Control-Allow-Origin`
							// response header may either contain the wildcard `*` or echo the value
							// of the `Origin` request header.
							//
							// If the configuration contains the wildcard `*` in `allowOrigins` and
							// `allowCredentials` is set to `true`, the gateway must not return `*`
							// in the `Access-Control-Allow-Origin` response header. Instead, it must
							// return a single origin matching the value of the `Origin` request header.
							//
							// Support: Extended
							allowOrigins?: list.MaxItems(64) & [...strings.MaxRunes(
								253) & strings.MinRunes(
								1) & =~"(^\\*$)|(^(http(s)?):\\/\\/(((\\*\\.)?([a-zA-Z0-9\\-]+\\.)*[a-zA-Z0-9-]+|\\*)(:([0-9]{1,5}))?)$)"]

							// ExposeHeaders indicates which HTTP response headers can be exposed
							// to client-side scripts in response to a cross-origin request.
							//
							// A CORS-safelisted response header is an HTTP header in a CORS response
							// that it is considered safe to expose to the client scripts.
							// The CORS-safelisted response headers include the following headers:
							// `Cache-Control`
							// `Content-Language`
							// `Content-Length`
							// `Content-Type`
							// `Expires`
							// `Last-Modified`
							// `Pragma`
							// (See https://fetch.spec.whatwg.org/#cors-safelisted-response-header-name)
							// The CORS-safelisted response headers are exposed to client by default.
							//
							// When an HTTP header name is specified using the `exposeHeaders` field,
							// this additional header will be exposed as part of the response to the
							// client.
							//
							// Header names are not case-sensitive.
							//
							// Multiple header names in the value of the `Access-Control-Expose-Headers`
							// response header are separated by a comma (",").
							//
							// A wildcard indicates that the responses with all HTTP headers are exposed
							// to clients.
							//
							// If the configuration contains the wildcard `*` in `exposeHeaders` and
							// `allowCredentials` is set to `false`, the `Access-Control-Expose-Headers`
							// response header can contain the wildcard `*`.
							//
							// If the configuration contains the wildcard `*` in `exposeHeaders` and
							// `allowCredentials` is set to `true`, the gateway cannot use the `*`
							// in the `Access-Control-Expose-Headers` response header.
							//
							// Support: Extended
							exposeHeaders?: list.MaxItems(64) & [...strings.MaxRunes(
								256) & strings.MinRunes(
								1) & =~"^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"]

							// MaxAge indicates the duration (in seconds) for the client to cache the
							// results of a "preflight" request.
							//
							// The information provided by the `Access-Control-Allow-Methods` and
							// `Access-Control-Allow-Headers` response headers can be cached by the
							// client until the time specified by `Access-Control-Max-Age` elapses.
							//
							// The default value of `Access-Control-Max-Age` response header is 5
							// (seconds).
							//
							// When the `MaxAge` field is unspecified, the gateway sets the response
							// header "Access-Control-Max-Age: 5" by default.
							maxAge?: int32 & int & >=1
						}

						// ExtensionRef is an optional, implementation-specific extension to the
						// "filter" behavior. For example, resource "myroutefilter" in group
						// "networking.example.net"). ExtensionRef MUST NOT be used for core and
						// extended filters.
						//
						// This filter can be used multiple times within the same rule.
						//
						// Support: Implementation-specific
						extensionRef?: {
							// Group is the group of the referent. For example, "gateway.networking.k8s.io".
							// When unspecified or empty string, core API group is inferred.
							group!: strings.MaxRunes(
								253) & =~"^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

							// Kind is kind of the referent. For example "HTTPRoute" or "Service".
							kind!: strings.MaxRunes(
								63) & strings.MinRunes(
								1) & =~"^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"

							// Name is the name of the referent.
							name!: strings.MaxRunes(
								253) & strings.MinRunes(
								1)
						}

						// ExternalAuth configures settings related to sending request details
						// to an external auth service. The external service MUST authenticate
						// the request, and MAY authorize the request as well.
						//
						// If there is any problem communicating with the external service,
						// this filter MUST fail closed.
						//
						// Support: Extended
						//
						// <gateway:experimental>
						externalAuth?: {
							// BackendRef is a reference to a backend to send authorization
							// requests to.
							//
							// The backend must speak the selected protocol (GRPC or HTTP) on the
							// referenced port.
							//
							// If the backend service requires TLS, use BackendTLSPolicy to tell the
							// implementation to supply the TLS details to be used to connect to that
							// backend.
							backendRef!: {
								// Group is the group of the referent. For example, "gateway.networking.k8s.io".
								// When unspecified or empty string, core API group is inferred.
								group?: strings.MaxRunes(
									253) & =~"^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

								// Kind is the Kubernetes resource kind of the referent. For example
								// "Service".
								//
								// Defaults to "Service" when not specified.
								//
								// ExternalName services can refer to CNAME DNS records that may live
								// outside of the cluster and as such are difficult to reason about in
								// terms of conformance. They also may not be safe to forward to (see
								// CVE-2021-25740 for more information). Implementations SHOULD NOT
								// support ExternalName Services.
								//
								// Support: Core (Services with a type other than ExternalName)
								//
								// Support: Implementation-specific (Services with type ExternalName)
								kind?: strings.MaxRunes(
									63) & strings.MinRunes(
									1) & =~"^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"

								// Name is the name of the referent.
								name!: strings.MaxRunes(
									253) & strings.MinRunes(
									1)

								// Namespace is the namespace of the backend. When unspecified, the local
								// namespace is inferred.
								//
								// Note that when a namespace different than the local namespace is specified,
								// a ReferenceGrant object is required in the referent namespace to allow that
								// namespace's owner to accept the reference. See the ReferenceGrant
								// documentation for details.
								//
								// Support: Core
								namespace?: strings.MaxRunes(
										63) & strings.MinRunes(
										1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"

								// Port specifies the destination port number to use for this resource.
								// Port is required when the referent is a Kubernetes Service. In this
								// case, the port number is the service port number, not the target port.
								// For other resources, destination port might be derived from the referent
								// resource or this field.
								port?: int32 & int & <=65535 & >=1
							}

							// ForwardBody controls if requests to the authorization server should include
							// the body of the client request; and if so, how big that body is allowed
							// to be.
							//
							// It is expected that implementations will buffer the request body up to
							// `forwardBody.maxSize` bytes. Bodies over that size must be rejected with a
							// 4xx series error (413 or 403 are common examples), and fail processing
							// of the filter.
							//
							// If unset, or `forwardBody.maxSize` is set to `0`, then the body will not
							// be forwarded.
							//
							// Feature Name: HTTPRouteExternalAuthForwardBody
							forwardBody?: {
								// MaxSize specifies how large in bytes the largest body that will be buffered
								// and sent to the authorization server. If the body size is larger than
								// `maxSize`, then the body sent to the authorization server must be
								// truncated to `maxSize` bytes.
								//
								// Experimental note: This behavior needs to be checked against
								// various dataplanes; it may need to be changed.
								// See https://github.com/kubernetes-sigs/gateway-api/pull/4001#discussion_r2291405746
								// for more.
								//
								// If 0, the body will not be sent to the authorization server.
								maxSize?: int
							}

							// GRPCAuthConfig contains configuration for communication with ext_authz
							// protocol-speaking backends.
							//
							// If unset, implementations must assume the default behavior for each
							// included field is intended.
							grpc?: {
								// AllowedRequestHeaders specifies what headers from the client request
								// will be sent to the authorization server.
								//
								// If this list is empty, then all headers must be sent.
								//
								// If the list has entries, only those entries must be sent.
								allowedHeaders?: list.MaxItems(64) & [...string]
							}

							// HTTPAuthConfig contains configuration for communication with HTTP-speaking
							// backends.
							//
							// If unset, implementations must assume the default behavior for each
							// included field is intended.
							http?: {
								// AllowedRequestHeaders specifies what additional headers from the client request
								// will be sent to the authorization server.
								//
								// The following headers must always be sent to the authorization server,
								// regardless of this setting:
								//
								// * `Host`
								// * `Method`
								// * `Path`
								// * `Content-Length`
								// * `Authorization`
								//
								// If this list is empty, then only those headers must be sent.
								//
								// Note that `Content-Length` has a special behavior, in that the length
								// sent must be correct for the actual request to the external authorization
								// server - that is, it must reflect the actual number of bytes sent in the
								// body of the request to the authorization server.
								//
								// So if the `forwardBody` stanza is unset, or `forwardBody.maxSize` is set
								// to `0`, then `Content-Length` must be `0`. If `forwardBody.maxSize` is set
								// to anything other than `0`, then the `Content-Length` of the authorization
								// request must be set to the actual number of bytes forwarded.
								allowedHeaders?: list.MaxItems(64) & [...string]

								// AllowedResponseHeaders specifies what headers from the authorization response
								// will be copied into the request to the backend.
								//
								// If this list is empty, then all headers from the authorization server
								// except Authority or Host must be copied.
								allowedResponseHeaders?: list.MaxItems(64) & [...string]

								// Path sets the prefix that paths from the client request will have added
								// when forwarded to the authorization server.
								//
								// When empty or unspecified, no prefix is added.
								//
								// Valid values are the same as the "value" regex for path values in the `match`
								// stanza, and the validation regex will screen out invalid paths in the same way.
								// Even with the validation, implementations MUST sanitize this input before using it
								// directly.
								path?: strings.MaxRunes(
									1024) & =~"^(?:[-A-Za-z0-9/._~!$&'()*+,;=:@]|[%][0-9a-fA-F]{2})+$"
							}

							// ExternalAuthProtocol describes which protocol to use when communicating with an
							// ext_authz authorization server.
							//
							// When this is set to GRPC, each backend must use the Envoy ext_authz protocol
							// on the port specified in `backendRefs`. Requests and responses are defined
							// in the protobufs explained at:
							// https://www.envoyproxy.io/docs/envoy/latest/api-v3/service/auth/v3/external_auth.proto
							//
							// When this is set to HTTP, each backend must respond with a `200` status
							// code in on a successful authorization. Any other code is considered
							// an authorization failure.
							//
							// Feature Names:
							// GRPC Support - HTTPRouteExternalAuthGRPC
							// HTTP Support - HTTPRouteExternalAuthHTTP
							protocol!: "HTTP" | "GRPC"
						}

						// RequestHeaderModifier defines a schema for a filter that modifies request
						// headers.
						//
						// Support: Core
						requestHeaderModifier?: {
							// Add adds the given header(s) (name, value) to the request
							// before the action. It appends to any existing values associated
							// with the header name.
							//
							// Input:
							// GET /foo HTTP/1.1
							// my-header: foo
							//
							// Config:
							// add:
							// - name: "my-header"
							// value: "bar,baz"
							//
							// Output:
							// GET /foo HTTP/1.1
							// my-header: foo,bar,baz
							add?: list.MaxItems(16) & [...{
								// Name is the name of the HTTP Header to be matched. Name matching MUST be
								// case-insensitive. (See https://tools.ietf.org/html/rfc7230#section-3.2).
								//
								// If multiple entries specify equivalent header names, the first entry with
								// an equivalent name MUST be considered for a match. Subsequent entries
								// with an equivalent header name MUST be ignored. Due to the
								// case-insensitivity of header names, "foo" and "Foo" are considered
								// equivalent.
								name!: strings.MaxRunes(
									256) & strings.MinRunes(
									1) & =~"^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"

								// Value is the value of HTTP Header to be matched.
								// <gateway:experimental:description>
								// Must consist of printable US-ASCII characters, optionally separated
								// by single tabs or spaces. See: https://tools.ietf.org/html/rfc7230#section-3.2
								// </gateway:experimental:description>
								//
								// <gateway:experimental:validation:Pattern=`^[!-~]+([\t ]?[!-~]+)*$`>
								value!: strings.MaxRunes(
									4096) & strings.MinRunes(
									1)
							}]

							// Remove the given header(s) from the HTTP request before the action. The
							// value of Remove is a list of HTTP header names. Note that the header
							// names are case-insensitive (see
							// https://datatracker.ietf.org/doc/html/rfc2616#section-4.2).
							//
							// Input:
							// GET /foo HTTP/1.1
							// my-header1: foo
							// my-header2: bar
							// my-header3: baz
							//
							// Config:
							// remove: ["my-header1", "my-header3"]
							//
							// Output:
							// GET /foo HTTP/1.1
							// my-header2: bar
							remove?: list.MaxItems(16) & [...string]

							// Set overwrites the request with the given header (name, value)
							// before the action.
							//
							// Input:
							// GET /foo HTTP/1.1
							// my-header: foo
							//
							// Config:
							// set:
							// - name: "my-header"
							// value: "bar"
							//
							// Output:
							// GET /foo HTTP/1.1
							// my-header: bar
							set?: list.MaxItems(16) & [...{
								// Name is the name of the HTTP Header to be matched. Name matching MUST be
								// case-insensitive. (See https://tools.ietf.org/html/rfc7230#section-3.2).
								//
								// If multiple entries specify equivalent header names, the first entry with
								// an equivalent name MUST be considered for a match. Subsequent entries
								// with an equivalent header name MUST be ignored. Due to the
								// case-insensitivity of header names, "foo" and "Foo" are considered
								// equivalent.
								name!: strings.MaxRunes(
									256) & strings.MinRunes(
									1) & =~"^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"

								// Value is the value of HTTP Header to be matched.
								// <gateway:experimental:description>
								// Must consist of printable US-ASCII characters, optionally separated
								// by single tabs or spaces. See: https://tools.ietf.org/html/rfc7230#section-3.2
								// </gateway:experimental:description>
								//
								// <gateway:experimental:validation:Pattern=`^[!-~]+([\t ]?[!-~]+)*$`>
								value!: strings.MaxRunes(
									4096) & strings.MinRunes(
									1)
							}]
						}

						// RequestMirror defines a schema for a filter that mirrors requests.
						// Requests are sent to the specified destination, but responses from
						// that destination are ignored.
						//
						// This filter can be used multiple times within the same rule. Note that
						// not all implementations will be able to support mirroring to multiple
						// backends.
						//
						// Support: Extended
						requestMirror?: {
							// BackendRef references a resource where mirrored requests are sent.
							//
							// Mirrored requests must be sent only to a single destination endpoint
							// within this BackendRef, irrespective of how many endpoints are present
							// within this BackendRef.
							//
							// If the referent cannot be found, this BackendRef is invalid and must be
							// dropped from the Gateway. The controller must ensure the "ResolvedRefs"
							// condition on the Route status is set to `status: False` and not configure
							// this backend in the underlying implementation.
							//
							// If there is a cross-namespace reference to an *existing* object
							// that is not allowed by a ReferenceGrant, the controller must ensure the
							// "ResolvedRefs" condition on the Route is set to `status: False`,
							// with the "RefNotPermitted" reason and not configure this backend in the
							// underlying implementation.
							//
							// In either error case, the Message of the `ResolvedRefs` Condition
							// should be used to provide more detail about the problem.
							//
							// Support: Extended for Kubernetes Service
							//
							// Support: Implementation-specific for any other resource
							//
							// If the backend service requires TLS, use BackendTLSPolicy to tell the
							// implementation to supply the TLS details to be used to connect to that
							// backend.
							backendRef!: {
								// Group is the group of the referent. For example, "gateway.networking.k8s.io".
								// When unspecified or empty string, core API group is inferred.
								group?: strings.MaxRunes(
									253) & =~"^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

								// Kind is the Kubernetes resource kind of the referent. For example
								// "Service".
								//
								// Defaults to "Service" when not specified.
								//
								// ExternalName services can refer to CNAME DNS records that may live
								// outside of the cluster and as such are difficult to reason about in
								// terms of conformance. They also may not be safe to forward to (see
								// CVE-2021-25740 for more information). Implementations SHOULD NOT
								// support ExternalName Services.
								//
								// Support: Core (Services with a type other than ExternalName)
								//
								// Support: Implementation-specific (Services with type ExternalName)
								kind?: strings.MaxRunes(
									63) & strings.MinRunes(
									1) & =~"^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"

								// Name is the name of the referent.
								name!: strings.MaxRunes(
									253) & strings.MinRunes(
									1)

								// Namespace is the namespace of the backend. When unspecified, the local
								// namespace is inferred.
								//
								// Note that when a namespace different than the local namespace is specified,
								// a ReferenceGrant object is required in the referent namespace to allow that
								// namespace's owner to accept the reference. See the ReferenceGrant
								// documentation for details.
								//
								// Support: Core
								namespace?: strings.MaxRunes(
										63) & strings.MinRunes(
										1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"

								// Port specifies the destination port number to use for this resource.
								// Port is required when the referent is a Kubernetes Service. In this
								// case, the port number is the service port number, not the target port.
								// For other resources, destination port might be derived from the referent
								// resource or this field.
								port?: int32 & int & <=65535 & >=1
							}

							// Fraction represents the fraction of requests that should be
							// mirrored to BackendRef.
							//
							// Only one of Fraction or Percent may be specified. If neither field
							// is specified, 100% of requests will be mirrored.
							fraction?: {
								denominator?: int32 & int & >=1
								numerator!:   int32 & int & >=0
							}

							// Percent represents the percentage of requests that should be
							// mirrored to BackendRef. Its minimum value is 0 (indicating 0% of
							// requests) and its maximum value is 100 (indicating 100% of requests).
							//
							// Only one of Fraction or Percent may be specified. If neither field
							// is specified, 100% of requests will be mirrored.
							percent?: int32 & int & <=100 & >=0
						}

						// RequestRedirect defines a schema for a filter that responds to the
						// request with an HTTP redirection.
						//
						// Support: Core
						requestRedirect?: {
							// Hostname is the hostname to be used in the value of the `Location`
							// header in the response.
							// When empty, the hostname in the `Host` header of the request is used.
							//
							// Support: Core
							hostname?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

							// Path defines parameters used to modify the path of the incoming request.
							// The modified path is then used to construct the `Location` header. When
							// empty, the request path is used as-is.
							//
							// Support: Extended
							path?: {
								// ReplaceFullPath specifies the value with which to replace the full path
								// of a request during a rewrite or redirect.
								replaceFullPath?: strings.MaxRunes(
											1024)

								// ReplacePrefixMatch specifies the value with which to replace the prefix
								// match of a request during a rewrite or redirect. For example, a request
								// to "/foo/bar" with a prefix match of "/foo" and a ReplacePrefixMatch
								// of "/xyz" would be modified to "/xyz/bar".
								//
								// Note that this matches the behavior of the PathPrefix match type. This
								// matches full path elements. A path element refers to the list of labels
								// in the path split by the `/` separator. When specified, a trailing `/` is
								// ignored. For example, the paths `/abc`, `/abc/`, and `/abc/def` would all
								// match the prefix `/abc`, but the path `/abcd` would not.
								//
								// ReplacePrefixMatch is only compatible with a `PathPrefix` HTTPRouteMatch.
								// Using any other HTTPRouteMatch type on the same HTTPRouteRule will result in
								// the implementation setting the Accepted Condition for the Route to `status: False`.
								//
								// Request Path | Prefix Match | Replace Prefix | Modified Path
								replacePrefixMatch?: strings.MaxRunes(
											1024)

								// Type defines the type of path modifier. Additional types may be
								// added in a future release of the API.
								//
								// Note that values may be added to this enum, implementations
								// must ensure that unknown values will not cause a crash.
								//
								// Unknown values here must result in the implementation setting the
								// Accepted Condition for the Route to `status: False`, with a
								// Reason of `UnsupportedValue`.
								type!: "ReplaceFullPath" | "ReplacePrefixMatch"
							}

							// Port is the port to be used in the value of the `Location`
							// header in the response.
							//
							// If no port is specified, the redirect port MUST be derived using the
							// following rules:
							//
							// * If redirect scheme is not-empty, the redirect port MUST be the well-known
							// port associated with the redirect scheme. Specifically "http" to port 80
							// and "https" to port 443. If the redirect scheme does not have a
							// well-known port, the listener port of the Gateway SHOULD be used.
							// * If redirect scheme is empty, the redirect port MUST be the Gateway
							// Listener port.
							//
							// Implementations SHOULD NOT add the port number in the 'Location'
							// header in the following cases:
							//
							// * A Location header that will use HTTP (whether that is determined via
							// the Listener protocol or the Scheme field) _and_ use port 80.
							// * A Location header that will use HTTPS (whether that is determined via
							// the Listener protocol or the Scheme field) _and_ use port 443.
							//
							// Support: Extended
							port?: int32 & int & <=65535 & >=1

							// Scheme is the scheme to be used in the value of the `Location` header in
							// the response. When empty, the scheme of the request is used.
							//
							// Scheme redirects can affect the port of the redirect, for more information,
							// refer to the documentation for the port field of this filter.
							//
							// Note that values may be added to this enum, implementations
							// must ensure that unknown values will not cause a crash.
							//
							// Unknown values here must result in the implementation setting the
							// Accepted Condition for the Route to `status: False`, with a
							// Reason of `UnsupportedValue`.
							//
							// Support: Extended
							scheme?: "http" | "https"

							// StatusCode is the HTTP status code to be used in response.
							//
							// Note that values may be added to this enum, implementations
							// must ensure that unknown values will not cause a crash.
							//
							// Unknown values here must result in the implementation setting the
							// Accepted Condition for the Route to `status: False`, with a
							// Reason of `UnsupportedValue`.
							//
							// Support: Core
							statusCode?: (301 | 302 | 303 | 307 | 308) & int
						}

						// ResponseHeaderModifier defines a schema for a filter that modifies response
						// headers.
						//
						// Support: Extended
						responseHeaderModifier?: {
							// Add adds the given header(s) (name, value) to the request
							// before the action. It appends to any existing values associated
							// with the header name.
							//
							// Input:
							// GET /foo HTTP/1.1
							// my-header: foo
							//
							// Config:
							// add:
							// - name: "my-header"
							// value: "bar,baz"
							//
							// Output:
							// GET /foo HTTP/1.1
							// my-header: foo,bar,baz
							add?: list.MaxItems(16) & [...{
								// Name is the name of the HTTP Header to be matched. Name matching MUST be
								// case-insensitive. (See https://tools.ietf.org/html/rfc7230#section-3.2).
								//
								// If multiple entries specify equivalent header names, the first entry with
								// an equivalent name MUST be considered for a match. Subsequent entries
								// with an equivalent header name MUST be ignored. Due to the
								// case-insensitivity of header names, "foo" and "Foo" are considered
								// equivalent.
								name!: strings.MaxRunes(
									256) & strings.MinRunes(
									1) & =~"^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"

								// Value is the value of HTTP Header to be matched.
								// <gateway:experimental:description>
								// Must consist of printable US-ASCII characters, optionally separated
								// by single tabs or spaces. See: https://tools.ietf.org/html/rfc7230#section-3.2
								// </gateway:experimental:description>
								//
								// <gateway:experimental:validation:Pattern=`^[!-~]+([\t ]?[!-~]+)*$`>
								value!: strings.MaxRunes(
									4096) & strings.MinRunes(
									1)
							}]

							// Remove the given header(s) from the HTTP request before the action. The
							// value of Remove is a list of HTTP header names. Note that the header
							// names are case-insensitive (see
							// https://datatracker.ietf.org/doc/html/rfc2616#section-4.2).
							//
							// Input:
							// GET /foo HTTP/1.1
							// my-header1: foo
							// my-header2: bar
							// my-header3: baz
							//
							// Config:
							// remove: ["my-header1", "my-header3"]
							//
							// Output:
							// GET /foo HTTP/1.1
							// my-header2: bar
							remove?: list.MaxItems(16) & [...string]

							// Set overwrites the request with the given header (name, value)
							// before the action.
							//
							// Input:
							// GET /foo HTTP/1.1
							// my-header: foo
							//
							// Config:
							// set:
							// - name: "my-header"
							// value: "bar"
							//
							// Output:
							// GET /foo HTTP/1.1
							// my-header: bar
							set?: list.MaxItems(16) & [...{
								// Name is the name of the HTTP Header to be matched. Name matching MUST be
								// case-insensitive. (See https://tools.ietf.org/html/rfc7230#section-3.2).
								//
								// If multiple entries specify equivalent header names, the first entry with
								// an equivalent name MUST be considered for a match. Subsequent entries
								// with an equivalent header name MUST be ignored. Due to the
								// case-insensitivity of header names, "foo" and "Foo" are considered
								// equivalent.
								name!: strings.MaxRunes(
									256) & strings.MinRunes(
									1) & =~"^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"

								// Value is the value of HTTP Header to be matched.
								// <gateway:experimental:description>
								// Must consist of printable US-ASCII characters, optionally separated
								// by single tabs or spaces. See: https://tools.ietf.org/html/rfc7230#section-3.2
								// </gateway:experimental:description>
								//
								// <gateway:experimental:validation:Pattern=`^[!-~]+([\t ]?[!-~]+)*$`>
								value!: strings.MaxRunes(
									4096) & strings.MinRunes(
									1)
							}]
						}

						// Type identifies the type of filter to apply. As with other API fields,
						// types are classified into three conformance levels:
						//
						// - Core: Filter types and their corresponding configuration defined by
						// "Support: Core" in this package, e.g. "RequestHeaderModifier". All
						// implementations must support core filters.
						//
						// - Extended: Filter types and their corresponding configuration defined by
						// "Support: Extended" in this package, e.g. "RequestMirror". Implementers
						// are encouraged to support extended filters.
						//
						// - Implementation-specific: Filters that are defined and supported by
						// specific vendors.
						// In the future, filters showing convergence in behavior across multiple
						// implementations will be considered for inclusion in extended or core
						// conformance levels. Filter-specific configuration for such filters
						// is specified using the ExtensionRef field. `Type` should be set to
						// "ExtensionRef" for custom filters.
						//
						// Implementers are encouraged to define custom implementation types to
						// extend the core API with implementation-specific behavior.
						//
						// If a reference to a custom filter type cannot be resolved, the filter
						// MUST NOT be skipped. Instead, requests that would have been processed by
						// that filter MUST receive a HTTP error response.
						//
						// Note that values may be added to this enum, implementations
						// must ensure that unknown values will not cause a crash.
						//
						// Unknown values here must result in the implementation setting the
						// Accepted Condition for the Route to `status: False`, with a
						// Reason of `UnsupportedValue`.
						//
						// <gateway:experimental:validation:Enum=RequestHeaderModifier;ResponseHeaderModifier;RequestMirror;RequestRedirect;URLRewrite;ExtensionRef;CORS;ExternalAuth>
						type!: "RequestHeaderModifier" | "ResponseHeaderModifier" | "RequestMirror" | "RequestRedirect" | "URLRewrite" | "ExtensionRef" | "CORS"

						// URLRewrite defines a schema for a filter that modifies a request during forwarding.
						//
						// Support: Extended
						urlRewrite?: {
							// Hostname is the value to be used to replace the Host header value during
							// forwarding.
							//
							// Support: Extended
							hostname?: strings.MaxRunes(
									253) & strings.MinRunes(
									1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

							// Path defines a path rewrite.
							//
							// Support: Extended
							path?: {
								// ReplaceFullPath specifies the value with which to replace the full path
								// of a request during a rewrite or redirect.
								replaceFullPath?: strings.MaxRunes(
											1024)

								// ReplacePrefixMatch specifies the value with which to replace the prefix
								// match of a request during a rewrite or redirect. For example, a request
								// to "/foo/bar" with a prefix match of "/foo" and a ReplacePrefixMatch
								// of "/xyz" would be modified to "/xyz/bar".
								//
								// Note that this matches the behavior of the PathPrefix match type. This
								// matches full path elements. A path element refers to the list of labels
								// in the path split by the `/` separator. When specified, a trailing `/` is
								// ignored. For example, the paths `/abc`, `/abc/`, and `/abc/def` would all
								// match the prefix `/abc`, but the path `/abcd` would not.
								//
								// ReplacePrefixMatch is only compatible with a `PathPrefix` HTTPRouteMatch.
								// Using any other HTTPRouteMatch type on the same HTTPRouteRule will result in
								// the implementation setting the Accepted Condition for the Route to `status: False`.
								//
								// Request Path | Prefix Match | Replace Prefix | Modified Path
								replacePrefixMatch?: strings.MaxRunes(
											1024)

								// Type defines the type of path modifier. Additional types may be
								// added in a future release of the API.
								//
								// Note that values may be added to this enum, implementations
								// must ensure that unknown values will not cause a crash.
								//
								// Unknown values here must result in the implementation setting the
								// Accepted Condition for the Route to `status: False`, with a
								// Reason of `UnsupportedValue`.
								type!: "ReplaceFullPath" | "ReplacePrefixMatch"
							}
						}
					}]

					// Matches define conditions used for matching the rule against incoming
					// HTTP requests. Each match is independent, i.e. this rule will be matched
					// if **any** one of the matches is satisfied.
					//
					// For example, take the following matches configuration:
					//
					// ```
					// matches:
					// - path:
					// value: "/foo"
					// headers:
					// - name: "version"
					// value: "v2"
					// - path:
					// value: "/v2/foo"
					// ```
					//
					// For a request to match against this rule, a request must satisfy
					// EITHER of the two conditions:
					//
					// - path prefixed with `/foo` AND contains the header `version: v2`
					// - path prefix of `/v2/foo`
					//
					// See the documentation for HTTPRouteMatch on how to specify multiple
					// match conditions that should be ANDed together.
					//
					// If no matches are specified, the default is a prefix
					// path match on "/", which has the effect of matching every
					// HTTP request.
					//
					// Proxy or Load Balancer routing configuration generated from HTTPRoutes
					// MUST prioritize matches based on the following criteria, continuing on
					// ties. Across all rules specified on applicable Routes, precedence must be
					// given to the match having:
					//
					// * "Exact" path match.
					// * "Prefix" path match with largest number of characters.
					// * Method match.
					// * Largest number of header matches.
					// * Largest number of query param matches.
					//
					// Note: The precedence of RegularExpression path matches are implementation-specific.
					//
					// If ties still exist across multiple Routes, matching precedence MUST be
					// determined in order of the following criteria, continuing on ties:
					//
					// * The oldest Route based on creation timestamp.
					// * The Route appearing first in alphabetical order by
					// "{namespace}/{name}".
					//
					// If ties still exist within an HTTPRoute, matching precedence MUST be granted
					// to the FIRST matching rule (in list order) with a match meeting the above
					// criteria.
					//
					// When no rules matching a request have been successfully attached to the
					// parent a request is coming from, a HTTP 404 status code MUST be returned.
					matches?: list.MaxItems(64) & [...{
						// Headers specifies HTTP request header matchers. Multiple match values are
						// ANDed together, meaning, a request must match all the specified headers
						// to select the route.
						headers?: list.MaxItems(16) & [...{
							// Name is the name of the HTTP Header to be matched. Name matching MUST be
							// case-insensitive. (See https://tools.ietf.org/html/rfc7230#section-3.2).
							//
							// If multiple entries specify equivalent header names, only the first
							// entry with an equivalent name MUST be considered for a match. Subsequent
							// entries with an equivalent header name MUST be ignored. Due to the
							// case-insensitivity of header names, "foo" and "Foo" are considered
							// equivalent.
							//
							// When a header is repeated in an HTTP request, it is
							// implementation-specific behavior as to how this is represented.
							// Generally, proxies should follow the guidance from the RFC:
							// https://www.rfc-editor.org/rfc/rfc7230.html#section-3.2.2 regarding
							// processing a repeated header, with special handling for "Set-Cookie".
							name!: strings.MaxRunes(
								256) & strings.MinRunes(
								1) & =~"^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"

							// Type specifies how to match against the value of the header.
							//
							// Support: Core (Exact)
							//
							// Support: Implementation-specific (RegularExpression)
							//
							// Since RegularExpression HeaderMatchType has implementation-specific
							// conformance, implementations can support POSIX, PCRE or any other dialects
							// of regular expressions. Please read the implementation's documentation to
							// determine the supported dialect.
							type?: "Exact" | "RegularExpression"

							// Value is the value of HTTP Header to be matched.
							// <gateway:experimental:description>
							// Must consist of printable US-ASCII characters, optionally separated
							// by single tabs or spaces. See: https://tools.ietf.org/html/rfc7230#section-3.2
							// </gateway:experimental:description>
							//
							// <gateway:experimental:validation:Pattern=`^[!-~]+([\t ]?[!-~]+)*$`>
							value!: strings.MaxRunes(
								4096) & strings.MinRunes(
								1)
						}]

						// Method specifies HTTP method matcher.
						// When specified, this route will be matched only if the request has the
						// specified method.
						//
						// Support: Extended
						method?: "GET" | "HEAD" | "POST" | "PUT" | "DELETE" | "CONNECT" | "OPTIONS" | "TRACE" | "PATCH"

						// Path specifies a HTTP request path matcher. If this field is not
						// specified, a default prefix match on the "/" path is provided.
						path?: {
							// Type specifies how to match against the path Value.
							//
							// Support: Core (Exact, PathPrefix)
							//
							// Support: Implementation-specific (RegularExpression)
							type?: "Exact" | "PathPrefix" | "RegularExpression"

							// Value of the HTTP path to match against.
							value?: strings.MaxRunes(
								1024)
						}

						// QueryParams specifies HTTP query parameter matchers. Multiple match
						// values are ANDed together, meaning, a request must match all the
						// specified query parameters to select the route.
						//
						// Support: Extended
						queryParams?: list.MaxItems(16) & [...{
							// Name is the name of the HTTP query param to be matched. This must be an
							// exact string match. (See
							// https://tools.ietf.org/html/rfc7230#section-2.7.3).
							//
							// If multiple entries specify equivalent query param names, only the first
							// entry with an equivalent name MUST be considered for a match. Subsequent
							// entries with an equivalent query param name MUST be ignored.
							//
							// If a query param is repeated in an HTTP request, the behavior is
							// purposely left undefined, since different data planes have different
							// capabilities. However, it is *recommended* that implementations should
							// match against the first value of the param if the data plane supports it,
							// as this behavior is expected in other load balancing contexts outside of
							// the Gateway API.
							//
							// Users SHOULD NOT route traffic based on repeated query params to guard
							// themselves against potential differences in the implementations.
							name!: strings.MaxRunes(
								256) & strings.MinRunes(
								1) & =~"^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"

							// Type specifies how to match against the value of the query parameter.
							//
							// Support: Extended (Exact)
							//
							// Support: Implementation-specific (RegularExpression)
							//
							// Since RegularExpression QueryParamMatchType has Implementation-specific
							// conformance, implementations can support POSIX, PCRE or any other
							// dialects of regular expressions. Please read the implementation's
							// documentation to determine the supported dialect.
							type?: "Exact" | "RegularExpression"

							// Value is the value of HTTP query param to be matched.
							value!: strings.MaxRunes(
								1024) & strings.MinRunes(
								1)
						}]
					}]

					// Name is the name of the route rule. This name MUST be unique within a Route if it is set.
					//
					// Support: Extended
					name?: strings.MaxRunes(
						253) & strings.MinRunes(
						1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

					// Retry defines the configuration for when to retry an HTTP request.
					//
					// Support: Extended
					//
					// <gateway:experimental>
					retry?: {
						// Attempts specifies the maximum number of times an individual request
						// from the gateway to a backend should be retried.
						//
						// If the maximum number of retries has been attempted without a successful
						// response from the backend, the Gateway MUST return an error.
						//
						// When this field is unspecified, the number of times to attempt to retry
						// a backend request is implementation-specific.
						//
						// Support: Extended
						attempts?: int & >=1

						// Backoff specifies the minimum duration a Gateway should wait between
						// retry attempts and is represented in Gateway API Duration formatting.
						//
						// For example, setting the `rules[].retry.backoff` field to the value
						// `100ms` will cause a backend request to first be retried approximately
						// 100 milliseconds after timing out or receiving a response code configured
						// to be retriable.
						//
						// An implementation MAY use an exponential or alternative backoff strategy
						// for subsequent retry attempts, MAY cap the maximum backoff duration to
						// some amount greater than the specified minimum, and MAY add arbitrary
						// jitter to stagger requests, as long as unsuccessful backend requests are
						// not retried before the configured minimum duration.
						//
						// If a Request timeout (`rules[].timeouts.request`) is configured on the
						// route, the entire duration of the initial request and any retry attempts
						// MUST not exceed the Request timeout duration. If any retry attempts are
						// still in progress when the Request timeout duration has been reached,
						// these SHOULD be canceled if possible and the Gateway MUST immediately
						// return a timeout error.
						//
						// If a BackendRequest timeout (`rules[].timeouts.backendRequest`) is
						// configured on the route, any retry attempts which reach the configured
						// BackendRequest timeout duration without a response SHOULD be canceled if
						// possible and the Gateway should wait for at least the specified backoff
						// duration before attempting to retry the backend request again.
						//
						// If a BackendRequest timeout is _not_ configured on the route, retry
						// attempts MAY time out after an implementation default duration, or MAY
						// remain pending until a configured Request timeout or implementation
						// default duration for total request time is reached.
						//
						// When this field is unspecified, the time to wait between retry attempts
						// is implementation-specific.
						//
						// Support: Extended
						backoff?: =~"^([0-9]{1,5}(h|m|s|ms)){1,4}$"

						// Codes defines the HTTP response status codes for which a backend request
						// should be retried.
						//
						// Support: Extended
						codes?: [...int & <=599 & >=400]
					}

					// SessionPersistence defines and configures session persistence
					// for the route rule.
					//
					// Support: Extended
					//
					// <gateway:experimental>
					sessionPersistence?: {
						// AbsoluteTimeout defines the absolute timeout of the persistent
						// session. Once the AbsoluteTimeout duration has elapsed, the
						// session becomes invalid.
						//
						// Support: Extended
						absoluteTimeout?: =~"^([0-9]{1,5}(h|m|s|ms)){1,4}$"

						// CookieConfig provides configuration settings that are specific
						// to cookie-based session persistence.
						//
						// Support: Core
						cookieConfig?: {
							// LifetimeType specifies whether the cookie has a permanent or
							// session-based lifetime. A permanent cookie persists until its
							// specified expiry time, defined by the Expires or Max-Age cookie
							// attributes, while a session cookie is deleted when the current
							// session ends.
							//
							// When set to "Permanent", AbsoluteTimeout indicates the
							// cookie's lifetime via the Expires or Max-Age cookie attributes
							// and is required.
							//
							// When set to "Session", AbsoluteTimeout indicates the
							// absolute lifetime of the cookie tracked by the gateway and
							// is optional.
							//
							// Defaults to "Session".
							//
							// Support: Core for "Session" type
							//
							// Support: Extended for "Permanent" type
							lifetimeType?: "Permanent" | "Session"
						}

						// SessionName defines the name of the persistent session token
						// which may be reflected in the cookie or the header. Users
						// should avoid reusing session names to prevent unintended
						// consequences, such as rejection or unpredictable behavior.
						//
						// Support: Implementation-specific
						sessionName?: strings.MaxRunes(
								128)

						// Type defines the type of session persistence such as through
						// the use of a header or cookie. Defaults to cookie based session
						// persistence.
						//
						// Support: Core for "Cookie" type
						//
						// Support: Extended for "Header" type
						type?: "Cookie" | "Header"
					}

					// Timeouts defines the timeouts that can be configured for an HTTP request.
					//
					// Support: Extended
					timeouts?: {
						// BackendRequest specifies a timeout for an individual request from the gateway
						// to a backend. This covers the time from when the request first starts being
						// sent from the gateway to when the full response has been received from the backend.
						//
						// Setting a timeout to the zero duration (e.g. "0s") SHOULD disable the timeout
						// completely. Implementations that cannot completely disable the timeout MUST
						// instead interpret the zero duration as the longest possible value to which
						// the timeout can be set.
						//
						// An entire client HTTP transaction with a gateway, covered by the Request timeout,
						// may result in more than one call from the gateway to the destination backend,
						// for example, if automatic retries are supported.
						//
						// The value of BackendRequest must be a Gateway API Duration string as defined by
						// GEP-2257. When this field is unspecified, its behavior is implementation-specific;
						// when specified, the value of BackendRequest must be no more than the value of the
						// Request timeout (since the Request timeout encompasses the BackendRequest timeout).
						//
						// Support: Extended
						backendRequest?: =~"^([0-9]{1,5}(h|m|s|ms)){1,4}$"

						// Request specifies the maximum duration for a gateway to respond to an HTTP request.
						// If the gateway has not been able to respond before this deadline is met, the gateway
						// MUST return a timeout error.
						//
						// For example, setting the `rules.timeouts.request` field to the value `10s` in an
						// `HTTPRoute` will cause a timeout if a client request is taking longer than 10 seconds
						// to complete.
						//
						// Setting a timeout to the zero duration (e.g. "0s") SHOULD disable the timeout
						// completely. Implementations that cannot completely disable the timeout MUST
						// instead interpret the zero duration as the longest possible value to which
						// the timeout can be set.
						//
						// This timeout is intended to cover as close to the whole request-response transaction
						// as possible although an implementation MAY choose to start the timeout after the entire
						// request stream has been received instead of immediately after the transaction is
						// initiated by the client.
						//
						// The value of Request is a Gateway API Duration string as defined by GEP-2257. When this
						// field is unspecified, request timeout behavior is implementation-specific.
						//
						// Support: Extended
						request?: =~"^([0-9]{1,5}(h|m|s|ms)){1,4}$"
					}
				}] & [_, ...]

				// UseDefaultGateways indicates the default Gateway scope to use for this
				// Route. If unset (the default) or set to None, the Route will not be
				// attached to any default Gateway; if set, it will be attached to any
				// default Gateway supporting the named scope, subject to the usual rules
				// about which Routes a Gateway is allowed to claim.
				//
				// Think carefully before using this functionality! The set of default
				// Gateways supporting the requested scope can change over time without
				// any notice to the Route author, and in many situations it will not be
				// appropriate to request a default Gateway for a given Route -- for
				// example, a Route with specific security requirements should almost
				// certainly not use a default Gateway.
				//
				// <gateway:experimental>
				useDefaultGateways?: "All" | "None"
			}
		}

		// Ingress sets how the ingress object should look like with your grafana instance.
		ingress?: {
			// ObjectMeta contains only a [subset of the fields included in
			// k8s.io/apimachinery/pkg/apis/meta/v1.ObjectMeta](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.27/#objectmeta-v1-meta).
			metadata?: {
				annotations?: [string]: string
				labels?: [string]:      string
			}

			// IngressSpec describes the Ingress the user wishes to exist.
			spec?: {
				// defaultBackend is the backend that should handle requests that don't
				// match any rule. If Rules are not specified, DefaultBackend must be specified.
				// If DefaultBackend is not set, the handling of requests that do not match any
				// of the rules will be up to the Ingress controller.
				defaultBackend?: {
					// resource is an ObjectRef to another Kubernetes resource in the namespace
					// of the Ingress object. If resource is specified, a service.Name and
					// service.Port must not be specified.
					// This is a mutually exclusive setting with "Service".
					resource?: {
						// APIGroup is the group for the resource being referenced.
						// If APIGroup is not specified, the specified Kind must be in the core API group.
						// For any other third-party types, APIGroup is required.
						apiGroup?: string

						// Kind is the type of resource being referenced
						kind!: string

						// Name is the name of resource being referenced
						name!: string
					}

					// service references a service as a backend.
					// This is a mutually exclusive setting with "Resource".
					service?: {
						// name is the referenced service. The service must exist in
						// the same namespace as the Ingress object.
						name!: string

						// port of the referenced service. A port name or port number
						// is required for a IngressServiceBackend.
						port?: {
							// name is the name of the port on the Service.
							// This is a mutually exclusive setting with "Number".
							name?: string

							// number is the numerical port number (e.g. 80) on the Service.
							// This is a mutually exclusive setting with "Name".
							number?: int32 & int
						}
					}
				}

				// ingressClassName is the name of an IngressClass cluster resource. Ingress
				// controller implementations use this field to know whether they should be
				// serving this Ingress resource, by a transitive connection
				// (controller -> IngressClass -> Ingress resource). Although the
				// `kubernetes.io/ingress.class` annotation (simple constant name) was never
				// formally defined, it was widely supported by Ingress controllers to create
				// a direct binding between Ingress controller and Ingress resources. Newly
				// created Ingress resources should prefer using the field. However, even
				// though the annotation is officially deprecated, for backwards compatibility
				// reasons, ingress controllers should still honor that annotation if present.
				ingressClassName?: string

				// rules is a list of host rules used to configure the Ingress. If unspecified,
				// or no rule matches, all traffic is sent to the default backend.
				rules?: [...{
					// host is the fully qualified domain name of a network host, as defined by RFC 3986.
					// Note the following deviations from the "host" part of the
					// URI as defined in RFC 3986:
					// 1. IPs are not allowed. Currently an IngressRuleValue can only apply to
					// the IP in the Spec of the parent Ingress.
					// 2. The `:` delimiter is not respected because ports are not allowed.
					// Currently the port of an Ingress is implicitly :80 for http and
					// :443 for https.
					// Both these may change in the future.
					// Incoming requests are matched against the host before the
					// IngressRuleValue. If the host is unspecified, the Ingress routes all
					// traffic based on the specified IngressRuleValue.
					//
					// host can be "precise" which is a domain name without the terminating dot of
					// a network host (e.g. "foo.bar.com") or "wildcard", which is a domain name
					// prefixed with a single wildcard label (e.g. "*.foo.com").
					// The wildcard character '*' must appear by itself as the first DNS label and
					// matches only a single label. You cannot have a wildcard label by itself (e.g. Host == "*").
					// Requests will be matched against the Host field in the following way:
					// 1. If host is precise, the request matches this rule if the http host header is equal to Host.
					// 2. If host is a wildcard, then the request matches this rule if the http host header
					// is to equal to the suffix (removing the first label) of the wildcard rule.
					host?: string

					// HTTPIngressRuleValue is a list of http selectors pointing to backends.
					// In the example: http://<host>/<path>?<searchpart> -> backend where
					// where parts of the url correspond to RFC 3986, this resource will be used
					// to match against everything after the last '/' and before the first '?'
					// or '#'.
					http?: {
						// paths is a collection of paths that map requests to backends.
						paths!: [...{
							// backend defines the referenced service endpoint to which the traffic
							// will be forwarded to.
							backend!: {
								// resource is an ObjectRef to another Kubernetes resource in the namespace
								// of the Ingress object. If resource is specified, a service.Name and
								// service.Port must not be specified.
								// This is a mutually exclusive setting with "Service".
								resource?: {
									// APIGroup is the group for the resource being referenced.
									// If APIGroup is not specified, the specified Kind must be in the core API group.
									// For any other third-party types, APIGroup is required.
									apiGroup?: string

									// Kind is the type of resource being referenced
									kind!: string

									// Name is the name of resource being referenced
									name!: string
								}

								// service references a service as a backend.
								// This is a mutually exclusive setting with "Resource".
								service?: {
									// name is the referenced service. The service must exist in
									// the same namespace as the Ingress object.
									name!: string

									// port of the referenced service. A port name or port number
									// is required for a IngressServiceBackend.
									port?: {
										// name is the name of the port on the Service.
										// This is a mutually exclusive setting with "Number".
										name?: string

										// number is the numerical port number (e.g. 80) on the Service.
										// This is a mutually exclusive setting with "Name".
										number?: int32 & int
									}
								}
							}

							// path is matched against the path of an incoming request. Currently it can
							// contain characters disallowed from the conventional "path" part of a URL
							// as defined by RFC 3986. Paths must begin with a '/' and must be present
							// when using PathType with value "Exact" or "Prefix".
							path?: string

							// pathType determines the interpretation of the path matching. PathType can
							// be one of the following values:
							// * Exact: Matches the URL path exactly.
							// * Prefix: Matches based on a URL path prefix split by '/'. Matching is
							// done on a path element by element basis. A path element refers is the
							// list of labels in the path split by the '/' separator. A request is a
							// match for path p if every p is an element-wise prefix of p of the
							// request path. Note that if the last element of the path is a substring
							// of the last element in request path, it is not a match (e.g. /foo/bar
							// matches /foo/bar/baz, but does not match /foo/barbaz).
							// * ImplementationSpecific: Interpretation of the Path matching is up to
							// the IngressClass. Implementations can treat this as a separate PathType
							// or treat it identically to Prefix or Exact path types.
							// Implementations are required to support all path types.
							pathType!: string
						}]
					}
				}]

				// tls represents the TLS configuration. Currently the Ingress only supports a
				// single TLS port, 443. If multiple members of this list specify different hosts,
				// they will be multiplexed on the same port according to the hostname specified
				// through the SNI TLS extension, if the ingress controller fulfilling the
				// ingress supports SNI.
				tls?: [...{
					// hosts is a list of hosts included in the TLS certificate. The values in
					// this list must match the name/s used in the tlsSecret. Defaults to the
					// wildcard host setting for the loadbalancer controller fulfilling this
					// Ingress, if left unspecified.
					hosts?: [...string]

					// secretName is the name of the secret used to terminate TLS traffic on
					// port 443. Field is left optional to allow TLS routing based on SNI
					// hostname alone. If the SNI host in a listener conflicts with the "Host"
					// header field used by an IngressRule, the SNI host is used for termination
					// and value of the "Host" header is used for routing.
					secretName?: string
				}]
			}
		}
		jsonnet?: {
			// A label selector is a label query over a set of resources. The result of matchLabels and
			// matchExpressions are ANDed. An empty label selector matches all objects. A null
			// label selector matches no objects.
			libraryLabelSelector?: {
				// matchExpressions is a list of label selector requirements. The requirements are ANDed.
				matchExpressions?: [...{
					// key is the label key that the selector applies to.
					key!: string

					// operator represents a key's relationship to a set of values.
					// Valid operators are In, NotIn, Exists and DoesNotExist.
					operator!: string

					// values is an array of string values. If the operator is In or NotIn,
					// the values array must be non-empty. If the operator is Exists or DoesNotExist,
					// the values array must be empty. This array is replaced during a strategic
					// merge patch.
					values?: [...string]
				}]

				// matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels
				// map is equivalent to an element of matchExpressions, whose key field is "key", the
				// operator is "In", and the values array contains only "value". The requirements are ANDed.
				matchLabels?: [string]: string
			}
		}

		// PersistentVolumeClaim creates a PVC if you need to attach one to your grafana instance.
		persistentVolumeClaim?: {
			// ObjectMeta contains only a [subset of the fields included in
			// k8s.io/apimachinery/pkg/apis/meta/v1.ObjectMeta](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.27/#objectmeta-v1-meta).
			metadata?: {
				annotations?: [string]: string
				labels?: [string]:      string
			}
			spec?: {
				accessModes?: [...string]

				// TypedLocalObjectReference contains enough information to let you locate the
				// typed referenced object inside the same namespace.
				dataSource?: {
					// APIGroup is the group for the resource being referenced.
					// If APIGroup is not specified, the specified Kind must be in the core API group.
					// For any other third-party types, APIGroup is required.
					apiGroup?: string

					// Kind is the type of resource being referenced
					kind!: string

					// Name is the name of resource being referenced
					name!: string
				}

				// TypedLocalObjectReference contains enough information to let you locate the
				// typed referenced object inside the same namespace.
				dataSourceRef?: {
					// APIGroup is the group for the resource being referenced.
					// If APIGroup is not specified, the specified Kind must be in the core API group.
					// For any other third-party types, APIGroup is required.
					apiGroup?: string

					// Kind is the type of resource being referenced
					kind!: string

					// Name is the name of resource being referenced
					name!: string
				}

				// ResourceRequirements describes the compute resource requirements.
				resources?: {
					// Claims lists the names of resources, defined in spec.resourceClaims,
					// that are used by this container.
					//
					// This field depends on the
					// DynamicResourceAllocation feature gate.
					//
					// This field is immutable. It can only be set for containers.
					claims?: [...{
						// Name must match the name of one entry in pod.spec.resourceClaims of
						// the Pod where this field is used. It makes that resource available
						// inside a container.
						name!: string

						// Request is the name chosen for a request in the referenced claim.
						// If empty, everything from the claim is made available, otherwise
						// only the result of this request.
						request?: string
					}]

					// Limits describes the maximum amount of compute resources allowed.
					// More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/
					limits?: [string]: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")

					// Requests describes the minimum amount of compute resources required.
					// If Requests is omitted for a container, it defaults to Limits if that is explicitly specified,
					// otherwise to an implementation-defined value. Requests cannot exceed Limits.
					// More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/
					requests?: [string]: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")
				}

				// A label selector is a label query over a set of resources. The result of matchLabels and
				// matchExpressions are ANDed. An empty label selector matches all objects. A null
				// label selector matches no objects.
				selector?: {
					// matchExpressions is a list of label selector requirements. The requirements are ANDed.
					matchExpressions?: [...{
						// key is the label key that the selector applies to.
						key!: string

						// operator represents a key's relationship to a set of values.
						// Valid operators are In, NotIn, Exists and DoesNotExist.
						operator!: string

						// values is an array of string values. If the operator is In or NotIn,
						// the values array must be non-empty. If the operator is Exists or DoesNotExist,
						// the values array must be empty. This array is replaced during a strategic
						// merge patch.
						values?: [...string]
					}]

					// matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels
					// map is equivalent to an element of matchExpressions, whose key field is "key", the
					// operator is "In", and the values array contains only "value". The requirements are ANDed.
					matchLabels?: [string]: string
				}
				storageClassName?: string

				// PersistentVolumeMode describes how a volume is intended to be consumed,
				// either Block or Filesystem.
				volumeMode?: string

				// VolumeName is the binding reference to the PersistentVolume backing this claim.
				volumeName?: string
			}
		}

		// Preferences holds the Grafana Preferences settings
		preferences?: homeDashboardUid?: string

		// Route sets how the ingress object should look like with your grafana
		// instance, this only works in Openshift.
		route?: {
			// ObjectMeta contains only a [subset of the fields included in
			// k8s.io/apimachinery/pkg/apis/meta/v1.ObjectMeta](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.27/#objectmeta-v1-meta).
			metadata?: {
				annotations?: [string]: string
				labels?: [string]:      string
			}
			spec?: {
				alternateBackends?: [...{
					// The kind of target that the route is referring to. Currently, only 'Service' is allowed
					kind!: "Service" | ""

					// name of the service/target that is being referred to. e.g. name of the service
					name!: strings.MinRunes(
						1)

					// weight as an integer between 0 and 256, default 100, that specifies the target's relative weight
					// against other target reference objects. 0 suppresses requests to this backend.
					weight?: int32 & int & <=256 & >=0
				}]
				host?: string
				path?: string

				// RoutePort defines a port mapping from a router to an endpoint in the service endpoints.
				port?: {
					// The target port on pods selected by the service this route points to.
					// If this is a string, it will be looked up as a named port in the target
					// endpoints port list. Required
					targetPort!: matchN(>=1, [int, string]) & (int | string)
				}
				subdomain?: string

				// TLSConfig defines config used to secure a route and provide termination
				tls?: {
					// caCertificate provides the cert authority certificate contents
					caCertificate?: string

					// certificate provides certificate contents. This should be a single serving
					// certificate, not a certificate
					// chain. Do not include a CA certificate.
					certificate?: string

					// destinationCACertificate provides the contents of the ca certificate of the
					// final destination. When using reencrypt
					// termination this file should be provided in order to have routers use it for
					// health checks on the secure connection.
					// If this field is not specified, the router may provide its own destination CA
					// and perform hostname validation using
					// the short service name (service.namespace.svc), which allows infrastructure
					// generated certificates to automatically
					// verify.
					destinationCACertificate?: string

					// externalCertificate provides certificate contents as a secret reference.
					// This should be a single serving certificate, not a certificate
					// chain. Do not include a CA certificate. The secret referenced should
					// be present in the same namespace as that of the Route.
					// Forbidden when `certificate` is set.
					// The router service account needs to be granted with read-only access to this secret,
					// please refer to openshift docs for additional details.
					externalCertificate?: {
						// name of the referent.
						// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
						name?: string
					}

					// insecureEdgeTerminationPolicy indicates the desired behavior for insecure
					// connections to a route. While
					// each router may make its own decisions on which ports to expose, this is normally port 80.
					//
					// If a route does not specify insecureEdgeTerminationPolicy, then the default behavior is "None".
					//
					// * Allow - traffic is sent to the server on the insecure port (edge/reencrypt terminations only).
					//
					// * None - no traffic is allowed on the insecure port (default).
					//
					// * Redirect - clients are redirected to the secure port.
					insecureEdgeTerminationPolicy?: "Allow" | "None" | "Redirect" | ""

					// key provides key file contents
					key?: string

					// termination indicates termination type.
					//
					// * edge - TLS termination is done by the router and http is used to
					// communicate with the backend (default)
					// * passthrough - Traffic is sent straight to the destination without the
					// router providing TLS termination
					// * reencrypt - TLS termination is done by the router and https is used to
					// communicate with the backend
					//
					// Note: passthrough termination is incompatible with httpHeader actions
					termination!: "edge" | "reencrypt" | "passthrough"
				}

				// RouteTargetReference specifies the target that resolve into endpoints. Only the 'Service'
				// kind is allowed. Use 'weight' field to emphasize one over others.
				to?: {
					// The kind of target that the route is referring to. Currently, only 'Service' is allowed
					kind!: "Service" | ""

					// name of the service/target that is being referred to. e.g. name of the service
					name!: strings.MinRunes(
						1)

					// weight as an integer between 0 and 256, default 100, that specifies the target's relative weight
					// against other target reference objects. 0 suppresses requests to this backend.
					weight?: int32 & int & <=256 & >=0
				}

				// WildcardPolicyType indicates the type of wildcard support needed by routes.
				wildcardPolicy?: string
			}
		}

		// Service sets how the service object should look like with your grafana
		// instance, contains a number of defaults.
		service?: {
			// ObjectMeta contains only a [subset of the fields included in
			// k8s.io/apimachinery/pkg/apis/meta/v1.ObjectMeta](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.27/#objectmeta-v1-meta).
			metadata?: {
				annotations?: [string]: string
				labels?: [string]:      string
			}

			// ServiceSpec describes the attributes that a user creates on a service.
			spec?: {
				// allocateLoadBalancerNodePorts defines if NodePorts will be automatically
				// allocated for services with type LoadBalancer. Default is "true". It
				// may be set to "false" if the cluster load-balancer does not rely on
				// NodePorts. If the caller requests specific NodePorts (by specifying a
				// value), those requests will be respected, regardless of this field.
				// This field may only be set for services with type LoadBalancer and will
				// be cleared if the type is changed to any other type.
				allocateLoadBalancerNodePorts?: bool

				// clusterIP is the IP address of the service and is usually assigned
				// randomly. If an address is specified manually, is in-range (as per
				// system configuration), and is not in use, it will be allocated to the
				// service; otherwise creation of the service will fail. This field may not
				// be changed through updates unless the type field is also being changed
				// to ExternalName (which requires this field to be blank) or the type
				// field is being changed from ExternalName (in which case this field may
				// optionally be specified, as describe above). Valid values are "None",
				// empty string (""), or a valid IP address. Setting this to "None" makes a
				// "headless service" (no virtual IP), which is useful when direct endpoint
				// connections are preferred and proxying is not required. Only applies to
				// types ClusterIP, NodePort, and LoadBalancer. If this field is specified
				// when creating a Service of type ExternalName, creation will fail. This
				// field will be wiped when updating a Service to type ExternalName.
				// More info:
				// https://kubernetes.io/docs/concepts/services-networking/service/#virtual-ips-and-service-proxies
				clusterIP?: string

				// ClusterIPs is a list of IP addresses assigned to this service, and are
				// usually assigned randomly. If an address is specified manually, is
				// in-range (as per system configuration), and is not in use, it will be
				// allocated to the service; otherwise creation of the service will fail.
				// This field may not be changed through updates unless the type field is
				// also being changed to ExternalName (which requires this field to be
				// empty) or the type field is being changed from ExternalName (in which
				// case this field may optionally be specified, as describe above). Valid
				// values are "None", empty string (""), or a valid IP address. Setting
				// this to "None" makes a "headless service" (no virtual IP), which is
				// useful when direct endpoint connections are preferred and proxying is
				// not required. Only applies to types ClusterIP, NodePort, and
				// LoadBalancer. If this field is specified when creating a Service of type
				// ExternalName, creation will fail. This field will be wiped when updating
				// a Service to type ExternalName. If this field is not specified, it will
				// be initialized from the clusterIP field. If this field is specified,
				// clients must ensure that clusterIPs[0] and clusterIP have the same
				// value.
				//
				// This field may hold a maximum of two entries (dual-stack IPs, in either order).
				// These IPs must correspond to the values of the ipFamilies field. Both
				// clusterIPs and ipFamilies are governed by the ipFamilyPolicy field.
				// More info:
				// https://kubernetes.io/docs/concepts/services-networking/service/#virtual-ips-and-service-proxies
				clusterIPs?: [...string]

				// externalIPs is a list of IP addresses for which nodes in the cluster
				// will also accept traffic for this service. These IPs are not managed by
				// Kubernetes. The user is responsible for ensuring that traffic arrives
				// at a node with this IP. A common example is external load-balancers
				// that are not part of the Kubernetes system.
				externalIPs?: [...string]

				// externalName is the external reference that discovery mechanisms will
				// return as an alias for this service (e.g. a DNS CNAME record). No
				// proxying will be involved. Must be a lowercase RFC-1123 hostname
				// (https://tools.ietf.org/html/rfc1123) and requires `type` to be "ExternalName".
				externalName?: string

				// externalTrafficPolicy describes how nodes distribute service traffic they
				// receive on one of the Service's "externally-facing" addresses (NodePorts,
				// ExternalIPs, and LoadBalancer IPs). If set to "Local", the proxy will configure
				// the service in a way that assumes that external load balancers will take care
				// of balancing the service traffic between nodes, and so each node will deliver
				// traffic only to the node-local endpoints of the service, without masquerading
				// the client source IP. (Traffic mistakenly sent to a node with no endpoints will
				// be dropped.) The default value, "Cluster", uses the standard behavior of
				// routing to all endpoints evenly (possibly modified by topology and other
				// features). Note that traffic sent to an External IP or LoadBalancer IP from
				// within the cluster will always get "Cluster" semantics, but clients sending to
				// a NodePort from within the cluster may need to take traffic policy into account
				// when picking a node.
				externalTrafficPolicy?: string

				// healthCheckNodePort specifies the healthcheck nodePort for the service.
				// This only applies when type is set to LoadBalancer and
				// externalTrafficPolicy is set to Local. If a value is specified, is
				// in-range, and is not in use, it will be used. If not specified, a value
				// will be automatically allocated. External systems (e.g. load-balancers)
				// can use this port to determine if a given node holds endpoints for this
				// service or not. If this field is specified when creating a Service
				// which does not need it, creation will fail. This field will be wiped
				// when updating a Service to no longer need it (e.g. changing type).
				// This field cannot be updated once set.
				healthCheckNodePort?: int32 & int

				// InternalTrafficPolicy describes how nodes distribute service traffic they
				// receive on the ClusterIP. If set to "Local", the proxy will assume that pods
				// only want to talk to endpoints of the service on the same node as the pod,
				// dropping the traffic if there are no local endpoints. The default value,
				// "Cluster", uses the standard behavior of routing to all endpoints evenly
				// (possibly modified by topology and other features).
				internalTrafficPolicy?: string

				// IPFamilies is a list of IP families (e.g. IPv4, IPv6) assigned to this
				// service. This field is usually assigned automatically based on cluster
				// configuration and the ipFamilyPolicy field. If this field is specified
				// manually, the requested family is available in the cluster,
				// and ipFamilyPolicy allows it, it will be used; otherwise creation of
				// the service will fail. This field is conditionally mutable: it allows
				// for adding or removing a secondary IP family, but it does not allow
				// changing the primary IP family of the Service. Valid values are "IPv4"
				// and "IPv6". This field only applies to Services of types ClusterIP,
				// NodePort, and LoadBalancer, and does apply to "headless" services.
				// This field will be wiped when updating a Service to type ExternalName.
				//
				// This field may hold a maximum of two entries (dual-stack families, in
				// either order). These families must correspond to the values of the
				// clusterIPs field, if specified. Both clusterIPs and ipFamilies are
				// governed by the ipFamilyPolicy field.
				ipFamilies?: [...string]

				// IPFamilyPolicy represents the dual-stack-ness requested or required by
				// this Service. If there is no value provided, then this field will be set
				// to SingleStack. Services can be "SingleStack" (a single IP family),
				// "PreferDualStack" (two IP families on dual-stack configured clusters or
				// a single IP family on single-stack clusters), or "RequireDualStack"
				// (two IP families on dual-stack configured clusters, otherwise fail). The
				// ipFamilies and clusterIPs fields depend on the value of this field. This
				// field will be wiped when updating a service to type ExternalName.
				ipFamilyPolicy?: string

				// loadBalancerClass is the class of the load balancer implementation this Service belongs to.
				// If specified, the value of this field must be a label-style identifier, with an optional prefix,
				// e.g. "internal-vip" or "example.com/internal-vip". Unprefixed names are reserved for end-users.
				// This field can only be set when the Service type is 'LoadBalancer'. If not set, the default load
				// balancer implementation is used, today this is typically done through the
				// cloud provider integration,
				// but should apply for any default implementation. If set, it is assumed that a load balancer
				// implementation is watching for Services with a matching class. Any default load balancer
				// implementation (e.g. cloud providers) should ignore Services that set this field.
				// This field can only be set when creating or updating a Service to type 'LoadBalancer'.
				// Once set, it can not be changed. This field will be wiped when a service is
				// updated to a non 'LoadBalancer' type.
				loadBalancerClass?: string

				// Only applies to Service Type: LoadBalancer.
				// This feature depends on whether the underlying cloud-provider supports specifying
				// the loadBalancerIP when a load balancer is created.
				// This field will be ignored if the cloud-provider does not support the feature.
				// Deprecated: This field was under-specified and its meaning varies across implementations.
				// Using it is non-portable and it may not support dual-stack.
				// Users are encouraged to use implementation-specific annotations when available.
				loadBalancerIP?: string

				// If specified and supported by the platform, this will restrict traffic through the cloud-provider
				// load-balancer will be restricted to the specified client IPs. This field will be ignored if the
				// cloud-provider does not support the feature."
				// More info:
				// https://kubernetes.io/docs/tasks/access-application-cluster/create-external-load-balancer/
				loadBalancerSourceRanges?: [...string]

				// The list of ports that are exposed by this service.
				// More info:
				// https://kubernetes.io/docs/concepts/services-networking/service/#virtual-ips-and-service-proxies
				ports?: [...{
					// The application protocol for this port.
					// This is used as a hint for implementations to offer richer behavior for
					// protocols that they understand.
					// This field follows standard Kubernetes label syntax.
					// Valid values are either:
					//
					// * Un-prefixed protocol names - reserved for IANA standard service names (as per
					// RFC-6335 and https://www.iana.org/assignments/service-names).
					//
					// * Kubernetes-defined prefixed names:
					// * 'kubernetes.io/h2c' - HTTP/2 prior knowledge over cleartext as described in
					// https://www.rfc-editor.org/rfc/rfc9113.html#name-starting-http-2-with-prior-
					// * 'kubernetes.io/ws' - WebSocket over cleartext as described in
					// https://www.rfc-editor.org/rfc/rfc6455
					// * 'kubernetes.io/wss' - WebSocket over TLS as described in https://www.rfc-editor.org/rfc/rfc6455
					//
					// * Other protocols should use implementation-defined prefixed names such as
					// mycompany.com/my-custom-protocol.
					appProtocol?: string

					// The name of this port within the service. This must be a DNS_LABEL.
					// All ports within a ServiceSpec must have unique names. When considering
					// the endpoints for a Service, this must match the 'name' field in the
					// EndpointPort.
					// Optional if only one ServicePort is defined on this service.
					name?: string

					// The port on each node on which this service is exposed when type is
					// NodePort or LoadBalancer. Usually assigned by the system. If a value is
					// specified, in-range, and not in use it will be used, otherwise the
					// operation will fail. If not specified, a port will be allocated if this
					// Service requires one. If this field is specified when creating a
					// Service which does not need it, creation will fail. This field will be
					// wiped when updating a Service to no longer need it (e.g. changing type
					// from NodePort to ClusterIP).
					// More info: https://kubernetes.io/docs/concepts/services-networking/service/#type-nodeport
					nodePort?: int32 & int

					// The port that will be exposed by this service.
					port!: int32 & int

					// The IP protocol for this port. Supports "TCP", "UDP", and "SCTP".
					// Default is TCP.
					protocol?: string

					// Number or name of the port to access on the pods targeted by the service.
					// Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME.
					// If this is a string, it will be looked up as a named port in the
					// target Pod's container ports. If this is not specified, the value
					// of the 'port' field is used (an identity map).
					// This field is ignored for services with clusterIP=None, and should be
					// omitted or set equal to the 'port' field.
					// More info: https://kubernetes.io/docs/concepts/services-networking/service/#defining-a-service
					targetPort?: matchN(>=1, [int, string]) & (int | string)
				}]

				// publishNotReadyAddresses indicates that any agent which deals with endpoints for this
				// Service should disregard any indications of ready/not-ready.
				// The primary use case for setting this field is for a StatefulSet's Headless Service to
				// propagate SRV DNS records for its Pods for the purpose of peer discovery.
				// The Kubernetes controllers that generate Endpoints and EndpointSlice resources for
				// Services interpret this to mean that all endpoints are considered "ready" even if the
				// Pods themselves are not. Agents which consume only Kubernetes generated endpoints
				// through the Endpoints or EndpointSlice resources can safely assume this behavior.
				publishNotReadyAddresses?: bool

				// Route service traffic to pods with label keys and values matching this
				// selector. If empty or not present, the service is assumed to have an
				// external process managing its endpoints, which Kubernetes will not
				// modify. Only applies to types ClusterIP, NodePort, and LoadBalancer.
				// Ignored if type is ExternalName.
				// More info: https://kubernetes.io/docs/concepts/services-networking/service/
				selector?: [string]: string

				// Supports "ClientIP" and "None". Used to maintain session affinity.
				// Enable client IP based session affinity.
				// Must be ClientIP or None.
				// Defaults to None.
				// More info:
				// https://kubernetes.io/docs/concepts/services-networking/service/#virtual-ips-and-service-proxies
				sessionAffinity?: string

				// sessionAffinityConfig contains the configurations of session affinity.
				sessionAffinityConfig?: {
					// clientIP contains the configurations of Client IP based session affinity.
					clientIP?: {
						// timeoutSeconds specifies the seconds of ClientIP type session sticky time.
						// The value must be >0 && <=86400(for 1 day) if ServiceAffinity == "ClientIP".
						// Default value is 10800(for 3 hours).
						timeoutSeconds?: int32 & int
					}
				}

				// TrafficDistribution offers a way to express preferences for how traffic
				// is distributed to Service endpoints. Implementations can use this field
				// as a hint, but are not required to guarantee strict adherence. If the
				// field is not set, the implementation will apply its default routing
				// strategy. If set to "PreferClose", implementations should prioritize
				// endpoints that are in the same zone.
				trafficDistribution?: string

				// type determines how the Service is exposed. Defaults to ClusterIP. Valid
				// options are ExternalName, ClusterIP, NodePort, and LoadBalancer.
				// "ClusterIP" allocates a cluster-internal IP address for load-balancing
				// to endpoints. Endpoints are determined by the selector or if that is not
				// specified, by manual construction of an Endpoints object or
				// EndpointSlice objects. If clusterIP is "None", no virtual IP is
				// allocated and the endpoints are published as a set of endpoints rather
				// than a virtual IP.
				// "NodePort" builds on ClusterIP and allocates a port on every node which
				// routes to the same endpoints as the clusterIP.
				// "LoadBalancer" builds on NodePort and creates an external load-balancer
				// (if supported in the current cloud) which routes to the same endpoints
				// as the clusterIP.
				// "ExternalName" aliases this service to the specified externalName.
				// Several other fields do not apply to ExternalName services.
				// More info:
				// https://kubernetes.io/docs/concepts/services-networking/service/#publishing-services-service-types
				type?: string
			}
		}

		// ServiceAccount sets how the ServiceAccount object should look like with your
		// grafana instance, contains a number of defaults.
		serviceAccount?: {
			automountServiceAccountToken?: bool
			imagePullSecrets?: [...{
				// Name of the referent.
				// This field is effectively required, but due to backwards compatibility is
				// allowed to be empty. Instances of this type with an empty value here are
				// almost certainly wrong.
				// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
				name?: string
			}]

			// ObjectMeta contains only a [subset of the fields included in
			// k8s.io/apimachinery/pkg/apis/meta/v1.ObjectMeta](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.27/#objectmeta-v1-meta).
			metadata?: {
				annotations?: [string]: string
				labels?: [string]:      string
			}
			secrets?: [...{
				// API version of the referent.
				apiVersion?: string

				// If referring to a piece of an object instead of an entire object, this string
				// should contain a valid JSON/Go field access statement, such as
				// desiredState.manifest.containers[2].
				// For example, if the object reference is to a container within a pod, this
				// would take on a value like:
				// "spec.containers{name}" (where "name" refers to the name of the container that triggered
				// the event) or if no container name is specified "spec.containers[2]" (container with
				// index 2 in this pod). This syntax is chosen only to have some well-defined way of
				// referencing a part of an object.
				fieldPath?: string

				// Kind of the referent.
				// More info:
				// https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
				kind?: string

				// Name of the referent.
				// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
				name?: string

				// Namespace of the referent.
				// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/
				namespace?: string

				// Specific resourceVersion to which this reference is made, if any.
				// More info:
				// https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#concurrency-control-and-consistency
				resourceVersion?: string

				// UID of the referent.
				// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#uids
				uid?: string
			}]
		}

		// Suspend pauses reconciliation of owned resources like deployments, Services, Etc. upon changes
		suspend?: bool

		// Version sets the tag of the default image: docker.io/grafana/grafana.
		// Allows full image refs with/without sha256checksum: "registry/repo/image:tag@sha"
		// default: 13.1.3
		version?: string
	}

	// GrafanaStatus defines the observed state of Grafana
	status?: {
		adminUrl?: string
		alertRuleGroups?: [...string]
		conditions?: [...{
			// lastTransitionTime is the last time the condition transitioned from one status to another.
			// This should be when the underlying condition changed. If that is not known,
			// then using the time when the API field changed is acceptable.
			lastTransitionTime!: time.Time

			// message is a human readable message indicating details about the transition.
			// This may be an empty string.
			message!: strings.MaxRunes(
					32768)

			// observedGeneration represents the .metadata.generation that the condition was set based upon.
			// For instance, if .metadata.generation is currently 12, but the
			// .status.conditions[x].observedGeneration is 9, the condition is out of date
			// with respect to the current state of the instance.
			observedGeneration?: int64 & int & >=0

			// reason contains a programmatic identifier indicating the reason for the
			// condition's last transition.
			// Producers of specific condition types may define expected values and meanings for this field,
			// and whether the values are considered a guaranteed API.
			// The value should be a CamelCase string.
			// This field may not be empty.
			reason!: strings.MaxRunes(
					1024) & strings.MinRunes(
					1) & =~"^[A-Za-z]([A-Za-z0-9_,:]*[A-Za-z0-9_])?$"

			// status of the condition, one of True, False, Unknown.
			status!: "True" | "False" | "Unknown"

			// type of condition in CamelCase or in foo.example.com/CamelCase.
			type!: strings.MaxRunes(
				316) & =~"^([a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*/)?(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])$"
		}]
		contactPoints?: [...string]
		dashboards?: [...string]
		datasources?: [...string]
		folders?: [...string]
		lastMessage?: string
		libraryPanels?: [...string]
		manifests?: [...string]
		muteTimings?: [...string]
		notificationTemplates?: [...string]
		replicas?: int32 & int
		selector?: string
		serviceaccounts?: [...string]
		stage?:       string
		stageStatus?: string
		version?:     string
	}

	_embeddedResource: {
		apiVersion!: string
		kind!:       string
		metadata?: {
			...
		}
	}
	apiVersion: "grafana.integreatly.org/v1beta1"
	kind:       "Grafana"
	metadata!: {
		name!:      string
		namespace!: string
		labels?: [string]: string
		annotations?: [string]: string
		...
	}
}
