package v1beta1

import (
	"time"
	"strings"
)

#VMAlert: {
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

	// VMAlertSpec defines the desired state of VMAlert
	spec?: {
		// Affinity If specified, the pod's scheduling constraints.
		affinity?: {
			...
		}

		// ComponentVersion defines default images tag for all components.
		// it can be overwritten with component specific image.tag value.
		componentVersion?: string

		// ConfigMaps is a list of ConfigMaps in the same namespace as the Application
		// object, which shall be mounted into the Application container
		// at /etc/vm/configs/CONFIGMAP_NAME folder
		configMaps?: [...string]

		// ConfigReloadAuthKeySecret defines optional secret reference authKey for /-/reload API requests.
		// Given secret reference will be added to the application and vm-config-reloader as volume
		configReloadAuthKeySecret?: {
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

		// ConfigReloaderExtraArgs that will be passed to VMAuths config-reloader container
		// for example resync-interval: "30s"
		configReloaderExtraArgs?: [string]: string

		// ConfigReloaderImage defines image:tag for config-reloader container
		configReloaderImage?: string

		// ConfigReloaderImageTag defines image:tag for config-reloader container
		configReloaderImageTag?: string

		// ConfigReloaderResources config-reloader container resource request and
		// limits,
		// https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/
		// if not defined default resources from operator config will be used
		configReloaderResources?: {
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

		// Containers property allows to inject additions sidecars or to patch existing containers.
		// It can be useful for proxies, backup, etc.
		containers?: [...{
			name!: _
			...
		}]

		// Datasource Victoria Metrics or VMSelect url. Required parameter. e.g. http://127.0.0.1:8428
		datasource!: {
			// BasicAuth allow an endpoint to authenticate over basic authentication
			basicAuth?: {
				// Password defines reference for secret with password value
				// The secret needs to be in the same namespace as scrape object
				password?: {
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

				// PasswordFile defines path to password file at disk
				// must be pre-mounted
				password_file?: string

				// Username defines reference for secret with username value
				// The secret needs to be in the same namespace as scrape object
				username?: {
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
			}

			// Path to bearer token file
			bearerTokenFile?: string

			// Optional bearer auth token to use for -remoteWrite.url
			bearerTokenSecret?: {
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

			// Headers allow configuring custom http headers
			// Must be in form of semicolon separated header with value
			// e.g.
			// headerName:headerValue
			// vmalert supports it since 1.79.0 version
			headers?: [...string]

			// OAuth2 defines OAuth2 configuration
			oauth2?: {
				client_id!: _
				token_url!: _
				...
			}

			// TLSConfig specifies TLSConfig configuration parameters.
			tlsConfig?: {
				...
			}

			// Victoria Metrics or VMSelect url. Required parameter. E.g. http://127.0.0.1:8428
			url!: string
		}

		// DisableAutomountServiceAccountToken whether to disable serviceAccount auto mount by Kubernetes
		// Operator will conditionally create volumes and volumeMounts for containers if
		// it requires k8s API access.
		// For example, vmagent and vm-config-reloader requires k8s API access.
		// Operator creates volumes with name: "kube-api-access", which can be used as
		// volumeMount for extraContainers if needed.
		// And also adds VolumeMounts at /var/run/secrets/kubernetes.io/serviceaccount.
		disableAutomountServiceAccountToken?: bool

		// DisableSelfServiceScrape controls creation of VMServiceScrape by operator
		// for the application.
		// Has priority over `VM_DISABLESELFSERVICESCRAPECREATION` operator env variable
		disableSelfServiceScrape?: bool

		// Specifies the DNS parameters of a pod.
		// Parameters specified here will be merged to the generated DNS
		// configuration based on DNSPolicy.
		dnsConfig?: {
			...
		}

		// DNSPolicy sets DNS policy for the pod
		dnsPolicy?: string

		// EnableServiceLinks indicates whether information about services should be injected into pod's
		// environment variables, matching the syntax of Docker links.
		// Optional: Defaults to true.
		enableServiceLinks?: bool

		// EnforcedNamespaceLabel enforces adding a namespace label of origin for each alert
		// and metric that is user created. The label value will always be the namespace
		// of the object that is
		// being created.
		enforcedNamespaceLabel?: string

		// EvaluationInterval defines how often to evaluate rules by default
		evaluationInterval?: =~"[0-9]+(ms|s|m|h)"

		// ExternalLabels in the form 'name: value' to add to all generated recording rules and alerts.
		externalLabels?: [string]: string

		// ExtraArgs that will be passed to the application container
		// for example remoteWrite.tmpDataPath: /tmp
		extraArgs?: [string]: string

		// ExtraEnvs that will be passed to the application container
		extraEnvs?: [...{
			// Name of the environment variable.
			// May consist of any printable ASCII characters except '='.
			name!: string

			// Variable references $(VAR_NAME) are expanded
			// using the previously defined environment variables in the container and
			// any service environment variables. If a variable cannot be resolved,
			// the reference in the input string will be unchanged. Double $$ are reduced
			// to a single $, which allows for escaping the $(VAR_NAME) syntax: i.e.
			// "$$(VAR_NAME)" will produce the string literal "$(VAR_NAME)".
			// Escaped references will never be expanded, regardless of whether the variable
			// exists or not.
			// Defaults to "".
			value?: string
			...
		}]

		// ExtraEnvsFrom defines source of env variables for the application container
		// could either be secret or configmap
		extraEnvsFrom?: [...{
			// The ConfigMap to select from
			configMapRef?: {
				// Name of the referent.
				// This field is effectively required, but due to backwards compatibility is
				// allowed to be empty. Instances of this type with an empty value here are
				// almost certainly wrong.
				// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
				name?: string

				// Specify whether the ConfigMap must be defined
				optional?: bool
			}

			// Optional text to prepend to the name of each environment variable.
			// May consist of any printable ASCII characters except '='.
			prefix?: string

			// The Secret to select from
			secretRef?: {
				// Name of the referent.
				// This field is effectively required, but due to backwards compatibility is
				// allowed to be empty. Instances of this type with an empty value here are
				// almost certainly wrong.
				// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
				name?: string

				// Specify whether the Secret must be defined
				optional?: bool
			}
		}]

		// HostAliasesUnderScore provides mapping for ip and hostname,
		// that would be propagated to pod,
		// cannot be used with HostNetwork.
		// Has Priority over hostAliases field
		host_aliases?: [...{
			// Hostnames for the above IP address.
			hostnames?: [...string]

			// IP address of the host file entry.
			ip!: string
		}]

		// HostAliases provides mapping for ip and hostname,
		// that would be propagated to pod,
		// cannot be used with HostNetwork.
		hostAliases?: [...{
			// Hostnames for the above IP address.
			hostnames?: [...string]

			// IP address of the host file entry.
			ip!: string
		}]

		// HostNetwork controls whether the pod may use the node network namespace
		hostNetwork?: bool

		// Image - docker image settings
		// if no specified operator uses default version from operator config
		image?: {
			// PullPolicy describes how to pull docker image
			pullPolicy?: string

			// Repository contains name of docker image + it's repository if needed
			repository?: string

			// Tag contains desired docker image version.
			// It may be a regular tag (e.g. "v1.96.0") or a digest
			// (e.g. "sha256:<hex>"); a digest is joined to the repository with "@"
			// instead of ":", allowing images to be pinned by digest.
			tag?: string
		}

		// ImagePullSecrets An optional list of references to secrets in the same namespace
		// to use for pulling images from registries
		// see https://kubernetes.io/docs/concepts/containers/images/#specifying-imagepullsecrets-on-a-pod
		imagePullSecrets?: [...{
			// Name of the referent.
			// This field is effectively required, but due to backwards compatibility is
			// allowed to be empty. Instances of this type with an empty value here are
			// almost certainly wrong.
			// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
			name?: string
		}]

		// InitContainers allows adding initContainers to the pod definition.
		// Any errors during the execution of an initContainer will lead to a restart of the Pod.
		// More info: https://kubernetes.io/docs/concepts/workloads/pods/init-containers/
		initContainers?: [...{
			name!: _
			...
		}]

		// License allows to configure license key to be used for enterprise features.
		// Using license key is supported starting from VictoriaMetrics v1.94.0.
		// See [here](https://docs.victoriametrics.com/victoriametrics/enterprise/)
		license?: {
			// Enforce offline verification of the license key.
			forceOffline?: bool

			// Enterprise license key. This flag is available only in [VictoriaMetrics
			// enterprise](https://docs.victoriametrics.com/victoriametrics/enterprise/).
			// To request a trial license, [go to](https://victoriametrics.com/products/enterprise/trial)
			key?: string

			// KeyRef is reference to secret with license key for enterprise features.
			keyRef?: {
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

			// Interval to be used for checking for license key changes. Note that this is
			// only applicable when using KeyRef.
			reloadInterval?: string
		}

		// LivenessProbe that will be added to CR pod
		livenessProbe?: {
			...
		}

		// LogFormat for VMAlert to be configured with.
		// default or json
		logFormat?: "default" | "json"

		// LogLevel for VMAlert to be configured with.
		logLevel?: "INFO" | "WARN" | "ERROR" | "FATAL" | "PANIC"

		// ManagedMetadata defines metadata that will be added to the all objects
		// created by operator for the given CustomResource
		managedMetadata?: {
			// Annotations is an unstructured key value map stored with a resource that may be
			// set by external tools to store and retrieve arbitrary metadata. They are not
			// queryable and should be preserved when modifying objects.
			// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations
			annotations?: [string]: string

			// Labels Map of string keys and values that can be used to organize and categorize
			// (scope and select) objects.
			// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/labels
			labels?: [string]: string
		}

		// MinReadySeconds defines a minimum number of seconds to wait before starting update next pod
		// if previous in healthy state
		// Has no effect for VLogs and VMSingle
		minReadySeconds?: int32 & int

		// NetworkPolicy defines network access rules for pods created by this CR.
		networkPolicy?: {
			// Egress defines the list of egress rules applied to pods selected by this CR.
			egress?: [...{
				// ports is a list of destination ports for outgoing traffic.
				// Each item in this list is combined using a logical OR. If this field is
				// empty or missing, this rule matches all ports (traffic not restricted by port).
				// If this field is present and contains at least one item, then this rule allows
				// traffic only if the traffic matches at least one port in the list.
				ports?: [...{
					// endPort indicates that the range of ports from port to endPort if set, inclusive,
					// should be allowed by the policy. This field cannot be defined if the port field
					// is not defined or if the port field is defined as a named (string) port.
					// The endPort must be equal or greater than port.
					endPort?: int32 & int

					// port represents the port on the given protocol. This can either be a numerical or named
					// port on a pod. If this field is not provided, this matches all port names and
					// numbers.
					// If present, only traffic on the specified protocol AND port will be matched.
					port?: matchN(>=1, [int, string]) & (int | string)

					// protocol represents the protocol (TCP, UDP, or SCTP) which traffic must match.
					// If not specified, this field defaults to TCP.
					protocol?: string
				}]

				// to is a list of destinations for outgoing traffic of pods selected for this rule.
				// Items in this list are combined using a logical OR operation. If this field is
				// empty or missing, this rule matches all destinations (traffic not restricted by
				// destination). If this field is present and contains at least one item, this rule
				// allows traffic only if the traffic matches at least one item in the to list.
				to?: [...{
					// ipBlock defines policy on a particular IPBlock. If this field is set then
					// neither of the other fields can be.
					ipBlock?: {
						// cidr is a string representing the IPBlock
						// Valid examples are "192.168.1.0/24" or "2001:db8::/64"
						cidr!: string

						// except is a slice of CIDRs that should not be included within an IPBlock
						// Valid examples are "192.168.1.0/24" or "2001:db8::/64"
						// Except values will be rejected if they are outside the cidr range
						except?: [...string]
					}

					// namespaceSelector selects namespaces using cluster-scoped labels. This field follows
					// standard label selector semantics; if present but empty, it selects all namespaces.
					//
					// If podSelector is also set, then the NetworkPolicyPeer as a whole selects
					// the pods matching podSelector in the namespaces selected by namespaceSelector.
					// Otherwise it selects all pods in the namespaces selected by namespaceSelector.
					namespaceSelector?: {
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

					// podSelector is a label selector which selects pods. This field follows standard label
					// selector semantics; if present but empty, it selects all pods.
					//
					// If namespaceSelector is also set, then the NetworkPolicyPeer as a whole selects
					// the pods matching podSelector in the Namespaces selected by NamespaceSelector.
					// Otherwise it selects the pods matching podSelector in the policy's own namespace.
					podSelector?: {
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
				}]
			}]

			// Ingress defines the list of ingress rules applied to pods selected by this CR.
			// Each rule allows traffic which matches both the from and ports sections.
			ingress?: [...{
				// from is a list of sources which should be able to access the pods selected for this rule.
				// Items in this list are combined using a logical OR operation. If this field is
				// empty or missing, this rule matches all sources (traffic not restricted by
				// source). If this field is present and contains at least one item, this rule
				// allows traffic only if the traffic matches at least one item in the from list.
				from?: [...{
					// ipBlock defines policy on a particular IPBlock. If this field is set then
					// neither of the other fields can be.
					ipBlock?: {
						// cidr is a string representing the IPBlock
						// Valid examples are "192.168.1.0/24" or "2001:db8::/64"
						cidr!: string

						// except is a slice of CIDRs that should not be included within an IPBlock
						// Valid examples are "192.168.1.0/24" or "2001:db8::/64"
						// Except values will be rejected if they are outside the cidr range
						except?: [...string]
					}

					// namespaceSelector selects namespaces using cluster-scoped labels. This field follows
					// standard label selector semantics; if present but empty, it selects all namespaces.
					//
					// If podSelector is also set, then the NetworkPolicyPeer as a whole selects
					// the pods matching podSelector in the namespaces selected by namespaceSelector.
					// Otherwise it selects all pods in the namespaces selected by namespaceSelector.
					namespaceSelector?: {
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

					// podSelector is a label selector which selects pods. This field follows standard label
					// selector semantics; if present but empty, it selects all pods.
					//
					// If namespaceSelector is also set, then the NetworkPolicyPeer as a whole selects
					// the pods matching podSelector in the Namespaces selected by NamespaceSelector.
					// Otherwise it selects the pods matching podSelector in the policy's own namespace.
					podSelector?: {
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
				}]

				// ports is a list of ports which should be made accessible on the pods selected for
				// this rule. Each item in this list is combined using a logical OR. If this field is
				// empty or missing, this rule matches all ports (traffic not restricted by port).
				// If this field is present and contains at least one item, then this rule allows
				// traffic only if the traffic matches at least one port in the list.
				ports?: [...{
					// endPort indicates that the range of ports from port to endPort if set, inclusive,
					// should be allowed by the policy. This field cannot be defined if the port field
					// is not defined or if the port field is defined as a named (string) port.
					// The endPort must be equal or greater than port.
					endPort?: int32 & int

					// port represents the port on the given protocol. This can either be a numerical or named
					// port on a pod. If this field is not provided, this matches all port names and
					// numbers.
					// If present, only traffic on the specified protocol AND port will be matched.
					port?: matchN(>=1, [int, string]) & (int | string)

					// protocol represents the protocol (TCP, UDP, or SCTP) which traffic must match.
					// If not specified, this field defaults to TCP.
					protocol?: string
				}]
			}]
		}

		// NodeSelector Define which Nodes the Pods are scheduled on.
		nodeSelector?: [string]: string

		// Notifier prometheus alertmanager endpoint spec. Required at least one of
		// notifier or notifiers when there are alerting rules. e.g.
		// http://127.0.0.1:9093
		// If specified both notifier and notifiers, notifier will be added as last element to notifiers.
		// only one of notifier options could be chosen: notifierConfigRef or notifiers + notifier
		notifier?: {
			// BasicAuth allow an endpoint to authenticate over basic authentication
			basicAuth?: {
				// Password defines reference for secret with password value
				// The secret needs to be in the same namespace as scrape object
				password?: {
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

				// PasswordFile defines path to password file at disk
				// must be pre-mounted
				password_file?: string

				// Username defines reference for secret with username value
				// The secret needs to be in the same namespace as scrape object
				username?: {
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
			}

			// Path to bearer token file
			bearerTokenFile?: string

			// Optional bearer auth token to use for -remoteWrite.url
			bearerTokenSecret?: {
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

			// Headers allow configuring custom http headers
			// Must be in form of semicolon separated header with value
			// e.g.
			// headerName:headerValue
			// vmalert supports it since 1.79.0 version
			headers?: [...string]

			// OAuth2 defines OAuth2 configuration
			oauth2?: {
				client_id!: _
				token_url!: _
				...
			}

			// Selector allows service discovery for alertmanager
			// in this case all matched vmalertmanager replicas will be added into vmalert notifier.url
			// as statefulset pod.fqdn
			selector?: {
				// A label selector is a label query over a set of resources. The result of matchLabels and
				// matchExpressions are ANDed. An empty label selector matches all objects. A null
				// label selector matches no objects.
				labelSelector?: {
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

				// NamespaceSelector is a selector for selecting either all namespaces or a
				// list of namespaces.
				namespaceSelector?: {
					// Boolean describing whether all namespaces are selected in contrast to a
					// list restricting them.
					any?: bool

					// List of namespace names.
					matchNames?: [...string]
				}
			}

			// TLSConfig specifies TLSConfig configuration parameters.
			tlsConfig?: {
				...
			}

			// AlertManager url. E.g. http://127.0.0.1:9093
			url?: string
		}

		// NotifierConfigRef reference for secret with notifier configuration for vmalert
		// only one of notifier options could be chosen: notifierConfigRef or notifiers + notifier
		notifierConfigRef?: {
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

		// Notifiers prometheus alertmanager endpoints. Required at least one of
		// notifier or notifiers when there are alerting rules. e.g.
		// http://127.0.0.1:9093
		// If specified both notifier and notifiers, notifier will be added as last element to notifiers.
		// only one of notifier options could be chosen: notifierConfigRef or notifiers + notifier
		notifiers?: [...{
			// BasicAuth allow an endpoint to authenticate over basic authentication
			basicAuth?: {
				// Password defines reference for secret with password value
				// The secret needs to be in the same namespace as scrape object
				password?: {
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

				// PasswordFile defines path to password file at disk
				// must be pre-mounted
				password_file?: string

				// Username defines reference for secret with username value
				// The secret needs to be in the same namespace as scrape object
				username?: {
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
			}

			// Path to bearer token file
			bearerTokenFile?: string

			// Optional bearer auth token to use for -remoteWrite.url
			bearerTokenSecret?: {
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

			// Headers allow configuring custom http headers
			// Must be in form of semicolon separated header with value
			// e.g.
			// headerName:headerValue
			// vmalert supports it since 1.79.0 version
			headers?: [...string]

			// OAuth2 defines OAuth2 configuration
			oauth2?: {
				client_id!: _
				token_url!: _
				...
			}

			// Selector allows service discovery for alertmanager
			// in this case all matched vmalertmanager replicas will be added into vmalert notifier.url
			// as statefulset pod.fqdn
			selector?: {
				// A label selector is a label query over a set of resources. The result of matchLabels and
				// matchExpressions are ANDed. An empty label selector matches all objects. A null
				// label selector matches no objects.
				labelSelector?: {
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

				// NamespaceSelector is a selector for selecting either all namespaces or a
				// list of namespaces.
				namespaceSelector?: {
					// Boolean describing whether all namespaces are selected in contrast to a
					// list restricting them.
					any?: bool

					// List of namespace names.
					matchNames?: [...string]
				}
			}

			// TLSConfig specifies TLSConfig configuration parameters.
			tlsConfig?: {
				...
			}

			// AlertManager url. E.g. http://127.0.0.1:9093
			url?: string
		}]

		// Paused If set to true all actions on the underlying managed objects are not
		// going to be performed, except for delete actions.
		paused?: bool

		// PodDisruptionBudget created by operator
		podDisruptionBudget?: {
			// An eviction is allowed if at most "maxUnavailable" pods selected by
			// "selector" are unavailable after the eviction, i.e. even in absence of
			// the evicted pod. For example, one can prevent all voluntary evictions
			// by specifying 0. This is a mutually exclusive setting with "minAvailable".
			maxUnavailable?: matchN(>=1, [int, string]) & (int | string)

			// An eviction is allowed if at least "minAvailable" pods selected by
			// "selector" will still be available after the eviction, i.e. even in the
			// absence of the evicted pod. So for example you can prevent all voluntary
			// evictions by specifying "100%".
			minAvailable?: matchN(>=1, [int, string]) & (int | string)

			// replaces default labels selector generated by operator
			// it's useful when you need to create custom budget
			selectorLabels?: [string]: string

			// UnhealthyPodEvictionPolicy defines the criteria for when unhealthy pods
			//
			// Valid policies are IfHealthyBudget and AlwaysAllow.
			// If no policy is specified, the default behavior will be used,
			// which corresponds to the IfHealthyBudget policy.
			unhealthyPodEvictionPolicy?: "IfHealthyBudget" | "AlwaysAllow"
		}

		// PodMetadata configures Labels and Annotations which are propagated to the VMAlert pods.
		podMetadata?: {
			// Annotations is an unstructured key value map stored with a resource that may be
			// set by external tools to store and retrieve arbitrary metadata. They are not
			// queryable and should be preserved when modifying objects.
			// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations
			annotations?: [string]: string

			// Labels Map of string keys and values that can be used to organize and categorize
			// (scope and select) objects. May match selectors of replication controllers
			// and services.
			// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/labels
			labels?: [string]: string

			// Name must be unique within a namespace. Is required when creating resources, although
			// some resources may allow a client to request the generation of an appropriate name
			// automatically. Name is primarily intended for creation idempotence and configuration
			// definition.
			// Cannot be updated.
			// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names#names
			name?: string
		}

		// Port listen address
		port?: string

		// PreStopSleepSeconds defines the number of seconds to sleep in the preStop lifecycle hook.
		// It gives time for load balancers to remove the pod from rotation before the pod is terminated.
		// Defaults to 15 for applicable components. Set to 0 to disable.
		preStopSleepSeconds?: int32 & int

		// PriorityClassName class assigned to the Pods
		priorityClassName?: string

		// ReadinessGates defines pod readiness gates
		readinessGates?: [...{
			// ConditionType refers to a condition in the pod's condition list with matching type.
			conditionType!: string
		}]

		// ReadinessProbe that will be added to CR pod
		readinessProbe?: {
			...
		}

		// RemoteRead Optional URL to read vmalert state (persisted via RemoteWrite)
		// This configuration only makes sense if alerts state has been successfully
		// persisted (via RemoteWrite) before.
		// see -remoteRead.url docs in vmalerts for details.
		// E.g. http://127.0.0.1:8428
		remoteRead?: {
			// BasicAuth allow an endpoint to authenticate over basic authentication
			basicAuth?: {
				// Password defines reference for secret with password value
				// The secret needs to be in the same namespace as scrape object
				password?: {
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

				// PasswordFile defines path to password file at disk
				// must be pre-mounted
				password_file?: string

				// Username defines reference for secret with username value
				// The secret needs to be in the same namespace as scrape object
				username?: {
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
			}

			// Path to bearer token file
			bearerTokenFile?: string

			// Optional bearer auth token to use for -remoteWrite.url
			bearerTokenSecret?: {
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

			// Headers allow configuring custom http headers
			// Must be in form of semicolon separated header with value
			// e.g.
			// headerName:headerValue
			// vmalert supports it since 1.79.0 version
			headers?: [...string]

			// Lookback defines how far to look into past for alerts timeseries. For
			// example, if lookback=1h then range from now() to now()-1h will be scanned.
			// (default 1h0m0s)
			// Applied only to RemoteReadSpec
			lookback?: string

			// OAuth2 defines OAuth2 configuration
			oauth2?: {
				client_id!: _
				token_url!: _
				...
			}

			// TLSConfig specifies TLSConfig configuration parameters.
			tlsConfig?: {
				...
			}

			// URL of the endpoint to send samples to.
			url!: string
		}

		// RemoteWrite Optional URL to remote-write compatible storage to persist
		// vmalert state and rule results to.
		// Rule results will be persisted according to each rule.
		// Alerts state will be persisted in the form of time series named ALERTS and ALERTS_FOR_STATE
		// see -remoteWrite.url docs in vmalerts for details.
		// E.g. http://127.0.0.1:8428
		remoteWrite?: {
			// BasicAuth allow an endpoint to authenticate over basic authentication
			basicAuth?: {
				// Password defines reference for secret with password value
				// The secret needs to be in the same namespace as scrape object
				password?: {
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

				// PasswordFile defines path to password file at disk
				// must be pre-mounted
				password_file?: string

				// Username defines reference for secret with username value
				// The secret needs to be in the same namespace as scrape object
				username?: {
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
			}

			// Path to bearer token file
			bearerTokenFile?: string

			// Optional bearer auth token to use for -remoteWrite.url
			bearerTokenSecret?: {
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

			// Defines number of readers that concurrently write into remote storage (default 1)
			concurrency?: int32 & int

			// Defines interval of flushes to remote write endpoint (default 5s)
			flushInterval?: =~"[0-9]+(ms|s|m|h)"

			// Headers allow configuring custom http headers
			// Must be in form of semicolon separated header with value
			// e.g.
			// headerName:headerValue
			// vmalert supports it since 1.79.0 version
			headers?: [...string]

			// Defines defines max number of timeseries to be flushed at once (default 1000)
			maxBatchSize?: int32 & int

			// Defines the max number of pending datapoints to remote write endpoint (default 100000)
			maxQueueSize?: int32 & int

			// OAuth2 defines OAuth2 configuration
			oauth2?: {
				client_id!: _
				token_url!: _
				...
			}

			// TLSConfig specifies TLSConfig configuration parameters.
			tlsConfig?: {
				...
			}

			// URL of the endpoint to send samples to.
			url!: string
		}

		// ReplicaCount is the expected size of the Application.
		replicaCount?: int32 & int

		// Resources container resource request and limits,
		// https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/
		// if not defined default resources from operator config will be used
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

		// The number of old ReplicaSets to retain to allow rollback in deployment or
		// maximum number of revisions that will be maintained in the Deployment revision history.
		// Has no effect at StatefulSets
		// Defaults to 10.
		revisionHistoryLimitCount?: int32 & int

		// RollingUpdate - overrides deployment update params.
		rollingUpdate?: {
			// The maximum number of pods that can be scheduled above the desired number of
			// pods.
			// Value can be an absolute number (ex: 5) or a percentage of desired pods (ex: 10%).
			// This can not be 0 if MaxUnavailable is 0.
			// Absolute number is calculated from percentage by rounding up.
			// Defaults to 25%.
			// Example: when this is set to 30%, the new ReplicaSet can be scaled up immediately when
			// the rolling update starts, such that the total number of old and new pods do not exceed
			// 130% of desired pods. Once old pods have been killed,
			// new ReplicaSet can be scaled up further, ensuring that total number of pods running
			// at any time during the update is at most 130% of desired pods.
			maxSurge?: matchN(>=1, [int, string]) & (int | string)

			// The maximum number of pods that can be unavailable during the update.
			// Value can be an absolute number (ex: 5) or a percentage of desired pods (ex: 10%).
			// Absolute number is calculated from percentage by rounding down.
			// This can not be 0 if MaxSurge is 0.
			// Defaults to 25%.
			// Example: when this is set to 30%, the old ReplicaSet can be scaled down to 70% of desired pods
			// immediately when the rolling update starts. Once new pods are ready, old ReplicaSet
			// can be scaled down further, followed by scaling up the new ReplicaSet, ensuring
			// that the total number of pods available at all times during the update is at
			// least 70% of desired pods.
			maxUnavailable?: matchN(>=1, [int, string]) & (int | string)
		}

		// RuleNamespaceSelector to be selected for VMRules discovery.
		// Works in combination with Selector.
		// If both nil - behaviour controlled by selectAllByDefault
		// NamespaceSelector nil - only objects at VMAlert namespace.
		ruleNamespaceSelector?: {
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

		// RulePath to the file with alert rules.
		// Supports patterns. Flag can be specified multiple times.
		// Examples:
		// -rule /path/to/file. Path to a single file with alerting rules
		// -rule dir/*.yaml -rule /*.yaml. Relative path to all .yaml files in folder,
		// absolute path to all .yaml files in root.
		// by default operator adds /etc/vmalert/configs/base/vmalert.yaml
		rulePath?: [...string]

		// RuleSelector selector to select which VMRules to mount for loading alerting
		// rules from.
		// Works in combination with NamespaceSelector.
		// If both nil - behaviour controlled by selectAllByDefault
		// NamespaceSelector nil - only objects at VMAlert namespace.
		ruleSelector?: {
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

		// RuntimeClassName - defines runtime class for kubernetes pod.
		// https://kubernetes.io/docs/concepts/containers/runtime-class/
		runtimeClassName?: string

		// SchedulerName - defines kubernetes scheduler name
		schedulerName?: string

		// Secrets is a list of Secrets in the same namespace as the Application
		// object, which shall be mounted into the Application container
		// at /etc/vm/secrets/SECRET_NAME folder
		secrets?: [...string]

		// SecurityContext holds pod-level security attributes and common container settings.
		// This defaults to the default PodSecurityContext.
		securityContext?: {
			...
		}

		// SelectAllByDefault changes default behavior for empty CRD selectors, such RuleSelector.
		// with selectAllByDefault: true and empty serviceScrapeSelector and RuleNamespaceSelector
		// Operator selects all exist serviceScrapes
		// with selectAllByDefault: false - selects nothing
		selectAllByDefault?: bool

		// ServiceAccountName is the name of the ServiceAccount to use to run the pods
		serviceAccountName?: string

		// ServiceScrapeSpec that will be added to vmalert VMServiceScrape spec
		serviceScrapeSpec?: {
			...
		}

		// ServiceSpec that will be added to vmalert service spec
		serviceSpec?: {
			// EmbeddedObjectMetadata defines objectMeta for additional service.
			metadata?: {
				// Annotations is an unstructured key value map stored with a resource that may be
				// set by external tools to store and retrieve arbitrary metadata. They are not
				// queryable and should be preserved when modifying objects.
				// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations
				annotations?: [string]: string

				// Labels Map of string keys and values that can be used to organize and categorize
				// (scope and select) objects. May match selectors of replication controllers
				// and services.
				// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/labels
				labels?: [string]: string

				// Name must be unique within a namespace. Is required when creating resources, although
				// some resources may allow a client to request the generation of an appropriate name
				// automatically. Name is primarily intended for creation idempotence and configuration
				// definition.
				// Cannot be updated.
				// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names#names
				name?: string
			}

			// ServiceSpec describes the attributes that a user creates on a service.
			// More info: https://kubernetes.io/docs/concepts/services-networking/service/
			spec!: {
				...
			}

			// UseAsDefault applies changes from given service definition to the main object Service
			// Changing from headless service to clusterIP or loadbalancer may break
			// cross-component communication
			useAsDefault?: bool
		}

		// StartupProbe that will be added to CR pod
		startupProbe?: {
			...
		}

		// TerminationGracePeriodSeconds period for container graceful termination
		terminationGracePeriodSeconds?: int64 & int

		// Tolerations If specified, the pod's tolerations.
		tolerations?: [...{
			// Effect indicates the taint effect to match. Empty means match all taint effects.
			// When specified, allowed values are NoSchedule, PreferNoSchedule and NoExecute.
			effect?: string

			// Key is the taint key that the toleration applies to. Empty means match all taint keys.
			// If the key is empty, operator must be Exists; this combination means to match
			// all values and all keys.
			key?: string

			// Operator represents a key's relationship to the value.
			// Valid operators are Exists, Equal, Lt, and Gt. Defaults to Equal.
			// Exists is equivalent to wildcard for value, so that a pod can
			// tolerate all taints of a particular category.
			// Lt and Gt perform numeric comparisons (requires feature gate TaintTolerationComparisonOperators).
			operator?: string

			// TolerationSeconds represents the period of time the toleration (which must be
			// of effect NoExecute, otherwise this field is ignored) tolerates the taint. By default,
			// it is not set, which means tolerate the taint forever (do not evict). Zero and
			// negative values will be treated as 0 (evict immediately) by the system.
			tolerationSeconds?: int64 & int

			// Value is the taint value the toleration matches to.
			// If the operator is Exists, the value should be empty, otherwise just a regular string.
			value?: string
		}]

		// TopologySpreadConstraints embedded kubernetes pod configuration option,
		// controls how pods are spread across your cluster among failure-domains
		// such as regions, zones, nodes, and other user-defined topology domains
		// https://kubernetes.io/docs/concepts/workloads/pods/pod-topology-spread-constraints/
		topologySpreadConstraints?: [...{
			maxSkew!:           _
			topologyKey!:       _
			whenUnsatisfiable!: _
			...
		}]

		// UpdateStrategy - overrides default update strategy.
		updateStrategy?: "Recreate" | "RollingUpdate"

		// UseDefaultResources controls resource settings
		// By default, operator sets built-in resource requirements
		useDefaultResources?: bool

		// UseLegacyNaming uses standalone Helm chart naming for managed resources:
		// the CR name is used directly instead of the default "<type>-<name>" convention.
		useLegacyNaming?: bool

		// UseStrictSecurity enables strict security mode for component
		// it restricts disk writes access
		// uses non-root user out of the box
		// drops not needed security permissions
		useStrictSecurity?: bool

		// UseVMConfigReloader replaces prometheus-like config-reloader
		// with vm one. It uses secrets watch instead of file watch
		// which greatly increases speed of config updates
		useVMConfigReloader?: bool

		// VolumeMounts allows configuration of additional VolumeMounts on the output
		// Deployment/StatefulSet definition.
		// VolumeMounts specified will be appended to other VolumeMounts in the Application container
		volumeMounts?: [...{
			// bindMountOptions is the list of additional bind mount options to apply when
			// mounting this volume into the container. Allowed values are noexec,
			// nodev, and nosuid. These are Linux mount options and have no effect on
			// Windows nodes.
			// This field is not supported with image volumes.
			// This is an alpha field and requires enabling the VolumeBindMountOptions feature gate.
			bindMountOptions?: [...string]

			// Path within the container at which the volume should be mounted.
			mountPath!: string

			// mountPropagation determines how mounts are propagated from the host
			// to container and the other way around.
			// When not set, MountPropagationNone is used.
			// This field is beta in 1.10.
			// When RecursiveReadOnly is set to IfPossible or to Enabled, MountPropagation
			// must be None or unspecified
			// (which defaults to None).
			mountPropagation?: string

			// This must match the Name of a Volume.
			name!: string

			// Mounted read-only if true, read-write otherwise (false or unspecified).
			// Defaults to false.
			readOnly?: bool

			// RecursiveReadOnly specifies whether read-only mounts should be handled
			// recursively.
			//
			// If ReadOnly is false, this field has no meaning and must be unspecified.
			//
			// If ReadOnly is true, and this field is set to Disabled, the mount is not made
			// recursively read-only. If this field is set to IfPossible, the mount is made
			// recursively read-only, if it is supported by the container runtime. If this
			// field is set to Enabled, the mount is made recursively read-only if it is
			// supported by the container runtime, otherwise the pod will not be started and
			// an error will be generated to indicate the reason.
			//
			// If this field is set to IfPossible or Enabled, MountPropagation must be set to
			// None (or be unspecified, which defaults to None).
			//
			// If this field is not specified, it is treated as an equivalent of Disabled.
			recursiveReadOnly?: string

			// Path within the volume from which the container's volume should be mounted.
			// Defaults to "" (volume's root).
			subPath?: string

			// Expanded path within the volume from which the container's volume should be mounted.
			// Behaves similarly to SubPath but environment variable references $(VAR_NAME)
			// are expanded using the container's environment.
			// Defaults to "" (volume's root).
			// SubPathExpr and SubPath are mutually exclusive.
			subPathExpr?: string
		}]

		// Volumes allows configuration of additional volumes on the output
		// Deployment/StatefulSet definition.
		// Volumes specified will be appended to other volumes that are generated.
		volumes?: [...{
			name!: _
			...
		}]

		// Configures vertical pod autoscaling.
		vpa?: {
			// Recommenders specifies custom VPA recommender names.
			recommenders?: [...{
				// Name of the recommender responsible for generating recommendation for this object.
				name!: string
			}]

			// ResourcePolicy controls how the autoscaler computes recommended resources per container.
			resourcePolicy?: {
				// Per-container resource policies.
				containerPolicies?: [...{
					// Name of the container or DefaultContainerResourcePolicy, in which
					// case the policy is used by the containers that don't have their own
					// policy specified.
					containerName?: string

					// Specifies the type of recommendations that will be computed
					// (and possibly applied) by VPA.
					// If not specified, the default of [ResourceCPU, ResourceMemory] will be used.
					controlledResources?: [...string]

					// Specifies which resource values should be controlled.
					// The default is "RequestsAndLimits".
					controlledValues?: "RequestsAndLimits" | "RequestsOnly"

					// Specifies the maximum amount of resources that will be recommended
					// for the container. The default is no maximum.
					maxAllowed?: [string]: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")

					// memoryAggregationIntervalCount is the number of consecutive
					// memoryAggregationIntervals which make up the memory aggregation window.
					// The total window length is:
					// MemoryAggregationIntervalSeconds * MemoryAggregationIntervalCount.
					memoryAggregationIntervalCount?: int64 & int & >=1

					// memoryAggregationIntervalSeconds is the length of a single interval
					// (in seconds) for which the peak memory usage is computed.
					// Memory usage peaks are aggregated in multiples of this interval.
					// In other words, there is one memory usage sample per interval
					// (the maximum usage over that interval).
					memoryAggregationIntervalSeconds?: int32 & int & >=1

					// Specifies the minimal amount of resources that will be recommended
					// for the container. The default is no minimum.
					minAllowed?: [string]: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")

					// Whether autoscaler is enabled for the container. The default is "Auto".
					mode?: "Auto" | "Off"

					// oomBumpUpRatio is the ratio to increase memory when OOM is detected.
					oomBumpUpRatio?: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")

					// oomMinBumpUp is the minimum increase in memory when OOM is detected.
					oomMinBumpUp?: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")

					// startupBoost specifies the startup boost policy for the container.
					// This overrides any pod-level startup boost policy.
					// The startup boost policy takes precedence over the rest of the fields in
					// this struct, except for ContainerName and ControlledValues.
					startupBoost?: {
						// cpu specifies the CPU startup boost policy.
						// If this field is not set, no startup boost is applied.
						cpu?: {
							// durationSeconds indicates for how long to keep the pod boosted after it goes to Ready.
							// Defaults to 0.
							durationSeconds?: int32 & int

							// factor specifies the factor to apply to the resource request.
							// This field is required when Type is "Factor".
							factor?: int32 & int

							// quantity specifies the absolute resource quantity to be used as the
							// resource request and limit during the boost phase.
							// This field is required when Type is "Quantity".
							quantity?: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")

							// type specifies the kind of boost to apply.
							// Supported values are: "Factor", "Quantity".
							// No startupboost will be applied for unrecognized values.
							type!: "Factor" | "Quantity"
						}
					}
				}]
			}

			// UpdatePolicy controls how the autoscaler applies changes to pod resources.
			updatePolicy?: {
				// evictAfterOOMSeconds specifies the time in seconds to wait after an OOM event before
				// considering the pod for eviction. Pods that have OOMed in less than this time
				// since start will be evicted.
				evictAfterOOMSeconds?: int32 & int & >=1

				// EvictionRequirements is a list of EvictionRequirements that need to
				// evaluate to true in order for a Pod to be evicted. If more than one
				// EvictionRequirement is specified, all of them need to be fulfilled to allow eviction.
				evictionRequirements?: [...{
					// EvictionChangeRequirement refers to the relationship between the new target
					// recommendation for a Pod and its current requests, what kind of change is
					// necessary for the Pod to be evicted
					changeRequirement!: "TargetHigherThanRequests" | "TargetLowerThanRequests"

					// Resources is a list of one or more resources that the condition applies
					// to. If more than one resource is given, the EvictionRequirement is fulfilled
					// if at least one resource meets `changeRequirement`.
					resources!: [...string]
				}]

				// Minimal number of replicas which need to be alive for Updater to attempt
				// pod eviction (pending other checks like PDB). Only positive values are
				// allowed. Overrides global '--min-replicas' flag.
				minReplicas?: int32 & int

				// Controls when autoscaler applies changes to the pod resources.
				// The default is 'Recreate'.
				updateMode?: "Off" | "Initial" | "Recreate" | "InPlaceOrRecreate" | "InPlace" | "Auto"
			}
		}
	}

	// VMAlertStatus defines the observed state of VMAlert
	status?: {
		// Known .status.conditions.type are: "Available", "Progressing", and "Degraded"
		conditions?: [...{
			// lastTransitionTime is the last time the condition transitioned from one status to another.
			lastTransitionTime!: time.Time

			// LastUpdateTime is the last time of given type update.
			// This value is used for status TTL update and removal
			lastUpdateTime!: time.Time

			// message is a human readable message indicating details about the transition.
			// This may be an empty string.
			message?: strings.MaxRunes(
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
					1)

			// status of the condition, one of True, False, Unknown.
			status!: "True" | "False" | "Unknown"

			// Type of condition in CamelCase or in name.namespace.resource.victoriametrics.com/CamelCase.
			type!: strings.MaxRunes(
				316)
		}]
		lastAppliedSpec?: null | bool | number | string | [...] | {
			...
		}

		// ObservedGeneration defines current generation picked by operator for the
		// reconcile
		observedGeneration?: int64 & int

		// Reason defines human readable error reason
		reason?: string

		// UpdateStatus defines a status for update rollout
		updateStatus?: string
	}

	_embeddedResource: {
		apiVersion!: string
		kind!:       string
		metadata?: {
			...
		}
	}
	apiVersion: "operator.victoriametrics.com/v1beta1"
	kind:       "VMAlert"
	metadata!: {
		name!:      string
		namespace!: string
		labels?: [string]: string
		annotations?: [string]: string
		...
	}
}
