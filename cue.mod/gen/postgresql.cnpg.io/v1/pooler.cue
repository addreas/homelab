package v1

#Pooler: {
	_embeddedResource

	// APIVersion defines the versioned schema of this representation
	// of an object.
	// Servers should convert recognized schemas to the latest
	// internal value, and
	// may reject unrecognized values.
	// More info:
	// https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
	apiVersion?: string

	// Kind is a string value representing the REST resource this
	// object represents.
	// Servers may infer this from the endpoint the client submits
	// requests to.
	// Cannot be updated.
	// In CamelCase.
	// More info:
	// https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
	kind?: string
	metadata!: {}

	// Specification of the desired behavior of the Pooler.
	// More info:
	// https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status
	spec!: {
		// This is the cluster reference on which the Pooler will work.
		// Pooler name should never match with any cluster name within the
		// same namespace.
		cluster!: {
			// Name of the referent.
			name!: string
		}

		// The deployment strategy to use for pgbouncer to replace
		// existing pods with new ones
		deploymentStrategy?: {
			// Rolling update config params. Present only if
			// DeploymentStrategyType =
			// RollingUpdate.
			rollingUpdate?: {
				// The maximum number of pods that can be scheduled above the
				// desired number of
				// pods.
				// Value can be an absolute number (ex: 5) or a percentage of
				// desired pods (ex: 10%).
				// This can not be 0 if MaxUnavailable is 0.
				// Absolute number is calculated from percentage by rounding up.
				// Defaults to 25%.
				// Example: when this is set to 30%, the new ReplicaSet can be
				// scaled up immediately when
				// the rolling update starts, such that the total number of old
				// and new pods do not exceed
				// 130% of desired pods. Once old pods have been killed,
				// new ReplicaSet can be scaled up further, ensuring that total
				// number of pods running
				// at any time during the update is at most 130% of desired pods.
				maxSurge?: matchN(>=1, [int, string]) & (int | string)

				// The maximum number of pods that can be unavailable during the
				// update.
				// Value can be an absolute number (ex: 5) or a percentage of
				// desired pods (ex: 10%).
				// Absolute number is calculated from percentage by rounding down.
				// This can not be 0 if MaxSurge is 0.
				// Defaults to 25%.
				// Example: when this is set to 30%, the old ReplicaSet can be
				// scaled down to 70% of desired pods
				// immediately when the rolling update starts. Once new pods are
				// ready, old ReplicaSet
				// can be scaled down further, followed by scaling up the new
				// ReplicaSet, ensuring
				// that the total number of pods available at all times during the
				// update is at
				// least 70% of desired pods.
				maxUnavailable?: matchN(>=1, [int, string]) & (int | string)
			}

			// Type of deployment. Can be "Recreate" or "RollingUpdate".
			// Default is RollingUpdate.
			type?: string
		}

		// The number of replicas we want. Default: 1.
		instances?: int32 & int

		// The configuration of the monitoring infrastructure of this
		// pooler.
		//
		// Deprecated: This feature will be removed in an upcoming
		// release. If
		// you need this functionality, you can create a PodMonitor
		// manually.
		monitoring?: {
			// Enable or disable the `PodMonitor`
			enablePodMonitor?: bool

			// The list of metric relabelings for the `PodMonitor`. Applied to
			// samples before ingestion.
			podMonitorMetricRelabelings?: [...{
				// action to perform based on the regex matching.
				//
				// `Uppercase` and `Lowercase` actions require Prometheus >=
				// v2.36.0.
				// `DropEqual` and `KeepEqual` actions require Prometheus >=
				// v2.41.0.
				//
				// Default: "Replace"
				action?: "replace" | "Replace" | "keep" | "Keep" | "drop" | "Drop" | "hashmod" | "HashMod" | "labelmap" | "LabelMap" | "labeldrop" | "LabelDrop" | "labelkeep" | "LabelKeep" | "lowercase" | "Lowercase" | "uppercase" | "Uppercase" | "keepequal" | "KeepEqual" | "dropequal" | "DropEqual"

				// modulus to take of the hash of the source label values.
				//
				// Only applicable when the action is `HashMod`.
				modulus?: int64 & int

				// regex defines the regular expression against which the
				// extracted value is matched.
				regex?: string

				// replacement value against which a Replace action is performed
				// if the
				// regular expression matches.
				//
				// Regex capture groups are available.
				replacement?: string

				// separator defines the string between concatenated SourceLabels.
				separator?: string

				// sourceLabels defines the source labels select values from
				// existing labels. Their content is
				// concatenated using the configured Separator and matched against
				// the
				// configured regular expression.
				sourceLabels?: [...string]

				// targetLabel defines the label to which the resulting string is
				// written in a replacement.
				//
				// It is mandatory for `Replace`, `HashMod`, `Lowercase`,
				// `Uppercase`,
				// `KeepEqual` and `DropEqual` actions.
				//
				// Regex capture groups are available.
				targetLabel?: string
			}]

			// The list of relabelings for the `PodMonitor`. Applied to
			// samples before scraping.
			podMonitorRelabelings?: [...{
				// action to perform based on the regex matching.
				//
				// `Uppercase` and `Lowercase` actions require Prometheus >=
				// v2.36.0.
				// `DropEqual` and `KeepEqual` actions require Prometheus >=
				// v2.41.0.
				//
				// Default: "Replace"
				action?: "replace" | "Replace" | "keep" | "Keep" | "drop" | "Drop" | "hashmod" | "HashMod" | "labelmap" | "LabelMap" | "labeldrop" | "LabelDrop" | "labelkeep" | "LabelKeep" | "lowercase" | "Lowercase" | "uppercase" | "Uppercase" | "keepequal" | "KeepEqual" | "dropequal" | "DropEqual"

				// modulus to take of the hash of the source label values.
				//
				// Only applicable when the action is `HashMod`.
				modulus?: int64 & int

				// regex defines the regular expression against which the
				// extracted value is matched.
				regex?: string

				// replacement value against which a Replace action is performed
				// if the
				// regular expression matches.
				//
				// Regex capture groups are available.
				replacement?: string

				// separator defines the string between concatenated SourceLabels.
				separator?: string

				// sourceLabels defines the source labels select values from
				// existing labels. Their content is
				// concatenated using the configured Separator and matched against
				// the
				// configured regular expression.
				sourceLabels?: [...string]

				// targetLabel defines the label to which the resulting string is
				// written in a replacement.
				//
				// It is mandatory for `Replace`, `HashMod`, `Lowercase`,
				// `Uppercase`,
				// `KeepEqual` and `DropEqual` actions.
				//
				// Regex capture groups are available.
				targetLabel?: string
			}]
		}

		// The PgBouncer configuration
		pgbouncer!: {
			// The query that will be used to download the hash of the
			// password
			// of a certain user. Default: "SELECT usename, passwd FROM
			// public.user_search($1)".
			// In case it is specified, also an AuthQuerySecret has to be
			// specified and
			// no automatic CNPG Cluster integration will be triggered.
			authQuery?: string

			// The credentials of the user that need to be used for the
			// authentication
			// query. In case it is specified, also an AuthQuery
			// (e.g. "SELECT usename, passwd FROM pg_catalog.pg_shadow WHERE
			// usename=$1")
			// has to be specified and no automatic CNPG Cluster integration
			// will be triggered.
			//
			// Deprecated.
			authQuerySecret?: {
				// Name of the referent.
				name!: string
			}

			// ClientCASecret provides PgBouncer’s client_tls_ca_file, the
			// root
			// CA for validating client certificates
			clientCASecret?: {
				// Name of the referent.
				name!: string
			}

			// ClientTLSSecret provides PgBouncer’s client_tls_key_file
			// (private key)
			// and client_tls_cert_file (certificate) used to accept client
			// connections
			clientTLSSecret?: {
				// Name of the referent.
				name!: string
			}

			// Additional parameters to be passed to PgBouncer - please check
			// the CNPG documentation for a list of options you can configure
			parameters?: [string]: string

			// When set to `true`, PgBouncer will disconnect from the
			// PostgreSQL
			// server, first waiting for all queries to complete, and pause
			// all new
			// client connections until this value is set to `false`
			// (default). Internally,
			// the operator calls PgBouncer's `PAUSE` and `RESUME` commands.
			paused?: bool

			// PostgreSQL Host Based Authentication rules (lines to be
			// appended
			// to the pg_hba.conf file)
			pg_hba?: [...string]

			// The pool mode. Default: `session`.
			poolMode?: "session" | "transaction"

			// ServerCASecret provides PgBouncer’s server_tls_ca_file, the
			// root
			// CA for validating PostgreSQL certificates
			serverCASecret?: {
				// Name of the referent.
				name!: string
			}

			// ServerTLSSecret, when pointing to a TLS secret, provides
			// pgbouncer's
			// `server_tls_key_file` and `server_tls_cert_file`, used when
			// authenticating against PostgreSQL.
			serverTLSSecret?: {
				// Name of the referent.
				name!: string
			}
		}

		// Template for the Service to be created
		serviceTemplate?: {
			// Standard object's metadata.
			// More info:
			// https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
			metadata?: {
				// Annotations is an unstructured key value map stored with a
				// resource that may be
				// set by external tools to store and retrieve arbitrary metadata.
				// They are not
				// queryable and should be preserved when modifying objects.
				// More info: http://kubernetes.io/docs/user-guide/annotations
				annotations?: [string]: string

				// Map of string keys and values that can be used to organize and
				// categorize
				// (scope and select) objects. May match selectors of replication
				// controllers
				// and services.
				// More info: http://kubernetes.io/docs/user-guide/labels
				labels?: [string]: string

				// The name of the resource. Only supported for certain types
				name?: string
			}

			// Specification of the desired behavior of the service.
			// More info:
			// https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status
			spec?: {
				// allocateLoadBalancerNodePorts defines if NodePorts will be
				// automatically
				// allocated for services with type LoadBalancer. Default is
				// "true". It
				// may be set to "false" if the cluster load-balancer does not
				// rely on
				// NodePorts. If the caller requests specific NodePorts (by
				// specifying a
				// value), those requests will be respected, regardless of this
				// field.
				// This field may only be set for services with type LoadBalancer
				// and will
				// be cleared if the type is changed to any other type.
				allocateLoadBalancerNodePorts?: bool

				// clusterIP is the IP address of the service and is usually
				// assigned
				// randomly. If an address is specified manually, is in-range (as
				// per
				// system configuration), and is not in use, it will be allocated
				// to the
				// service; otherwise creation of the service will fail. This
				// field may not
				// be changed through updates unless the type field is also being
				// changed
				// to ExternalName (which requires this field to be blank) or the
				// type
				// field is being changed from ExternalName (in which case this
				// field may
				// optionally be specified, as describe above). Valid values are
				// "None",
				// empty string (""), or a valid IP address. Setting this to
				// "None" makes a
				// "headless service" (no virtual IP), which is useful when direct
				// endpoint
				// connections are preferred and proxying is not required. Only
				// applies to
				// types ClusterIP, NodePort, and LoadBalancer. If this field is
				// specified
				// when creating a Service of type ExternalName, creation will
				// fail. This
				// field will be wiped when updating a Service to type
				// ExternalName.
				// More info:
				// https://kubernetes.io/docs/concepts/services-networking/service/#virtual-ips-and-service-proxies
				clusterIP?: string

				// ClusterIPs is a list of IP addresses assigned to this service,
				// and are
				// usually assigned randomly. If an address is specified manually,
				// is
				// in-range (as per system configuration), and is not in use, it
				// will be
				// allocated to the service; otherwise creation of the service
				// will fail.
				// This field may not be changed through updates unless the type
				// field is
				// also being changed to ExternalName (which requires this field
				// to be
				// empty) or the type field is being changed from ExternalName (in
				// which
				// case this field may optionally be specified, as describe
				// above). Valid
				// values are "None", empty string (""), or a valid IP address.
				// Setting
				// this to "None" makes a "headless service" (no virtual IP),
				// which is
				// useful when direct endpoint connections are preferred and
				// proxying is
				// not required. Only applies to types ClusterIP, NodePort, and
				// LoadBalancer. If this field is specified when creating a
				// Service of type
				// ExternalName, creation will fail. This field will be wiped when
				// updating
				// a Service to type ExternalName. If this field is not specified,
				// it will
				// be initialized from the clusterIP field. If this field is
				// specified,
				// clients must ensure that clusterIPs[0] and clusterIP have the
				// same
				// value.
				//
				// This field may hold a maximum of two entries (dual-stack IPs,
				// in either order).
				// These IPs must correspond to the values of the ipFamilies
				// field. Both
				// clusterIPs and ipFamilies are governed by the ipFamilyPolicy
				// field.
				// More info:
				// https://kubernetes.io/docs/concepts/services-networking/service/#virtual-ips-and-service-proxies
				clusterIPs?: [...string]

				// externalIPs is a list of IP addresses for which nodes in the
				// cluster
				// will also accept traffic for this service. These IPs are not
				// managed by
				// Kubernetes. The user is responsible for ensuring that traffic
				// arrives
				// at a node with this IP. A common example is external
				// load-balancers
				// that are not part of the Kubernetes system.
				externalIPs?: [...string]

				// externalName is the external reference that discovery
				// mechanisms will
				// return as an alias for this service (e.g. a DNS CNAME record).
				// No
				// proxying will be involved. Must be a lowercase RFC-1123
				// hostname
				// (https://tools.ietf.org/html/rfc1123) and requires `type` to be
				// "ExternalName".
				externalName?: string

				// externalTrafficPolicy describes how nodes distribute service
				// traffic they
				// receive on one of the Service's "externally-facing" addresses
				// (NodePorts,
				// ExternalIPs, and LoadBalancer IPs). If set to "Local", the
				// proxy will configure
				// the service in a way that assumes that external load balancers
				// will take care
				// of balancing the service traffic between nodes, and so each
				// node will deliver
				// traffic only to the node-local endpoints of the service,
				// without masquerading
				// the client source IP. (Traffic mistakenly sent to a node with
				// no endpoints will
				// be dropped.) The default value, "Cluster", uses the standard
				// behavior of
				// routing to all endpoints evenly (possibly modified by topology
				// and other
				// features). Note that traffic sent to an External IP or
				// LoadBalancer IP from
				// within the cluster will always get "Cluster" semantics, but
				// clients sending to
				// a NodePort from within the cluster may need to take traffic
				// policy into account
				// when picking a node.
				externalTrafficPolicy?: string

				// healthCheckNodePort specifies the healthcheck nodePort for the
				// service.
				// This only applies when type is set to LoadBalancer and
				// externalTrafficPolicy is set to Local. If a value is specified,
				// is
				// in-range, and is not in use, it will be used. If not specified,
				// a value
				// will be automatically allocated. External systems (e.g.
				// load-balancers)
				// can use this port to determine if a given node holds endpoints
				// for this
				// service or not. If this field is specified when creating a
				// Service
				// which does not need it, creation will fail. This field will be
				// wiped
				// when updating a Service to no longer need it (e.g. changing
				// type).
				// This field cannot be updated once set.
				healthCheckNodePort?: int32 & int

				// InternalTrafficPolicy describes how nodes distribute service
				// traffic they
				// receive on the ClusterIP. If set to "Local", the proxy will
				// assume that pods
				// only want to talk to endpoints of the service on the same node
				// as the pod,
				// dropping the traffic if there are no local endpoints. The
				// default value,
				// "Cluster", uses the standard behavior of routing to all
				// endpoints evenly
				// (possibly modified by topology and other features).
				internalTrafficPolicy?: string

				// IPFamilies is a list of IP families (e.g. IPv4, IPv6) assigned
				// to this
				// service. This field is usually assigned automatically based on
				// cluster
				// configuration and the ipFamilyPolicy field. If this field is
				// specified
				// manually, the requested family is available in the cluster,
				// and ipFamilyPolicy allows it, it will be used; otherwise
				// creation of
				// the service will fail. This field is conditionally mutable: it
				// allows
				// for adding or removing a secondary IP family, but it does not
				// allow
				// changing the primary IP family of the Service. Valid values are
				// "IPv4"
				// and "IPv6". This field only applies to Services of types
				// ClusterIP,
				// NodePort, and LoadBalancer, and does apply to "headless"
				// services.
				// This field will be wiped when updating a Service to type
				// ExternalName.
				//
				// This field may hold a maximum of two entries (dual-stack
				// families, in
				// either order). These families must correspond to the values of
				// the
				// clusterIPs field, if specified. Both clusterIPs and ipFamilies
				// are
				// governed by the ipFamilyPolicy field.
				ipFamilies?: [...string]

				// IPFamilyPolicy represents the dual-stack-ness requested or
				// required by
				// this Service. If there is no value provided, then this field
				// will be set
				// to SingleStack. Services can be "SingleStack" (a single IP
				// family),
				// "PreferDualStack" (two IP families on dual-stack configured
				// clusters or
				// a single IP family on single-stack clusters), or
				// "RequireDualStack"
				// (two IP families on dual-stack configured clusters, otherwise
				// fail). The
				// ipFamilies and clusterIPs fields depend on the value of this
				// field. This
				// field will be wiped when updating a service to type
				// ExternalName.
				ipFamilyPolicy?: string

				// loadBalancerClass is the class of the load balancer
				// implementation this Service belongs to.
				// If specified, the value of this field must be a label-style
				// identifier, with an optional prefix,
				// e.g. "internal-vip" or "example.com/internal-vip". Unprefixed
				// names are reserved for end-users.
				// This field can only be set when the Service type is
				// 'LoadBalancer'. If not set, the default load
				// balancer implementation is used, today this is typically done
				// through the cloud provider integration,
				// but should apply for any default implementation. If set, it is
				// assumed that a load balancer
				// implementation is watching for Services with a matching class.
				// Any default load balancer
				// implementation (e.g. cloud providers) should ignore Services
				// that set this field.
				// This field can only be set when creating or updating a Service
				// to type 'LoadBalancer'.
				// Once set, it can not be changed. This field will be wiped when
				// a service is updated to a non 'LoadBalancer' type.
				loadBalancerClass?: string

				// Only applies to Service Type: LoadBalancer.
				// This feature depends on whether the underlying cloud-provider
				// supports specifying
				// the loadBalancerIP when a load balancer is created.
				// This field will be ignored if the cloud-provider does not
				// support the feature.
				// Deprecated: This field was under-specified and its meaning
				// varies across implementations.
				// Using it is non-portable and it may not support dual-stack.
				// Users are encouraged to use implementation-specific annotations
				// when available.
				loadBalancerIP?: string

				// If specified and supported by the platform, this will restrict
				// traffic through the cloud-provider
				// load-balancer will be restricted to the specified client IPs.
				// This field will be ignored if the
				// cloud-provider does not support the feature."
				// More info:
				// https://kubernetes.io/docs/tasks/access-application-cluster/create-external-load-balancer/
				loadBalancerSourceRanges?: [...string]

				// The list of ports that are exposed by this service.
				// More info:
				// https://kubernetes.io/docs/concepts/services-networking/service/#virtual-ips-and-service-proxies
				ports?: [...{
					// The application protocol for this port.
					// This is used as a hint for implementations to offer richer
					// behavior for protocols that they understand.
					// This field follows standard Kubernetes label syntax.
					// Valid values are either:
					//
					// * Un-prefixed protocol names - reserved for IANA standard
					// service names (as per
					// RFC-6335 and https://www.iana.org/assignments/service-names).
					//
					// * Kubernetes-defined prefixed names:
					// * 'kubernetes.io/h2c' - HTTP/2 prior knowledge over cleartext
					// as described in
					// https://www.rfc-editor.org/rfc/rfc9113.html#name-starting-http-2-with-prior-
					// * 'kubernetes.io/ws' - WebSocket over cleartext as described in
					// https://www.rfc-editor.org/rfc/rfc6455
					// * 'kubernetes.io/wss' - WebSocket over TLS as described in
					// https://www.rfc-editor.org/rfc/rfc6455
					//
					// * Other protocols should use implementation-defined prefixed
					// names such as
					// mycompany.com/my-custom-protocol.
					appProtocol?: string

					// The name of this port within the service. This must be a
					// DNS_LABEL.
					// All ports within a ServiceSpec must have unique names. When
					// considering
					// the endpoints for a Service, this must match the 'name' field
					// in the
					// EndpointPort.
					// Optional if only one ServicePort is defined on this service.
					name?: string

					// The port on each node on which this service is exposed when
					// type is
					// NodePort or LoadBalancer. Usually assigned by the system. If a
					// value is
					// specified, in-range, and not in use it will be used, otherwise
					// the
					// operation will fail. If not specified, a port will be allocated
					// if this
					// Service requires one. If this field is specified when creating
					// a
					// Service which does not need it, creation will fail. This field
					// will be
					// wiped when updating a Service to no longer need it (e.g.
					// changing type
					// from NodePort to ClusterIP).
					// More info:
					// https://kubernetes.io/docs/concepts/services-networking/service/#type-nodeport
					nodePort?: int32 & int

					// The port that will be exposed by this service.
					port!: int32 & int

					// The IP protocol for this port. Supports "TCP", "UDP", and
					// "SCTP".
					// Default is TCP.
					protocol?: string

					// Number or name of the port to access on the pods targeted by
					// the service.
					// Number must be in the range 1 to 65535. Name must be an
					// IANA_SVC_NAME.
					// If this is a string, it will be looked up as a named port in
					// the
					// target Pod's container ports. If this is not specified, the
					// value
					// of the 'port' field is used (an identity map).
					// This field is ignored for services with clusterIP=None, and
					// should be
					// omitted or set equal to the 'port' field.
					// More info:
					// https://kubernetes.io/docs/concepts/services-networking/service/#defining-a-service
					targetPort?: matchN(>=1, [int, string]) & (int | string)
				}]

				// publishNotReadyAddresses indicates that any agent which deals
				// with endpoints for this
				// Service should disregard any indications of ready/not-ready.
				// The primary use case for setting this field is for a
				// StatefulSet's Headless Service to
				// propagate SRV DNS records for its Pods for the purpose of peer
				// discovery.
				// The Kubernetes controllers that generate Endpoints and
				// EndpointSlice resources for
				// Services interpret this to mean that all endpoints are
				// considered "ready" even if the
				// Pods themselves are not. Agents which consume only Kubernetes
				// generated endpoints
				// through the Endpoints or EndpointSlice resources can safely
				// assume this behavior.
				publishNotReadyAddresses?: bool

				// Route service traffic to pods with label keys and values
				// matching this
				// selector. If empty or not present, the service is assumed to
				// have an
				// external process managing its endpoints, which Kubernetes will
				// not
				// modify. Only applies to types ClusterIP, NodePort, and
				// LoadBalancer.
				// Ignored if type is ExternalName.
				// More info:
				// https://kubernetes.io/docs/concepts/services-networking/service/
				selector?: [string]: string

				// Supports "ClientIP" and "None". Used to maintain session
				// affinity.
				// Enable client IP based session affinity.
				// Must be ClientIP or None.
				// Defaults to None.
				// More info:
				// https://kubernetes.io/docs/concepts/services-networking/service/#virtual-ips-and-service-proxies
				sessionAffinity?: string

				// sessionAffinityConfig contains the configurations of session
				// affinity.
				sessionAffinityConfig?: {
					// clientIP contains the configurations of Client IP based session
					// affinity.
					clientIP?: {
						// timeoutSeconds specifies the seconds of ClientIP type session
						// sticky time.
						// The value must be >0 && <=86400(for 1 day) if ServiceAffinity
						// == "ClientIP".
						// Default value is 10800(for 3 hours).
						timeoutSeconds?: int32 & int
					}
				}

				// TrafficDistribution offers a way to express preferences for how
				// traffic
				// is distributed to Service endpoints. Implementations can use
				// this field
				// as a hint, but are not required to guarantee strict adherence.
				// If the
				// field is not set, the implementation will apply its default
				// routing
				// strategy. If set to "PreferClose", implementations should
				// prioritize
				// endpoints that are in the same zone.
				trafficDistribution?: string

				// type determines how the Service is exposed. Defaults to
				// ClusterIP. Valid
				// options are ExternalName, ClusterIP, NodePort, and
				// LoadBalancer.
				// "ClusterIP" allocates a cluster-internal IP address for
				// load-balancing
				// to endpoints. Endpoints are determined by the selector or if
				// that is not
				// specified, by manual construction of an Endpoints object or
				// EndpointSlice objects. If clusterIP is "None", no virtual IP is
				// allocated and the endpoints are published as a set of endpoints
				// rather
				// than a virtual IP.
				// "NodePort" builds on ClusterIP and allocates a port on every
				// node which
				// routes to the same endpoints as the clusterIP.
				// "LoadBalancer" builds on NodePort and creates an external
				// load-balancer
				// (if supported in the current cloud) which routes to the same
				// endpoints
				// as the clusterIP.
				// "ExternalName" aliases this service to the specified
				// externalName.
				// Several other fields do not apply to ExternalName services.
				// More info:
				// https://kubernetes.io/docs/concepts/services-networking/service/#publishing-services-service-types
				type?: string
			}
		}

		// The template of the Pod to be created
		template?: {
			// Standard object's metadata.
			// More info:
			// https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
			metadata?: {
				// Annotations is an unstructured key value map stored with a
				// resource that may be
				// set by external tools to store and retrieve arbitrary metadata.
				// They are not
				// queryable and should be preserved when modifying objects.
				// More info: http://kubernetes.io/docs/user-guide/annotations
				annotations?: [string]: string

				// Map of string keys and values that can be used to organize and
				// categorize
				// (scope and select) objects. May match selectors of replication
				// controllers
				// and services.
				// More info: http://kubernetes.io/docs/user-guide/labels
				labels?: [string]: string

				// The name of the resource. Only supported for certain types
				name?: string
			}

			// Specification of the desired behavior of the pod.
			// More info:
			// https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status
			spec?: {
				// Optional duration in seconds the pod may be active on the node
				// relative to
				// StartTime before the system will actively try to mark it failed
				// and kill associated containers.
				// Value must be a positive integer.
				activeDeadlineSeconds?: int64 & int

				// If specified, the pod's scheduling constraints
				affinity?: {
					// Describes node affinity scheduling rules for the pod.
					nodeAffinity?: {
						// The scheduler will prefer to schedule pods to nodes that
						// satisfy
						// the affinity expressions specified by this field, but it may
						// choose
						// a node that violates one or more of the expressions. The node
						// that is
						// most preferred is the one with the greatest sum of weights,
						// i.e.
						// for each node that meets all of the scheduling requirements
						// (resource
						// request, requiredDuringScheduling affinity expressions, etc.),
						// compute a sum by iterating through the elements of this field
						// and adding
						// "weight" to the sum if the node matches the corresponding
						// matchExpressions; the
						// node(s) with the highest sum are the most preferred.
						preferredDuringSchedulingIgnoredDuringExecution?: [...{
							// A node selector term, associated with the corresponding weight.
							preference!: {
								// A list of node selector requirements by node's labels.
								matchExpressions?: [...{
									// The label key that the selector applies to.
									key!: string

									// Represents a key's relationship to a set of values.
									// Valid operators are In, NotIn, Exists, DoesNotExist. Gt, and
									// Lt.
									operator!: string

									// An array of string values. If the operator is In or NotIn,
									// the values array must be non-empty. If the operator is Exists
									// or DoesNotExist,
									// the values array must be empty. If the operator is Gt or Lt,
									// the values
									// array must have a single element, which will be interpreted as
									// an integer.
									// This array is replaced during a strategic merge patch.
									values?: [...string]
								}]

								// A list of node selector requirements by node's fields.
								matchFields?: [...{
									// The label key that the selector applies to.
									key!: string

									// Represents a key's relationship to a set of values.
									// Valid operators are In, NotIn, Exists, DoesNotExist. Gt, and
									// Lt.
									operator!: string

									// An array of string values. If the operator is In or NotIn,
									// the values array must be non-empty. If the operator is Exists
									// or DoesNotExist,
									// the values array must be empty. If the operator is Gt or Lt,
									// the values
									// array must have a single element, which will be interpreted as
									// an integer.
									// This array is replaced during a strategic merge patch.
									values?: [...string]
								}]
							}

							// Weight associated with matching the corresponding
							// nodeSelectorTerm, in the range 1-100.
							weight!: int32 & int
						}]

						// If the affinity requirements specified by this field are not
						// met at
						// scheduling time, the pod will not be scheduled onto the node.
						// If the affinity requirements specified by this field cease to
						// be met
						// at some point during pod execution (e.g. due to an update), the
						// system
						// may or may not try to eventually evict the pod from its node.
						requiredDuringSchedulingIgnoredDuringExecution?: {
							// Required. A list of node selector terms. The terms are ORed.
							nodeSelectorTerms!: [...{
								// A list of node selector requirements by node's labels.
								matchExpressions?: [...{
									// The label key that the selector applies to.
									key!: string

									// Represents a key's relationship to a set of values.
									// Valid operators are In, NotIn, Exists, DoesNotExist. Gt, and
									// Lt.
									operator!: string

									// An array of string values. If the operator is In or NotIn,
									// the values array must be non-empty. If the operator is Exists
									// or DoesNotExist,
									// the values array must be empty. If the operator is Gt or Lt,
									// the values
									// array must have a single element, which will be interpreted as
									// an integer.
									// This array is replaced during a strategic merge patch.
									values?: [...string]
								}]

								// A list of node selector requirements by node's fields.
								matchFields?: [...{
									// The label key that the selector applies to.
									key!: string

									// Represents a key's relationship to a set of values.
									// Valid operators are In, NotIn, Exists, DoesNotExist. Gt, and
									// Lt.
									operator!: string

									// An array of string values. If the operator is In or NotIn,
									// the values array must be non-empty. If the operator is Exists
									// or DoesNotExist,
									// the values array must be empty. If the operator is Gt or Lt,
									// the values
									// array must have a single element, which will be interpreted as
									// an integer.
									// This array is replaced during a strategic merge patch.
									values?: [...string]
								}]
							}]
						}
					}

					// Describes pod affinity scheduling rules (e.g. co-locate this
					// pod in the same node, zone, etc. as some other pod(s)).
					podAffinity?: {
						// The scheduler will prefer to schedule pods to nodes that
						// satisfy
						// the affinity expressions specified by this field, but it may
						// choose
						// a node that violates one or more of the expressions. The node
						// that is
						// most preferred is the one with the greatest sum of weights,
						// i.e.
						// for each node that meets all of the scheduling requirements
						// (resource
						// request, requiredDuringScheduling affinity expressions, etc.),
						// compute a sum by iterating through the elements of this field
						// and adding
						// "weight" to the sum if the node has pods which matches the
						// corresponding podAffinityTerm; the
						// node(s) with the highest sum are the most preferred.
						preferredDuringSchedulingIgnoredDuringExecution?: [...{
							// Required. A pod affinity term, associated with the
							// corresponding weight.
							podAffinityTerm!: {
								// A label query over a set of resources, in this case pods.
								// If it's null, this PodAffinityTerm matches with no Pods.
								labelSelector?: {
									// matchExpressions is a list of label selector requirements. The
									// requirements are ANDed.
									matchExpressions?: [...{
										// key is the label key that the selector applies to.
										key!: string

										// operator represents a key's relationship to a set of values.
										// Valid operators are In, NotIn, Exists and DoesNotExist.
										operator!: string

										// values is an array of string values. If the operator is In or
										// NotIn,
										// the values array must be non-empty. If the operator is Exists
										// or DoesNotExist,
										// the values array must be empty. This array is replaced during a
										// strategic
										// merge patch.
										values?: [...string]
									}]

									// matchLabels is a map of {key,value} pairs. A single {key,value}
									// in the matchLabels
									// map is equivalent to an element of matchExpressions, whose key
									// field is "key", the
									// operator is "In", and the values array contains only "value".
									// The requirements are ANDed.
									matchLabels?: [string]: string
								}

								// MatchLabelKeys is a set of pod label keys to select which pods
								// will
								// be taken into consideration. The keys are used to lookup values
								// from the
								// incoming pod labels, those key-value labels are merged with
								// `labelSelector` as `key in (value)`
								// to select the group of existing pods which pods will be taken
								// into consideration
								// for the incoming pod's pod (anti) affinity. Keys that don't
								// exist in the incoming
								// pod labels will be ignored. The default value is empty.
								// The same key is forbidden to exist in both matchLabelKeys and
								// labelSelector.
								// Also, matchLabelKeys cannot be set when labelSelector isn't
								// set.
								matchLabelKeys?: [...string]

								// MismatchLabelKeys is a set of pod label keys to select which
								// pods will
								// be taken into consideration. The keys are used to lookup values
								// from the
								// incoming pod labels, those key-value labels are merged with
								// `labelSelector` as `key notin (value)`
								// to select the group of existing pods which pods will be taken
								// into consideration
								// for the incoming pod's pod (anti) affinity. Keys that don't
								// exist in the incoming
								// pod labels will be ignored. The default value is empty.
								// The same key is forbidden to exist in both mismatchLabelKeys
								// and labelSelector.
								// Also, mismatchLabelKeys cannot be set when labelSelector isn't
								// set.
								mismatchLabelKeys?: [...string]

								// A label query over the set of namespaces that the term applies
								// to.
								// The term is applied to the union of the namespaces selected by
								// this field
								// and the ones listed in the namespaces field.
								// null selector and null or empty namespaces list means "this
								// pod's namespace".
								// An empty selector ({}) matches all namespaces.
								namespaceSelector?: {
									// matchExpressions is a list of label selector requirements. The
									// requirements are ANDed.
									matchExpressions?: [...{
										// key is the label key that the selector applies to.
										key!: string

										// operator represents a key's relationship to a set of values.
										// Valid operators are In, NotIn, Exists and DoesNotExist.
										operator!: string

										// values is an array of string values. If the operator is In or
										// NotIn,
										// the values array must be non-empty. If the operator is Exists
										// or DoesNotExist,
										// the values array must be empty. This array is replaced during a
										// strategic
										// merge patch.
										values?: [...string]
									}]

									// matchLabels is a map of {key,value} pairs. A single {key,value}
									// in the matchLabels
									// map is equivalent to an element of matchExpressions, whose key
									// field is "key", the
									// operator is "In", and the values array contains only "value".
									// The requirements are ANDed.
									matchLabels?: [string]: string
								}

								// namespaces specifies a static list of namespace names that the
								// term applies to.
								// The term is applied to the union of the namespaces listed in
								// this field
								// and the ones selected by namespaceSelector.
								// null or empty namespaces list and null namespaceSelector means
								// "this pod's namespace".
								namespaces?: [...string]

								// This pod should be co-located (affinity) or not co-located
								// (anti-affinity) with the pods matching
								// the labelSelector in the specified namespaces, where co-located
								// is defined as running on a node
								// whose value of the label with key topologyKey matches that of
								// any node on which any of the
								// selected pods is running.
								// Empty topologyKey is not allowed.
								topologyKey!: string
							}

							// weight associated with matching the corresponding
							// podAffinityTerm,
							// in the range 1-100.
							weight!: int32 & int
						}]

						// If the affinity requirements specified by this field are not
						// met at
						// scheduling time, the pod will not be scheduled onto the node.
						// If the affinity requirements specified by this field cease to
						// be met
						// at some point during pod execution (e.g. due to a pod label
						// update), the
						// system may or may not try to eventually evict the pod from its
						// node.
						// When there are multiple elements, the lists of nodes
						// corresponding to each
						// podAffinityTerm are intersected, i.e. all terms must be
						// satisfied.
						requiredDuringSchedulingIgnoredDuringExecution?: [...{
							// A label query over a set of resources, in this case pods.
							// If it's null, this PodAffinityTerm matches with no Pods.
							labelSelector?: {
								// matchExpressions is a list of label selector requirements. The
								// requirements are ANDed.
								matchExpressions?: [...{
									// key is the label key that the selector applies to.
									key!: string

									// operator represents a key's relationship to a set of values.
									// Valid operators are In, NotIn, Exists and DoesNotExist.
									operator!: string

									// values is an array of string values. If the operator is In or
									// NotIn,
									// the values array must be non-empty. If the operator is Exists
									// or DoesNotExist,
									// the values array must be empty. This array is replaced during a
									// strategic
									// merge patch.
									values?: [...string]
								}]

								// matchLabels is a map of {key,value} pairs. A single {key,value}
								// in the matchLabels
								// map is equivalent to an element of matchExpressions, whose key
								// field is "key", the
								// operator is "In", and the values array contains only "value".
								// The requirements are ANDed.
								matchLabels?: [string]: string
							}

							// MatchLabelKeys is a set of pod label keys to select which pods
							// will
							// be taken into consideration. The keys are used to lookup values
							// from the
							// incoming pod labels, those key-value labels are merged with
							// `labelSelector` as `key in (value)`
							// to select the group of existing pods which pods will be taken
							// into consideration
							// for the incoming pod's pod (anti) affinity. Keys that don't
							// exist in the incoming
							// pod labels will be ignored. The default value is empty.
							// The same key is forbidden to exist in both matchLabelKeys and
							// labelSelector.
							// Also, matchLabelKeys cannot be set when labelSelector isn't
							// set.
							matchLabelKeys?: [...string]

							// MismatchLabelKeys is a set of pod label keys to select which
							// pods will
							// be taken into consideration. The keys are used to lookup values
							// from the
							// incoming pod labels, those key-value labels are merged with
							// `labelSelector` as `key notin (value)`
							// to select the group of existing pods which pods will be taken
							// into consideration
							// for the incoming pod's pod (anti) affinity. Keys that don't
							// exist in the incoming
							// pod labels will be ignored. The default value is empty.
							// The same key is forbidden to exist in both mismatchLabelKeys
							// and labelSelector.
							// Also, mismatchLabelKeys cannot be set when labelSelector isn't
							// set.
							mismatchLabelKeys?: [...string]

							// A label query over the set of namespaces that the term applies
							// to.
							// The term is applied to the union of the namespaces selected by
							// this field
							// and the ones listed in the namespaces field.
							// null selector and null or empty namespaces list means "this
							// pod's namespace".
							// An empty selector ({}) matches all namespaces.
							namespaceSelector?: {
								// matchExpressions is a list of label selector requirements. The
								// requirements are ANDed.
								matchExpressions?: [...{
									// key is the label key that the selector applies to.
									key!: string

									// operator represents a key's relationship to a set of values.
									// Valid operators are In, NotIn, Exists and DoesNotExist.
									operator!: string

									// values is an array of string values. If the operator is In or
									// NotIn,
									// the values array must be non-empty. If the operator is Exists
									// or DoesNotExist,
									// the values array must be empty. This array is replaced during a
									// strategic
									// merge patch.
									values?: [...string]
								}]

								// matchLabels is a map of {key,value} pairs. A single {key,value}
								// in the matchLabels
								// map is equivalent to an element of matchExpressions, whose key
								// field is "key", the
								// operator is "In", and the values array contains only "value".
								// The requirements are ANDed.
								matchLabels?: [string]: string
							}

							// namespaces specifies a static list of namespace names that the
							// term applies to.
							// The term is applied to the union of the namespaces listed in
							// this field
							// and the ones selected by namespaceSelector.
							// null or empty namespaces list and null namespaceSelector means
							// "this pod's namespace".
							namespaces?: [...string]

							// This pod should be co-located (affinity) or not co-located
							// (anti-affinity) with the pods matching
							// the labelSelector in the specified namespaces, where co-located
							// is defined as running on a node
							// whose value of the label with key topologyKey matches that of
							// any node on which any of the
							// selected pods is running.
							// Empty topologyKey is not allowed.
							topologyKey!: string
						}]
					}

					// Describes pod anti-affinity scheduling rules (e.g. avoid
					// putting this pod in the same node, zone, etc. as some other
					// pod(s)).
					podAntiAffinity?: {
						// The scheduler will prefer to schedule pods to nodes that
						// satisfy
						// the anti-affinity expressions specified by this field, but it
						// may choose
						// a node that violates one or more of the expressions. The node
						// that is
						// most preferred is the one with the greatest sum of weights,
						// i.e.
						// for each node that meets all of the scheduling requirements
						// (resource
						// request, requiredDuringScheduling anti-affinity expressions,
						// etc.),
						// compute a sum by iterating through the elements of this field
						// and subtracting
						// "weight" from the sum if the node has pods which matches the
						// corresponding podAffinityTerm; the
						// node(s) with the highest sum are the most preferred.
						preferredDuringSchedulingIgnoredDuringExecution?: [...{
							// Required. A pod affinity term, associated with the
							// corresponding weight.
							podAffinityTerm!: {
								// A label query over a set of resources, in this case pods.
								// If it's null, this PodAffinityTerm matches with no Pods.
								labelSelector?: {
									// matchExpressions is a list of label selector requirements. The
									// requirements are ANDed.
									matchExpressions?: [...{
										// key is the label key that the selector applies to.
										key!: string

										// operator represents a key's relationship to a set of values.
										// Valid operators are In, NotIn, Exists and DoesNotExist.
										operator!: string

										// values is an array of string values. If the operator is In or
										// NotIn,
										// the values array must be non-empty. If the operator is Exists
										// or DoesNotExist,
										// the values array must be empty. This array is replaced during a
										// strategic
										// merge patch.
										values?: [...string]
									}]

									// matchLabels is a map of {key,value} pairs. A single {key,value}
									// in the matchLabels
									// map is equivalent to an element of matchExpressions, whose key
									// field is "key", the
									// operator is "In", and the values array contains only "value".
									// The requirements are ANDed.
									matchLabels?: [string]: string
								}

								// MatchLabelKeys is a set of pod label keys to select which pods
								// will
								// be taken into consideration. The keys are used to lookup values
								// from the
								// incoming pod labels, those key-value labels are merged with
								// `labelSelector` as `key in (value)`
								// to select the group of existing pods which pods will be taken
								// into consideration
								// for the incoming pod's pod (anti) affinity. Keys that don't
								// exist in the incoming
								// pod labels will be ignored. The default value is empty.
								// The same key is forbidden to exist in both matchLabelKeys and
								// labelSelector.
								// Also, matchLabelKeys cannot be set when labelSelector isn't
								// set.
								matchLabelKeys?: [...string]

								// MismatchLabelKeys is a set of pod label keys to select which
								// pods will
								// be taken into consideration. The keys are used to lookup values
								// from the
								// incoming pod labels, those key-value labels are merged with
								// `labelSelector` as `key notin (value)`
								// to select the group of existing pods which pods will be taken
								// into consideration
								// for the incoming pod's pod (anti) affinity. Keys that don't
								// exist in the incoming
								// pod labels will be ignored. The default value is empty.
								// The same key is forbidden to exist in both mismatchLabelKeys
								// and labelSelector.
								// Also, mismatchLabelKeys cannot be set when labelSelector isn't
								// set.
								mismatchLabelKeys?: [...string]

								// A label query over the set of namespaces that the term applies
								// to.
								// The term is applied to the union of the namespaces selected by
								// this field
								// and the ones listed in the namespaces field.
								// null selector and null or empty namespaces list means "this
								// pod's namespace".
								// An empty selector ({}) matches all namespaces.
								namespaceSelector?: {
									// matchExpressions is a list of label selector requirements. The
									// requirements are ANDed.
									matchExpressions?: [...{
										// key is the label key that the selector applies to.
										key!: string

										// operator represents a key's relationship to a set of values.
										// Valid operators are In, NotIn, Exists and DoesNotExist.
										operator!: string

										// values is an array of string values. If the operator is In or
										// NotIn,
										// the values array must be non-empty. If the operator is Exists
										// or DoesNotExist,
										// the values array must be empty. This array is replaced during a
										// strategic
										// merge patch.
										values?: [...string]
									}]

									// matchLabels is a map of {key,value} pairs. A single {key,value}
									// in the matchLabels
									// map is equivalent to an element of matchExpressions, whose key
									// field is "key", the
									// operator is "In", and the values array contains only "value".
									// The requirements are ANDed.
									matchLabels?: [string]: string
								}

								// namespaces specifies a static list of namespace names that the
								// term applies to.
								// The term is applied to the union of the namespaces listed in
								// this field
								// and the ones selected by namespaceSelector.
								// null or empty namespaces list and null namespaceSelector means
								// "this pod's namespace".
								namespaces?: [...string]

								// This pod should be co-located (affinity) or not co-located
								// (anti-affinity) with the pods matching
								// the labelSelector in the specified namespaces, where co-located
								// is defined as running on a node
								// whose value of the label with key topologyKey matches that of
								// any node on which any of the
								// selected pods is running.
								// Empty topologyKey is not allowed.
								topologyKey!: string
							}

							// weight associated with matching the corresponding
							// podAffinityTerm,
							// in the range 1-100.
							weight!: int32 & int
						}]

						// If the anti-affinity requirements specified by this field are
						// not met at
						// scheduling time, the pod will not be scheduled onto the node.
						// If the anti-affinity requirements specified by this field cease
						// to be met
						// at some point during pod execution (e.g. due to a pod label
						// update), the
						// system may or may not try to eventually evict the pod from its
						// node.
						// When there are multiple elements, the lists of nodes
						// corresponding to each
						// podAffinityTerm are intersected, i.e. all terms must be
						// satisfied.
						requiredDuringSchedulingIgnoredDuringExecution?: [...{
							// A label query over a set of resources, in this case pods.
							// If it's null, this PodAffinityTerm matches with no Pods.
							labelSelector?: {
								// matchExpressions is a list of label selector requirements. The
								// requirements are ANDed.
								matchExpressions?: [...{
									// key is the label key that the selector applies to.
									key!: string

									// operator represents a key's relationship to a set of values.
									// Valid operators are In, NotIn, Exists and DoesNotExist.
									operator!: string

									// values is an array of string values. If the operator is In or
									// NotIn,
									// the values array must be non-empty. If the operator is Exists
									// or DoesNotExist,
									// the values array must be empty. This array is replaced during a
									// strategic
									// merge patch.
									values?: [...string]
								}]

								// matchLabels is a map of {key,value} pairs. A single {key,value}
								// in the matchLabels
								// map is equivalent to an element of matchExpressions, whose key
								// field is "key", the
								// operator is "In", and the values array contains only "value".
								// The requirements are ANDed.
								matchLabels?: [string]: string
							}

							// MatchLabelKeys is a set of pod label keys to select which pods
							// will
							// be taken into consideration. The keys are used to lookup values
							// from the
							// incoming pod labels, those key-value labels are merged with
							// `labelSelector` as `key in (value)`
							// to select the group of existing pods which pods will be taken
							// into consideration
							// for the incoming pod's pod (anti) affinity. Keys that don't
							// exist in the incoming
							// pod labels will be ignored. The default value is empty.
							// The same key is forbidden to exist in both matchLabelKeys and
							// labelSelector.
							// Also, matchLabelKeys cannot be set when labelSelector isn't
							// set.
							matchLabelKeys?: [...string]

							// MismatchLabelKeys is a set of pod label keys to select which
							// pods will
							// be taken into consideration. The keys are used to lookup values
							// from the
							// incoming pod labels, those key-value labels are merged with
							// `labelSelector` as `key notin (value)`
							// to select the group of existing pods which pods will be taken
							// into consideration
							// for the incoming pod's pod (anti) affinity. Keys that don't
							// exist in the incoming
							// pod labels will be ignored. The default value is empty.
							// The same key is forbidden to exist in both mismatchLabelKeys
							// and labelSelector.
							// Also, mismatchLabelKeys cannot be set when labelSelector isn't
							// set.
							mismatchLabelKeys?: [...string]

							// A label query over the set of namespaces that the term applies
							// to.
							// The term is applied to the union of the namespaces selected by
							// this field
							// and the ones listed in the namespaces field.
							// null selector and null or empty namespaces list means "this
							// pod's namespace".
							// An empty selector ({}) matches all namespaces.
							namespaceSelector?: {
								// matchExpressions is a list of label selector requirements. The
								// requirements are ANDed.
								matchExpressions?: [...{
									// key is the label key that the selector applies to.
									key!: string

									// operator represents a key's relationship to a set of values.
									// Valid operators are In, NotIn, Exists and DoesNotExist.
									operator!: string

									// values is an array of string values. If the operator is In or
									// NotIn,
									// the values array must be non-empty. If the operator is Exists
									// or DoesNotExist,
									// the values array must be empty. This array is replaced during a
									// strategic
									// merge patch.
									values?: [...string]
								}]

								// matchLabels is a map of {key,value} pairs. A single {key,value}
								// in the matchLabels
								// map is equivalent to an element of matchExpressions, whose key
								// field is "key", the
								// operator is "In", and the values array contains only "value".
								// The requirements are ANDed.
								matchLabels?: [string]: string
							}

							// namespaces specifies a static list of namespace names that the
							// term applies to.
							// The term is applied to the union of the namespaces listed in
							// this field
							// and the ones selected by namespaceSelector.
							// null or empty namespaces list and null namespaceSelector means
							// "this pod's namespace".
							namespaces?: [...string]

							// This pod should be co-located (affinity) or not co-located
							// (anti-affinity) with the pods matching
							// the labelSelector in the specified namespaces, where co-located
							// is defined as running on a node
							// whose value of the label with key topologyKey matches that of
							// any node on which any of the
							// selected pods is running.
							// Empty topologyKey is not allowed.
							topologyKey!: string
						}]
					}
				}

				// AutomountServiceAccountToken indicates whether a service
				// account token should be automatically mounted.
				automountServiceAccountToken?: bool

				// List of containers belonging to the pod.
				// Containers cannot currently be added or removed.
				// There must be at least one container in a Pod.
				// Cannot be updated.
				containers!: [...{
					// Arguments to the entrypoint.
					// The container image's CMD is used if this is not provided.
					// Variable references $(VAR_NAME) are expanded using the
					// container's environment. If a variable
					// cannot be resolved, the reference in the input string will be
					// unchanged. Double $$ are reduced
					// to a single $, which allows for escaping the $(VAR_NAME)
					// syntax: i.e. "$$(VAR_NAME)" will
					// produce the string literal "$(VAR_NAME)". Escaped references
					// will never be expanded, regardless
					// of whether the variable exists or not. Cannot be updated.
					// More info:
					// https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/#running-a-command-in-a-shell
					args?: [...string]

					// Entrypoint array. Not executed within a shell.
					// The container image's ENTRYPOINT is used if this is not
					// provided.
					// Variable references $(VAR_NAME) are expanded using the
					// container's environment. If a variable
					// cannot be resolved, the reference in the input string will be
					// unchanged. Double $$ are reduced
					// to a single $, which allows for escaping the $(VAR_NAME)
					// syntax: i.e. "$$(VAR_NAME)" will
					// produce the string literal "$(VAR_NAME)". Escaped references
					// will never be expanded, regardless
					// of whether the variable exists or not. Cannot be updated.
					// More info:
					// https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/#running-a-command-in-a-shell
					command?: [...string]

					// List of environment variables to set in the container.
					// Cannot be updated.
					env?: [...{
						// Name of the environment variable.
						// May consist of any printable ASCII characters except '='.
						name!: string

						// Variable references $(VAR_NAME) are expanded
						// using the previously defined environment variables in the
						// container and
						// any service environment variables. If a variable cannot be
						// resolved,
						// the reference in the input string will be unchanged. Double $$
						// are reduced
						// to a single $, which allows for escaping the $(VAR_NAME)
						// syntax: i.e.
						// "$$(VAR_NAME)" will produce the string literal "$(VAR_NAME)".
						// Escaped references will never be expanded, regardless of
						// whether the variable
						// exists or not.
						// Defaults to "".
						value?: string

						// Source for the environment variable's value. Cannot be used if
						// value is not empty.
						valueFrom?: {
							// Selects a key of a ConfigMap.
							configMapKeyRef?: {
								// The key to select.
								key!: string

								// Name of the referent.
								// This field is effectively required, but due to backwards
								// compatibility is
								// allowed to be empty. Instances of this type with an empty value
								// here are
								// almost certainly wrong.
								// More info:
								// https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
								name?: string

								// Specify whether the ConfigMap or its key must be defined
								optional?: bool
							}

							// Selects a field of the pod: supports metadata.name,
							// metadata.namespace, `metadata.labels['<KEY>']`,
							// `metadata.annotations['<KEY>']`,
							// spec.nodeName, spec.serviceAccountName, status.hostIP,
							// status.podIP, status.podIPs.
							fieldRef?: {
								// Version of the schema the FieldPath is written in terms of,
								// defaults to "v1".
								apiVersion?: string

								// Path of the field to select in the specified API version.
								fieldPath!: string
							}

							// FileKeyRef selects a key of the env file.
							// Requires the EnvFiles feature gate to be enabled.
							fileKeyRef?: {
								// The key within the env file. An invalid key will prevent the
								// pod from starting.
								// The keys defined within a source may consist of any printable
								// ASCII characters except '='.
								// During Alpha stage of the EnvFiles feature gate, the key size
								// is limited to 128 characters.
								key!: string

								// Specify whether the file or its key must be defined. If the
								// file or key
								// does not exist, then the env var is not published.
								// If optional is set to true and the specified key does not
								// exist,
								// the environment variable will not be set in the Pod's
								// containers.
								//
								// If optional is set to false and the specified key does not
								// exist,
								// an error will be returned during Pod creation.
								optional?: bool

								// The path within the volume from which to select the file.
								// Must be relative and may not contain the '..' path or start
								// with '..'.
								path!: string

								// The name of the volume mount containing the env file.
								volumeName!: string
							}

							// Selects a resource of the container: only resources limits and
							// requests
							// (limits.cpu, limits.memory, limits.ephemeral-storage,
							// requests.cpu, requests.memory and requests.ephemeral-storage)
							// are currently supported.
							resourceFieldRef?: {
								// Container name: required for volumes, optional for env vars
								containerName?: string

								// Specifies the output format of the exposed resources, defaults
								// to "1"
								divisor?: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")

								// Required: resource to select
								resource!: string
							}

							// Selects a key of a secret in the pod's namespace
							secretKeyRef?: {
								// The key of the secret to select from. Must be a valid secret
								// key.
								key!: string

								// Name of the referent.
								// This field is effectively required, but due to backwards
								// compatibility is
								// allowed to be empty. Instances of this type with an empty value
								// here are
								// almost certainly wrong.
								// More info:
								// https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
								name?: string

								// Specify whether the Secret or its key must be defined
								optional?: bool
							}
						}
					}]

					// List of sources to populate environment variables in the
					// container.
					// The keys defined within a source may consist of any printable
					// ASCII characters except '='.
					// When a key exists in multiple
					// sources, the value associated with the last source will take
					// precedence.
					// Values defined by an Env with a duplicate key will take
					// precedence.
					// Cannot be updated.
					envFrom?: [...{
						// The ConfigMap to select from
						configMapRef?: {
							// Name of the referent.
							// This field is effectively required, but due to backwards
							// compatibility is
							// allowed to be empty. Instances of this type with an empty value
							// here are
							// almost certainly wrong.
							// More info:
							// https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
							name?: string

							// Specify whether the ConfigMap must be defined
							optional?: bool
						}

						// Optional text to prepend to the name of each environment
						// variable.
						// May consist of any printable ASCII characters except '='.
						prefix?: string

						// The Secret to select from
						secretRef?: {
							// Name of the referent.
							// This field is effectively required, but due to backwards
							// compatibility is
							// allowed to be empty. Instances of this type with an empty value
							// here are
							// almost certainly wrong.
							// More info:
							// https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
							name?: string

							// Specify whether the Secret must be defined
							optional?: bool
						}
					}]

					// Container image name.
					// More info:
					// https://kubernetes.io/docs/concepts/containers/images
					// This field is optional to allow higher level config management
					// to default or override
					// container images in workload controllers like Deployments and
					// StatefulSets.
					image?: string

					// Image pull policy.
					// One of Always, Never, IfNotPresent.
					// Defaults to Always if :latest tag is specified, or IfNotPresent
					// otherwise.
					// Cannot be updated.
					// More info:
					// https://kubernetes.io/docs/concepts/containers/images#updating-images
					imagePullPolicy?: string

					// Actions that the management system should take in response to
					// container lifecycle events.
					// Cannot be updated.
					lifecycle?: {
						// PostStart is called immediately after a container is created.
						// If the handler fails,
						// the container is terminated and restarted according to its
						// restart policy.
						// Other management of the container blocks until the hook
						// completes.
						// More info:
						// https://kubernetes.io/docs/concepts/containers/container-lifecycle-hooks/#container-hooks
						postStart?: {
							// Exec specifies a command to execute in the container.
							exec?: {
								// Command is the command line to execute inside the container,
								// the working directory for the
								// command is root ('/') in the container's filesystem. The
								// command is simply exec'd, it is
								// not run inside a shell, so traditional shell instructions ('|',
								// etc) won't work. To use
								// a shell, you need to explicitly call out to that shell.
								// Exit status of 0 is treated as live/healthy and non-zero is
								// unhealthy.
								command?: [...string]
							}

							// HTTPGet specifies an HTTP GET request to perform.
							httpGet?: {
								// Host name to connect to, defaults to the pod IP. You probably
								// want to set
								// "Host" in httpHeaders instead.
								host?: string

								// Custom headers to set in the request. HTTP allows repeated
								// headers.
								httpHeaders?: [...{
									// The header field name.
									// This will be canonicalized upon output, so case-variant names
									// will be understood as the same header.
									name!: string

									// The header field value
									value!: string
								}]

								// Path to access on the HTTP server.
								path?: string

								// Name or number of the port to access on the container.
								// Number must be in the range 1 to 65535.
								// Name must be an IANA_SVC_NAME.
								port!: matchN(>=1, [int, string]) & (int | string)

								// Scheme to use for connecting to the host.
								// Defaults to HTTP.
								scheme?: string
							}

							// Sleep represents a duration that the container should sleep.
							sleep?: {
								// Seconds is the number of seconds to sleep.
								seconds!: int64 & int
							}

							// Deprecated. TCPSocket is NOT supported as a LifecycleHandler
							// and kept
							// for backward compatibility. There is no validation of this
							// field and
							// lifecycle hooks will fail at runtime when it is specified.
							tcpSocket?: {
								// Optional: Host name to connect to, defaults to the pod IP.
								host?: string

								// Number or name of the port to access on the container.
								// Number must be in the range 1 to 65535.
								// Name must be an IANA_SVC_NAME.
								port!: matchN(>=1, [int, string]) & (int | string)
							}
						}

						// PreStop is called immediately before a container is terminated
						// due to an
						// API request or management event such as liveness/startup probe
						// failure,
						// preemption, resource contention, etc. The handler is not called
						// if the
						// container crashes or exits. The Pod's termination grace period
						// countdown begins before the
						// PreStop hook is executed. Regardless of the outcome of the
						// handler, the
						// container will eventually terminate within the Pod's
						// termination grace
						// period (unless delayed by finalizers). Other management of the
						// container blocks until the hook completes
						// or until the termination grace period is reached.
						// More info:
						// https://kubernetes.io/docs/concepts/containers/container-lifecycle-hooks/#container-hooks
						preStop?: {
							// Exec specifies a command to execute in the container.
							exec?: {
								// Command is the command line to execute inside the container,
								// the working directory for the
								// command is root ('/') in the container's filesystem. The
								// command is simply exec'd, it is
								// not run inside a shell, so traditional shell instructions ('|',
								// etc) won't work. To use
								// a shell, you need to explicitly call out to that shell.
								// Exit status of 0 is treated as live/healthy and non-zero is
								// unhealthy.
								command?: [...string]
							}

							// HTTPGet specifies an HTTP GET request to perform.
							httpGet?: {
								// Host name to connect to, defaults to the pod IP. You probably
								// want to set
								// "Host" in httpHeaders instead.
								host?: string

								// Custom headers to set in the request. HTTP allows repeated
								// headers.
								httpHeaders?: [...{
									// The header field name.
									// This will be canonicalized upon output, so case-variant names
									// will be understood as the same header.
									name!: string

									// The header field value
									value!: string
								}]

								// Path to access on the HTTP server.
								path?: string

								// Name or number of the port to access on the container.
								// Number must be in the range 1 to 65535.
								// Name must be an IANA_SVC_NAME.
								port!: matchN(>=1, [int, string]) & (int | string)

								// Scheme to use for connecting to the host.
								// Defaults to HTTP.
								scheme?: string
							}

							// Sleep represents a duration that the container should sleep.
							sleep?: {
								// Seconds is the number of seconds to sleep.
								seconds!: int64 & int
							}

							// Deprecated. TCPSocket is NOT supported as a LifecycleHandler
							// and kept
							// for backward compatibility. There is no validation of this
							// field and
							// lifecycle hooks will fail at runtime when it is specified.
							tcpSocket?: {
								// Optional: Host name to connect to, defaults to the pod IP.
								host?: string

								// Number or name of the port to access on the container.
								// Number must be in the range 1 to 65535.
								// Name must be an IANA_SVC_NAME.
								port!: matchN(>=1, [int, string]) & (int | string)
							}
						}

						// StopSignal defines which signal will be sent to a container
						// when it is being stopped.
						// If not specified, the default is defined by the container
						// runtime in use.
						// StopSignal can only be set for Pods with a non-empty
						// .spec.os.name
						stopSignal?: string
					}

					// Periodic probe of container liveness.
					// Container will be restarted if the probe fails.
					// Cannot be updated.
					// More info:
					// https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes
					livenessProbe?: {
						// Exec specifies a command to execute in the container.
						exec?: {
							// Command is the command line to execute inside the container,
							// the working directory for the
							// command is root ('/') in the container's filesystem. The
							// command is simply exec'd, it is
							// not run inside a shell, so traditional shell instructions ('|',
							// etc) won't work. To use
							// a shell, you need to explicitly call out to that shell.
							// Exit status of 0 is treated as live/healthy and non-zero is
							// unhealthy.
							command?: [...string]
						}

						// Minimum consecutive failures for the probe to be considered
						// failed after having succeeded.
						// Defaults to 3. Minimum value is 1.
						failureThreshold?: int32 & int

						// GRPC specifies a GRPC HealthCheckRequest.
						grpc?: {
							// Port number of the gRPC service. Number must be in the range 1
							// to 65535.
							port!: int32 & int

							// Service is the name of the service to place in the gRPC
							// HealthCheckRequest
							// (see
							// https://github.com/grpc/grpc/blob/master/doc/health-checking.md).
							//
							// If this is not specified, the default behavior is defined by
							// gRPC.
							service?: string
						}

						// HTTPGet specifies an HTTP GET request to perform.
						httpGet?: {
							// Host name to connect to, defaults to the pod IP. You probably
							// want to set
							// "Host" in httpHeaders instead.
							host?: string

							// Custom headers to set in the request. HTTP allows repeated
							// headers.
							httpHeaders?: [...{
								// The header field name.
								// This will be canonicalized upon output, so case-variant names
								// will be understood as the same header.
								name!: string

								// The header field value
								value!: string
							}]

							// Path to access on the HTTP server.
							path?: string

							// Name or number of the port to access on the container.
							// Number must be in the range 1 to 65535.
							// Name must be an IANA_SVC_NAME.
							port!: matchN(>=1, [int, string]) & (int | string)

							// Scheme to use for connecting to the host.
							// Defaults to HTTP.
							scheme?: string
						}

						// Number of seconds after the container has started before
						// liveness probes are initiated.
						// More info:
						// https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes
						initialDelaySeconds?: int32 & int

						// How often (in seconds) to perform the probe.
						// Default to 10 seconds. Minimum value is 1.
						periodSeconds?: int32 & int

						// Minimum consecutive successes for the probe to be considered
						// successful after having failed.
						// Defaults to 1. Must be 1 for liveness and startup. Minimum
						// value is 1.
						successThreshold?: int32 & int

						// TCPSocket specifies a connection to a TCP port.
						tcpSocket?: {
							// Optional: Host name to connect to, defaults to the pod IP.
							host?: string

							// Number or name of the port to access on the container.
							// Number must be in the range 1 to 65535.
							// Name must be an IANA_SVC_NAME.
							port!: matchN(>=1, [int, string]) & (int | string)
						}

						// Optional duration in seconds the pod needs to terminate
						// gracefully upon probe failure.
						// The grace period is the duration in seconds after the processes
						// running in the pod are sent
						// a termination signal and the time when the processes are
						// forcibly halted with a kill signal.
						// Set this value longer than the expected cleanup time for your
						// process.
						// If this value is nil, the pod's terminationGracePeriodSeconds
						// will be used. Otherwise, this
						// value overrides the value provided by the pod spec.
						// Value must be non-negative integer. The value zero indicates
						// stop immediately via
						// the kill signal (no opportunity to shut down).
						// This is a beta field and requires enabling
						// ProbeTerminationGracePeriod feature gate.
						// Minimum value is 1. spec.terminationGracePeriodSeconds is used
						// if unset.
						terminationGracePeriodSeconds?: int64 & int

						// Number of seconds after which the probe times out.
						// Defaults to 1 second. Minimum value is 1.
						// More info:
						// https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes
						timeoutSeconds?: int32 & int
					}

					// Name of the container specified as a DNS_LABEL.
					// Each container in a pod must have a unique name (DNS_LABEL).
					// Cannot be updated.
					name!: string

					// List of ports to expose from the container. Not specifying a
					// port here
					// DOES NOT prevent that port from being exposed. Any port which
					// is
					// listening on the default "0.0.0.0" address inside a container
					// will be
					// accessible from the network.
					// Modifying this array with strategic merge patch may corrupt the
					// data.
					// For more information See
					// https://github.com/kubernetes/kubernetes/issues/108255.
					// Cannot be updated.
					ports?: [...{
						// Number of port to expose on the pod's IP address.
						// This must be a valid port number, 0 < x < 65536.
						containerPort!: int32 & int

						// What host IP to bind the external port to.
						hostIP?: string

						// Number of port to expose on the host.
						// If specified, this must be a valid port number, 0 < x < 65536.
						// If HostNetwork is specified, this must match ContainerPort.
						// Most containers do not need this.
						hostPort?: int32 & int

						// If specified, this must be an IANA_SVC_NAME and unique within
						// the pod. Each
						// named port in a pod must have a unique name. Name for the port
						// that can be
						// referred to by services.
						name?: string

						// Protocol for port. Must be UDP, TCP, or SCTP.
						// Defaults to "TCP".
						protocol?: string
					}]

					// Periodic probe of container service readiness.
					// Container will be removed from service endpoints if the probe
					// fails.
					// Cannot be updated.
					// More info:
					// https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes
					readinessProbe?: {
						// Exec specifies a command to execute in the container.
						exec?: {
							// Command is the command line to execute inside the container,
							// the working directory for the
							// command is root ('/') in the container's filesystem. The
							// command is simply exec'd, it is
							// not run inside a shell, so traditional shell instructions ('|',
							// etc) won't work. To use
							// a shell, you need to explicitly call out to that shell.
							// Exit status of 0 is treated as live/healthy and non-zero is
							// unhealthy.
							command?: [...string]
						}

						// Minimum consecutive failures for the probe to be considered
						// failed after having succeeded.
						// Defaults to 3. Minimum value is 1.
						failureThreshold?: int32 & int

						// GRPC specifies a GRPC HealthCheckRequest.
						grpc?: {
							// Port number of the gRPC service. Number must be in the range 1
							// to 65535.
							port!: int32 & int

							// Service is the name of the service to place in the gRPC
							// HealthCheckRequest
							// (see
							// https://github.com/grpc/grpc/blob/master/doc/health-checking.md).
							//
							// If this is not specified, the default behavior is defined by
							// gRPC.
							service?: string
						}

						// HTTPGet specifies an HTTP GET request to perform.
						httpGet?: {
							// Host name to connect to, defaults to the pod IP. You probably
							// want to set
							// "Host" in httpHeaders instead.
							host?: string

							// Custom headers to set in the request. HTTP allows repeated
							// headers.
							httpHeaders?: [...{
								// The header field name.
								// This will be canonicalized upon output, so case-variant names
								// will be understood as the same header.
								name!: string

								// The header field value
								value!: string
							}]

							// Path to access on the HTTP server.
							path?: string

							// Name or number of the port to access on the container.
							// Number must be in the range 1 to 65535.
							// Name must be an IANA_SVC_NAME.
							port!: matchN(>=1, [int, string]) & (int | string)

							// Scheme to use for connecting to the host.
							// Defaults to HTTP.
							scheme?: string
						}

						// Number of seconds after the container has started before
						// liveness probes are initiated.
						// More info:
						// https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes
						initialDelaySeconds?: int32 & int

						// How often (in seconds) to perform the probe.
						// Default to 10 seconds. Minimum value is 1.
						periodSeconds?: int32 & int

						// Minimum consecutive successes for the probe to be considered
						// successful after having failed.
						// Defaults to 1. Must be 1 for liveness and startup. Minimum
						// value is 1.
						successThreshold?: int32 & int

						// TCPSocket specifies a connection to a TCP port.
						tcpSocket?: {
							// Optional: Host name to connect to, defaults to the pod IP.
							host?: string

							// Number or name of the port to access on the container.
							// Number must be in the range 1 to 65535.
							// Name must be an IANA_SVC_NAME.
							port!: matchN(>=1, [int, string]) & (int | string)
						}

						// Optional duration in seconds the pod needs to terminate
						// gracefully upon probe failure.
						// The grace period is the duration in seconds after the processes
						// running in the pod are sent
						// a termination signal and the time when the processes are
						// forcibly halted with a kill signal.
						// Set this value longer than the expected cleanup time for your
						// process.
						// If this value is nil, the pod's terminationGracePeriodSeconds
						// will be used. Otherwise, this
						// value overrides the value provided by the pod spec.
						// Value must be non-negative integer. The value zero indicates
						// stop immediately via
						// the kill signal (no opportunity to shut down).
						// This is a beta field and requires enabling
						// ProbeTerminationGracePeriod feature gate.
						// Minimum value is 1. spec.terminationGracePeriodSeconds is used
						// if unset.
						terminationGracePeriodSeconds?: int64 & int

						// Number of seconds after which the probe times out.
						// Defaults to 1 second. Minimum value is 1.
						// More info:
						// https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes
						timeoutSeconds?: int32 & int
					}

					// Resources resize policy for the container.
					// This field cannot be set on ephemeral containers.
					resizePolicy?: [...{
						// Name of the resource to which this resource resize policy
						// applies.
						// Supported values: cpu, memory.
						resourceName!: string

						// Restart policy to apply when specified resource is resized.
						// If not specified, it defaults to NotRequired.
						restartPolicy!: string
					}]

					// Compute Resources required by this container.
					// Cannot be updated.
					// More info:
					// https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/
					resources?: {
						// Claims lists the names of resources, defined in
						// spec.resourceClaims,
						// that are used by this container.
						//
						// This field depends on the
						// DynamicResourceAllocation feature gate.
						//
						// This field is immutable. It can only be set for containers.
						claims?: [...{
							// Name must match the name of one entry in
							// pod.spec.resourceClaims of
							// the Pod where this field is used. It makes that resource
							// available
							// inside a container.
							name!: string

							// Request is the name chosen for a request in the referenced
							// claim.
							// If empty, everything from the claim is made available,
							// otherwise
							// only the result of this request.
							request?: string
						}]

						// Limits describes the maximum amount of compute resources
						// allowed.
						// More info:
						// https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/
						limits?: [string]: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")

						// Requests describes the minimum amount of compute resources
						// required.
						// If Requests is omitted for a container, it defaults to Limits
						// if that is explicitly specified,
						// otherwise to an implementation-defined value. Requests cannot
						// exceed Limits.
						// More info:
						// https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/
						requests?: [string]: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")
					}

					// RestartPolicy defines the restart behavior of individual
					// containers in a pod.
					// This overrides the pod-level restart policy. When this field is
					// not specified,
					// the restart behavior is defined by the Pod's restart policy and
					// the container type.
					// Additionally, setting the RestartPolicy as "Always" for the
					// init container will
					// have the following effect:
					// this init container will be continually restarted on
					// exit until all regular containers have terminated. Once all
					// regular
					// containers have completed, all init containers with
					// restartPolicy "Always"
					// will be shut down. This lifecycle differs from normal init
					// containers and
					// is often referred to as a "sidecar" container. Although this
					// init
					// container still starts in the init container sequence, it does
					// not wait
					// for the container to complete before proceeding to the next
					// init
					// container. Instead, the next init container starts immediately
					// after this
					// init container is started, or after any startupProbe has
					// successfully
					// completed.
					restartPolicy?: string

					// Represents a list of rules to be checked to determine if the
					// container should be restarted on exit. The rules are evaluated
					// in
					// order. Once a rule matches a container exit condition, the
					// remaining
					// rules are ignored. If no rule matches the container exit
					// condition,
					// the Container-level restart policy determines the whether the
					// container
					// is restarted or not. Constraints on the rules:
					// - At most 20 rules are allowed.
					// - Rules can have the same action.
					// - Identical rules are not forbidden in validations.
					// When rules are specified, container MUST set RestartPolicy
					// explicitly
					// even it if matches the Pod's RestartPolicy.
					restartPolicyRules?: [...{
						// Specifies the action taken on a container exit if the
						// requirements
						// are satisfied. The only possible value is "Restart" to restart
						// the
						// container.
						action!: string

						// Represents the exit codes to check on container exits.
						exitCodes?: {
							// Represents the relationship between the container exit code(s)
							// and the
							// specified values. Possible values are:
							// - In: the requirement is satisfied if the container exit code
							// is in the
							// set of specified values.
							// - NotIn: the requirement is satisfied if the container exit
							// code is
							// not in the set of specified values.
							operator!: string

							// Specifies the set of values to check for container exit codes.
							// At most 255 elements are allowed.
							values?: [...int32 & int]
						}
					}]

					// SecurityContext defines the security options the container
					// should be run with.
					// If set, the fields of SecurityContext override the equivalent
					// fields of PodSecurityContext.
					// More info:
					// https://kubernetes.io/docs/tasks/configure-pod-container/security-context/
					securityContext?: {
						// AllowPrivilegeEscalation controls whether a process can gain
						// more
						// privileges than its parent process. This bool directly controls
						// if
						// the no_new_privs flag will be set on the container process.
						// AllowPrivilegeEscalation is true always when the container is:
						// 1) run as Privileged
						// 2) has CAP_SYS_ADMIN
						// Note that this field cannot be set when spec.os.name is
						// windows.
						allowPrivilegeEscalation?: bool

						// appArmorProfile is the AppArmor options to use by this
						// container. If set, this profile
						// overrides the pod's appArmorProfile.
						// Note that this field cannot be set when spec.os.name is
						// windows.
						appArmorProfile?: {
							// localhostProfile indicates a profile loaded on the node that
							// should be used.
							// The profile must be preconfigured on the node to work.
							// Must match the loaded name of the profile.
							// Must be set if and only if type is "Localhost".
							localhostProfile?: string

							// type indicates which kind of AppArmor profile will be applied.
							// Valid options are:
							// Localhost - a profile pre-loaded on the node.
							// RuntimeDefault - the container runtime's default profile.
							// Unconfined - no AppArmor enforcement.
							type!: string
						}

						// The capabilities to add/drop when running containers.
						// Defaults to the default set of capabilities granted by the
						// container runtime.
						// Note that this field cannot be set when spec.os.name is
						// windows.
						capabilities?: {
							// Added capabilities
							add?: [...string]

							// Removed capabilities
							drop?: [...string]
						}

						// Run container in privileged mode.
						// Processes in privileged containers are essentially equivalent
						// to root on the host.
						// Defaults to false.
						// Note that this field cannot be set when spec.os.name is
						// windows.
						privileged?: bool

						// procMount denotes the type of proc mount to use for the
						// containers.
						// The default value is Default which uses the container runtime
						// defaults for
						// readonly paths and masked paths.
						// This requires the ProcMountType feature flag to be enabled.
						// Note that this field cannot be set when spec.os.name is
						// windows.
						procMount?: string

						// Whether this container has a read-only root filesystem.
						// Default is false.
						// Note that this field cannot be set when spec.os.name is
						// windows.
						readOnlyRootFilesystem?: bool

						// The GID to run the entrypoint of the container process.
						// Uses runtime default if unset.
						// May also be set in PodSecurityContext. If set in both
						// SecurityContext and
						// PodSecurityContext, the value specified in SecurityContext
						// takes precedence.
						// Note that this field cannot be set when spec.os.name is
						// windows.
						runAsGroup?: int64 & int

						// Indicates that the container must run as a non-root user.
						// If true, the Kubelet will validate the image at runtime to
						// ensure that it
						// does not run as UID 0 (root) and fail to start the container if
						// it does.
						// If unset or false, no such validation will be performed.
						// May also be set in PodSecurityContext. If set in both
						// SecurityContext and
						// PodSecurityContext, the value specified in SecurityContext
						// takes precedence.
						runAsNonRoot?: bool

						// The UID to run the entrypoint of the container process.
						// Defaults to user specified in image metadata if unspecified.
						// May also be set in PodSecurityContext. If set in both
						// SecurityContext and
						// PodSecurityContext, the value specified in SecurityContext
						// takes precedence.
						// Note that this field cannot be set when spec.os.name is
						// windows.
						runAsUser?: int64 & int

						// The SELinux context to be applied to the container.
						// If unspecified, the container runtime will allocate a random
						// SELinux context for each
						// container. May also be set in PodSecurityContext. If set in
						// both SecurityContext and
						// PodSecurityContext, the value specified in SecurityContext
						// takes precedence.
						// Note that this field cannot be set when spec.os.name is
						// windows.
						seLinuxOptions?: {
							// Level is SELinux level label that applies to the container.
							level?: string

							// Role is a SELinux role label that applies to the container.
							role?: string

							// Type is a SELinux type label that applies to the container.
							type?: string

							// User is a SELinux user label that applies to the container.
							user?: string
						}

						// The seccomp options to use by this container. If seccomp
						// options are
						// provided at both the pod & container level, the container
						// options
						// override the pod options.
						// Note that this field cannot be set when spec.os.name is
						// windows.
						seccompProfile?: {
							// localhostProfile indicates a profile defined in a file on the
							// node should be used.
							// The profile must be preconfigured on the node to work.
							// Must be a descending path, relative to the kubelet's configured
							// seccomp profile location.
							// Must be set if type is "Localhost". Must NOT be set for any
							// other type.
							localhostProfile?: string

							// type indicates which kind of seccomp profile will be applied.
							// Valid options are:
							//
							// Localhost - a profile defined in a file on the node should be
							// used.
							// RuntimeDefault - the container runtime default profile should
							// be used.
							// Unconfined - no profile should be applied.
							type!: string
						}

						// The Windows specific settings applied to all containers.
						// If unspecified, the options from the PodSecurityContext will be
						// used.
						// If set in both SecurityContext and PodSecurityContext, the
						// value specified in SecurityContext takes precedence.
						// Note that this field cannot be set when spec.os.name is linux.
						windowsOptions?: {
							// GMSACredentialSpec is where the GMSA admission webhook
							// (https://github.com/kubernetes-sigs/windows-gmsa) inlines the
							// contents of the
							// GMSA credential spec named by the GMSACredentialSpecName field.
							gmsaCredentialSpec?: string

							// GMSACredentialSpecName is the name of the GMSA credential spec
							// to use.
							gmsaCredentialSpecName?: string

							// HostProcess determines if a container should be run as a 'Host
							// Process' container.
							// All of a Pod's containers must have the same effective
							// HostProcess value
							// (it is not allowed to have a mix of HostProcess containers and
							// non-HostProcess containers).
							// In addition, if HostProcess is true then HostNetwork must also
							// be set to true.
							hostProcess?: bool

							// The UserName in Windows to run the entrypoint of the container
							// process.
							// Defaults to the user specified in image metadata if
							// unspecified.
							// May also be set in PodSecurityContext. If set in both
							// SecurityContext and
							// PodSecurityContext, the value specified in SecurityContext
							// takes precedence.
							runAsUserName?: string
						}
					}

					// StartupProbe indicates that the Pod has successfully
					// initialized.
					// If specified, no other probes are executed until this completes
					// successfully.
					// If this probe fails, the Pod will be restarted, just as if the
					// livenessProbe failed.
					// This can be used to provide different probe parameters at the
					// beginning of a Pod's lifecycle,
					// when it might take a long time to load data or warm a cache,
					// than during steady-state operation.
					// This cannot be updated.
					// More info:
					// https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes
					startupProbe?: {
						// Exec specifies a command to execute in the container.
						exec?: {
							// Command is the command line to execute inside the container,
							// the working directory for the
							// command is root ('/') in the container's filesystem. The
							// command is simply exec'd, it is
							// not run inside a shell, so traditional shell instructions ('|',
							// etc) won't work. To use
							// a shell, you need to explicitly call out to that shell.
							// Exit status of 0 is treated as live/healthy and non-zero is
							// unhealthy.
							command?: [...string]
						}

						// Minimum consecutive failures for the probe to be considered
						// failed after having succeeded.
						// Defaults to 3. Minimum value is 1.
						failureThreshold?: int32 & int

						// GRPC specifies a GRPC HealthCheckRequest.
						grpc?: {
							// Port number of the gRPC service. Number must be in the range 1
							// to 65535.
							port!: int32 & int

							// Service is the name of the service to place in the gRPC
							// HealthCheckRequest
							// (see
							// https://github.com/grpc/grpc/blob/master/doc/health-checking.md).
							//
							// If this is not specified, the default behavior is defined by
							// gRPC.
							service?: string
						}

						// HTTPGet specifies an HTTP GET request to perform.
						httpGet?: {
							// Host name to connect to, defaults to the pod IP. You probably
							// want to set
							// "Host" in httpHeaders instead.
							host?: string

							// Custom headers to set in the request. HTTP allows repeated
							// headers.
							httpHeaders?: [...{
								// The header field name.
								// This will be canonicalized upon output, so case-variant names
								// will be understood as the same header.
								name!: string

								// The header field value
								value!: string
							}]

							// Path to access on the HTTP server.
							path?: string

							// Name or number of the port to access on the container.
							// Number must be in the range 1 to 65535.
							// Name must be an IANA_SVC_NAME.
							port!: matchN(>=1, [int, string]) & (int | string)

							// Scheme to use for connecting to the host.
							// Defaults to HTTP.
							scheme?: string
						}

						// Number of seconds after the container has started before
						// liveness probes are initiated.
						// More info:
						// https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes
						initialDelaySeconds?: int32 & int

						// How often (in seconds) to perform the probe.
						// Default to 10 seconds. Minimum value is 1.
						periodSeconds?: int32 & int

						// Minimum consecutive successes for the probe to be considered
						// successful after having failed.
						// Defaults to 1. Must be 1 for liveness and startup. Minimum
						// value is 1.
						successThreshold?: int32 & int

						// TCPSocket specifies a connection to a TCP port.
						tcpSocket?: {
							// Optional: Host name to connect to, defaults to the pod IP.
							host?: string

							// Number or name of the port to access on the container.
							// Number must be in the range 1 to 65535.
							// Name must be an IANA_SVC_NAME.
							port!: matchN(>=1, [int, string]) & (int | string)
						}

						// Optional duration in seconds the pod needs to terminate
						// gracefully upon probe failure.
						// The grace period is the duration in seconds after the processes
						// running in the pod are sent
						// a termination signal and the time when the processes are
						// forcibly halted with a kill signal.
						// Set this value longer than the expected cleanup time for your
						// process.
						// If this value is nil, the pod's terminationGracePeriodSeconds
						// will be used. Otherwise, this
						// value overrides the value provided by the pod spec.
						// Value must be non-negative integer. The value zero indicates
						// stop immediately via
						// the kill signal (no opportunity to shut down).
						// This is a beta field and requires enabling
						// ProbeTerminationGracePeriod feature gate.
						// Minimum value is 1. spec.terminationGracePeriodSeconds is used
						// if unset.
						terminationGracePeriodSeconds?: int64 & int

						// Number of seconds after which the probe times out.
						// Defaults to 1 second. Minimum value is 1.
						// More info:
						// https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes
						timeoutSeconds?: int32 & int
					}

					// Whether this container should allocate a buffer for stdin in
					// the container runtime. If this
					// is not set, reads from stdin in the container will always
					// result in EOF.
					// Default is false.
					stdin?: bool

					// Whether the container runtime should close the stdin channel
					// after it has been opened by
					// a single attach. When stdin is true the stdin stream will
					// remain open across multiple attach
					// sessions. If stdinOnce is set to true, stdin is opened on
					// container start, is empty until the
					// first client attaches to stdin, and then remains open and
					// accepts data until the client disconnects,
					// at which time stdin is closed and remains closed until the
					// container is restarted. If this
					// flag is false, a container processes that reads from stdin will
					// never receive an EOF.
					// Default is false
					stdinOnce?: bool

					// Optional: Path at which the file to which the container's
					// termination message
					// will be written is mounted into the container's filesystem.
					// Message written is intended to be brief final status, such as
					// an assertion failure message.
					// Will be truncated by the node if greater than 4096 bytes. The
					// total message length across
					// all containers will be limited to 12kb.
					// Defaults to /dev/termination-log.
					// Cannot be updated.
					terminationMessagePath?: string

					// Indicate how the termination message should be populated. File
					// will use the contents of
					// terminationMessagePath to populate the container status message
					// on both success and failure.
					// FallbackToLogsOnError will use the last chunk of container log
					// output if the termination
					// message file is empty and the container exited with an error.
					// The log output is limited to 2048 bytes or 80 lines, whichever
					// is smaller.
					// Defaults to File.
					// Cannot be updated.
					terminationMessagePolicy?: string

					// Whether this container should allocate a TTY for itself, also
					// requires 'stdin' to be true.
					// Default is false.
					tty?: bool

					// volumeDevices is the list of block devices to be used by the
					// container.
					volumeDevices?: [...{
						// devicePath is the path inside of the container that the device
						// will be mapped to.
						devicePath!: string

						// name must match the name of a persistentVolumeClaim in the pod
						name!: string
					}]

					// Pod volumes to mount into the container's filesystem.
					// Cannot be updated.
					volumeMounts?: [...{
						// Path within the container at which the volume should be
						// mounted. Must
						// not contain ':'.
						mountPath!: string

						// mountPropagation determines how mounts are propagated from the
						// host
						// to container and the other way around.
						// When not set, MountPropagationNone is used.
						// This field is beta in 1.10.
						// When RecursiveReadOnly is set to IfPossible or to Enabled,
						// MountPropagation must be None or unspecified
						// (which defaults to None).
						mountPropagation?: string

						// This must match the Name of a Volume.
						name!: string

						// Mounted read-only if true, read-write otherwise (false or
						// unspecified).
						// Defaults to false.
						readOnly?: bool

						// RecursiveReadOnly specifies whether read-only mounts should be
						// handled
						// recursively.
						//
						// If ReadOnly is false, this field has no meaning and must be
						// unspecified.
						//
						// If ReadOnly is true, and this field is set to Disabled, the
						// mount is not made
						// recursively read-only. If this field is set to IfPossible, the
						// mount is made
						// recursively read-only, if it is supported by the container
						// runtime. If this
						// field is set to Enabled, the mount is made recursively
						// read-only if it is
						// supported by the container runtime, otherwise the pod will not
						// be started and
						// an error will be generated to indicate the reason.
						//
						// If this field is set to IfPossible or Enabled, MountPropagation
						// must be set to
						// None (or be unspecified, which defaults to None).
						//
						// If this field is not specified, it is treated as an equivalent
						// of Disabled.
						recursiveReadOnly?: string

						// Path within the volume from which the container's volume should
						// be mounted.
						// Defaults to "" (volume's root).
						subPath?: string

						// Expanded path within the volume from which the container's
						// volume should be mounted.
						// Behaves similarly to SubPath but environment variable
						// references $(VAR_NAME) are expanded using the container's
						// environment.
						// Defaults to "" (volume's root).
						// SubPathExpr and SubPath are mutually exclusive.
						subPathExpr?: string
					}]

					// Container's working directory.
					// If not specified, the container runtime's default will be used,
					// which
					// might be configured in the container image.
					// Cannot be updated.
					workingDir?: string
				}]

				// Specifies the DNS parameters of a pod.
				// Parameters specified here will be merged to the generated DNS
				// configuration based on DNSPolicy.
				dnsConfig?: {
					// A list of DNS name server IP addresses.
					// This will be appended to the base nameservers generated from
					// DNSPolicy.
					// Duplicated nameservers will be removed.
					nameservers?: [...string]

					// A list of DNS resolver options.
					// This will be merged with the base options generated from
					// DNSPolicy.
					// Duplicated entries will be removed. Resolution options given in
					// Options
					// will override those that appear in the base DNSPolicy.
					options?: [...{
						// Name is this DNS resolver option's name.
						// Required.
						name?: string

						// Value is this DNS resolver option's value.
						value?: string
					}]

					// A list of DNS search domains for host-name lookup.
					// This will be appended to the base search paths generated from
					// DNSPolicy.
					// Duplicated search paths will be removed.
					searches?: [...string]
				}

				// Set DNS policy for the pod.
				// Defaults to "ClusterFirst".
				// Valid values are 'ClusterFirstWithHostNet', 'ClusterFirst',
				// 'Default' or 'None'.
				// DNS parameters given in DNSConfig will be merged with the
				// policy selected with DNSPolicy.
				// To have DNS options set along with hostNetwork, you have to
				// specify DNS policy
				// explicitly to 'ClusterFirstWithHostNet'.
				dnsPolicy?: string

				// EnableServiceLinks indicates whether information about services
				// should be injected into pod's
				// environment variables, matching the syntax of Docker links.
				// Optional: Defaults to true.
				enableServiceLinks?: bool

				// List of ephemeral containers run in this pod. Ephemeral
				// containers may be run in an existing
				// pod to perform user-initiated actions such as debugging. This
				// list cannot be specified when
				// creating a pod, and it cannot be modified by updating the pod
				// spec. In order to add an
				// ephemeral container to an existing pod, use the pod's
				// ephemeralcontainers subresource.
				ephemeralContainers?: [...{
					// Arguments to the entrypoint.
					// The image's CMD is used if this is not provided.
					// Variable references $(VAR_NAME) are expanded using the
					// container's environment. If a variable
					// cannot be resolved, the reference in the input string will be
					// unchanged. Double $$ are reduced
					// to a single $, which allows for escaping the $(VAR_NAME)
					// syntax: i.e. "$$(VAR_NAME)" will
					// produce the string literal "$(VAR_NAME)". Escaped references
					// will never be expanded, regardless
					// of whether the variable exists or not. Cannot be updated.
					// More info:
					// https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/#running-a-command-in-a-shell
					args?: [...string]

					// Entrypoint array. Not executed within a shell.
					// The image's ENTRYPOINT is used if this is not provided.
					// Variable references $(VAR_NAME) are expanded using the
					// container's environment. If a variable
					// cannot be resolved, the reference in the input string will be
					// unchanged. Double $$ are reduced
					// to a single $, which allows for escaping the $(VAR_NAME)
					// syntax: i.e. "$$(VAR_NAME)" will
					// produce the string literal "$(VAR_NAME)". Escaped references
					// will never be expanded, regardless
					// of whether the variable exists or not. Cannot be updated.
					// More info:
					// https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/#running-a-command-in-a-shell
					command?: [...string]

					// List of environment variables to set in the container.
					// Cannot be updated.
					env?: [...{
						// Name of the environment variable.
						// May consist of any printable ASCII characters except '='.
						name!: string

						// Variable references $(VAR_NAME) are expanded
						// using the previously defined environment variables in the
						// container and
						// any service environment variables. If a variable cannot be
						// resolved,
						// the reference in the input string will be unchanged. Double $$
						// are reduced
						// to a single $, which allows for escaping the $(VAR_NAME)
						// syntax: i.e.
						// "$$(VAR_NAME)" will produce the string literal "$(VAR_NAME)".
						// Escaped references will never be expanded, regardless of
						// whether the variable
						// exists or not.
						// Defaults to "".
						value?: string

						// Source for the environment variable's value. Cannot be used if
						// value is not empty.
						valueFrom?: {
							// Selects a key of a ConfigMap.
							configMapKeyRef?: {
								// The key to select.
								key!: string

								// Name of the referent.
								// This field is effectively required, but due to backwards
								// compatibility is
								// allowed to be empty. Instances of this type with an empty value
								// here are
								// almost certainly wrong.
								// More info:
								// https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
								name?: string

								// Specify whether the ConfigMap or its key must be defined
								optional?: bool
							}

							// Selects a field of the pod: supports metadata.name,
							// metadata.namespace, `metadata.labels['<KEY>']`,
							// `metadata.annotations['<KEY>']`,
							// spec.nodeName, spec.serviceAccountName, status.hostIP,
							// status.podIP, status.podIPs.
							fieldRef?: {
								// Version of the schema the FieldPath is written in terms of,
								// defaults to "v1".
								apiVersion?: string

								// Path of the field to select in the specified API version.
								fieldPath!: string
							}

							// FileKeyRef selects a key of the env file.
							// Requires the EnvFiles feature gate to be enabled.
							fileKeyRef?: {
								// The key within the env file. An invalid key will prevent the
								// pod from starting.
								// The keys defined within a source may consist of any printable
								// ASCII characters except '='.
								// During Alpha stage of the EnvFiles feature gate, the key size
								// is limited to 128 characters.
								key!: string

								// Specify whether the file or its key must be defined. If the
								// file or key
								// does not exist, then the env var is not published.
								// If optional is set to true and the specified key does not
								// exist,
								// the environment variable will not be set in the Pod's
								// containers.
								//
								// If optional is set to false and the specified key does not
								// exist,
								// an error will be returned during Pod creation.
								optional?: bool

								// The path within the volume from which to select the file.
								// Must be relative and may not contain the '..' path or start
								// with '..'.
								path!: string

								// The name of the volume mount containing the env file.
								volumeName!: string
							}

							// Selects a resource of the container: only resources limits and
							// requests
							// (limits.cpu, limits.memory, limits.ephemeral-storage,
							// requests.cpu, requests.memory and requests.ephemeral-storage)
							// are currently supported.
							resourceFieldRef?: {
								// Container name: required for volumes, optional for env vars
								containerName?: string

								// Specifies the output format of the exposed resources, defaults
								// to "1"
								divisor?: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")

								// Required: resource to select
								resource!: string
							}

							// Selects a key of a secret in the pod's namespace
							secretKeyRef?: {
								// The key of the secret to select from. Must be a valid secret
								// key.
								key!: string

								// Name of the referent.
								// This field is effectively required, but due to backwards
								// compatibility is
								// allowed to be empty. Instances of this type with an empty value
								// here are
								// almost certainly wrong.
								// More info:
								// https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
								name?: string

								// Specify whether the Secret or its key must be defined
								optional?: bool
							}
						}
					}]

					// List of sources to populate environment variables in the
					// container.
					// The keys defined within a source may consist of any printable
					// ASCII characters except '='.
					// When a key exists in multiple
					// sources, the value associated with the last source will take
					// precedence.
					// Values defined by an Env with a duplicate key will take
					// precedence.
					// Cannot be updated.
					envFrom?: [...{
						// The ConfigMap to select from
						configMapRef?: {
							// Name of the referent.
							// This field is effectively required, but due to backwards
							// compatibility is
							// allowed to be empty. Instances of this type with an empty value
							// here are
							// almost certainly wrong.
							// More info:
							// https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
							name?: string

							// Specify whether the ConfigMap must be defined
							optional?: bool
						}

						// Optional text to prepend to the name of each environment
						// variable.
						// May consist of any printable ASCII characters except '='.
						prefix?: string

						// The Secret to select from
						secretRef?: {
							// Name of the referent.
							// This field is effectively required, but due to backwards
							// compatibility is
							// allowed to be empty. Instances of this type with an empty value
							// here are
							// almost certainly wrong.
							// More info:
							// https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
							name?: string

							// Specify whether the Secret must be defined
							optional?: bool
						}
					}]

					// Container image name.
					// More info:
					// https://kubernetes.io/docs/concepts/containers/images
					image?: string

					// Image pull policy.
					// One of Always, Never, IfNotPresent.
					// Defaults to Always if :latest tag is specified, or IfNotPresent
					// otherwise.
					// Cannot be updated.
					// More info:
					// https://kubernetes.io/docs/concepts/containers/images#updating-images
					imagePullPolicy?: string

					// Lifecycle is not allowed for ephemeral containers.
					lifecycle?: {
						// PostStart is called immediately after a container is created.
						// If the handler fails,
						// the container is terminated and restarted according to its
						// restart policy.
						// Other management of the container blocks until the hook
						// completes.
						// More info:
						// https://kubernetes.io/docs/concepts/containers/container-lifecycle-hooks/#container-hooks
						postStart?: {
							// Exec specifies a command to execute in the container.
							exec?: {
								// Command is the command line to execute inside the container,
								// the working directory for the
								// command is root ('/') in the container's filesystem. The
								// command is simply exec'd, it is
								// not run inside a shell, so traditional shell instructions ('|',
								// etc) won't work. To use
								// a shell, you need to explicitly call out to that shell.
								// Exit status of 0 is treated as live/healthy and non-zero is
								// unhealthy.
								command?: [...string]
							}

							// HTTPGet specifies an HTTP GET request to perform.
							httpGet?: {
								// Host name to connect to, defaults to the pod IP. You probably
								// want to set
								// "Host" in httpHeaders instead.
								host?: string

								// Custom headers to set in the request. HTTP allows repeated
								// headers.
								httpHeaders?: [...{
									// The header field name.
									// This will be canonicalized upon output, so case-variant names
									// will be understood as the same header.
									name!: string

									// The header field value
									value!: string
								}]

								// Path to access on the HTTP server.
								path?: string

								// Name or number of the port to access on the container.
								// Number must be in the range 1 to 65535.
								// Name must be an IANA_SVC_NAME.
								port!: matchN(>=1, [int, string]) & (int | string)

								// Scheme to use for connecting to the host.
								// Defaults to HTTP.
								scheme?: string
							}

							// Sleep represents a duration that the container should sleep.
							sleep?: {
								// Seconds is the number of seconds to sleep.
								seconds!: int64 & int
							}

							// Deprecated. TCPSocket is NOT supported as a LifecycleHandler
							// and kept
							// for backward compatibility. There is no validation of this
							// field and
							// lifecycle hooks will fail at runtime when it is specified.
							tcpSocket?: {
								// Optional: Host name to connect to, defaults to the pod IP.
								host?: string

								// Number or name of the port to access on the container.
								// Number must be in the range 1 to 65535.
								// Name must be an IANA_SVC_NAME.
								port!: matchN(>=1, [int, string]) & (int | string)
							}
						}

						// PreStop is called immediately before a container is terminated
						// due to an
						// API request or management event such as liveness/startup probe
						// failure,
						// preemption, resource contention, etc. The handler is not called
						// if the
						// container crashes or exits. The Pod's termination grace period
						// countdown begins before the
						// PreStop hook is executed. Regardless of the outcome of the
						// handler, the
						// container will eventually terminate within the Pod's
						// termination grace
						// period (unless delayed by finalizers). Other management of the
						// container blocks until the hook completes
						// or until the termination grace period is reached.
						// More info:
						// https://kubernetes.io/docs/concepts/containers/container-lifecycle-hooks/#container-hooks
						preStop?: {
							// Exec specifies a command to execute in the container.
							exec?: {
								// Command is the command line to execute inside the container,
								// the working directory for the
								// command is root ('/') in the container's filesystem. The
								// command is simply exec'd, it is
								// not run inside a shell, so traditional shell instructions ('|',
								// etc) won't work. To use
								// a shell, you need to explicitly call out to that shell.
								// Exit status of 0 is treated as live/healthy and non-zero is
								// unhealthy.
								command?: [...string]
							}

							// HTTPGet specifies an HTTP GET request to perform.
							httpGet?: {
								// Host name to connect to, defaults to the pod IP. You probably
								// want to set
								// "Host" in httpHeaders instead.
								host?: string

								// Custom headers to set in the request. HTTP allows repeated
								// headers.
								httpHeaders?: [...{
									// The header field name.
									// This will be canonicalized upon output, so case-variant names
									// will be understood as the same header.
									name!: string

									// The header field value
									value!: string
								}]

								// Path to access on the HTTP server.
								path?: string

								// Name or number of the port to access on the container.
								// Number must be in the range 1 to 65535.
								// Name must be an IANA_SVC_NAME.
								port!: matchN(>=1, [int, string]) & (int | string)

								// Scheme to use for connecting to the host.
								// Defaults to HTTP.
								scheme?: string
							}

							// Sleep represents a duration that the container should sleep.
							sleep?: {
								// Seconds is the number of seconds to sleep.
								seconds!: int64 & int
							}

							// Deprecated. TCPSocket is NOT supported as a LifecycleHandler
							// and kept
							// for backward compatibility. There is no validation of this
							// field and
							// lifecycle hooks will fail at runtime when it is specified.
							tcpSocket?: {
								// Optional: Host name to connect to, defaults to the pod IP.
								host?: string

								// Number or name of the port to access on the container.
								// Number must be in the range 1 to 65535.
								// Name must be an IANA_SVC_NAME.
								port!: matchN(>=1, [int, string]) & (int | string)
							}
						}

						// StopSignal defines which signal will be sent to a container
						// when it is being stopped.
						// If not specified, the default is defined by the container
						// runtime in use.
						// StopSignal can only be set for Pods with a non-empty
						// .spec.os.name
						stopSignal?: string
					}

					// Probes are not allowed for ephemeral containers.
					livenessProbe?: {
						// Exec specifies a command to execute in the container.
						exec?: {
							// Command is the command line to execute inside the container,
							// the working directory for the
							// command is root ('/') in the container's filesystem. The
							// command is simply exec'd, it is
							// not run inside a shell, so traditional shell instructions ('|',
							// etc) won't work. To use
							// a shell, you need to explicitly call out to that shell.
							// Exit status of 0 is treated as live/healthy and non-zero is
							// unhealthy.
							command?: [...string]
						}

						// Minimum consecutive failures for the probe to be considered
						// failed after having succeeded.
						// Defaults to 3. Minimum value is 1.
						failureThreshold?: int32 & int

						// GRPC specifies a GRPC HealthCheckRequest.
						grpc?: {
							// Port number of the gRPC service. Number must be in the range 1
							// to 65535.
							port!: int32 & int

							// Service is the name of the service to place in the gRPC
							// HealthCheckRequest
							// (see
							// https://github.com/grpc/grpc/blob/master/doc/health-checking.md).
							//
							// If this is not specified, the default behavior is defined by
							// gRPC.
							service?: string
						}

						// HTTPGet specifies an HTTP GET request to perform.
						httpGet?: {
							// Host name to connect to, defaults to the pod IP. You probably
							// want to set
							// "Host" in httpHeaders instead.
							host?: string

							// Custom headers to set in the request. HTTP allows repeated
							// headers.
							httpHeaders?: [...{
								// The header field name.
								// This will be canonicalized upon output, so case-variant names
								// will be understood as the same header.
								name!: string

								// The header field value
								value!: string
							}]

							// Path to access on the HTTP server.
							path?: string

							// Name or number of the port to access on the container.
							// Number must be in the range 1 to 65535.
							// Name must be an IANA_SVC_NAME.
							port!: matchN(>=1, [int, string]) & (int | string)

							// Scheme to use for connecting to the host.
							// Defaults to HTTP.
							scheme?: string
						}

						// Number of seconds after the container has started before
						// liveness probes are initiated.
						// More info:
						// https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes
						initialDelaySeconds?: int32 & int

						// How often (in seconds) to perform the probe.
						// Default to 10 seconds. Minimum value is 1.
						periodSeconds?: int32 & int

						// Minimum consecutive successes for the probe to be considered
						// successful after having failed.
						// Defaults to 1. Must be 1 for liveness and startup. Minimum
						// value is 1.
						successThreshold?: int32 & int

						// TCPSocket specifies a connection to a TCP port.
						tcpSocket?: {
							// Optional: Host name to connect to, defaults to the pod IP.
							host?: string

							// Number or name of the port to access on the container.
							// Number must be in the range 1 to 65535.
							// Name must be an IANA_SVC_NAME.
							port!: matchN(>=1, [int, string]) & (int | string)
						}

						// Optional duration in seconds the pod needs to terminate
						// gracefully upon probe failure.
						// The grace period is the duration in seconds after the processes
						// running in the pod are sent
						// a termination signal and the time when the processes are
						// forcibly halted with a kill signal.
						// Set this value longer than the expected cleanup time for your
						// process.
						// If this value is nil, the pod's terminationGracePeriodSeconds
						// will be used. Otherwise, this
						// value overrides the value provided by the pod spec.
						// Value must be non-negative integer. The value zero indicates
						// stop immediately via
						// the kill signal (no opportunity to shut down).
						// This is a beta field and requires enabling
						// ProbeTerminationGracePeriod feature gate.
						// Minimum value is 1. spec.terminationGracePeriodSeconds is used
						// if unset.
						terminationGracePeriodSeconds?: int64 & int

						// Number of seconds after which the probe times out.
						// Defaults to 1 second. Minimum value is 1.
						// More info:
						// https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes
						timeoutSeconds?: int32 & int
					}

					// Name of the ephemeral container specified as a DNS_LABEL.
					// This name must be unique among all containers, init containers
					// and ephemeral containers.
					name!: string

					// Ports are not allowed for ephemeral containers.
					ports?: [...{
						// Number of port to expose on the pod's IP address.
						// This must be a valid port number, 0 < x < 65536.
						containerPort!: int32 & int

						// What host IP to bind the external port to.
						hostIP?: string

						// Number of port to expose on the host.
						// If specified, this must be a valid port number, 0 < x < 65536.
						// If HostNetwork is specified, this must match ContainerPort.
						// Most containers do not need this.
						hostPort?: int32 & int

						// If specified, this must be an IANA_SVC_NAME and unique within
						// the pod. Each
						// named port in a pod must have a unique name. Name for the port
						// that can be
						// referred to by services.
						name?: string

						// Protocol for port. Must be UDP, TCP, or SCTP.
						// Defaults to "TCP".
						protocol?: string
					}]

					// Probes are not allowed for ephemeral containers.
					readinessProbe?: {
						// Exec specifies a command to execute in the container.
						exec?: {
							// Command is the command line to execute inside the container,
							// the working directory for the
							// command is root ('/') in the container's filesystem. The
							// command is simply exec'd, it is
							// not run inside a shell, so traditional shell instructions ('|',
							// etc) won't work. To use
							// a shell, you need to explicitly call out to that shell.
							// Exit status of 0 is treated as live/healthy and non-zero is
							// unhealthy.
							command?: [...string]
						}

						// Minimum consecutive failures for the probe to be considered
						// failed after having succeeded.
						// Defaults to 3. Minimum value is 1.
						failureThreshold?: int32 & int

						// GRPC specifies a GRPC HealthCheckRequest.
						grpc?: {
							// Port number of the gRPC service. Number must be in the range 1
							// to 65535.
							port!: int32 & int

							// Service is the name of the service to place in the gRPC
							// HealthCheckRequest
							// (see
							// https://github.com/grpc/grpc/blob/master/doc/health-checking.md).
							//
							// If this is not specified, the default behavior is defined by
							// gRPC.
							service?: string
						}

						// HTTPGet specifies an HTTP GET request to perform.
						httpGet?: {
							// Host name to connect to, defaults to the pod IP. You probably
							// want to set
							// "Host" in httpHeaders instead.
							host?: string

							// Custom headers to set in the request. HTTP allows repeated
							// headers.
							httpHeaders?: [...{
								// The header field name.
								// This will be canonicalized upon output, so case-variant names
								// will be understood as the same header.
								name!: string

								// The header field value
								value!: string
							}]

							// Path to access on the HTTP server.
							path?: string

							// Name or number of the port to access on the container.
							// Number must be in the range 1 to 65535.
							// Name must be an IANA_SVC_NAME.
							port!: matchN(>=1, [int, string]) & (int | string)

							// Scheme to use for connecting to the host.
							// Defaults to HTTP.
							scheme?: string
						}

						// Number of seconds after the container has started before
						// liveness probes are initiated.
						// More info:
						// https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes
						initialDelaySeconds?: int32 & int

						// How often (in seconds) to perform the probe.
						// Default to 10 seconds. Minimum value is 1.
						periodSeconds?: int32 & int

						// Minimum consecutive successes for the probe to be considered
						// successful after having failed.
						// Defaults to 1. Must be 1 for liveness and startup. Minimum
						// value is 1.
						successThreshold?: int32 & int

						// TCPSocket specifies a connection to a TCP port.
						tcpSocket?: {
							// Optional: Host name to connect to, defaults to the pod IP.
							host?: string

							// Number or name of the port to access on the container.
							// Number must be in the range 1 to 65535.
							// Name must be an IANA_SVC_NAME.
							port!: matchN(>=1, [int, string]) & (int | string)
						}

						// Optional duration in seconds the pod needs to terminate
						// gracefully upon probe failure.
						// The grace period is the duration in seconds after the processes
						// running in the pod are sent
						// a termination signal and the time when the processes are
						// forcibly halted with a kill signal.
						// Set this value longer than the expected cleanup time for your
						// process.
						// If this value is nil, the pod's terminationGracePeriodSeconds
						// will be used. Otherwise, this
						// value overrides the value provided by the pod spec.
						// Value must be non-negative integer. The value zero indicates
						// stop immediately via
						// the kill signal (no opportunity to shut down).
						// This is a beta field and requires enabling
						// ProbeTerminationGracePeriod feature gate.
						// Minimum value is 1. spec.terminationGracePeriodSeconds is used
						// if unset.
						terminationGracePeriodSeconds?: int64 & int

						// Number of seconds after which the probe times out.
						// Defaults to 1 second. Minimum value is 1.
						// More info:
						// https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes
						timeoutSeconds?: int32 & int
					}

					// Resources resize policy for the container.
					resizePolicy?: [...{
						// Name of the resource to which this resource resize policy
						// applies.
						// Supported values: cpu, memory.
						resourceName!: string

						// Restart policy to apply when specified resource is resized.
						// If not specified, it defaults to NotRequired.
						restartPolicy!: string
					}]

					// Resources are not allowed for ephemeral containers. Ephemeral
					// containers use spare resources
					// already allocated to the pod.
					resources?: {
						// Claims lists the names of resources, defined in
						// spec.resourceClaims,
						// that are used by this container.
						//
						// This field depends on the
						// DynamicResourceAllocation feature gate.
						//
						// This field is immutable. It can only be set for containers.
						claims?: [...{
							// Name must match the name of one entry in
							// pod.spec.resourceClaims of
							// the Pod where this field is used. It makes that resource
							// available
							// inside a container.
							name!: string

							// Request is the name chosen for a request in the referenced
							// claim.
							// If empty, everything from the claim is made available,
							// otherwise
							// only the result of this request.
							request?: string
						}]

						// Limits describes the maximum amount of compute resources
						// allowed.
						// More info:
						// https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/
						limits?: [string]: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")

						// Requests describes the minimum amount of compute resources
						// required.
						// If Requests is omitted for a container, it defaults to Limits
						// if that is explicitly specified,
						// otherwise to an implementation-defined value. Requests cannot
						// exceed Limits.
						// More info:
						// https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/
						requests?: [string]: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")
					}

					// Restart policy for the container to manage the restart behavior
					// of each
					// container within a pod.
					// You cannot set this field on ephemeral containers.
					restartPolicy?: string

					// Represents a list of rules to be checked to determine if the
					// container should be restarted on exit. You cannot set this
					// field on
					// ephemeral containers.
					restartPolicyRules?: [...{
						// Specifies the action taken on a container exit if the
						// requirements
						// are satisfied. The only possible value is "Restart" to restart
						// the
						// container.
						action!: string

						// Represents the exit codes to check on container exits.
						exitCodes?: {
							// Represents the relationship between the container exit code(s)
							// and the
							// specified values. Possible values are:
							// - In: the requirement is satisfied if the container exit code
							// is in the
							// set of specified values.
							// - NotIn: the requirement is satisfied if the container exit
							// code is
							// not in the set of specified values.
							operator!: string

							// Specifies the set of values to check for container exit codes.
							// At most 255 elements are allowed.
							values?: [...int32 & int]
						}
					}]

					// Optional: SecurityContext defines the security options the
					// ephemeral container should be run with.
					// If set, the fields of SecurityContext override the equivalent
					// fields of PodSecurityContext.
					securityContext?: {
						// AllowPrivilegeEscalation controls whether a process can gain
						// more
						// privileges than its parent process. This bool directly controls
						// if
						// the no_new_privs flag will be set on the container process.
						// AllowPrivilegeEscalation is true always when the container is:
						// 1) run as Privileged
						// 2) has CAP_SYS_ADMIN
						// Note that this field cannot be set when spec.os.name is
						// windows.
						allowPrivilegeEscalation?: bool

						// appArmorProfile is the AppArmor options to use by this
						// container. If set, this profile
						// overrides the pod's appArmorProfile.
						// Note that this field cannot be set when spec.os.name is
						// windows.
						appArmorProfile?: {
							// localhostProfile indicates a profile loaded on the node that
							// should be used.
							// The profile must be preconfigured on the node to work.
							// Must match the loaded name of the profile.
							// Must be set if and only if type is "Localhost".
							localhostProfile?: string

							// type indicates which kind of AppArmor profile will be applied.
							// Valid options are:
							// Localhost - a profile pre-loaded on the node.
							// RuntimeDefault - the container runtime's default profile.
							// Unconfined - no AppArmor enforcement.
							type!: string
						}

						// The capabilities to add/drop when running containers.
						// Defaults to the default set of capabilities granted by the
						// container runtime.
						// Note that this field cannot be set when spec.os.name is
						// windows.
						capabilities?: {
							// Added capabilities
							add?: [...string]

							// Removed capabilities
							drop?: [...string]
						}

						// Run container in privileged mode.
						// Processes in privileged containers are essentially equivalent
						// to root on the host.
						// Defaults to false.
						// Note that this field cannot be set when spec.os.name is
						// windows.
						privileged?: bool

						// procMount denotes the type of proc mount to use for the
						// containers.
						// The default value is Default which uses the container runtime
						// defaults for
						// readonly paths and masked paths.
						// This requires the ProcMountType feature flag to be enabled.
						// Note that this field cannot be set when spec.os.name is
						// windows.
						procMount?: string

						// Whether this container has a read-only root filesystem.
						// Default is false.
						// Note that this field cannot be set when spec.os.name is
						// windows.
						readOnlyRootFilesystem?: bool

						// The GID to run the entrypoint of the container process.
						// Uses runtime default if unset.
						// May also be set in PodSecurityContext. If set in both
						// SecurityContext and
						// PodSecurityContext, the value specified in SecurityContext
						// takes precedence.
						// Note that this field cannot be set when spec.os.name is
						// windows.
						runAsGroup?: int64 & int

						// Indicates that the container must run as a non-root user.
						// If true, the Kubelet will validate the image at runtime to
						// ensure that it
						// does not run as UID 0 (root) and fail to start the container if
						// it does.
						// If unset or false, no such validation will be performed.
						// May also be set in PodSecurityContext. If set in both
						// SecurityContext and
						// PodSecurityContext, the value specified in SecurityContext
						// takes precedence.
						runAsNonRoot?: bool

						// The UID to run the entrypoint of the container process.
						// Defaults to user specified in image metadata if unspecified.
						// May also be set in PodSecurityContext. If set in both
						// SecurityContext and
						// PodSecurityContext, the value specified in SecurityContext
						// takes precedence.
						// Note that this field cannot be set when spec.os.name is
						// windows.
						runAsUser?: int64 & int

						// The SELinux context to be applied to the container.
						// If unspecified, the container runtime will allocate a random
						// SELinux context for each
						// container. May also be set in PodSecurityContext. If set in
						// both SecurityContext and
						// PodSecurityContext, the value specified in SecurityContext
						// takes precedence.
						// Note that this field cannot be set when spec.os.name is
						// windows.
						seLinuxOptions?: {
							// Level is SELinux level label that applies to the container.
							level?: string

							// Role is a SELinux role label that applies to the container.
							role?: string

							// Type is a SELinux type label that applies to the container.
							type?: string

							// User is a SELinux user label that applies to the container.
							user?: string
						}

						// The seccomp options to use by this container. If seccomp
						// options are
						// provided at both the pod & container level, the container
						// options
						// override the pod options.
						// Note that this field cannot be set when spec.os.name is
						// windows.
						seccompProfile?: {
							// localhostProfile indicates a profile defined in a file on the
							// node should be used.
							// The profile must be preconfigured on the node to work.
							// Must be a descending path, relative to the kubelet's configured
							// seccomp profile location.
							// Must be set if type is "Localhost". Must NOT be set for any
							// other type.
							localhostProfile?: string

							// type indicates which kind of seccomp profile will be applied.
							// Valid options are:
							//
							// Localhost - a profile defined in a file on the node should be
							// used.
							// RuntimeDefault - the container runtime default profile should
							// be used.
							// Unconfined - no profile should be applied.
							type!: string
						}

						// The Windows specific settings applied to all containers.
						// If unspecified, the options from the PodSecurityContext will be
						// used.
						// If set in both SecurityContext and PodSecurityContext, the
						// value specified in SecurityContext takes precedence.
						// Note that this field cannot be set when spec.os.name is linux.
						windowsOptions?: {
							// GMSACredentialSpec is where the GMSA admission webhook
							// (https://github.com/kubernetes-sigs/windows-gmsa) inlines the
							// contents of the
							// GMSA credential spec named by the GMSACredentialSpecName field.
							gmsaCredentialSpec?: string

							// GMSACredentialSpecName is the name of the GMSA credential spec
							// to use.
							gmsaCredentialSpecName?: string

							// HostProcess determines if a container should be run as a 'Host
							// Process' container.
							// All of a Pod's containers must have the same effective
							// HostProcess value
							// (it is not allowed to have a mix of HostProcess containers and
							// non-HostProcess containers).
							// In addition, if HostProcess is true then HostNetwork must also
							// be set to true.
							hostProcess?: bool

							// The UserName in Windows to run the entrypoint of the container
							// process.
							// Defaults to the user specified in image metadata if
							// unspecified.
							// May also be set in PodSecurityContext. If set in both
							// SecurityContext and
							// PodSecurityContext, the value specified in SecurityContext
							// takes precedence.
							runAsUserName?: string
						}
					}

					// Probes are not allowed for ephemeral containers.
					startupProbe?: {
						// Exec specifies a command to execute in the container.
						exec?: {
							// Command is the command line to execute inside the container,
							// the working directory for the
							// command is root ('/') in the container's filesystem. The
							// command is simply exec'd, it is
							// not run inside a shell, so traditional shell instructions ('|',
							// etc) won't work. To use
							// a shell, you need to explicitly call out to that shell.
							// Exit status of 0 is treated as live/healthy and non-zero is
							// unhealthy.
							command?: [...string]
						}

						// Minimum consecutive failures for the probe to be considered
						// failed after having succeeded.
						// Defaults to 3. Minimum value is 1.
						failureThreshold?: int32 & int

						// GRPC specifies a GRPC HealthCheckRequest.
						grpc?: {
							// Port number of the gRPC service. Number must be in the range 1
							// to 65535.
							port!: int32 & int

							// Service is the name of the service to place in the gRPC
							// HealthCheckRequest
							// (see
							// https://github.com/grpc/grpc/blob/master/doc/health-checking.md).
							//
							// If this is not specified, the default behavior is defined by
							// gRPC.
							service?: string
						}

						// HTTPGet specifies an HTTP GET request to perform.
						httpGet?: {
							// Host name to connect to, defaults to the pod IP. You probably
							// want to set
							// "Host" in httpHeaders instead.
							host?: string

							// Custom headers to set in the request. HTTP allows repeated
							// headers.
							httpHeaders?: [...{
								// The header field name.
								// This will be canonicalized upon output, so case-variant names
								// will be understood as the same header.
								name!: string

								// The header field value
								value!: string
							}]

							// Path to access on the HTTP server.
							path?: string

							// Name or number of the port to access on the container.
							// Number must be in the range 1 to 65535.
							// Name must be an IANA_SVC_NAME.
							port!: matchN(>=1, [int, string]) & (int | string)

							// Scheme to use for connecting to the host.
							// Defaults to HTTP.
							scheme?: string
						}

						// Number of seconds after the container has started before
						// liveness probes are initiated.
						// More info:
						// https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes
						initialDelaySeconds?: int32 & int

						// How often (in seconds) to perform the probe.
						// Default to 10 seconds. Minimum value is 1.
						periodSeconds?: int32 & int

						// Minimum consecutive successes for the probe to be considered
						// successful after having failed.
						// Defaults to 1. Must be 1 for liveness and startup. Minimum
						// value is 1.
						successThreshold?: int32 & int

						// TCPSocket specifies a connection to a TCP port.
						tcpSocket?: {
							// Optional: Host name to connect to, defaults to the pod IP.
							host?: string

							// Number or name of the port to access on the container.
							// Number must be in the range 1 to 65535.
							// Name must be an IANA_SVC_NAME.
							port!: matchN(>=1, [int, string]) & (int | string)
						}

						// Optional duration in seconds the pod needs to terminate
						// gracefully upon probe failure.
						// The grace period is the duration in seconds after the processes
						// running in the pod are sent
						// a termination signal and the time when the processes are
						// forcibly halted with a kill signal.
						// Set this value longer than the expected cleanup time for your
						// process.
						// If this value is nil, the pod's terminationGracePeriodSeconds
						// will be used. Otherwise, this
						// value overrides the value provided by the pod spec.
						// Value must be non-negative integer. The value zero indicates
						// stop immediately via
						// the kill signal (no opportunity to shut down).
						// This is a beta field and requires enabling
						// ProbeTerminationGracePeriod feature gate.
						// Minimum value is 1. spec.terminationGracePeriodSeconds is used
						// if unset.
						terminationGracePeriodSeconds?: int64 & int

						// Number of seconds after which the probe times out.
						// Defaults to 1 second. Minimum value is 1.
						// More info:
						// https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes
						timeoutSeconds?: int32 & int
					}

					// Whether this container should allocate a buffer for stdin in
					// the container runtime. If this
					// is not set, reads from stdin in the container will always
					// result in EOF.
					// Default is false.
					stdin?: bool

					// Whether the container runtime should close the stdin channel
					// after it has been opened by
					// a single attach. When stdin is true the stdin stream will
					// remain open across multiple attach
					// sessions. If stdinOnce is set to true, stdin is opened on
					// container start, is empty until the
					// first client attaches to stdin, and then remains open and
					// accepts data until the client disconnects,
					// at which time stdin is closed and remains closed until the
					// container is restarted. If this
					// flag is false, a container processes that reads from stdin will
					// never receive an EOF.
					// Default is false
					stdinOnce?: bool

					// If set, the name of the container from PodSpec that this
					// ephemeral container targets.
					// The ephemeral container will be run in the namespaces (IPC,
					// PID, etc) of this container.
					// If not set then the ephemeral container uses the namespaces
					// configured in the Pod spec.
					//
					// The container runtime must implement support for this feature.
					// If the runtime does not
					// support namespace targeting then the result of setting this
					// field is undefined.
					targetContainerName?: string

					// Optional: Path at which the file to which the container's
					// termination message
					// will be written is mounted into the container's filesystem.
					// Message written is intended to be brief final status, such as
					// an assertion failure message.
					// Will be truncated by the node if greater than 4096 bytes. The
					// total message length across
					// all containers will be limited to 12kb.
					// Defaults to /dev/termination-log.
					// Cannot be updated.
					terminationMessagePath?: string

					// Indicate how the termination message should be populated. File
					// will use the contents of
					// terminationMessagePath to populate the container status message
					// on both success and failure.
					// FallbackToLogsOnError will use the last chunk of container log
					// output if the termination
					// message file is empty and the container exited with an error.
					// The log output is limited to 2048 bytes or 80 lines, whichever
					// is smaller.
					// Defaults to File.
					// Cannot be updated.
					terminationMessagePolicy?: string

					// Whether this container should allocate a TTY for itself, also
					// requires 'stdin' to be true.
					// Default is false.
					tty?: bool

					// volumeDevices is the list of block devices to be used by the
					// container.
					volumeDevices?: [...{
						// devicePath is the path inside of the container that the device
						// will be mapped to.
						devicePath!: string

						// name must match the name of a persistentVolumeClaim in the pod
						name!: string
					}]

					// Pod volumes to mount into the container's filesystem. Subpath
					// mounts are not allowed for ephemeral containers.
					// Cannot be updated.
					volumeMounts?: [...{
						// Path within the container at which the volume should be
						// mounted. Must
						// not contain ':'.
						mountPath!: string

						// mountPropagation determines how mounts are propagated from the
						// host
						// to container and the other way around.
						// When not set, MountPropagationNone is used.
						// This field is beta in 1.10.
						// When RecursiveReadOnly is set to IfPossible or to Enabled,
						// MountPropagation must be None or unspecified
						// (which defaults to None).
						mountPropagation?: string

						// This must match the Name of a Volume.
						name!: string

						// Mounted read-only if true, read-write otherwise (false or
						// unspecified).
						// Defaults to false.
						readOnly?: bool

						// RecursiveReadOnly specifies whether read-only mounts should be
						// handled
						// recursively.
						//
						// If ReadOnly is false, this field has no meaning and must be
						// unspecified.
						//
						// If ReadOnly is true, and this field is set to Disabled, the
						// mount is not made
						// recursively read-only. If this field is set to IfPossible, the
						// mount is made
						// recursively read-only, if it is supported by the container
						// runtime. If this
						// field is set to Enabled, the mount is made recursively
						// read-only if it is
						// supported by the container runtime, otherwise the pod will not
						// be started and
						// an error will be generated to indicate the reason.
						//
						// If this field is set to IfPossible or Enabled, MountPropagation
						// must be set to
						// None (or be unspecified, which defaults to None).
						//
						// If this field is not specified, it is treated as an equivalent
						// of Disabled.
						recursiveReadOnly?: string

						// Path within the volume from which the container's volume should
						// be mounted.
						// Defaults to "" (volume's root).
						subPath?: string

						// Expanded path within the volume from which the container's
						// volume should be mounted.
						// Behaves similarly to SubPath but environment variable
						// references $(VAR_NAME) are expanded using the container's
						// environment.
						// Defaults to "" (volume's root).
						// SubPathExpr and SubPath are mutually exclusive.
						subPathExpr?: string
					}]

					// Container's working directory.
					// If not specified, the container runtime's default will be used,
					// which
					// might be configured in the container image.
					// Cannot be updated.
					workingDir?: string
				}]

				// HostAliases is an optional list of hosts and IPs that will be
				// injected into the pod's hosts
				// file if specified.
				hostAliases?: [...{
					// Hostnames for the above IP address.
					hostnames?: [...string]

					// IP address of the host file entry.
					ip!: string
				}]

				// Use the host's ipc namespace.
				// Optional: Default to false.
				hostIPC?: bool

				// Host networking requested for this pod. Use the host's network
				// namespace.
				// When using HostNetwork you should specify ports so the
				// scheduler is aware.
				// When `hostNetwork` is true, specified `hostPort` fields in port
				// definitions must match `containerPort`,
				// and unspecified `hostPort` fields in port definitions are
				// defaulted to match `containerPort`.
				// Default to false.
				hostNetwork?: bool

				// Use the host's pid namespace.
				// Optional: Default to false.
				hostPID?: bool

				// Use the host's user namespace.
				// Optional: Default to true.
				// If set to true or not present, the pod will be run in the host
				// user namespace, useful
				// for when the pod needs a feature only available to the host
				// user namespace, such as
				// loading a kernel module with CAP_SYS_MODULE.
				// When set to false, a new userns is created for the pod. Setting
				// false is useful for
				// mitigating container breakout vulnerabilities even allowing
				// users to run their
				// containers as root without actually having root privileges on
				// the host.
				// This field is alpha-level and is only honored by servers that
				// enable the UserNamespacesSupport feature.
				hostUsers?: bool

				// Specifies the hostname of the Pod
				// If not specified, the pod's hostname will be set to a
				// system-defined value.
				hostname?: string

				// HostnameOverride specifies an explicit override for the pod's
				// hostname as perceived by the pod.
				// This field only specifies the pod's hostname and does not
				// affect its DNS records.
				// When this field is set to a non-empty string:
				// - It takes precedence over the values set in `hostname` and
				// `subdomain`.
				// - The Pod's hostname will be set to this value.
				// - `setHostnameAsFQDN` must be nil or set to false.
				// - `hostNetwork` must be set to false.
				//
				// This field must be a valid DNS subdomain as defined in RFC 1123
				// and contain at most 64 characters.
				// Requires the HostnameOverride feature gate to be enabled.
				hostnameOverride?: string

				// ImagePullSecrets is an optional list of references to secrets
				// in the same namespace to use for pulling any of the images
				// used by this PodSpec.
				// If specified, these secrets will be passed to individual puller
				// implementations for them to use.
				// More info:
				// https://kubernetes.io/docs/concepts/containers/images#specifying-imagepullsecrets-on-a-pod
				imagePullSecrets?: [...{
					// Name of the referent.
					// This field is effectively required, but due to backwards
					// compatibility is
					// allowed to be empty. Instances of this type with an empty value
					// here are
					// almost certainly wrong.
					// More info:
					// https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
					name?: string
				}]

				// List of initialization containers belonging to the pod.
				// Init containers are executed in order prior to containers being
				// started. If any
				// init container fails, the pod is considered to have failed and
				// is handled according
				// to its restartPolicy. The name for an init container or normal
				// container must be
				// unique among all containers.
				// Init containers may not have Lifecycle actions, Readiness
				// probes, Liveness probes, or Startup probes.
				// The resourceRequirements of an init container are taken into
				// account during scheduling
				// by finding the highest request/limit for each resource type,
				// and then using the max of
				// that value or the sum of the normal containers. Limits are
				// applied to init containers
				// in a similar fashion.
				// Init containers cannot currently be added or removed.
				// Cannot be updated.
				// More info:
				// https://kubernetes.io/docs/concepts/workloads/pods/init-containers/
				initContainers?: [...{
					// Arguments to the entrypoint.
					// The container image's CMD is used if this is not provided.
					// Variable references $(VAR_NAME) are expanded using the
					// container's environment. If a variable
					// cannot be resolved, the reference in the input string will be
					// unchanged. Double $$ are reduced
					// to a single $, which allows for escaping the $(VAR_NAME)
					// syntax: i.e. "$$(VAR_NAME)" will
					// produce the string literal "$(VAR_NAME)". Escaped references
					// will never be expanded, regardless
					// of whether the variable exists or not. Cannot be updated.
					// More info:
					// https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/#running-a-command-in-a-shell
					args?: [...string]

					// Entrypoint array. Not executed within a shell.
					// The container image's ENTRYPOINT is used if this is not
					// provided.
					// Variable references $(VAR_NAME) are expanded using the
					// container's environment. If a variable
					// cannot be resolved, the reference in the input string will be
					// unchanged. Double $$ are reduced
					// to a single $, which allows for escaping the $(VAR_NAME)
					// syntax: i.e. "$$(VAR_NAME)" will
					// produce the string literal "$(VAR_NAME)". Escaped references
					// will never be expanded, regardless
					// of whether the variable exists or not. Cannot be updated.
					// More info:
					// https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/#running-a-command-in-a-shell
					command?: [...string]

					// List of environment variables to set in the container.
					// Cannot be updated.
					env?: [...{
						// Name of the environment variable.
						// May consist of any printable ASCII characters except '='.
						name!: string

						// Variable references $(VAR_NAME) are expanded
						// using the previously defined environment variables in the
						// container and
						// any service environment variables. If a variable cannot be
						// resolved,
						// the reference in the input string will be unchanged. Double $$
						// are reduced
						// to a single $, which allows for escaping the $(VAR_NAME)
						// syntax: i.e.
						// "$$(VAR_NAME)" will produce the string literal "$(VAR_NAME)".
						// Escaped references will never be expanded, regardless of
						// whether the variable
						// exists or not.
						// Defaults to "".
						value?: string

						// Source for the environment variable's value. Cannot be used if
						// value is not empty.
						valueFrom?: {
							// Selects a key of a ConfigMap.
							configMapKeyRef?: {
								// The key to select.
								key!: string

								// Name of the referent.
								// This field is effectively required, but due to backwards
								// compatibility is
								// allowed to be empty. Instances of this type with an empty value
								// here are
								// almost certainly wrong.
								// More info:
								// https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
								name?: string

								// Specify whether the ConfigMap or its key must be defined
								optional?: bool
							}

							// Selects a field of the pod: supports metadata.name,
							// metadata.namespace, `metadata.labels['<KEY>']`,
							// `metadata.annotations['<KEY>']`,
							// spec.nodeName, spec.serviceAccountName, status.hostIP,
							// status.podIP, status.podIPs.
							fieldRef?: {
								// Version of the schema the FieldPath is written in terms of,
								// defaults to "v1".
								apiVersion?: string

								// Path of the field to select in the specified API version.
								fieldPath!: string
							}

							// FileKeyRef selects a key of the env file.
							// Requires the EnvFiles feature gate to be enabled.
							fileKeyRef?: {
								// The key within the env file. An invalid key will prevent the
								// pod from starting.
								// The keys defined within a source may consist of any printable
								// ASCII characters except '='.
								// During Alpha stage of the EnvFiles feature gate, the key size
								// is limited to 128 characters.
								key!: string

								// Specify whether the file or its key must be defined. If the
								// file or key
								// does not exist, then the env var is not published.
								// If optional is set to true and the specified key does not
								// exist,
								// the environment variable will not be set in the Pod's
								// containers.
								//
								// If optional is set to false and the specified key does not
								// exist,
								// an error will be returned during Pod creation.
								optional?: bool

								// The path within the volume from which to select the file.
								// Must be relative and may not contain the '..' path or start
								// with '..'.
								path!: string

								// The name of the volume mount containing the env file.
								volumeName!: string
							}

							// Selects a resource of the container: only resources limits and
							// requests
							// (limits.cpu, limits.memory, limits.ephemeral-storage,
							// requests.cpu, requests.memory and requests.ephemeral-storage)
							// are currently supported.
							resourceFieldRef?: {
								// Container name: required for volumes, optional for env vars
								containerName?: string

								// Specifies the output format of the exposed resources, defaults
								// to "1"
								divisor?: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")

								// Required: resource to select
								resource!: string
							}

							// Selects a key of a secret in the pod's namespace
							secretKeyRef?: {
								// The key of the secret to select from. Must be a valid secret
								// key.
								key!: string

								// Name of the referent.
								// This field is effectively required, but due to backwards
								// compatibility is
								// allowed to be empty. Instances of this type with an empty value
								// here are
								// almost certainly wrong.
								// More info:
								// https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
								name?: string

								// Specify whether the Secret or its key must be defined
								optional?: bool
							}
						}
					}]

					// List of sources to populate environment variables in the
					// container.
					// The keys defined within a source may consist of any printable
					// ASCII characters except '='.
					// When a key exists in multiple
					// sources, the value associated with the last source will take
					// precedence.
					// Values defined by an Env with a duplicate key will take
					// precedence.
					// Cannot be updated.
					envFrom?: [...{
						// The ConfigMap to select from
						configMapRef?: {
							// Name of the referent.
							// This field is effectively required, but due to backwards
							// compatibility is
							// allowed to be empty. Instances of this type with an empty value
							// here are
							// almost certainly wrong.
							// More info:
							// https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
							name?: string

							// Specify whether the ConfigMap must be defined
							optional?: bool
						}

						// Optional text to prepend to the name of each environment
						// variable.
						// May consist of any printable ASCII characters except '='.
						prefix?: string

						// The Secret to select from
						secretRef?: {
							// Name of the referent.
							// This field is effectively required, but due to backwards
							// compatibility is
							// allowed to be empty. Instances of this type with an empty value
							// here are
							// almost certainly wrong.
							// More info:
							// https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
							name?: string

							// Specify whether the Secret must be defined
							optional?: bool
						}
					}]

					// Container image name.
					// More info:
					// https://kubernetes.io/docs/concepts/containers/images
					// This field is optional to allow higher level config management
					// to default or override
					// container images in workload controllers like Deployments and
					// StatefulSets.
					image?: string

					// Image pull policy.
					// One of Always, Never, IfNotPresent.
					// Defaults to Always if :latest tag is specified, or IfNotPresent
					// otherwise.
					// Cannot be updated.
					// More info:
					// https://kubernetes.io/docs/concepts/containers/images#updating-images
					imagePullPolicy?: string

					// Actions that the management system should take in response to
					// container lifecycle events.
					// Cannot be updated.
					lifecycle?: {
						// PostStart is called immediately after a container is created.
						// If the handler fails,
						// the container is terminated and restarted according to its
						// restart policy.
						// Other management of the container blocks until the hook
						// completes.
						// More info:
						// https://kubernetes.io/docs/concepts/containers/container-lifecycle-hooks/#container-hooks
						postStart?: {
							// Exec specifies a command to execute in the container.
							exec?: {
								// Command is the command line to execute inside the container,
								// the working directory for the
								// command is root ('/') in the container's filesystem. The
								// command is simply exec'd, it is
								// not run inside a shell, so traditional shell instructions ('|',
								// etc) won't work. To use
								// a shell, you need to explicitly call out to that shell.
								// Exit status of 0 is treated as live/healthy and non-zero is
								// unhealthy.
								command?: [...string]
							}

							// HTTPGet specifies an HTTP GET request to perform.
							httpGet?: {
								// Host name to connect to, defaults to the pod IP. You probably
								// want to set
								// "Host" in httpHeaders instead.
								host?: string

								// Custom headers to set in the request. HTTP allows repeated
								// headers.
								httpHeaders?: [...{
									// The header field name.
									// This will be canonicalized upon output, so case-variant names
									// will be understood as the same header.
									name!: string

									// The header field value
									value!: string
								}]

								// Path to access on the HTTP server.
								path?: string

								// Name or number of the port to access on the container.
								// Number must be in the range 1 to 65535.
								// Name must be an IANA_SVC_NAME.
								port!: matchN(>=1, [int, string]) & (int | string)

								// Scheme to use for connecting to the host.
								// Defaults to HTTP.
								scheme?: string
							}

							// Sleep represents a duration that the container should sleep.
							sleep?: {
								// Seconds is the number of seconds to sleep.
								seconds!: int64 & int
							}

							// Deprecated. TCPSocket is NOT supported as a LifecycleHandler
							// and kept
							// for backward compatibility. There is no validation of this
							// field and
							// lifecycle hooks will fail at runtime when it is specified.
							tcpSocket?: {
								// Optional: Host name to connect to, defaults to the pod IP.
								host?: string

								// Number or name of the port to access on the container.
								// Number must be in the range 1 to 65535.
								// Name must be an IANA_SVC_NAME.
								port!: matchN(>=1, [int, string]) & (int | string)
							}
						}

						// PreStop is called immediately before a container is terminated
						// due to an
						// API request or management event such as liveness/startup probe
						// failure,
						// preemption, resource contention, etc. The handler is not called
						// if the
						// container crashes or exits. The Pod's termination grace period
						// countdown begins before the
						// PreStop hook is executed. Regardless of the outcome of the
						// handler, the
						// container will eventually terminate within the Pod's
						// termination grace
						// period (unless delayed by finalizers). Other management of the
						// container blocks until the hook completes
						// or until the termination grace period is reached.
						// More info:
						// https://kubernetes.io/docs/concepts/containers/container-lifecycle-hooks/#container-hooks
						preStop?: {
							// Exec specifies a command to execute in the container.
							exec?: {
								// Command is the command line to execute inside the container,
								// the working directory for the
								// command is root ('/') in the container's filesystem. The
								// command is simply exec'd, it is
								// not run inside a shell, so traditional shell instructions ('|',
								// etc) won't work. To use
								// a shell, you need to explicitly call out to that shell.
								// Exit status of 0 is treated as live/healthy and non-zero is
								// unhealthy.
								command?: [...string]
							}

							// HTTPGet specifies an HTTP GET request to perform.
							httpGet?: {
								// Host name to connect to, defaults to the pod IP. You probably
								// want to set
								// "Host" in httpHeaders instead.
								host?: string

								// Custom headers to set in the request. HTTP allows repeated
								// headers.
								httpHeaders?: [...{
									// The header field name.
									// This will be canonicalized upon output, so case-variant names
									// will be understood as the same header.
									name!: string

									// The header field value
									value!: string
								}]

								// Path to access on the HTTP server.
								path?: string

								// Name or number of the port to access on the container.
								// Number must be in the range 1 to 65535.
								// Name must be an IANA_SVC_NAME.
								port!: matchN(>=1, [int, string]) & (int | string)

								// Scheme to use for connecting to the host.
								// Defaults to HTTP.
								scheme?: string
							}

							// Sleep represents a duration that the container should sleep.
							sleep?: {
								// Seconds is the number of seconds to sleep.
								seconds!: int64 & int
							}

							// Deprecated. TCPSocket is NOT supported as a LifecycleHandler
							// and kept
							// for backward compatibility. There is no validation of this
							// field and
							// lifecycle hooks will fail at runtime when it is specified.
							tcpSocket?: {
								// Optional: Host name to connect to, defaults to the pod IP.
								host?: string

								// Number or name of the port to access on the container.
								// Number must be in the range 1 to 65535.
								// Name must be an IANA_SVC_NAME.
								port!: matchN(>=1, [int, string]) & (int | string)
							}
						}

						// StopSignal defines which signal will be sent to a container
						// when it is being stopped.
						// If not specified, the default is defined by the container
						// runtime in use.
						// StopSignal can only be set for Pods with a non-empty
						// .spec.os.name
						stopSignal?: string
					}

					// Periodic probe of container liveness.
					// Container will be restarted if the probe fails.
					// Cannot be updated.
					// More info:
					// https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes
					livenessProbe?: {
						// Exec specifies a command to execute in the container.
						exec?: {
							// Command is the command line to execute inside the container,
							// the working directory for the
							// command is root ('/') in the container's filesystem. The
							// command is simply exec'd, it is
							// not run inside a shell, so traditional shell instructions ('|',
							// etc) won't work. To use
							// a shell, you need to explicitly call out to that shell.
							// Exit status of 0 is treated as live/healthy and non-zero is
							// unhealthy.
							command?: [...string]
						}

						// Minimum consecutive failures for the probe to be considered
						// failed after having succeeded.
						// Defaults to 3. Minimum value is 1.
						failureThreshold?: int32 & int

						// GRPC specifies a GRPC HealthCheckRequest.
						grpc?: {
							// Port number of the gRPC service. Number must be in the range 1
							// to 65535.
							port!: int32 & int

							// Service is the name of the service to place in the gRPC
							// HealthCheckRequest
							// (see
							// https://github.com/grpc/grpc/blob/master/doc/health-checking.md).
							//
							// If this is not specified, the default behavior is defined by
							// gRPC.
							service?: string
						}

						// HTTPGet specifies an HTTP GET request to perform.
						httpGet?: {
							// Host name to connect to, defaults to the pod IP. You probably
							// want to set
							// "Host" in httpHeaders instead.
							host?: string

							// Custom headers to set in the request. HTTP allows repeated
							// headers.
							httpHeaders?: [...{
								// The header field name.
								// This will be canonicalized upon output, so case-variant names
								// will be understood as the same header.
								name!: string

								// The header field value
								value!: string
							}]

							// Path to access on the HTTP server.
							path?: string

							// Name or number of the port to access on the container.
							// Number must be in the range 1 to 65535.
							// Name must be an IANA_SVC_NAME.
							port!: matchN(>=1, [int, string]) & (int | string)

							// Scheme to use for connecting to the host.
							// Defaults to HTTP.
							scheme?: string
						}

						// Number of seconds after the container has started before
						// liveness probes are initiated.
						// More info:
						// https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes
						initialDelaySeconds?: int32 & int

						// How often (in seconds) to perform the probe.
						// Default to 10 seconds. Minimum value is 1.
						periodSeconds?: int32 & int

						// Minimum consecutive successes for the probe to be considered
						// successful after having failed.
						// Defaults to 1. Must be 1 for liveness and startup. Minimum
						// value is 1.
						successThreshold?: int32 & int

						// TCPSocket specifies a connection to a TCP port.
						tcpSocket?: {
							// Optional: Host name to connect to, defaults to the pod IP.
							host?: string

							// Number or name of the port to access on the container.
							// Number must be in the range 1 to 65535.
							// Name must be an IANA_SVC_NAME.
							port!: matchN(>=1, [int, string]) & (int | string)
						}

						// Optional duration in seconds the pod needs to terminate
						// gracefully upon probe failure.
						// The grace period is the duration in seconds after the processes
						// running in the pod are sent
						// a termination signal and the time when the processes are
						// forcibly halted with a kill signal.
						// Set this value longer than the expected cleanup time for your
						// process.
						// If this value is nil, the pod's terminationGracePeriodSeconds
						// will be used. Otherwise, this
						// value overrides the value provided by the pod spec.
						// Value must be non-negative integer. The value zero indicates
						// stop immediately via
						// the kill signal (no opportunity to shut down).
						// This is a beta field and requires enabling
						// ProbeTerminationGracePeriod feature gate.
						// Minimum value is 1. spec.terminationGracePeriodSeconds is used
						// if unset.
						terminationGracePeriodSeconds?: int64 & int

						// Number of seconds after which the probe times out.
						// Defaults to 1 second. Minimum value is 1.
						// More info:
						// https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes
						timeoutSeconds?: int32 & int
					}

					// Name of the container specified as a DNS_LABEL.
					// Each container in a pod must have a unique name (DNS_LABEL).
					// Cannot be updated.
					name!: string

					// List of ports to expose from the container. Not specifying a
					// port here
					// DOES NOT prevent that port from being exposed. Any port which
					// is
					// listening on the default "0.0.0.0" address inside a container
					// will be
					// accessible from the network.
					// Modifying this array with strategic merge patch may corrupt the
					// data.
					// For more information See
					// https://github.com/kubernetes/kubernetes/issues/108255.
					// Cannot be updated.
					ports?: [...{
						// Number of port to expose on the pod's IP address.
						// This must be a valid port number, 0 < x < 65536.
						containerPort!: int32 & int

						// What host IP to bind the external port to.
						hostIP?: string

						// Number of port to expose on the host.
						// If specified, this must be a valid port number, 0 < x < 65536.
						// If HostNetwork is specified, this must match ContainerPort.
						// Most containers do not need this.
						hostPort?: int32 & int

						// If specified, this must be an IANA_SVC_NAME and unique within
						// the pod. Each
						// named port in a pod must have a unique name. Name for the port
						// that can be
						// referred to by services.
						name?: string

						// Protocol for port. Must be UDP, TCP, or SCTP.
						// Defaults to "TCP".
						protocol?: string
					}]

					// Periodic probe of container service readiness.
					// Container will be removed from service endpoints if the probe
					// fails.
					// Cannot be updated.
					// More info:
					// https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes
					readinessProbe?: {
						// Exec specifies a command to execute in the container.
						exec?: {
							// Command is the command line to execute inside the container,
							// the working directory for the
							// command is root ('/') in the container's filesystem. The
							// command is simply exec'd, it is
							// not run inside a shell, so traditional shell instructions ('|',
							// etc) won't work. To use
							// a shell, you need to explicitly call out to that shell.
							// Exit status of 0 is treated as live/healthy and non-zero is
							// unhealthy.
							command?: [...string]
						}

						// Minimum consecutive failures for the probe to be considered
						// failed after having succeeded.
						// Defaults to 3. Minimum value is 1.
						failureThreshold?: int32 & int

						// GRPC specifies a GRPC HealthCheckRequest.
						grpc?: {
							// Port number of the gRPC service. Number must be in the range 1
							// to 65535.
							port!: int32 & int

							// Service is the name of the service to place in the gRPC
							// HealthCheckRequest
							// (see
							// https://github.com/grpc/grpc/blob/master/doc/health-checking.md).
							//
							// If this is not specified, the default behavior is defined by
							// gRPC.
							service?: string
						}

						// HTTPGet specifies an HTTP GET request to perform.
						httpGet?: {
							// Host name to connect to, defaults to the pod IP. You probably
							// want to set
							// "Host" in httpHeaders instead.
							host?: string

							// Custom headers to set in the request. HTTP allows repeated
							// headers.
							httpHeaders?: [...{
								// The header field name.
								// This will be canonicalized upon output, so case-variant names
								// will be understood as the same header.
								name!: string

								// The header field value
								value!: string
							}]

							// Path to access on the HTTP server.
							path?: string

							// Name or number of the port to access on the container.
							// Number must be in the range 1 to 65535.
							// Name must be an IANA_SVC_NAME.
							port!: matchN(>=1, [int, string]) & (int | string)

							// Scheme to use for connecting to the host.
							// Defaults to HTTP.
							scheme?: string
						}

						// Number of seconds after the container has started before
						// liveness probes are initiated.
						// More info:
						// https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes
						initialDelaySeconds?: int32 & int

						// How often (in seconds) to perform the probe.
						// Default to 10 seconds. Minimum value is 1.
						periodSeconds?: int32 & int

						// Minimum consecutive successes for the probe to be considered
						// successful after having failed.
						// Defaults to 1. Must be 1 for liveness and startup. Minimum
						// value is 1.
						successThreshold?: int32 & int

						// TCPSocket specifies a connection to a TCP port.
						tcpSocket?: {
							// Optional: Host name to connect to, defaults to the pod IP.
							host?: string

							// Number or name of the port to access on the container.
							// Number must be in the range 1 to 65535.
							// Name must be an IANA_SVC_NAME.
							port!: matchN(>=1, [int, string]) & (int | string)
						}

						// Optional duration in seconds the pod needs to terminate
						// gracefully upon probe failure.
						// The grace period is the duration in seconds after the processes
						// running in the pod are sent
						// a termination signal and the time when the processes are
						// forcibly halted with a kill signal.
						// Set this value longer than the expected cleanup time for your
						// process.
						// If this value is nil, the pod's terminationGracePeriodSeconds
						// will be used. Otherwise, this
						// value overrides the value provided by the pod spec.
						// Value must be non-negative integer. The value zero indicates
						// stop immediately via
						// the kill signal (no opportunity to shut down).
						// This is a beta field and requires enabling
						// ProbeTerminationGracePeriod feature gate.
						// Minimum value is 1. spec.terminationGracePeriodSeconds is used
						// if unset.
						terminationGracePeriodSeconds?: int64 & int

						// Number of seconds after which the probe times out.
						// Defaults to 1 second. Minimum value is 1.
						// More info:
						// https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes
						timeoutSeconds?: int32 & int
					}

					// Resources resize policy for the container.
					// This field cannot be set on ephemeral containers.
					resizePolicy?: [...{
						// Name of the resource to which this resource resize policy
						// applies.
						// Supported values: cpu, memory.
						resourceName!: string

						// Restart policy to apply when specified resource is resized.
						// If not specified, it defaults to NotRequired.
						restartPolicy!: string
					}]

					// Compute Resources required by this container.
					// Cannot be updated.
					// More info:
					// https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/
					resources?: {
						// Claims lists the names of resources, defined in
						// spec.resourceClaims,
						// that are used by this container.
						//
						// This field depends on the
						// DynamicResourceAllocation feature gate.
						//
						// This field is immutable. It can only be set for containers.
						claims?: [...{
							// Name must match the name of one entry in
							// pod.spec.resourceClaims of
							// the Pod where this field is used. It makes that resource
							// available
							// inside a container.
							name!: string

							// Request is the name chosen for a request in the referenced
							// claim.
							// If empty, everything from the claim is made available,
							// otherwise
							// only the result of this request.
							request?: string
						}]

						// Limits describes the maximum amount of compute resources
						// allowed.
						// More info:
						// https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/
						limits?: [string]: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")

						// Requests describes the minimum amount of compute resources
						// required.
						// If Requests is omitted for a container, it defaults to Limits
						// if that is explicitly specified,
						// otherwise to an implementation-defined value. Requests cannot
						// exceed Limits.
						// More info:
						// https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/
						requests?: [string]: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")
					}

					// RestartPolicy defines the restart behavior of individual
					// containers in a pod.
					// This overrides the pod-level restart policy. When this field is
					// not specified,
					// the restart behavior is defined by the Pod's restart policy and
					// the container type.
					// Additionally, setting the RestartPolicy as "Always" for the
					// init container will
					// have the following effect:
					// this init container will be continually restarted on
					// exit until all regular containers have terminated. Once all
					// regular
					// containers have completed, all init containers with
					// restartPolicy "Always"
					// will be shut down. This lifecycle differs from normal init
					// containers and
					// is often referred to as a "sidecar" container. Although this
					// init
					// container still starts in the init container sequence, it does
					// not wait
					// for the container to complete before proceeding to the next
					// init
					// container. Instead, the next init container starts immediately
					// after this
					// init container is started, or after any startupProbe has
					// successfully
					// completed.
					restartPolicy?: string

					// Represents a list of rules to be checked to determine if the
					// container should be restarted on exit. The rules are evaluated
					// in
					// order. Once a rule matches a container exit condition, the
					// remaining
					// rules are ignored. If no rule matches the container exit
					// condition,
					// the Container-level restart policy determines the whether the
					// container
					// is restarted or not. Constraints on the rules:
					// - At most 20 rules are allowed.
					// - Rules can have the same action.
					// - Identical rules are not forbidden in validations.
					// When rules are specified, container MUST set RestartPolicy
					// explicitly
					// even it if matches the Pod's RestartPolicy.
					restartPolicyRules?: [...{
						// Specifies the action taken on a container exit if the
						// requirements
						// are satisfied. The only possible value is "Restart" to restart
						// the
						// container.
						action!: string

						// Represents the exit codes to check on container exits.
						exitCodes?: {
							// Represents the relationship between the container exit code(s)
							// and the
							// specified values. Possible values are:
							// - In: the requirement is satisfied if the container exit code
							// is in the
							// set of specified values.
							// - NotIn: the requirement is satisfied if the container exit
							// code is
							// not in the set of specified values.
							operator!: string

							// Specifies the set of values to check for container exit codes.
							// At most 255 elements are allowed.
							values?: [...int32 & int]
						}
					}]

					// SecurityContext defines the security options the container
					// should be run with.
					// If set, the fields of SecurityContext override the equivalent
					// fields of PodSecurityContext.
					// More info:
					// https://kubernetes.io/docs/tasks/configure-pod-container/security-context/
					securityContext?: {
						// AllowPrivilegeEscalation controls whether a process can gain
						// more
						// privileges than its parent process. This bool directly controls
						// if
						// the no_new_privs flag will be set on the container process.
						// AllowPrivilegeEscalation is true always when the container is:
						// 1) run as Privileged
						// 2) has CAP_SYS_ADMIN
						// Note that this field cannot be set when spec.os.name is
						// windows.
						allowPrivilegeEscalation?: bool

						// appArmorProfile is the AppArmor options to use by this
						// container. If set, this profile
						// overrides the pod's appArmorProfile.
						// Note that this field cannot be set when spec.os.name is
						// windows.
						appArmorProfile?: {
							// localhostProfile indicates a profile loaded on the node that
							// should be used.
							// The profile must be preconfigured on the node to work.
							// Must match the loaded name of the profile.
							// Must be set if and only if type is "Localhost".
							localhostProfile?: string

							// type indicates which kind of AppArmor profile will be applied.
							// Valid options are:
							// Localhost - a profile pre-loaded on the node.
							// RuntimeDefault - the container runtime's default profile.
							// Unconfined - no AppArmor enforcement.
							type!: string
						}

						// The capabilities to add/drop when running containers.
						// Defaults to the default set of capabilities granted by the
						// container runtime.
						// Note that this field cannot be set when spec.os.name is
						// windows.
						capabilities?: {
							// Added capabilities
							add?: [...string]

							// Removed capabilities
							drop?: [...string]
						}

						// Run container in privileged mode.
						// Processes in privileged containers are essentially equivalent
						// to root on the host.
						// Defaults to false.
						// Note that this field cannot be set when spec.os.name is
						// windows.
						privileged?: bool

						// procMount denotes the type of proc mount to use for the
						// containers.
						// The default value is Default which uses the container runtime
						// defaults for
						// readonly paths and masked paths.
						// This requires the ProcMountType feature flag to be enabled.
						// Note that this field cannot be set when spec.os.name is
						// windows.
						procMount?: string

						// Whether this container has a read-only root filesystem.
						// Default is false.
						// Note that this field cannot be set when spec.os.name is
						// windows.
						readOnlyRootFilesystem?: bool

						// The GID to run the entrypoint of the container process.
						// Uses runtime default if unset.
						// May also be set in PodSecurityContext. If set in both
						// SecurityContext and
						// PodSecurityContext, the value specified in SecurityContext
						// takes precedence.
						// Note that this field cannot be set when spec.os.name is
						// windows.
						runAsGroup?: int64 & int

						// Indicates that the container must run as a non-root user.
						// If true, the Kubelet will validate the image at runtime to
						// ensure that it
						// does not run as UID 0 (root) and fail to start the container if
						// it does.
						// If unset or false, no such validation will be performed.
						// May also be set in PodSecurityContext. If set in both
						// SecurityContext and
						// PodSecurityContext, the value specified in SecurityContext
						// takes precedence.
						runAsNonRoot?: bool

						// The UID to run the entrypoint of the container process.
						// Defaults to user specified in image metadata if unspecified.
						// May also be set in PodSecurityContext. If set in both
						// SecurityContext and
						// PodSecurityContext, the value specified in SecurityContext
						// takes precedence.
						// Note that this field cannot be set when spec.os.name is
						// windows.
						runAsUser?: int64 & int

						// The SELinux context to be applied to the container.
						// If unspecified, the container runtime will allocate a random
						// SELinux context for each
						// container. May also be set in PodSecurityContext. If set in
						// both SecurityContext and
						// PodSecurityContext, the value specified in SecurityContext
						// takes precedence.
						// Note that this field cannot be set when spec.os.name is
						// windows.
						seLinuxOptions?: {
							// Level is SELinux level label that applies to the container.
							level?: string

							// Role is a SELinux role label that applies to the container.
							role?: string

							// Type is a SELinux type label that applies to the container.
							type?: string

							// User is a SELinux user label that applies to the container.
							user?: string
						}

						// The seccomp options to use by this container. If seccomp
						// options are
						// provided at both the pod & container level, the container
						// options
						// override the pod options.
						// Note that this field cannot be set when spec.os.name is
						// windows.
						seccompProfile?: {
							// localhostProfile indicates a profile defined in a file on the
							// node should be used.
							// The profile must be preconfigured on the node to work.
							// Must be a descending path, relative to the kubelet's configured
							// seccomp profile location.
							// Must be set if type is "Localhost". Must NOT be set for any
							// other type.
							localhostProfile?: string

							// type indicates which kind of seccomp profile will be applied.
							// Valid options are:
							//
							// Localhost - a profile defined in a file on the node should be
							// used.
							// RuntimeDefault - the container runtime default profile should
							// be used.
							// Unconfined - no profile should be applied.
							type!: string
						}

						// The Windows specific settings applied to all containers.
						// If unspecified, the options from the PodSecurityContext will be
						// used.
						// If set in both SecurityContext and PodSecurityContext, the
						// value specified in SecurityContext takes precedence.
						// Note that this field cannot be set when spec.os.name is linux.
						windowsOptions?: {
							// GMSACredentialSpec is where the GMSA admission webhook
							// (https://github.com/kubernetes-sigs/windows-gmsa) inlines the
							// contents of the
							// GMSA credential spec named by the GMSACredentialSpecName field.
							gmsaCredentialSpec?: string

							// GMSACredentialSpecName is the name of the GMSA credential spec
							// to use.
							gmsaCredentialSpecName?: string

							// HostProcess determines if a container should be run as a 'Host
							// Process' container.
							// All of a Pod's containers must have the same effective
							// HostProcess value
							// (it is not allowed to have a mix of HostProcess containers and
							// non-HostProcess containers).
							// In addition, if HostProcess is true then HostNetwork must also
							// be set to true.
							hostProcess?: bool

							// The UserName in Windows to run the entrypoint of the container
							// process.
							// Defaults to the user specified in image metadata if
							// unspecified.
							// May also be set in PodSecurityContext. If set in both
							// SecurityContext and
							// PodSecurityContext, the value specified in SecurityContext
							// takes precedence.
							runAsUserName?: string
						}
					}

					// StartupProbe indicates that the Pod has successfully
					// initialized.
					// If specified, no other probes are executed until this completes
					// successfully.
					// If this probe fails, the Pod will be restarted, just as if the
					// livenessProbe failed.
					// This can be used to provide different probe parameters at the
					// beginning of a Pod's lifecycle,
					// when it might take a long time to load data or warm a cache,
					// than during steady-state operation.
					// This cannot be updated.
					// More info:
					// https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes
					startupProbe?: {
						// Exec specifies a command to execute in the container.
						exec?: {
							// Command is the command line to execute inside the container,
							// the working directory for the
							// command is root ('/') in the container's filesystem. The
							// command is simply exec'd, it is
							// not run inside a shell, so traditional shell instructions ('|',
							// etc) won't work. To use
							// a shell, you need to explicitly call out to that shell.
							// Exit status of 0 is treated as live/healthy and non-zero is
							// unhealthy.
							command?: [...string]
						}

						// Minimum consecutive failures for the probe to be considered
						// failed after having succeeded.
						// Defaults to 3. Minimum value is 1.
						failureThreshold?: int32 & int

						// GRPC specifies a GRPC HealthCheckRequest.
						grpc?: {
							// Port number of the gRPC service. Number must be in the range 1
							// to 65535.
							port!: int32 & int

							// Service is the name of the service to place in the gRPC
							// HealthCheckRequest
							// (see
							// https://github.com/grpc/grpc/blob/master/doc/health-checking.md).
							//
							// If this is not specified, the default behavior is defined by
							// gRPC.
							service?: string
						}

						// HTTPGet specifies an HTTP GET request to perform.
						httpGet?: {
							// Host name to connect to, defaults to the pod IP. You probably
							// want to set
							// "Host" in httpHeaders instead.
							host?: string

							// Custom headers to set in the request. HTTP allows repeated
							// headers.
							httpHeaders?: [...{
								// The header field name.
								// This will be canonicalized upon output, so case-variant names
								// will be understood as the same header.
								name!: string

								// The header field value
								value!: string
							}]

							// Path to access on the HTTP server.
							path?: string

							// Name or number of the port to access on the container.
							// Number must be in the range 1 to 65535.
							// Name must be an IANA_SVC_NAME.
							port!: matchN(>=1, [int, string]) & (int | string)

							// Scheme to use for connecting to the host.
							// Defaults to HTTP.
							scheme?: string
						}

						// Number of seconds after the container has started before
						// liveness probes are initiated.
						// More info:
						// https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes
						initialDelaySeconds?: int32 & int

						// How often (in seconds) to perform the probe.
						// Default to 10 seconds. Minimum value is 1.
						periodSeconds?: int32 & int

						// Minimum consecutive successes for the probe to be considered
						// successful after having failed.
						// Defaults to 1. Must be 1 for liveness and startup. Minimum
						// value is 1.
						successThreshold?: int32 & int

						// TCPSocket specifies a connection to a TCP port.
						tcpSocket?: {
							// Optional: Host name to connect to, defaults to the pod IP.
							host?: string

							// Number or name of the port to access on the container.
							// Number must be in the range 1 to 65535.
							// Name must be an IANA_SVC_NAME.
							port!: matchN(>=1, [int, string]) & (int | string)
						}

						// Optional duration in seconds the pod needs to terminate
						// gracefully upon probe failure.
						// The grace period is the duration in seconds after the processes
						// running in the pod are sent
						// a termination signal and the time when the processes are
						// forcibly halted with a kill signal.
						// Set this value longer than the expected cleanup time for your
						// process.
						// If this value is nil, the pod's terminationGracePeriodSeconds
						// will be used. Otherwise, this
						// value overrides the value provided by the pod spec.
						// Value must be non-negative integer. The value zero indicates
						// stop immediately via
						// the kill signal (no opportunity to shut down).
						// This is a beta field and requires enabling
						// ProbeTerminationGracePeriod feature gate.
						// Minimum value is 1. spec.terminationGracePeriodSeconds is used
						// if unset.
						terminationGracePeriodSeconds?: int64 & int

						// Number of seconds after which the probe times out.
						// Defaults to 1 second. Minimum value is 1.
						// More info:
						// https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes
						timeoutSeconds?: int32 & int
					}

					// Whether this container should allocate a buffer for stdin in
					// the container runtime. If this
					// is not set, reads from stdin in the container will always
					// result in EOF.
					// Default is false.
					stdin?: bool

					// Whether the container runtime should close the stdin channel
					// after it has been opened by
					// a single attach. When stdin is true the stdin stream will
					// remain open across multiple attach
					// sessions. If stdinOnce is set to true, stdin is opened on
					// container start, is empty until the
					// first client attaches to stdin, and then remains open and
					// accepts data until the client disconnects,
					// at which time stdin is closed and remains closed until the
					// container is restarted. If this
					// flag is false, a container processes that reads from stdin will
					// never receive an EOF.
					// Default is false
					stdinOnce?: bool

					// Optional: Path at which the file to which the container's
					// termination message
					// will be written is mounted into the container's filesystem.
					// Message written is intended to be brief final status, such as
					// an assertion failure message.
					// Will be truncated by the node if greater than 4096 bytes. The
					// total message length across
					// all containers will be limited to 12kb.
					// Defaults to /dev/termination-log.
					// Cannot be updated.
					terminationMessagePath?: string

					// Indicate how the termination message should be populated. File
					// will use the contents of
					// terminationMessagePath to populate the container status message
					// on both success and failure.
					// FallbackToLogsOnError will use the last chunk of container log
					// output if the termination
					// message file is empty and the container exited with an error.
					// The log output is limited to 2048 bytes or 80 lines, whichever
					// is smaller.
					// Defaults to File.
					// Cannot be updated.
					terminationMessagePolicy?: string

					// Whether this container should allocate a TTY for itself, also
					// requires 'stdin' to be true.
					// Default is false.
					tty?: bool

					// volumeDevices is the list of block devices to be used by the
					// container.
					volumeDevices?: [...{
						// devicePath is the path inside of the container that the device
						// will be mapped to.
						devicePath!: string

						// name must match the name of a persistentVolumeClaim in the pod
						name!: string
					}]

					// Pod volumes to mount into the container's filesystem.
					// Cannot be updated.
					volumeMounts?: [...{
						// Path within the container at which the volume should be
						// mounted. Must
						// not contain ':'.
						mountPath!: string

						// mountPropagation determines how mounts are propagated from the
						// host
						// to container and the other way around.
						// When not set, MountPropagationNone is used.
						// This field is beta in 1.10.
						// When RecursiveReadOnly is set to IfPossible or to Enabled,
						// MountPropagation must be None or unspecified
						// (which defaults to None).
						mountPropagation?: string

						// This must match the Name of a Volume.
						name!: string

						// Mounted read-only if true, read-write otherwise (false or
						// unspecified).
						// Defaults to false.
						readOnly?: bool

						// RecursiveReadOnly specifies whether read-only mounts should be
						// handled
						// recursively.
						//
						// If ReadOnly is false, this field has no meaning and must be
						// unspecified.
						//
						// If ReadOnly is true, and this field is set to Disabled, the
						// mount is not made
						// recursively read-only. If this field is set to IfPossible, the
						// mount is made
						// recursively read-only, if it is supported by the container
						// runtime. If this
						// field is set to Enabled, the mount is made recursively
						// read-only if it is
						// supported by the container runtime, otherwise the pod will not
						// be started and
						// an error will be generated to indicate the reason.
						//
						// If this field is set to IfPossible or Enabled, MountPropagation
						// must be set to
						// None (or be unspecified, which defaults to None).
						//
						// If this field is not specified, it is treated as an equivalent
						// of Disabled.
						recursiveReadOnly?: string

						// Path within the volume from which the container's volume should
						// be mounted.
						// Defaults to "" (volume's root).
						subPath?: string

						// Expanded path within the volume from which the container's
						// volume should be mounted.
						// Behaves similarly to SubPath but environment variable
						// references $(VAR_NAME) are expanded using the container's
						// environment.
						// Defaults to "" (volume's root).
						// SubPathExpr and SubPath are mutually exclusive.
						subPathExpr?: string
					}]

					// Container's working directory.
					// If not specified, the container runtime's default will be used,
					// which
					// might be configured in the container image.
					// Cannot be updated.
					workingDir?: string
				}]

				// NodeName indicates in which node this pod is scheduled.
				// If empty, this pod is a candidate for scheduling by the
				// scheduler defined in schedulerName.
				// Once this field is set, the kubelet for this node becomes
				// responsible for the lifecycle of this pod.
				// This field should not be used to express a desire for the pod
				// to be scheduled on a specific node.
				// https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#nodename
				nodeName?: string

				// NodeSelector is a selector which must be true for the pod to
				// fit on a node.
				// Selector which must match a node's labels for the pod to be
				// scheduled on that node.
				// More info:
				// https://kubernetes.io/docs/concepts/configuration/assign-pod-node/
				nodeSelector?: [string]: string

				// Specifies the OS of the containers in the pod.
				// Some pod and container fields are restricted if this is set.
				//
				// If the OS field is set to linux, the following fields must be
				// unset:
				// -securityContext.windowsOptions
				//
				// If the OS field is set to windows, following fields must be
				// unset:
				// - spec.hostPID
				// - spec.hostIPC
				// - spec.hostUsers
				// - spec.resources
				// - spec.securityContext.appArmorProfile
				// - spec.securityContext.seLinuxOptions
				// - spec.securityContext.seccompProfile
				// - spec.securityContext.fsGroup
				// - spec.securityContext.fsGroupChangePolicy
				// - spec.securityContext.sysctls
				// - spec.shareProcessNamespace
				// - spec.securityContext.runAsUser
				// - spec.securityContext.runAsGroup
				// - spec.securityContext.supplementalGroups
				// - spec.securityContext.supplementalGroupsPolicy
				// - spec.containers[*].securityContext.appArmorProfile
				// - spec.containers[*].securityContext.seLinuxOptions
				// - spec.containers[*].securityContext.seccompProfile
				// - spec.containers[*].securityContext.capabilities
				// - spec.containers[*].securityContext.readOnlyRootFilesystem
				// - spec.containers[*].securityContext.privileged
				// - spec.containers[*].securityContext.allowPrivilegeEscalation
				// - spec.containers[*].securityContext.procMount
				// - spec.containers[*].securityContext.runAsUser
				// - spec.containers[*].securityContext.runAsGroup
				os?: {
					// Name is the name of the operating system. The currently
					// supported values are linux and windows.
					// Additional value may be defined in future and can be one of:
					// https://github.com/opencontainers/runtime-spec/blob/master/config.md#platform-specific-configuration
					// Clients should expect to handle additional values and treat
					// unrecognized values in this field as os: null
					name!: string
				}

				// Overhead represents the resource overhead associated with
				// running a pod for a given RuntimeClass.
				// This field will be autopopulated at admission time by the
				// RuntimeClass admission controller. If
				// the RuntimeClass admission controller is enabled, overhead must
				// not be set in Pod create requests.
				// The RuntimeClass admission controller will reject Pod create
				// requests which have the overhead already
				// set. If RuntimeClass is configured and selected in the PodSpec,
				// Overhead will be set to the value
				// defined in the corresponding RuntimeClass, otherwise it will
				// remain unset and treated as zero.
				// More info:
				// https://git.k8s.io/enhancements/keps/sig-node/688-pod-overhead/README.md
				overhead?: [string]: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")

				// PreemptionPolicy is the Policy for preempting pods with lower
				// priority.
				// One of Never, PreemptLowerPriority.
				// Defaults to PreemptLowerPriority if unset.
				preemptionPolicy?: string

				// The priority value. Various system components use this field to
				// find the
				// priority of the pod. When Priority Admission Controller is
				// enabled, it
				// prevents users from setting this field. The admission
				// controller populates
				// this field from PriorityClassName.
				// The higher the value, the higher the priority.
				priority?: int32 & int

				// If specified, indicates the pod's priority.
				// "system-node-critical" and
				// "system-cluster-critical" are two special keywords which
				// indicate the
				// highest priorities with the former being the highest priority.
				// Any other
				// name must be defined by creating a PriorityClass object with
				// that name.
				// If not specified, the pod priority will be default or zero if
				// there is no
				// default.
				priorityClassName?: string

				// If specified, all readiness gates will be evaluated for pod
				// readiness.
				// A pod is ready when all its containers are ready AND
				// all conditions specified in the readiness gates have status
				// equal to "True"
				// More info:
				// https://git.k8s.io/enhancements/keps/sig-network/580-pod-readiness-gates
				readinessGates?: [...{
					// ConditionType refers to a condition in the pod's condition list
					// with matching type.
					conditionType!: string
				}]

				// ResourceClaims defines which ResourceClaims must be allocated
				// and reserved before the Pod is allowed to start. The resources
				// will be made available to those containers which consume them
				// by name.
				//
				// This is a stable field but requires that the
				// DynamicResourceAllocation feature gate is enabled.
				//
				// This field is immutable.
				resourceClaims?: [...{
					// Name uniquely identifies this resource claim inside the pod.
					// This must be a DNS_LABEL.
					name!: string

					// ResourceClaimName is the name of a ResourceClaim object in the
					// same
					// namespace as this pod.
					//
					// Exactly one of ResourceClaimName and ResourceClaimTemplateName
					// must
					// be set.
					resourceClaimName?: string

					// ResourceClaimTemplateName is the name of a
					// ResourceClaimTemplate
					// object in the same namespace as this pod.
					//
					// The template will be used to create a new ResourceClaim, which
					// will
					// be bound to this pod. When this pod is deleted, the
					// ResourceClaim
					// will also be deleted. The pod name and resource name, along
					// with a
					// generated component, will be used to form a unique name for the
					// ResourceClaim, which will be recorded in
					// pod.status.resourceClaimStatuses.
					//
					// This field is immutable and no changes will be made to the
					// corresponding ResourceClaim by the control plane after creating
					// the
					// ResourceClaim.
					//
					// Exactly one of ResourceClaimName and ResourceClaimTemplateName
					// must
					// be set.
					resourceClaimTemplateName?: string
				}]

				// Resources is the total amount of CPU and Memory resources
				// required by all
				// containers in the pod. It supports specifying Requests and
				// Limits for
				// "cpu", "memory" and "hugepages-" resource names only.
				// ResourceClaims are not supported.
				//
				// This field enables fine-grained control over resource
				// allocation for the
				// entire pod, allowing resource sharing among containers in a
				// pod.
				//
				// This is an alpha field and requires enabling the
				// PodLevelResources feature
				// gate.
				resources?: {
					// Claims lists the names of resources, defined in
					// spec.resourceClaims,
					// that are used by this container.
					//
					// This field depends on the
					// DynamicResourceAllocation feature gate.
					//
					// This field is immutable. It can only be set for containers.
					claims?: [...{
						// Name must match the name of one entry in
						// pod.spec.resourceClaims of
						// the Pod where this field is used. It makes that resource
						// available
						// inside a container.
						name!: string

						// Request is the name chosen for a request in the referenced
						// claim.
						// If empty, everything from the claim is made available,
						// otherwise
						// only the result of this request.
						request?: string
					}]

					// Limits describes the maximum amount of compute resources
					// allowed.
					// More info:
					// https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/
					limits?: [string]: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")

					// Requests describes the minimum amount of compute resources
					// required.
					// If Requests is omitted for a container, it defaults to Limits
					// if that is explicitly specified,
					// otherwise to an implementation-defined value. Requests cannot
					// exceed Limits.
					// More info:
					// https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/
					requests?: [string]: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")
				}

				// Restart policy for all containers within the pod.
				// One of Always, OnFailure, Never. In some contexts, only a
				// subset of those values may be permitted.
				// Default to Always.
				// More info:
				// https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle/#restart-policy
				restartPolicy?: string

				// RuntimeClassName refers to a RuntimeClass object in the
				// node.k8s.io group, which should be used
				// to run this pod. If no RuntimeClass resource matches the named
				// class, the pod will not be run.
				// If unset or empty, the "legacy" RuntimeClass will be used,
				// which is an implicit class with an
				// empty definition that uses the default runtime handler.
				// More info:
				// https://git.k8s.io/enhancements/keps/sig-node/585-runtime-class
				runtimeClassName?: string

				// If specified, the pod will be dispatched by specified
				// scheduler.
				// If not specified, the pod will be dispatched by default
				// scheduler.
				schedulerName?: string

				// SchedulingGates is an opaque list of values that if specified
				// will block scheduling the pod.
				// If schedulingGates is not empty, the pod will stay in the
				// SchedulingGated state and the
				// scheduler will not attempt to schedule the pod.
				//
				// SchedulingGates can only be set at pod creation time, and be
				// removed only afterwards.
				schedulingGates?: [...{
					// Name of the scheduling gate.
					// Each scheduling gate must have a unique name field.
					name!: string
				}]

				// SecurityContext holds pod-level security attributes and common
				// container settings.
				// Optional: Defaults to empty. See type description for default
				// values of each field.
				securityContext?: {
					// appArmorProfile is the AppArmor options to use by the
					// containers in this pod.
					// Note that this field cannot be set when spec.os.name is
					// windows.
					appArmorProfile?: {
						// localhostProfile indicates a profile loaded on the node that
						// should be used.
						// The profile must be preconfigured on the node to work.
						// Must match the loaded name of the profile.
						// Must be set if and only if type is "Localhost".
						localhostProfile?: string

						// type indicates which kind of AppArmor profile will be applied.
						// Valid options are:
						// Localhost - a profile pre-loaded on the node.
						// RuntimeDefault - the container runtime's default profile.
						// Unconfined - no AppArmor enforcement.
						type!: string
					}

					// A special supplemental group that applies to all containers in
					// a pod.
					// Some volume types allow the Kubelet to change the ownership of
					// that volume
					// to be owned by the pod:
					//
					// 1. The owning GID will be the FSGroup
					// 2. The setgid bit is set (new files created in the volume will
					// be owned by FSGroup)
					// 3. The permission bits are OR'd with rw-rw----
					//
					// If unset, the Kubelet will not modify the ownership and
					// permissions of any volume.
					// Note that this field cannot be set when spec.os.name is
					// windows.
					fsGroup?: int64 & int

					// fsGroupChangePolicy defines behavior of changing ownership and
					// permission of the volume
					// before being exposed inside Pod. This field will only apply to
					// volume types which support fsGroup based ownership(and
					// permissions).
					// It will have no effect on ephemeral volume types such as:
					// secret, configmaps
					// and emptydir.
					// Valid values are "OnRootMismatch" and "Always". If not
					// specified, "Always" is used.
					// Note that this field cannot be set when spec.os.name is
					// windows.
					fsGroupChangePolicy?: string

					// The GID to run the entrypoint of the container process.
					// Uses runtime default if unset.
					// May also be set in SecurityContext. If set in both
					// SecurityContext and
					// PodSecurityContext, the value specified in SecurityContext
					// takes precedence
					// for that container.
					// Note that this field cannot be set when spec.os.name is
					// windows.
					runAsGroup?: int64 & int

					// Indicates that the container must run as a non-root user.
					// If true, the Kubelet will validate the image at runtime to
					// ensure that it
					// does not run as UID 0 (root) and fail to start the container if
					// it does.
					// If unset or false, no such validation will be performed.
					// May also be set in SecurityContext. If set in both
					// SecurityContext and
					// PodSecurityContext, the value specified in SecurityContext
					// takes precedence.
					runAsNonRoot?: bool

					// The UID to run the entrypoint of the container process.
					// Defaults to user specified in image metadata if unspecified.
					// May also be set in SecurityContext. If set in both
					// SecurityContext and
					// PodSecurityContext, the value specified in SecurityContext
					// takes precedence
					// for that container.
					// Note that this field cannot be set when spec.os.name is
					// windows.
					runAsUser?: int64 & int

					// seLinuxChangePolicy defines how the container's SELinux label
					// is applied to all volumes used by the Pod.
					// It has no effect on nodes that do not support SELinux or to
					// volumes does not support SELinux.
					// Valid values are "MountOption" and "Recursive".
					//
					// "Recursive" means relabeling of all files on all Pod volumes by
					// the container runtime.
					// This may be slow for large volumes, but allows mixing
					// privileged and unprivileged Pods sharing the same volume on
					// the same node.
					//
					// "MountOption" mounts all eligible Pod volumes with `-o context`
					// mount option.
					// This requires all Pods that share the same volume to use the
					// same SELinux label.
					// It is not possible to share the same volume among privileged
					// and unprivileged Pods.
					// Eligible volumes are in-tree FibreChannel and iSCSI volumes,
					// and all CSI volumes
					// whose CSI driver announces SELinux support by setting
					// spec.seLinuxMount: true in their
					// CSIDriver instance. Other volumes are always re-labelled
					// recursively.
					// "MountOption" value is allowed only when SELinuxMount feature
					// gate is enabled.
					//
					// If not specified and SELinuxMount feature gate is enabled,
					// "MountOption" is used.
					// If not specified and SELinuxMount feature gate is disabled,
					// "MountOption" is used for ReadWriteOncePod volumes
					// and "Recursive" for all other volumes.
					//
					// This field affects only Pods that have SELinux label set,
					// either in PodSecurityContext or in SecurityContext of all
					// containers.
					//
					// All Pods that use the same volume should use the same
					// seLinuxChangePolicy, otherwise some pods can get stuck in
					// ContainerCreating state.
					// Note that this field cannot be set when spec.os.name is
					// windows.
					seLinuxChangePolicy?: string

					// The SELinux context to be applied to all containers.
					// If unspecified, the container runtime will allocate a random
					// SELinux context for each
					// container. May also be set in SecurityContext. If set in
					// both SecurityContext and PodSecurityContext, the value
					// specified in SecurityContext
					// takes precedence for that container.
					// Note that this field cannot be set when spec.os.name is
					// windows.
					seLinuxOptions?: {
						// Level is SELinux level label that applies to the container.
						level?: string

						// Role is a SELinux role label that applies to the container.
						role?: string

						// Type is a SELinux type label that applies to the container.
						type?: string

						// User is a SELinux user label that applies to the container.
						user?: string
					}

					// The seccomp options to use by the containers in this pod.
					// Note that this field cannot be set when spec.os.name is
					// windows.
					seccompProfile?: {
						// localhostProfile indicates a profile defined in a file on the
						// node should be used.
						// The profile must be preconfigured on the node to work.
						// Must be a descending path, relative to the kubelet's configured
						// seccomp profile location.
						// Must be set if type is "Localhost". Must NOT be set for any
						// other type.
						localhostProfile?: string

						// type indicates which kind of seccomp profile will be applied.
						// Valid options are:
						//
						// Localhost - a profile defined in a file on the node should be
						// used.
						// RuntimeDefault - the container runtime default profile should
						// be used.
						// Unconfined - no profile should be applied.
						type!: string
					}

					// A list of groups applied to the first process run in each
					// container, in
					// addition to the container's primary GID and fsGroup (if
					// specified). If
					// the SupplementalGroupsPolicy feature is enabled, the
					// supplementalGroupsPolicy field determines whether these are in
					// addition
					// to or instead of any group memberships defined in the container
					// image.
					// If unspecified, no additional groups are added, though group
					// memberships
					// defined in the container image may still be used, depending on
					// the
					// supplementalGroupsPolicy field.
					// Note that this field cannot be set when spec.os.name is
					// windows.
					supplementalGroups?: [...int64 & int]

					// Defines how supplemental groups of the first container
					// processes are calculated.
					// Valid values are "Merge" and "Strict". If not specified,
					// "Merge" is used.
					// (Alpha) Using the field requires the SupplementalGroupsPolicy
					// feature gate to be enabled
					// and the container runtime must implement support for this
					// feature.
					// Note that this field cannot be set when spec.os.name is
					// windows.
					supplementalGroupsPolicy?: string

					// Sysctls hold a list of namespaced sysctls used for the pod.
					// Pods with unsupported
					// sysctls (by the container runtime) might fail to launch.
					// Note that this field cannot be set when spec.os.name is
					// windows.
					sysctls?: [...{
						// Name of a property to set
						name!: string

						// Value of a property to set
						value!: string
					}]

					// The Windows specific settings applied to all containers.
					// If unspecified, the options within a container's
					// SecurityContext will be used.
					// If set in both SecurityContext and PodSecurityContext, the
					// value specified in SecurityContext takes precedence.
					// Note that this field cannot be set when spec.os.name is linux.
					windowsOptions?: {
						// GMSACredentialSpec is where the GMSA admission webhook
						// (https://github.com/kubernetes-sigs/windows-gmsa) inlines the
						// contents of the
						// GMSA credential spec named by the GMSACredentialSpecName field.
						gmsaCredentialSpec?: string

						// GMSACredentialSpecName is the name of the GMSA credential spec
						// to use.
						gmsaCredentialSpecName?: string

						// HostProcess determines if a container should be run as a 'Host
						// Process' container.
						// All of a Pod's containers must have the same effective
						// HostProcess value
						// (it is not allowed to have a mix of HostProcess containers and
						// non-HostProcess containers).
						// In addition, if HostProcess is true then HostNetwork must also
						// be set to true.
						hostProcess?: bool

						// The UserName in Windows to run the entrypoint of the container
						// process.
						// Defaults to the user specified in image metadata if
						// unspecified.
						// May also be set in PodSecurityContext. If set in both
						// SecurityContext and
						// PodSecurityContext, the value specified in SecurityContext
						// takes precedence.
						runAsUserName?: string
					}
				}

				// DeprecatedServiceAccount is a deprecated alias for
				// ServiceAccountName.
				// Deprecated: Use serviceAccountName instead.
				serviceAccount?: string

				// ServiceAccountName is the name of the ServiceAccount to use to
				// run this pod.
				// More info:
				// https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/
				serviceAccountName?: string

				// If true the pod's hostname will be configured as the pod's
				// FQDN, rather than the leaf name (the default).
				// In Linux containers, this means setting the FQDN in the
				// hostname field of the kernel (the nodename field of struct
				// utsname).
				// In Windows containers, this means setting the registry value of
				// hostname for the registry key
				// HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Services\\Tcpip\\Parameters
				// to FQDN.
				// If a pod does not have FQDN, this has no effect.
				// Default to false.
				setHostnameAsFQDN?: bool

				// Share a single process namespace between all of the containers
				// in a pod.
				// When this is set containers will be able to view and signal
				// processes from other containers
				// in the same pod, and the first process in each container will
				// not be assigned PID 1.
				// HostPID and ShareProcessNamespace cannot both be set.
				// Optional: Default to false.
				shareProcessNamespace?: bool

				// If specified, the fully qualified Pod hostname will be
				// "<hostname>.<subdomain>.<pod namespace>.svc.<cluster domain>".
				// If not specified, the pod will not have a domainname at all.
				subdomain?: string

				// Optional duration in seconds the pod needs to terminate
				// gracefully. May be decreased in delete request.
				// Value must be non-negative integer. The value zero indicates
				// stop immediately via
				// the kill signal (no opportunity to shut down).
				// If this value is nil, the default grace period will be used
				// instead.
				// The grace period is the duration in seconds after the processes
				// running in the pod are sent
				// a termination signal and the time when the processes are
				// forcibly halted with a kill signal.
				// Set this value longer than the expected cleanup time for your
				// process.
				// Defaults to 30 seconds.
				terminationGracePeriodSeconds?: int64 & int

				// If specified, the pod's tolerations.
				tolerations?: [...{
					// Effect indicates the taint effect to match. Empty means match
					// all taint effects.
					// When specified, allowed values are NoSchedule, PreferNoSchedule
					// and NoExecute.
					effect?: string

					// Key is the taint key that the toleration applies to. Empty
					// means match all taint keys.
					// If the key is empty, operator must be Exists; this combination
					// means to match all values and all keys.
					key?: string

					// Operator represents a key's relationship to the value.
					// Valid operators are Exists, Equal, Lt, and Gt. Defaults to
					// Equal.
					// Exists is equivalent to wildcard for value, so that a pod can
					// tolerate all taints of a particular category.
					// Lt and Gt perform numeric comparisons (requires feature gate
					// TaintTolerationComparisonOperators).
					operator?: string

					// TolerationSeconds represents the period of time the toleration
					// (which must be
					// of effect NoExecute, otherwise this field is ignored) tolerates
					// the taint. By default,
					// it is not set, which means tolerate the taint forever (do not
					// evict). Zero and
					// negative values will be treated as 0 (evict immediately) by the
					// system.
					tolerationSeconds?: int64 & int

					// Value is the taint value the toleration matches to.
					// If the operator is Exists, the value should be empty, otherwise
					// just a regular string.
					value?: string
				}]

				// TopologySpreadConstraints describes how a group of pods ought
				// to spread across topology
				// domains. Scheduler will schedule pods in a way which abides by
				// the constraints.
				// All topologySpreadConstraints are ANDed.
				topologySpreadConstraints?: [...{
					// LabelSelector is used to find matching pods.
					// Pods that match this label selector are counted to determine
					// the number of pods
					// in their corresponding topology domain.
					labelSelector?: {
						// matchExpressions is a list of label selector requirements. The
						// requirements are ANDed.
						matchExpressions?: [...{
							// key is the label key that the selector applies to.
							key!: string

							// operator represents a key's relationship to a set of values.
							// Valid operators are In, NotIn, Exists and DoesNotExist.
							operator!: string

							// values is an array of string values. If the operator is In or
							// NotIn,
							// the values array must be non-empty. If the operator is Exists
							// or DoesNotExist,
							// the values array must be empty. This array is replaced during a
							// strategic
							// merge patch.
							values?: [...string]
						}]

						// matchLabels is a map of {key,value} pairs. A single {key,value}
						// in the matchLabels
						// map is equivalent to an element of matchExpressions, whose key
						// field is "key", the
						// operator is "In", and the values array contains only "value".
						// The requirements are ANDed.
						matchLabels?: [string]: string
					}

					// MatchLabelKeys is a set of pod label keys to select the pods
					// over which
					// spreading will be calculated. The keys are used to lookup
					// values from the
					// incoming pod labels, those key-value labels are ANDed with
					// labelSelector
					// to select the group of existing pods over which spreading will
					// be calculated
					// for the incoming pod. The same key is forbidden to exist in
					// both MatchLabelKeys and LabelSelector.
					// MatchLabelKeys cannot be set when LabelSelector isn't set.
					// Keys that don't exist in the incoming pod labels will
					// be ignored. A null or empty list means only match against
					// labelSelector.
					//
					// This is a beta field and requires the
					// MatchLabelKeysInPodTopologySpread feature gate to be enabled
					// (enabled by default).
					matchLabelKeys?: [...string]

					// MaxSkew describes the degree to which pods may be unevenly
					// distributed.
					// When `whenUnsatisfiable=DoNotSchedule`, it is the maximum
					// permitted difference
					// between the number of matching pods in the target topology and
					// the global minimum.
					// The global minimum is the minimum number of matching pods in an
					// eligible domain
					// or zero if the number of eligible domains is less than
					// MinDomains.
					// For example, in a 3-zone cluster, MaxSkew is set to 1, and pods
					// with the same
					// labelSelector spread as 2/2/1:
					// In this case, the global minimum is 1.
					// | zone1 | zone2 | zone3 |
					// | P P | P P | P |
					// - if MaxSkew is 1, incoming pod can only be scheduled to zone3
					// to become 2/2/2;
					// scheduling it onto zone1(zone2) would make the ActualSkew(3-1)
					// on zone1(zone2)
					// violate MaxSkew(1).
					// - if MaxSkew is 2, incoming pod can be scheduled onto any zone.
					// When `whenUnsatisfiable=ScheduleAnyway`, it is used to give
					// higher precedence
					// to topologies that satisfy it.
					// It's a required field. Default value is 1 and 0 is not allowed.
					maxSkew!: int32 & int

					// MinDomains indicates a minimum number of eligible domains.
					// When the number of eligible domains with matching topology keys
					// is less than minDomains,
					// Pod Topology Spread treats "global minimum" as 0, and then the
					// calculation of Skew is performed.
					// And when the number of eligible domains with matching topology
					// keys equals or greater than minDomains,
					// this value has no effect on scheduling.
					// As a result, when the number of eligible domains is less than
					// minDomains,
					// scheduler won't schedule more than maxSkew Pods to those
					// domains.
					// If value is nil, the constraint behaves as if MinDomains is
					// equal to 1.
					// Valid values are integers greater than 0.
					// When value is not nil, WhenUnsatisfiable must be DoNotSchedule.
					//
					// For example, in a 3-zone cluster, MaxSkew is set to 2,
					// MinDomains is set to 5 and pods with the same
					// labelSelector spread as 2/2/2:
					// | zone1 | zone2 | zone3 |
					// | P P | P P | P P |
					// The number of domains is less than 5(MinDomains), so "global
					// minimum" is treated as 0.
					// In this situation, new pod with the same labelSelector cannot
					// be scheduled,
					// because computed skew will be 3(3 - 0) if new Pod is scheduled
					// to any of the three zones,
					// it will violate MaxSkew.
					minDomains?: int32 & int

					// NodeAffinityPolicy indicates how we will treat Pod's
					// nodeAffinity/nodeSelector
					// when calculating pod topology spread skew. Options are:
					// - Honor: only nodes matching nodeAffinity/nodeSelector are
					// included in the calculations.
					// - Ignore: nodeAffinity/nodeSelector are ignored. All nodes are
					// included in the calculations.
					//
					// If this value is nil, the behavior is equivalent to the Honor
					// policy.
					nodeAffinityPolicy?: string

					// NodeTaintsPolicy indicates how we will treat node taints when
					// calculating
					// pod topology spread skew. Options are:
					// - Honor: nodes without taints, along with tainted nodes for
					// which the incoming pod
					// has a toleration, are included.
					// - Ignore: node taints are ignored. All nodes are included.
					//
					// If this value is nil, the behavior is equivalent to the Ignore
					// policy.
					nodeTaintsPolicy?: string

					// TopologyKey is the key of node labels. Nodes that have a label
					// with this key
					// and identical values are considered to be in the same topology.
					// We consider each <key, value> as a "bucket", and try to put
					// balanced number
					// of pods into each bucket.
					// We define a domain as a particular instance of a topology.
					// Also, we define an eligible domain as a domain whose nodes meet
					// the requirements of
					// nodeAffinityPolicy and nodeTaintsPolicy.
					// e.g. If TopologyKey is "kubernetes.io/hostname", each Node is a
					// domain of that topology.
					// And, if TopologyKey is "topology.kubernetes.io/zone", each zone
					// is a domain of that topology.
					// It's a required field.
					topologyKey!: string

					// WhenUnsatisfiable indicates how to deal with a pod if it
					// doesn't satisfy
					// the spread constraint.
					// - DoNotSchedule (default) tells the scheduler not to schedule
					// it.
					// - ScheduleAnyway tells the scheduler to schedule the pod in any
					// location,
					// but giving higher precedence to topologies that would help
					// reduce the
					// skew.
					// A constraint is considered "Unsatisfiable" for an incoming pod
					// if and only if every possible node assignment for that pod
					// would violate
					// "MaxSkew" on some topology.
					// For example, in a 3-zone cluster, MaxSkew is set to 1, and pods
					// with the same
					// labelSelector spread as 3/1/1:
					// | zone1 | zone2 | zone3 |
					// | P P P | P | P |
					// If WhenUnsatisfiable is set to DoNotSchedule, incoming pod can
					// only be scheduled
					// to zone2(zone3) to become 3/2/1(3/1/2) as ActualSkew(2-1) on
					// zone2(zone3) satisfies
					// MaxSkew(1). In other words, the cluster can still be
					// imbalanced, but scheduler
					// won't make it *more* imbalanced.
					// It's a required field.
					whenUnsatisfiable!: string
				}]

				// List of volumes that can be mounted by containers belonging to
				// the pod.
				// More info: https://kubernetes.io/docs/concepts/storage/volumes
				volumes?: [...{
					// awsElasticBlockStore represents an AWS Disk resource that is
					// attached to a
					// kubelet's host machine and then exposed to the pod.
					// Deprecated: AWSElasticBlockStore is deprecated. All operations
					// for the in-tree
					// awsElasticBlockStore type are redirected to the ebs.csi.aws.com
					// CSI driver.
					// More info:
					// https://kubernetes.io/docs/concepts/storage/volumes#awselasticblockstore
					awsElasticBlockStore?: {
						// fsType is the filesystem type of the volume that you want to
						// mount.
						// Tip: Ensure that the filesystem type is supported by the host
						// operating system.
						// Examples: "ext4", "xfs", "ntfs". Implicitly inferred to be
						// "ext4" if unspecified.
						// More info:
						// https://kubernetes.io/docs/concepts/storage/volumes#awselasticblockstore
						fsType?: string

						// partition is the partition in the volume that you want to
						// mount.
						// If omitted, the default is to mount by volume name.
						// Examples: For volume /dev/sda1, you specify the partition as
						// "1".
						// Similarly, the volume partition for /dev/sda is "0" (or you can
						// leave the property empty).
						partition?: int32 & int

						// readOnly value true will force the readOnly setting in
						// VolumeMounts.
						// More info:
						// https://kubernetes.io/docs/concepts/storage/volumes#awselasticblockstore
						readOnly?: bool

						// volumeID is unique ID of the persistent disk resource in AWS
						// (Amazon EBS volume).
						// More info:
						// https://kubernetes.io/docs/concepts/storage/volumes#awselasticblockstore
						volumeID!: string
					}

					// azureDisk represents an Azure Data Disk mount on the host and
					// bind mount to the pod.
					// Deprecated: AzureDisk is deprecated. All operations for the
					// in-tree azureDisk type
					// are redirected to the disk.csi.azure.com CSI driver.
					azureDisk?: {
						// cachingMode is the Host Caching mode: None, Read Only, Read
						// Write.
						cachingMode?: string

						// diskName is the Name of the data disk in the blob storage
						diskName!: string

						// diskURI is the URI of data disk in the blob storage
						diskURI!: string

						// fsType is Filesystem type to mount.
						// Must be a filesystem type supported by the host operating
						// system.
						// Ex. "ext4", "xfs", "ntfs". Implicitly inferred to be "ext4" if
						// unspecified.
						fsType?: string

						// kind expected values are Shared: multiple blob disks per
						// storage account Dedicated: single blob disk per storage
						// account Managed: azure managed data disk (only in managed
						// availability set). defaults to shared
						kind?: string

						// readOnly Defaults to false (read/write). ReadOnly here will
						// force
						// the ReadOnly setting in VolumeMounts.
						readOnly?: bool
					}

					// azureFile represents an Azure File Service mount on the host
					// and bind mount to the pod.
					// Deprecated: AzureFile is deprecated. All operations for the
					// in-tree azureFile type
					// are redirected to the file.csi.azure.com CSI driver.
					azureFile?: {
						// readOnly defaults to false (read/write). ReadOnly here will
						// force
						// the ReadOnly setting in VolumeMounts.
						readOnly?: bool

						// secretName is the name of secret that contains Azure Storage
						// Account Name and Key
						secretName!: string

						// shareName is the azure share Name
						shareName!: string
					}

					// cephFS represents a Ceph FS mount on the host that shares a
					// pod's lifetime.
					// Deprecated: CephFS is deprecated and the in-tree cephfs type is
					// no longer supported.
					cephfs?: {
						// monitors is Required: Monitors is a collection of Ceph monitors
						// More info:
						// https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it
						monitors!: [...string]

						// path is Optional: Used as the mounted root, rather than the
						// full Ceph tree, default is /
						path?: string

						// readOnly is Optional: Defaults to false (read/write). ReadOnly
						// here will force
						// the ReadOnly setting in VolumeMounts.
						// More info:
						// https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it
						readOnly?: bool

						// secretFile is Optional: SecretFile is the path to key ring for
						// User, default is /etc/ceph/user.secret
						// More info:
						// https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it
						secretFile?: string

						// secretRef is Optional: SecretRef is reference to the
						// authentication secret for User, default is empty.
						// More info:
						// https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it
						secretRef?: {
							// Name of the referent.
							// This field is effectively required, but due to backwards
							// compatibility is
							// allowed to be empty. Instances of this type with an empty value
							// here are
							// almost certainly wrong.
							// More info:
							// https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
							name?: string
						}

						// user is optional: User is the rados user name, default is admin
						// More info:
						// https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it
						user?: string
					}

					// cinder represents a cinder volume attached and mounted on
					// kubelets host machine.
					// Deprecated: Cinder is deprecated. All operations for the
					// in-tree cinder type
					// are redirected to the cinder.csi.openstack.org CSI driver.
					// More info: https://examples.k8s.io/mysql-cinder-pd/README.md
					cinder?: {
						// fsType is the filesystem type to mount.
						// Must be a filesystem type supported by the host operating
						// system.
						// Examples: "ext4", "xfs", "ntfs". Implicitly inferred to be
						// "ext4" if unspecified.
						// More info: https://examples.k8s.io/mysql-cinder-pd/README.md
						fsType?: string

						// readOnly defaults to false (read/write). ReadOnly here will
						// force
						// the ReadOnly setting in VolumeMounts.
						// More info: https://examples.k8s.io/mysql-cinder-pd/README.md
						readOnly?: bool

						// secretRef is optional: points to a secret object containing
						// parameters used to connect
						// to OpenStack.
						secretRef?: {
							// Name of the referent.
							// This field is effectively required, but due to backwards
							// compatibility is
							// allowed to be empty. Instances of this type with an empty value
							// here are
							// almost certainly wrong.
							// More info:
							// https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
							name?: string
						}

						// volumeID used to identify the volume in cinder.
						// More info: https://examples.k8s.io/mysql-cinder-pd/README.md
						volumeID!: string
					}

					// configMap represents a configMap that should populate this
					// volume
					configMap?: {
						// defaultMode is optional: mode bits used to set permissions on
						// created files by default.
						// Must be an octal value between 0000 and 0777 or a decimal value
						// between 0 and 511.
						// YAML accepts both octal and decimal values, JSON requires
						// decimal values for mode bits.
						// Defaults to 0644.
						// Directories within the path are not affected by this setting.
						// This might be in conflict with other options that affect the
						// file
						// mode, like fsGroup, and the result can be other mode bits set.
						defaultMode?: int32 & int

						// items if unspecified, each key-value pair in the Data field of
						// the referenced
						// ConfigMap will be projected into the volume as a file whose
						// name is the
						// key and content is the value. If specified, the listed keys
						// will be
						// projected into the specified paths, and unlisted keys will not
						// be
						// present. If a key is specified which is not present in the
						// ConfigMap,
						// the volume setup will error unless it is marked optional. Paths
						// must be
						// relative and may not contain the '..' path or start with '..'.
						items?: [...{
							// key is the key to project.
							key!: string

							// mode is Optional: mode bits used to set permissions on this
							// file.
							// Must be an octal value between 0000 and 0777 or a decimal value
							// between 0 and 511.
							// YAML accepts both octal and decimal values, JSON requires
							// decimal values for mode bits.
							// If not specified, the volume defaultMode will be used.
							// This might be in conflict with other options that affect the
							// file
							// mode, like fsGroup, and the result can be other mode bits set.
							mode?: int32 & int

							// path is the relative path of the file to map the key to.
							// May not be an absolute path.
							// May not contain the path element '..'.
							// May not start with the string '..'.
							path!: string
						}]

						// Name of the referent.
						// This field is effectively required, but due to backwards
						// compatibility is
						// allowed to be empty. Instances of this type with an empty value
						// here are
						// almost certainly wrong.
						// More info:
						// https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
						name?: string

						// optional specify whether the ConfigMap or its keys must be
						// defined
						optional?: bool
					}

					// csi (Container Storage Interface) represents ephemeral storage
					// that is handled by certain external CSI drivers.
					csi?: {
						// driver is the name of the CSI driver that handles this volume.
						// Consult with your admin for the correct name as registered in
						// the cluster.
						driver!: string

						// fsType to mount. Ex. "ext4", "xfs", "ntfs".
						// If not provided, the empty value is passed to the associated
						// CSI driver
						// which will determine the default filesystem to apply.
						fsType?: string

						// nodePublishSecretRef is a reference to the secret object
						// containing
						// sensitive information to pass to the CSI driver to complete the
						// CSI
						// NodePublishVolume and NodeUnpublishVolume calls.
						// This field is optional, and may be empty if no secret is
						// required. If the
						// secret object contains more than one secret, all secret
						// references are passed.
						nodePublishSecretRef?: {
							// Name of the referent.
							// This field is effectively required, but due to backwards
							// compatibility is
							// allowed to be empty. Instances of this type with an empty value
							// here are
							// almost certainly wrong.
							// More info:
							// https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
							name?: string
						}

						// readOnly specifies a read-only configuration for the volume.
						// Defaults to false (read/write).
						readOnly?: bool

						// volumeAttributes stores driver-specific properties that are
						// passed to the CSI
						// driver. Consult your driver's documentation for supported
						// values.
						volumeAttributes?: [string]: string
					}

					// downwardAPI represents downward API about the pod that should
					// populate this volume
					downwardAPI?: {
						// Optional: mode bits to use on created files by default. Must be
						// a
						// Optional: mode bits used to set permissions on created files by
						// default.
						// Must be an octal value between 0000 and 0777 or a decimal value
						// between 0 and 511.
						// YAML accepts both octal and decimal values, JSON requires
						// decimal values for mode bits.
						// Defaults to 0644.
						// Directories within the path are not affected by this setting.
						// This might be in conflict with other options that affect the
						// file
						// mode, like fsGroup, and the result can be other mode bits set.
						defaultMode?: int32 & int

						// Items is a list of downward API volume file
						items?: [...{
							// Required: Selects a field of the pod: only annotations, labels,
							// name, namespace and uid are supported.
							fieldRef?: {
								// Version of the schema the FieldPath is written in terms of,
								// defaults to "v1".
								apiVersion?: string

								// Path of the field to select in the specified API version.
								fieldPath!: string
							}

							// Optional: mode bits used to set permissions on this file, must
							// be an octal value
							// between 0000 and 0777 or a decimal value between 0 and 511.
							// YAML accepts both octal and decimal values, JSON requires
							// decimal values for mode bits.
							// If not specified, the volume defaultMode will be used.
							// This might be in conflict with other options that affect the
							// file
							// mode, like fsGroup, and the result can be other mode bits set.
							mode?: int32 & int

							// Required: Path is the relative path name of the file to be
							// created. Must not be absolute or contain the '..' path. Must
							// be utf-8 encoded. The first item of the relative path must not
							// start with '..'
							path!: string

							// Selects a resource of the container: only resources limits and
							// requests
							// (limits.cpu, limits.memory, requests.cpu and requests.memory)
							// are currently supported.
							resourceFieldRef?: {
								// Container name: required for volumes, optional for env vars
								containerName?: string

								// Specifies the output format of the exposed resources, defaults
								// to "1"
								divisor?: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")

								// Required: resource to select
								resource!: string
							}
						}]
					}

					// emptyDir represents a temporary directory that shares a pod's
					// lifetime.
					// More info:
					// https://kubernetes.io/docs/concepts/storage/volumes#emptydir
					emptyDir?: {
						// medium represents what type of storage medium should back this
						// directory.
						// The default is "" which means to use the node's default medium.
						// Must be an empty string (default) or Memory.
						// More info:
						// https://kubernetes.io/docs/concepts/storage/volumes#emptydir
						medium?: string

						// sizeLimit is the total amount of local storage required for
						// this EmptyDir volume.
						// The size limit is also applicable for memory medium.
						// The maximum usage on memory medium EmptyDir would be the
						// minimum value between
						// the SizeLimit specified here and the sum of memory limits of
						// all containers in a pod.
						// The default is nil which means that the limit is undefined.
						// More info:
						// https://kubernetes.io/docs/concepts/storage/volumes#emptydir
						sizeLimit?: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")
					}

					// ephemeral represents a volume that is handled by a cluster
					// storage driver.
					// The volume's lifecycle is tied to the pod that defines it - it
					// will be created before the pod starts,
					// and deleted when the pod is removed.
					//
					// Use this if:
					// a) the volume is only needed while the pod runs,
					// b) features of normal volumes like restoring from snapshot or
					// capacity
					// tracking are needed,
					// c) the storage driver is specified through a storage class, and
					// d) the storage driver supports dynamic volume provisioning
					// through
					// a PersistentVolumeClaim (see EphemeralVolumeSource for more
					// information on the connection between this volume type
					// and PersistentVolumeClaim).
					//
					// Use PersistentVolumeClaim or one of the vendor-specific
					// APIs for volumes that persist for longer than the lifecycle
					// of an individual pod.
					//
					// Use CSI for light-weight local ephemeral volumes if the CSI
					// driver is meant to
					// be used that way - see the documentation of the driver for
					// more information.
					//
					// A pod can use both types of ephemeral volumes and
					// persistent volumes at the same time.
					ephemeral?: {
						// Will be used to create a stand-alone PVC to provision the
						// volume.
						// The pod in which this EphemeralVolumeSource is embedded will be
						// the
						// owner of the PVC, i.e. the PVC will be deleted together with
						// the
						// pod. The name of the PVC will be `<pod name>-<volume name>`
						// where
						// `<volume name>` is the name from the `PodSpec.Volumes` array
						// entry. Pod validation will reject the pod if the concatenated
						// name
						// is not valid for a PVC (for example, too long).
						//
						// An existing PVC with that name that is not owned by the pod
						// will *not* be used for the pod to avoid using an unrelated
						// volume by mistake. Starting the pod is then blocked until
						// the unrelated PVC is removed. If such a pre-created PVC is
						// meant to be used by the pod, the PVC has to updated with an
						// owner reference to the pod once the pod exists. Normally
						// this should not be necessary, but it may be useful when
						// manually reconstructing a broken cluster.
						//
						// This field is read-only and no changes will be made by
						// Kubernetes
						// to the PVC after it has been created.
						//
						// Required, must not be nil.
						volumeClaimTemplate?: {
							// May contain labels and annotations that will be copied into the
							// PVC
							// when creating it. No other fields are allowed and will be
							// rejected during
							// validation.
							metadata?: {}

							// The specification for the PersistentVolumeClaim. The entire
							// content is
							// copied unchanged into the PVC that gets created from this
							// template. The same fields as in a PersistentVolumeClaim
							// are also valid here.
							spec!: {
								// accessModes contains the desired access modes the volume should
								// have.
								// More info:
								// https://kubernetes.io/docs/concepts/storage/persistent-volumes#access-modes-1
								accessModes?: [...string]

								// dataSource field can be used to specify either:
								// * An existing VolumeSnapshot object
								// (snapshot.storage.k8s.io/VolumeSnapshot)
								// * An existing PVC (PersistentVolumeClaim)
								// If the provisioner or an external controller can support the
								// specified data source,
								// it will create a new volume based on the contents of the
								// specified data source.
								// When the AnyVolumeDataSource feature gate is enabled,
								// dataSource contents will be copied to dataSourceRef,
								// and dataSourceRef contents will be copied to dataSource when
								// dataSourceRef.namespace is not specified.
								// If the namespace is specified, then dataSourceRef will not be
								// copied to dataSource.
								dataSource?: {
									// APIGroup is the group for the resource being referenced.
									// If APIGroup is not specified, the specified Kind must be in the
									// core API group.
									// For any other third-party types, APIGroup is required.
									apiGroup?: string

									// Kind is the type of resource being referenced
									kind!: string

									// Name is the name of resource being referenced
									name!: string
								}

								// dataSourceRef specifies the object from which to populate the
								// volume with data, if a non-empty
								// volume is desired. This may be any object from a non-empty API
								// group (non
								// core object) or a PersistentVolumeClaim object.
								// When this field is specified, volume binding will only succeed
								// if the type of
								// the specified object matches some installed volume populator or
								// dynamic
								// provisioner.
								// This field will replace the functionality of the dataSource
								// field and as such
								// if both fields are non-empty, they must have the same value.
								// For backwards
								// compatibility, when namespace isn't specified in dataSourceRef,
								// both fields (dataSource and dataSourceRef) will be set to the
								// same
								// value automatically if one of them is empty and the other is
								// non-empty.
								// When namespace is specified in dataSourceRef,
								// dataSource isn't set to the same value and must be empty.
								// There are three important differences between dataSource and
								// dataSourceRef:
								// * While dataSource only allows two specific types of objects,
								// dataSourceRef
								// allows any non-core object, as well as PersistentVolumeClaim
								// objects.
								// * While dataSource ignores disallowed values (dropping them),
								// dataSourceRef
								// preserves all values, and generates an error if a disallowed
								// value is
								// specified.
								// * While dataSource only allows local objects, dataSourceRef
								// allows objects
								// in any namespaces.
								// (Beta) Using this field requires the AnyVolumeDataSource
								// feature gate to be enabled.
								// (Alpha) Using the namespace field of dataSourceRef requires the
								// CrossNamespaceVolumeDataSource feature gate to be enabled.
								dataSourceRef?: {
									// APIGroup is the group for the resource being referenced.
									// If APIGroup is not specified, the specified Kind must be in the
									// core API group.
									// For any other third-party types, APIGroup is required.
									apiGroup?: string

									// Kind is the type of resource being referenced
									kind!: string

									// Name is the name of resource being referenced
									name!: string

									// Namespace is the namespace of resource being referenced
									// Note that when a namespace is specified, a
									// gateway.networking.k8s.io/ReferenceGrant object is required in
									// the referent namespace to allow that namespace's owner to
									// accept the reference. See the ReferenceGrant documentation for
									// details.
									// (Alpha) This field requires the CrossNamespaceVolumeDataSource
									// feature gate to be enabled.
									namespace?: string
								}

								// resources represents the minimum resources the volume should
								// have.
								// Users are allowed to specify resource requirements
								// that are lower than previous value but must still be higher
								// than capacity recorded in the
								// status field of the claim.
								// More info:
								// https://kubernetes.io/docs/concepts/storage/persistent-volumes#resources
								resources?: {
									// Limits describes the maximum amount of compute resources
									// allowed.
									// More info:
									// https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/
									limits?: [string]: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")

									// Requests describes the minimum amount of compute resources
									// required.
									// If Requests is omitted for a container, it defaults to Limits
									// if that is explicitly specified,
									// otherwise to an implementation-defined value. Requests cannot
									// exceed Limits.
									// More info:
									// https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/
									requests?: [string]: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")
								}

								// selector is a label query over volumes to consider for binding.
								selector?: {
									// matchExpressions is a list of label selector requirements. The
									// requirements are ANDed.
									matchExpressions?: [...{
										// key is the label key that the selector applies to.
										key!: string

										// operator represents a key's relationship to a set of values.
										// Valid operators are In, NotIn, Exists and DoesNotExist.
										operator!: string

										// values is an array of string values. If the operator is In or
										// NotIn,
										// the values array must be non-empty. If the operator is Exists
										// or DoesNotExist,
										// the values array must be empty. This array is replaced during a
										// strategic
										// merge patch.
										values?: [...string]
									}]

									// matchLabels is a map of {key,value} pairs. A single {key,value}
									// in the matchLabels
									// map is equivalent to an element of matchExpressions, whose key
									// field is "key", the
									// operator is "In", and the values array contains only "value".
									// The requirements are ANDed.
									matchLabels?: [string]: string
								}

								// storageClassName is the name of the StorageClass required by
								// the claim.
								// More info:
								// https://kubernetes.io/docs/concepts/storage/persistent-volumes#class-1
								storageClassName?: string

								// volumeAttributesClassName may be used to set the
								// VolumeAttributesClass used by this claim.
								// If specified, the CSI driver will create or update the volume
								// with the attributes defined
								// in the corresponding VolumeAttributesClass. This has a
								// different purpose than storageClassName,
								// it can be changed after the claim is created. An empty string
								// or nil value indicates that no
								// VolumeAttributesClass will be applied to the claim. If the
								// claim enters an Infeasible error state,
								// this field can be reset to its previous value (including nil)
								// to cancel the modification.
								// If the resource referred to by volumeAttributesClass does not
								// exist, this PersistentVolumeClaim will be
								// set to a Pending state, as reflected by the modifyVolumeStatus
								// field, until such as a resource
								// exists.
								// More info:
								// https://kubernetes.io/docs/concepts/storage/volume-attributes-classes/
								volumeAttributesClassName?: string

								// volumeMode defines what type of volume is required by the
								// claim.
								// Value of Filesystem is implied when not included in claim spec.
								volumeMode?: string

								// volumeName is the binding reference to the PersistentVolume
								// backing this claim.
								volumeName?: string
							}
						}
					}

					// fc represents a Fibre Channel resource that is attached to a
					// kubelet's host machine and then exposed to the pod.
					fc?: {
						// fsType is the filesystem type to mount.
						// Must be a filesystem type supported by the host operating
						// system.
						// Ex. "ext4", "xfs", "ntfs". Implicitly inferred to be "ext4" if
						// unspecified.
						fsType?: string

						// lun is Optional: FC target lun number
						lun?: int32 & int

						// readOnly is Optional: Defaults to false (read/write). ReadOnly
						// here will force
						// the ReadOnly setting in VolumeMounts.
						readOnly?: bool

						// targetWWNs is Optional: FC target worldwide names (WWNs)
						targetWWNs?: [...string]

						// wwids Optional: FC volume world wide identifiers (wwids)
						// Either wwids or combination of targetWWNs and lun must be set,
						// but not both simultaneously.
						wwids?: [...string]
					}

					// flexVolume represents a generic volume resource that is
					// provisioned/attached using an exec based plugin.
					// Deprecated: FlexVolume is deprecated. Consider using a
					// CSIDriver instead.
					flexVolume?: {
						// driver is the name of the driver to use for this volume.
						driver!: string

						// fsType is the filesystem type to mount.
						// Must be a filesystem type supported by the host operating
						// system.
						// Ex. "ext4", "xfs", "ntfs". The default filesystem depends on
						// FlexVolume script.
						fsType?: string

						// options is Optional: this field holds extra command options if
						// any.
						options?: [string]: string

						// readOnly is Optional: defaults to false (read/write). ReadOnly
						// here will force
						// the ReadOnly setting in VolumeMounts.
						readOnly?: bool

						// secretRef is Optional: secretRef is reference to the secret
						// object containing
						// sensitive information to pass to the plugin scripts. This may
						// be
						// empty if no secret object is specified. If the secret object
						// contains more than one secret, all secrets are passed to the
						// plugin
						// scripts.
						secretRef?: {
							// Name of the referent.
							// This field is effectively required, but due to backwards
							// compatibility is
							// allowed to be empty. Instances of this type with an empty value
							// here are
							// almost certainly wrong.
							// More info:
							// https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
							name?: string
						}
					}

					// flocker represents a Flocker volume attached to a kubelet's
					// host machine. This depends on the Flocker control service
					// being running.
					// Deprecated: Flocker is deprecated and the in-tree flocker type
					// is no longer supported.
					flocker?: {
						// datasetName is Name of the dataset stored as metadata -> name
						// on the dataset for Flocker
						// should be considered as deprecated
						datasetName?: string

						// datasetUUID is the UUID of the dataset. This is unique
						// identifier of a Flocker dataset
						datasetUUID?: string
					}

					// gcePersistentDisk represents a GCE Disk resource that is
					// attached to a
					// kubelet's host machine and then exposed to the pod.
					// Deprecated: GCEPersistentDisk is deprecated. All operations for
					// the in-tree
					// gcePersistentDisk type are redirected to the
					// pd.csi.storage.gke.io CSI driver.
					// More info:
					// https://kubernetes.io/docs/concepts/storage/volumes#gcepersistentdisk
					gcePersistentDisk?: {
						// fsType is filesystem type of the volume that you want to mount.
						// Tip: Ensure that the filesystem type is supported by the host
						// operating system.
						// Examples: "ext4", "xfs", "ntfs". Implicitly inferred to be
						// "ext4" if unspecified.
						// More info:
						// https://kubernetes.io/docs/concepts/storage/volumes#gcepersistentdisk
						fsType?: string

						// partition is the partition in the volume that you want to
						// mount.
						// If omitted, the default is to mount by volume name.
						// Examples: For volume /dev/sda1, you specify the partition as
						// "1".
						// Similarly, the volume partition for /dev/sda is "0" (or you can
						// leave the property empty).
						// More info:
						// https://kubernetes.io/docs/concepts/storage/volumes#gcepersistentdisk
						partition?: int32 & int

						// pdName is unique name of the PD resource in GCE. Used to
						// identify the disk in GCE.
						// More info:
						// https://kubernetes.io/docs/concepts/storage/volumes#gcepersistentdisk
						pdName!: string

						// readOnly here will force the ReadOnly setting in VolumeMounts.
						// Defaults to false.
						// More info:
						// https://kubernetes.io/docs/concepts/storage/volumes#gcepersistentdisk
						readOnly?: bool
					}

					// gitRepo represents a git repository at a particular revision.
					// Deprecated: GitRepo is deprecated. To provision a container
					// with a git repo, mount an
					// EmptyDir into an InitContainer that clones the repo using git,
					// then mount the EmptyDir
					// into the Pod's container.
					gitRepo?: {
						// directory is the target directory name.
						// Must not contain or start with '..'. If '.' is supplied, the
						// volume directory will be the
						// git repository. Otherwise, if specified, the volume will
						// contain the git repository in
						// the subdirectory with the given name.
						directory?: string

						// repository is the URL
						repository!: string

						// revision is the commit hash for the specified revision.
						revision?: string
					}

					// glusterfs represents a Glusterfs mount on the host that shares
					// a pod's lifetime.
					// Deprecated: Glusterfs is deprecated and the in-tree glusterfs
					// type is no longer supported.
					glusterfs?: {
						// endpoints is the endpoint name that details Glusterfs topology.
						endpoints!: string

						// path is the Glusterfs volume path.
						// More info:
						// https://examples.k8s.io/volumes/glusterfs/README.md#create-a-pod
						path!: string

						// readOnly here will force the Glusterfs volume to be mounted
						// with read-only permissions.
						// Defaults to false.
						// More info:
						// https://examples.k8s.io/volumes/glusterfs/README.md#create-a-pod
						readOnly?: bool
					}

					// hostPath represents a pre-existing file or directory on the
					// host
					// machine that is directly exposed to the container. This is
					// generally
					// used for system agents or other privileged things that are
					// allowed
					// to see the host machine. Most containers will NOT need this.
					// More info:
					// https://kubernetes.io/docs/concepts/storage/volumes#hostpath
					hostPath?: {
						// path of the directory on the host.
						// If the path is a symlink, it will follow the link to the real
						// path.
						// More info:
						// https://kubernetes.io/docs/concepts/storage/volumes#hostpath
						path!: string

						// type for HostPath Volume
						// Defaults to ""
						// More info:
						// https://kubernetes.io/docs/concepts/storage/volumes#hostpath
						type?: string
					}

					// image represents an OCI object (a container image or artifact)
					// pulled and mounted on the kubelet's host machine.
					// The volume is resolved at pod startup depending on which
					// PullPolicy value is provided:
					//
					// - Always: the kubelet always attempts to pull the reference.
					// Container creation will fail If the pull fails.
					// - Never: the kubelet never pulls the reference and only uses a
					// local image or artifact. Container creation will fail if the
					// reference isn't present.
					// - IfNotPresent: the kubelet pulls if the reference isn't
					// already present on disk. Container creation will fail if the
					// reference isn't present and the pull fails.
					//
					// The volume gets re-resolved if the pod gets deleted and
					// recreated, which means that new remote content will become
					// available on pod recreation.
					// A failure to resolve or pull the image during pod startup will
					// block containers from starting and may add significant
					// latency. Failures will be retried using normal volume backoff
					// and will be reported on the pod reason and message.
					// The types of objects that may be mounted by this volume are
					// defined by the container runtime implementation on a host
					// machine and at minimum must include all valid types supported
					// by the container image field.
					// The OCI object gets mounted in a single directory
					// (spec.containers[*].volumeMounts.mountPath) by merging the
					// manifest layers in the same way as for container images.
					// The volume will be mounted read-only (ro) and non-executable
					// files (noexec).
					// Sub path mounts for containers are not supported
					// (spec.containers[*].volumeMounts.subpath) before 1.33.
					// The field spec.securityContext.fsGroupChangePolicy has no
					// effect on this volume type.
					image?: {
						// Policy for pulling OCI objects. Possible values are:
						// Always: the kubelet always attempts to pull the reference.
						// Container creation will fail If the pull fails.
						// Never: the kubelet never pulls the reference and only uses a
						// local image or artifact. Container creation will fail if the
						// reference isn't present.
						// IfNotPresent: the kubelet pulls if the reference isn't already
						// present on disk. Container creation will fail if the reference
						// isn't present and the pull fails.
						// Defaults to Always if :latest tag is specified, or IfNotPresent
						// otherwise.
						pullPolicy?: string

						// Required: Image or artifact reference to be used.
						// Behaves in the same way as pod.spec.containers[*].image.
						// Pull secrets will be assembled in the same way as for the
						// container image by looking up node credentials, SA image pull
						// secrets, and pod spec image pull secrets.
						// More info:
						// https://kubernetes.io/docs/concepts/containers/images
						// This field is optional to allow higher level config management
						// to default or override
						// container images in workload controllers like Deployments and
						// StatefulSets.
						reference?: string
					}

					// iscsi represents an ISCSI Disk resource that is attached to a
					// kubelet's host machine and then exposed to the pod.
					// More info:
					// https://kubernetes.io/docs/concepts/storage/volumes/#iscsi
					iscsi?: {
						// chapAuthDiscovery defines whether support iSCSI Discovery CHAP
						// authentication
						chapAuthDiscovery?: bool

						// chapAuthSession defines whether support iSCSI Session CHAP
						// authentication
						chapAuthSession?: bool

						// fsType is the filesystem type of the volume that you want to
						// mount.
						// Tip: Ensure that the filesystem type is supported by the host
						// operating system.
						// Examples: "ext4", "xfs", "ntfs". Implicitly inferred to be
						// "ext4" if unspecified.
						// More info:
						// https://kubernetes.io/docs/concepts/storage/volumes#iscsi
						fsType?: string

						// initiatorName is the custom iSCSI Initiator Name.
						// If initiatorName is specified with iscsiInterface
						// simultaneously, new iSCSI interface
						// <target portal>:<volume name> will be created for the
						// connection.
						initiatorName?: string

						// iqn is the target iSCSI Qualified Name.
						iqn!: string

						// iscsiInterface is the interface Name that uses an iSCSI
						// transport.
						// Defaults to 'default' (tcp).
						iscsiInterface?: string

						// lun represents iSCSI Target Lun number.
						lun!: int32 & int

						// portals is the iSCSI Target Portal List. The portal is either
						// an IP or ip_addr:port if the port
						// is other than default (typically TCP ports 860 and 3260).
						portals?: [...string]

						// readOnly here will force the ReadOnly setting in VolumeMounts.
						// Defaults to false.
						readOnly?: bool

						// secretRef is the CHAP Secret for iSCSI target and initiator
						// authentication
						secretRef?: {
							// Name of the referent.
							// This field is effectively required, but due to backwards
							// compatibility is
							// allowed to be empty. Instances of this type with an empty value
							// here are
							// almost certainly wrong.
							// More info:
							// https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
							name?: string
						}

						// targetPortal is iSCSI Target Portal. The Portal is either an IP
						// or ip_addr:port if the port
						// is other than default (typically TCP ports 860 and 3260).
						targetPortal!: string
					}

					// name of the volume.
					// Must be a DNS_LABEL and unique within the pod.
					// More info:
					// https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
					name!: string

					// nfs represents an NFS mount on the host that shares a pod's
					// lifetime
					// More info:
					// https://kubernetes.io/docs/concepts/storage/volumes#nfs
					nfs?: {
						// path that is exported by the NFS server.
						// More info:
						// https://kubernetes.io/docs/concepts/storage/volumes#nfs
						path!: string

						// readOnly here will force the NFS export to be mounted with
						// read-only permissions.
						// Defaults to false.
						// More info:
						// https://kubernetes.io/docs/concepts/storage/volumes#nfs
						readOnly?: bool

						// server is the hostname or IP address of the NFS server.
						// More info:
						// https://kubernetes.io/docs/concepts/storage/volumes#nfs
						server!: string
					}

					// persistentVolumeClaimVolumeSource represents a reference to a
					// PersistentVolumeClaim in the same namespace.
					// More info:
					// https://kubernetes.io/docs/concepts/storage/persistent-volumes#persistentvolumeclaims
					persistentVolumeClaim?: {
						// claimName is the name of a PersistentVolumeClaim in the same
						// namespace as the pod using this volume.
						// More info:
						// https://kubernetes.io/docs/concepts/storage/persistent-volumes#persistentvolumeclaims
						claimName!: string

						// readOnly Will force the ReadOnly setting in VolumeMounts.
						// Default false.
						readOnly?: bool
					}

					// photonPersistentDisk represents a PhotonController persistent
					// disk attached and mounted on kubelets host machine.
					// Deprecated: PhotonPersistentDisk is deprecated and the in-tree
					// photonPersistentDisk type is no longer supported.
					photonPersistentDisk?: {
						// fsType is the filesystem type to mount.
						// Must be a filesystem type supported by the host operating
						// system.
						// Ex. "ext4", "xfs", "ntfs". Implicitly inferred to be "ext4" if
						// unspecified.
						fsType?: string

						// pdID is the ID that identifies Photon Controller persistent
						// disk
						pdID!: string
					}

					// portworxVolume represents a portworx volume attached and
					// mounted on kubelets host machine.
					// Deprecated: PortworxVolume is deprecated. All operations for
					// the in-tree portworxVolume type
					// are redirected to the pxd.portworx.com CSI driver when the
					// CSIMigrationPortworx feature-gate
					// is on.
					portworxVolume?: {
						// fSType represents the filesystem type to mount
						// Must be a filesystem type supported by the host operating
						// system.
						// Ex. "ext4", "xfs". Implicitly inferred to be "ext4" if
						// unspecified.
						fsType?: string

						// readOnly defaults to false (read/write). ReadOnly here will
						// force
						// the ReadOnly setting in VolumeMounts.
						readOnly?: bool

						// volumeID uniquely identifies a Portworx volume
						volumeID!: string
					}

					// projected items for all in one resources secrets, configmaps,
					// and downward API
					projected?: {
						// defaultMode are the mode bits used to set permissions on
						// created files by default.
						// Must be an octal value between 0000 and 0777 or a decimal value
						// between 0 and 511.
						// YAML accepts both octal and decimal values, JSON requires
						// decimal values for mode bits.
						// Directories within the path are not affected by this setting.
						// This might be in conflict with other options that affect the
						// file
						// mode, like fsGroup, and the result can be other mode bits set.
						defaultMode?: int32 & int

						// sources is the list of volume projections. Each entry in this
						// list
						// handles one source.
						sources?: [...{
							// ClusterTrustBundle allows a pod to access the
							// `.spec.trustBundle` field
							// of ClusterTrustBundle objects in an auto-updating file.
							//
							// Alpha, gated by the ClusterTrustBundleProjection feature gate.
							//
							// ClusterTrustBundle objects can either be selected by name, or
							// by the
							// combination of signer name and a label selector.
							//
							// Kubelet performs aggressive normalization of the PEM contents
							// written
							// into the pod filesystem. Esoteric PEM features such as
							// inter-block
							// comments and block headers are stripped. Certificates are
							// deduplicated.
							// The ordering of certificates within the file is arbitrary, and
							// Kubelet
							// may change the order over time.
							clusterTrustBundle?: {
								// Select all ClusterTrustBundles that match this label selector.
								// Only has
								// effect if signerName is set. Mutually-exclusive with name. If
								// unset,
								// interpreted as "match nothing". If set but empty, interpreted
								// as "match
								// everything".
								labelSelector?: {
									// matchExpressions is a list of label selector requirements. The
									// requirements are ANDed.
									matchExpressions?: [...{
										// key is the label key that the selector applies to.
										key!: string

										// operator represents a key's relationship to a set of values.
										// Valid operators are In, NotIn, Exists and DoesNotExist.
										operator!: string

										// values is an array of string values. If the operator is In or
										// NotIn,
										// the values array must be non-empty. If the operator is Exists
										// or DoesNotExist,
										// the values array must be empty. This array is replaced during a
										// strategic
										// merge patch.
										values?: [...string]
									}]

									// matchLabels is a map of {key,value} pairs. A single {key,value}
									// in the matchLabels
									// map is equivalent to an element of matchExpressions, whose key
									// field is "key", the
									// operator is "In", and the values array contains only "value".
									// The requirements are ANDed.
									matchLabels?: [string]: string
								}

								// Select a single ClusterTrustBundle by object name.
								// Mutually-exclusive
								// with signerName and labelSelector.
								name?: string

								// If true, don't block pod startup if the referenced
								// ClusterTrustBundle(s)
								// aren't available. If using name, then the named
								// ClusterTrustBundle is
								// allowed not to exist. If using signerName, then the combination
								// of
								// signerName and labelSelector is allowed to match zero
								// ClusterTrustBundles.
								optional?: bool

								// Relative path from the volume root to write the bundle.
								path!: string

								// Select all ClusterTrustBundles that match this signer name.
								// Mutually-exclusive with name. The contents of all selected
								// ClusterTrustBundles will be unified and deduplicated.
								signerName?: string
							}

							// configMap information about the configMap data to project
							configMap?: {
								// items if unspecified, each key-value pair in the Data field of
								// the referenced
								// ConfigMap will be projected into the volume as a file whose
								// name is the
								// key and content is the value. If specified, the listed keys
								// will be
								// projected into the specified paths, and unlisted keys will not
								// be
								// present. If a key is specified which is not present in the
								// ConfigMap,
								// the volume setup will error unless it is marked optional. Paths
								// must be
								// relative and may not contain the '..' path or start with '..'.
								items?: [...{
									// key is the key to project.
									key!: string

									// mode is Optional: mode bits used to set permissions on this
									// file.
									// Must be an octal value between 0000 and 0777 or a decimal value
									// between 0 and 511.
									// YAML accepts both octal and decimal values, JSON requires
									// decimal values for mode bits.
									// If not specified, the volume defaultMode will be used.
									// This might be in conflict with other options that affect the
									// file
									// mode, like fsGroup, and the result can be other mode bits set.
									mode?: int32 & int

									// path is the relative path of the file to map the key to.
									// May not be an absolute path.
									// May not contain the path element '..'.
									// May not start with the string '..'.
									path!: string
								}]

								// Name of the referent.
								// This field is effectively required, but due to backwards
								// compatibility is
								// allowed to be empty. Instances of this type with an empty value
								// here are
								// almost certainly wrong.
								// More info:
								// https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
								name?: string

								// optional specify whether the ConfigMap or its keys must be
								// defined
								optional?: bool
							}

							// downwardAPI information about the downwardAPI data to project
							downwardAPI?: {
								// Items is a list of DownwardAPIVolume file
								items?: [...{
									// Required: Selects a field of the pod: only annotations, labels,
									// name, namespace and uid are supported.
									fieldRef?: {
										// Version of the schema the FieldPath is written in terms of,
										// defaults to "v1".
										apiVersion?: string

										// Path of the field to select in the specified API version.
										fieldPath!: string
									}

									// Optional: mode bits used to set permissions on this file, must
									// be an octal value
									// between 0000 and 0777 or a decimal value between 0 and 511.
									// YAML accepts both octal and decimal values, JSON requires
									// decimal values for mode bits.
									// If not specified, the volume defaultMode will be used.
									// This might be in conflict with other options that affect the
									// file
									// mode, like fsGroup, and the result can be other mode bits set.
									mode?: int32 & int

									// Required: Path is the relative path name of the file to be
									// created. Must not be absolute or contain the '..' path. Must
									// be utf-8 encoded. The first item of the relative path must not
									// start with '..'
									path!: string

									// Selects a resource of the container: only resources limits and
									// requests
									// (limits.cpu, limits.memory, requests.cpu and requests.memory)
									// are currently supported.
									resourceFieldRef?: {
										// Container name: required for volumes, optional for env vars
										containerName?: string

										// Specifies the output format of the exposed resources, defaults
										// to "1"
										divisor?: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")

										// Required: resource to select
										resource!: string
									}
								}]
							}

							// Projects an auto-rotating credential bundle (private key and
							// certificate
							// chain) that the pod can use either as a TLS client or server.
							//
							// Kubelet generates a private key and uses it to send a
							// PodCertificateRequest to the named signer. Once the signer
							// approves the
							// request and issues a certificate chain, Kubelet writes the key
							// and
							// certificate chain to the pod filesystem. The pod does not start
							// until
							// certificates have been issued for each podCertificate projected
							// volume
							// source in its spec.
							//
							// Kubelet will begin trying to rotate the certificate at the time
							// indicated
							// by the signer using the
							// PodCertificateRequest.Status.BeginRefreshAt
							// timestamp.
							//
							// Kubelet can write a single file, indicated by the
							// credentialBundlePath
							// field, or separate files, indicated by the keyPath and
							// certificateChainPath fields.
							//
							// The credential bundle is a single file in PEM format. The first
							// PEM
							// entry is the private key (in PKCS#8 format), and the remaining
							// PEM
							// entries are the certificate chain issued by the signer
							// (typically,
							// signers will return their certificate chain in leaf-to-root
							// order).
							//
							// Prefer using the credential bundle format, since your
							// application code
							// can read it atomically. If you use keyPath and
							// certificateChainPath,
							// your application must make two separate file reads. If these
							// coincide
							// with a certificate rotation, it is possible that the private
							// key and leaf
							// certificate you read may not correspond to each other. Your
							// application
							// will need to check for this condition, and re-read until they
							// are
							// consistent.
							//
							// The named signer controls chooses the format of the certificate
							// it
							// issues; consult the signer implementation's documentation to
							// learn how to
							// use the certificates it issues.
							podCertificate?: {
								// Write the certificate chain at this path in the projected
								// volume.
								//
								// Most applications should use credentialBundlePath. When using
								// keyPath
								// and certificateChainPath, your application needs to check that
								// the key
								// and leaf certificate are consistent, because it is possible to
								// read the
								// files mid-rotation.
								certificateChainPath?: string

								// Write the credential bundle at this path in the projected
								// volume.
								//
								// The credential bundle is a single file that contains multiple
								// PEM blocks.
								// The first PEM block is a PRIVATE KEY block, containing a PKCS#8
								// private
								// key.
								//
								// The remaining blocks are CERTIFICATE blocks, containing the
								// issued
								// certificate chain from the signer (leaf and any intermediates).
								//
								// Using credentialBundlePath lets your Pod's application code
								// make a single
								// atomic read that retrieves a consistent key and certificate
								// chain. If you
								// project them to separate files, your application code will need
								// to
								// additionally check that the leaf certificate was issued to the
								// key.
								credentialBundlePath?: string

								// Write the key at this path in the projected volume.
								//
								// Most applications should use credentialBundlePath. When using
								// keyPath
								// and certificateChainPath, your application needs to check that
								// the key
								// and leaf certificate are consistent, because it is possible to
								// read the
								// files mid-rotation.
								keyPath?: string

								// The type of keypair Kubelet will generate for the pod.
								//
								// Valid values are "RSA3072", "RSA4096", "ECDSAP256",
								// "ECDSAP384",
								// "ECDSAP521", and "ED25519".
								keyType!: string

								// maxExpirationSeconds is the maximum lifetime permitted for the
								// certificate.
								//
								// Kubelet copies this value verbatim into the
								// PodCertificateRequests it
								// generates for this projection.
								//
								// If omitted, kube-apiserver will set it to 86400(24 hours).
								// kube-apiserver
								// will reject values shorter than 3600 (1 hour). The maximum
								// allowable
								// value is 7862400 (91 days).
								//
								// The signer implementation is then free to issue a certificate
								// with any
								// lifetime *shorter* than MaxExpirationSeconds, but no shorter
								// than 3600
								// seconds (1 hour). This constraint is enforced by
								// kube-apiserver.
								// `kubernetes.io` signers will never issue certificates with a
								// lifetime
								// longer than 24 hours.
								maxExpirationSeconds?: int32 & int

								// Kubelet's generated CSRs will be addressed to this signer.
								signerName!: string

								// userAnnotations allow pod authors to pass additional
								// information to
								// the signer implementation. Kubernetes does not restrict or
								// validate this
								// metadata in any way.
								//
								// These values are copied verbatim into the
								// `spec.unverifiedUserAnnotations` field of
								// the PodCertificateRequest objects that Kubelet creates.
								//
								// Entries are subject to the same validation as object metadata
								// annotations,
								// with the addition that all keys must be domain-prefixed. No
								// restrictions
								// are placed on values, except an overall size limitation on the
								// entire field.
								//
								// Signers should document the keys and values they support.
								// Signers should
								// deny requests that contain keys they do not recognize.
								userAnnotations?: [string]: string
							}

							// secret information about the secret data to project
							secret?: {
								// items if unspecified, each key-value pair in the Data field of
								// the referenced
								// Secret will be projected into the volume as a file whose name
								// is the
								// key and content is the value. If specified, the listed keys
								// will be
								// projected into the specified paths, and unlisted keys will not
								// be
								// present. If a key is specified which is not present in the
								// Secret,
								// the volume setup will error unless it is marked optional. Paths
								// must be
								// relative and may not contain the '..' path or start with '..'.
								items?: [...{
									// key is the key to project.
									key!: string

									// mode is Optional: mode bits used to set permissions on this
									// file.
									// Must be an octal value between 0000 and 0777 or a decimal value
									// between 0 and 511.
									// YAML accepts both octal and decimal values, JSON requires
									// decimal values for mode bits.
									// If not specified, the volume defaultMode will be used.
									// This might be in conflict with other options that affect the
									// file
									// mode, like fsGroup, and the result can be other mode bits set.
									mode?: int32 & int

									// path is the relative path of the file to map the key to.
									// May not be an absolute path.
									// May not contain the path element '..'.
									// May not start with the string '..'.
									path!: string
								}]

								// Name of the referent.
								// This field is effectively required, but due to backwards
								// compatibility is
								// allowed to be empty. Instances of this type with an empty value
								// here are
								// almost certainly wrong.
								// More info:
								// https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
								name?: string

								// optional field specify whether the Secret or its key must be
								// defined
								optional?: bool
							}

							// serviceAccountToken is information about the
							// serviceAccountToken data to project
							serviceAccountToken?: {
								// audience is the intended audience of the token. A recipient of
								// a token
								// must identify itself with an identifier specified in the
								// audience of the
								// token, and otherwise should reject the token. The audience
								// defaults to the
								// identifier of the apiserver.
								audience?: string

								// expirationSeconds is the requested duration of validity of the
								// service
								// account token. As the token approaches expiration, the kubelet
								// volume
								// plugin will proactively rotate the service account token. The
								// kubelet will
								// start trying to rotate the token if the token is older than 80
								// percent of
								// its time to live or if the token is older than 24
								// hours.Defaults to 1 hour
								// and must be at least 10 minutes.
								expirationSeconds?: int64 & int

								// path is the path relative to the mount point of the file to
								// project the
								// token into.
								path!: string
							}
						}]
					}

					// quobyte represents a Quobyte mount on the host that shares a
					// pod's lifetime.
					// Deprecated: Quobyte is deprecated and the in-tree quobyte type
					// is no longer supported.
					quobyte?: {
						// group to map volume access to
						// Default is no group
						group?: string

						// readOnly here will force the Quobyte volume to be mounted with
						// read-only permissions.
						// Defaults to false.
						readOnly?: bool

						// registry represents a single or multiple Quobyte Registry
						// services
						// specified as a string as host:port pair (multiple entries are
						// separated with commas)
						// which acts as the central registry for volumes
						registry!: string

						// tenant owning the given Quobyte volume in the Backend
						// Used with dynamically provisioned Quobyte volumes, value is set
						// by the plugin
						tenant?: string

						// user to map volume access to
						// Defaults to serivceaccount user
						user?: string

						// volume is a string that references an already created Quobyte
						// volume by name.
						volume!: string
					}

					// rbd represents a Rados Block Device mount on the host that
					// shares a pod's lifetime.
					// Deprecated: RBD is deprecated and the in-tree rbd type is no
					// longer supported.
					rbd?: {
						// fsType is the filesystem type of the volume that you want to
						// mount.
						// Tip: Ensure that the filesystem type is supported by the host
						// operating system.
						// Examples: "ext4", "xfs", "ntfs". Implicitly inferred to be
						// "ext4" if unspecified.
						// More info:
						// https://kubernetes.io/docs/concepts/storage/volumes#rbd
						fsType?: string

						// image is the rados image name.
						// More info:
						// https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it
						image!: string

						// keyring is the path to key ring for RBDUser.
						// Default is /etc/ceph/keyring.
						// More info:
						// https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it
						keyring?: string

						// monitors is a collection of Ceph monitors.
						// More info:
						// https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it
						monitors!: [...string]

						// pool is the rados pool name.
						// Default is rbd.
						// More info:
						// https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it
						pool?: string

						// readOnly here will force the ReadOnly setting in VolumeMounts.
						// Defaults to false.
						// More info:
						// https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it
						readOnly?: bool

						// secretRef is name of the authentication secret for RBDUser. If
						// provided
						// overrides keyring.
						// Default is nil.
						// More info:
						// https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it
						secretRef?: {
							// Name of the referent.
							// This field is effectively required, but due to backwards
							// compatibility is
							// allowed to be empty. Instances of this type with an empty value
							// here are
							// almost certainly wrong.
							// More info:
							// https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
							name?: string
						}

						// user is the rados user name.
						// Default is admin.
						// More info:
						// https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it
						user?: string
					}

					// scaleIO represents a ScaleIO persistent volume attached and
					// mounted on Kubernetes nodes.
					// Deprecated: ScaleIO is deprecated and the in-tree scaleIO type
					// is no longer supported.
					scaleIO?: {
						// fsType is the filesystem type to mount.
						// Must be a filesystem type supported by the host operating
						// system.
						// Ex. "ext4", "xfs", "ntfs".
						// Default is "xfs".
						fsType?: string

						// gateway is the host address of the ScaleIO API Gateway.
						gateway!: string

						// protectionDomain is the name of the ScaleIO Protection Domain
						// for the configured storage.
						protectionDomain?: string

						// readOnly Defaults to false (read/write). ReadOnly here will
						// force
						// the ReadOnly setting in VolumeMounts.
						readOnly?: bool

						// secretRef references to the secret for ScaleIO user and other
						// sensitive information. If this is not provided, Login operation
						// will fail.
						secretRef!: {
							// Name of the referent.
							// This field is effectively required, but due to backwards
							// compatibility is
							// allowed to be empty. Instances of this type with an empty value
							// here are
							// almost certainly wrong.
							// More info:
							// https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
							name?: string
						}

						// sslEnabled Flag enable/disable SSL communication with Gateway,
						// default false
						sslEnabled?: bool

						// storageMode indicates whether the storage for a volume should
						// be ThickProvisioned or ThinProvisioned.
						// Default is ThinProvisioned.
						storageMode?: string

						// storagePool is the ScaleIO Storage Pool associated with the
						// protection domain.
						storagePool?: string

						// system is the name of the storage system as configured in
						// ScaleIO.
						system!: string

						// volumeName is the name of a volume already created in the
						// ScaleIO system
						// that is associated with this volume source.
						volumeName?: string
					}

					// secret represents a secret that should populate this volume.
					// More info:
					// https://kubernetes.io/docs/concepts/storage/volumes#secret
					secret?: {
						// defaultMode is Optional: mode bits used to set permissions on
						// created files by default.
						// Must be an octal value between 0000 and 0777 or a decimal value
						// between 0 and 511.
						// YAML accepts both octal and decimal values, JSON requires
						// decimal values
						// for mode bits. Defaults to 0644.
						// Directories within the path are not affected by this setting.
						// This might be in conflict with other options that affect the
						// file
						// mode, like fsGroup, and the result can be other mode bits set.
						defaultMode?: int32 & int

						// items If unspecified, each key-value pair in the Data field of
						// the referenced
						// Secret will be projected into the volume as a file whose name
						// is the
						// key and content is the value. If specified, the listed keys
						// will be
						// projected into the specified paths, and unlisted keys will not
						// be
						// present. If a key is specified which is not present in the
						// Secret,
						// the volume setup will error unless it is marked optional. Paths
						// must be
						// relative and may not contain the '..' path or start with '..'.
						items?: [...{
							// key is the key to project.
							key!: string

							// mode is Optional: mode bits used to set permissions on this
							// file.
							// Must be an octal value between 0000 and 0777 or a decimal value
							// between 0 and 511.
							// YAML accepts both octal and decimal values, JSON requires
							// decimal values for mode bits.
							// If not specified, the volume defaultMode will be used.
							// This might be in conflict with other options that affect the
							// file
							// mode, like fsGroup, and the result can be other mode bits set.
							mode?: int32 & int

							// path is the relative path of the file to map the key to.
							// May not be an absolute path.
							// May not contain the path element '..'.
							// May not start with the string '..'.
							path!: string
						}]

						// optional field specify whether the Secret or its keys must be
						// defined
						optional?: bool

						// secretName is the name of the secret in the pod's namespace to
						// use.
						// More info:
						// https://kubernetes.io/docs/concepts/storage/volumes#secret
						secretName?: string
					}

					// storageOS represents a StorageOS volume attached and mounted on
					// Kubernetes nodes.
					// Deprecated: StorageOS is deprecated and the in-tree storageos
					// type is no longer supported.
					storageos?: {
						// fsType is the filesystem type to mount.
						// Must be a filesystem type supported by the host operating
						// system.
						// Ex. "ext4", "xfs", "ntfs". Implicitly inferred to be "ext4" if
						// unspecified.
						fsType?: string

						// readOnly defaults to false (read/write). ReadOnly here will
						// force
						// the ReadOnly setting in VolumeMounts.
						readOnly?: bool

						// secretRef specifies the secret to use for obtaining the
						// StorageOS API
						// credentials. If not specified, default values will be
						// attempted.
						secretRef?: {
							// Name of the referent.
							// This field is effectively required, but due to backwards
							// compatibility is
							// allowed to be empty. Instances of this type with an empty value
							// here are
							// almost certainly wrong.
							// More info:
							// https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
							name?: string
						}

						// volumeName is the human-readable name of the StorageOS volume.
						// Volume
						// names are only unique within a namespace.
						volumeName?: string

						// volumeNamespace specifies the scope of the volume within
						// StorageOS. If no
						// namespace is specified then the Pod's namespace will be used.
						// This allows the
						// Kubernetes name scoping to be mirrored within StorageOS for
						// tighter integration.
						// Set VolumeName to any name to override the default behaviour.
						// Set to "default" if you are not using namespaces within
						// StorageOS.
						// Namespaces that do not pre-exist within StorageOS will be
						// created.
						volumeNamespace?: string
					}

					// vsphereVolume represents a vSphere volume attached and mounted
					// on kubelets host machine.
					// Deprecated: VsphereVolume is deprecated. All operations for the
					// in-tree vsphereVolume type
					// are redirected to the csi.vsphere.vmware.com CSI driver.
					vsphereVolume?: {
						// fsType is filesystem type to mount.
						// Must be a filesystem type supported by the host operating
						// system.
						// Ex. "ext4", "xfs", "ntfs". Implicitly inferred to be "ext4" if
						// unspecified.
						fsType?: string

						// storagePolicyID is the storage Policy Based Management (SPBM)
						// profile ID associated with the StoragePolicyName.
						storagePolicyID?: string

						// storagePolicyName is the storage Policy Based Management (SPBM)
						// profile name.
						storagePolicyName?: string

						// volumePath is the path that identifies vSphere volume vmdk
						volumePath!: string
					}
				}]

				// WorkloadRef provides a reference to the Workload object that
				// this Pod belongs to.
				// This field is used by the scheduler to identify the PodGroup
				// and apply the
				// correct group scheduling policies. The Workload object
				// referenced
				// by this field may not exist at the time the Pod is created.
				// This field is immutable, but a Workload object with the same
				// name
				// may be recreated with different policies. Doing this during pod
				// scheduling
				// may result in the placement not conforming to the expected
				// policies.
				workloadRef?: {
					// Name defines the name of the Workload object this Pod belongs
					// to.
					// Workload must be in the same namespace as the Pod.
					// If it doesn't match any existing Workload, the Pod will remain
					// unschedulable
					// until a Workload object is created and observed by the
					// kube-scheduler.
					// It must be a DNS subdomain.
					name!: string

					// PodGroup is the name of the PodGroup within the Workload that
					// this Pod
					// belongs to. If it doesn't match any existing PodGroup within
					// the Workload,
					// the Pod will remain unschedulable until the Workload object is
					// recreated
					// and observed by the kube-scheduler. It must be a DNS label.
					podGroup!: string

					// PodGroupReplicaKey specifies the replica key of the PodGroup to
					// which this
					// Pod belongs. It is used to distinguish pods belonging to
					// different replicas
					// of the same pod group. The pod group policy is applied
					// separately to each replica.
					// When set, it must be a DNS label.
					podGroupReplicaKey?: string
				}
			}
		}

		// Type of service to forward traffic to. Default: `rw`.
		type?: "rw" | "ro" | "r"
	}

	// Most recently observed status of the Pooler. This data may not
	// be up to
	// date. Populated by the system. Read-only.
	// More info:
	// https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status
	status?: {
		// The number of pods trying to be scheduled
		instances?: int32 & int

		// The resource version of the config object
		secrets?: {
			// The client CA secret version
			clientCA?: {
				// The name of the secret
				name?: string

				// The ResourceVersion of the secret
				version?: string
			}

			// The client TLS secret version
			clientTLS?: {
				// The name of the secret
				name?: string

				// The ResourceVersion of the secret
				version?: string
			}

			// The version of the secrets used by PgBouncer
			pgBouncerSecrets?: {
				// The auth query secret version
				authQuery?: {
					// The name of the secret
					name?: string

					// The ResourceVersion of the secret
					version?: string
				}
			}

			// The server CA secret version
			serverCA?: {
				// The name of the secret
				name?: string

				// The ResourceVersion of the secret
				version?: string
			}

			// The server TLS secret version
			serverTLS?: {
				// The name of the secret
				name?: string

				// The ResourceVersion of the secret
				version?: string
			}
		}
	}

	_embeddedResource: {
		apiVersion!: string
		kind!:       string
		metadata?: {
			...
		}
	}
	apiVersion: "postgresql.cnpg.io/v1"
	kind:       "Pooler"
	metadata!: {
		name!:      string
		namespace!: string
		labels?: [string]: string
		annotations?: [string]: string
		...
	}
}
