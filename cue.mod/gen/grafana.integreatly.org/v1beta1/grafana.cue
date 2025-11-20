package v1beta1

import (
	"time"
	"strings"
)

#Grafana: {
	_embeddedResource
	apiVersion?: string
	kind?:       string
	metadata?: {}
	spec?: {
		client?: {
			preferIngress?:
				null | bool
			timeout?:
				null | int
		}
		config?: {
			[string]: {
				[string]: string
				...
			}
			...
		}
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
					metadata?: {}
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
									tcpSocket?: {
										host?: string
										port!: matchN(>=1, [int, string]) & (int | string)
									}
								}
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
							resources?: {
								limits?: [string]: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")
								requests?: [string]: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")
							}
							securityContext?: {
								allowPrivilegeEscalation?: bool
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
								mountPath!:        string
								mountPropagation?: string
								name!:             string
								readOnly?:         bool
								subPath?:          string
								subPathExpr?:      string
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
									tcpSocket?: {
										host?: string
										port!: matchN(>=1, [int, string]) & (int | string)
									}
								}
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
							resources?: {
								limits?: [string]: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")
								requests?: [string]: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")
							}
							securityContext?: {
								allowPrivilegeEscalation?: bool
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
								mountPath!:        string
								mountPropagation?: string
								name!:             string
								readOnly?:         bool
								subPath?:          string
								subPathExpr?:      string
							}]
							workingDir?: string
						}]
						hostAliases?: [...{
							hostnames?: [...string]
							ip?: string
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
									tcpSocket?: {
										host?: string
										port!: matchN(>=1, [int, string]) & (int | string)
									}
								}
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
							resources?: {
								limits?: [string]: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")
								requests?: [string]: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")
							}
							securityContext?: {
								allowPrivilegeEscalation?: bool
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
								mountPath!:        string
								mountPropagation?: string
								name!:             string
								readOnly?:         bool
								subPath?:          string
								subPathExpr?:      string
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
							fsGroup?:             int64 & int
							fsGroupChangePolicy?: string
							runAsGroup?:          int64 & int
							runAsNonRoot?:        bool
							runAsUser?:           int64 & int
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
										apiGroup?: string
										kind!:     string
										name!:     string
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
									storageClassName?: string
									volumeMode?:       string
									volumeName?:       string
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
		external?: {
			adminPassword?: {
				key!:      string
				name?:     string
				optional?: bool
			}
			adminUser?: {
				key!:      string
				name?:     string
				optional?: bool
			}
			apiKey?: {
				key!:      string
				name?:     string
				optional?: bool
			}
			url!: string
		}
		ingress?: {
			metadata?: {
				annotations?: [string]: string
				labels?: [string]:      string
			}
			spec?: {
				defaultBackend?: {
					resource?: {
						apiGroup?: string
						kind!:     string
						name!:     string
					}
					service?: {
						name!: string
						port?: {
							name?:   string
							number?: int32 & int
						}
					}
				}
				ingressClassName?: string
				rules?: [...{
					host?: string
					http?: paths!: [...{
						backend!: {
							resource?: {
								apiGroup?: string
								kind!:     string
								name!:     string
							}
							service?: {
								name!: string
								port?: {
									name?:   string
									number?: int32 & int
								}
							}
						}
						path?:     string
						pathType!: string
					}]
				}]
				tls?: [...{
					hosts?: [...string]
					secretName?: string
				}]
			}
		}
		jsonnet?: libraryLabelSelector?: {
			matchExpressions?: [...{
				key!:      string
				operator!: string
				values?: [...string]
			}]
			matchLabels?: [string]: string
		}
		persistentVolumeClaim?: {
			metadata?: {
				annotations?: [string]: string
				labels?: [string]:      string
			}
			spec?: {
				accessModes?: [...string]
				dataSource?: {
					apiGroup?: string
					kind!:     string
					name!:     string
				}
				dataSourceRef?: {
					apiGroup?: string
					kind!:     string
					name!:     string
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
				storageClassName?: string
				volumeMode?:       string
				volumeName?:       string
			}
		}
		route?: {
			metadata?: {
				annotations?: [string]: string
				labels?: [string]:      string
			}
			spec?: {
				alternateBackends?: [...{
					kind!:   string
					name!:   string
					weight!: int32 & int
				}]
				host?: string
				path?: string
				port?: targetPort!: matchN(>=1, [int, string]) & (int | string)
				tls?: {
					caCertificate?:                 string
					certificate?:                   string
					destinationCACertificate?:      string
					insecureEdgeTerminationPolicy?: string
					key?:                           string
					termination!:                   string
				}
				to?: {
					kind!:   string
					name!:   string
					weight!: int32 & int
				}
				wildcardPolicy?: string
			}
		}
		service?: {
			metadata?: {
				annotations?: [string]: string
				labels?: [string]:      string
			}
			spec?: {
				allocateLoadBalancerNodePorts?: bool
				clusterIP?:                     string
				clusterIPs?: [...string]
				externalIPs?: [...string]
				externalName?:          string
				externalTrafficPolicy?: string
				healthCheckNodePort?:   int32 & int
				internalTrafficPolicy?: string
				ipFamilies?: [...string]
				ipFamilyPolicy?:    string
				loadBalancerClass?: string
				loadBalancerIP?:    string
				loadBalancerSourceRanges?: [...string]
				ports?: [...{
					appProtocol?: string
					name?:        string
					nodePort?:    int32 & int
					port!:        int32 & int
					protocol?:    string
					targetPort?: matchN(>=1, [int, string]) & (int | string)
				}]
				publishNotReadyAddresses?: bool
				selector?: [string]: string
				sessionAffinity?: string
				sessionAffinityConfig?: clientIP?: timeoutSeconds?: int32 & int
				type?: string
			}
		}
		serviceAccount?: {
			automountServiceAccountToken?: bool
			imagePullSecrets?: [...{
				name?: string
			}]
			metadata?: {
				annotations?: [string]: string
				labels?: [string]:      string
			}
			secrets?: [...{
				apiVersion?:      string
				fieldPath?:       string
				kind?:            string
				name?:            string
				namespace?:       string
				resourceVersion?: string
				uid?:             string
			}]
		}
	}
	status?: {
		adminUrl?: string
		conditions?: [...{
			lastTransitionTime!: time.Time
			message!:            strings.MaxRunes(
						32768)
			observedGeneration?: int64 & int & >=0
			reason!:             strings.MaxRunes(
						1024) & strings.MinRunes(
						1) & =~"^[A-Za-z]([A-Za-z0-9_,:]*[A-Za-z0-9_])?$"
			status!:             "True" | "False" | "Unknown"
			type!:               strings.MaxRunes(
						316) & =~"^([a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*/)?(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])$"
		}]
		plugins?: [...{
			name!:    string
			version!: string
		}]
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
