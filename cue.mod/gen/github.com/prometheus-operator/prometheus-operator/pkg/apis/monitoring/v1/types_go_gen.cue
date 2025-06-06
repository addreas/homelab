// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/prometheus-operator/prometheus-operator/pkg/apis/monitoring/v1

package v1

import (
	"k8s.io/api/core/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
	"k8s.io/apimachinery/pkg/util/intstr"
	"k8s.io/apimachinery/pkg/api/resource"
)

#Version: "v1"

// ByteSize is a valid memory size type based on powers-of-2, so 1KB is 1024B.
// Supported units: B, KB, KiB, MB, MiB, GB, GiB, TB, TiB, PB, PiB, EB, EiB Ex: `512MB`.
// +kubebuilder:validation:Pattern:="(^0|([0-9]*[.])?[0-9]+((K|M|G|T|E|P)i?)?B)$"
#ByteSize: string

// Duration is a valid time duration that can be parsed by Prometheus model.ParseDuration() function.
// Supported units: y, w, d, h, m, s, ms
// Examples: `30s`, `1m`, `1h20m15s`, `15d`
// +kubebuilder:validation:Pattern:="^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
#Duration: string

// NonEmptyDuration is a valid time duration that can be parsed by Prometheus model.ParseDuration() function.
// Compared to Duration,  NonEmptyDuration enforces a minimum length of 1.
// Supported units: y, w, d, h, m, s, ms
// Examples: `30s`, `1m`, `1h20m15s`, `15d`
// +kubebuilder:validation:Pattern:="^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
// +kubebuilder:validation:MinLength=1
#NonEmptyDuration: string

// GoDuration is a valid time duration that can be parsed by Go's time.ParseDuration() function.
// Supported units: h, m, s, ms
// Examples: `45ms`, `30s`, `1m`, `1h20m15s`
// +kubebuilder:validation:Pattern:="^(0|(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
#GoDuration: string

// HostAlias holds the mapping between IP and hostnames that will be injected as an entry in the
// pod's hosts file.
#HostAlias: {
	// IP address of the host file entry.
	// +kubebuilder:validation:Required
	ip: string @go(IP)

	// Hostnames for the above IP address.
	// +kubebuilder:validation:Required
	hostnames: [...string] @go(Hostnames,[]string)
}

// PrometheusRuleExcludeConfig enables users to configure excluded
// PrometheusRule names and their namespaces to be ignored while enforcing
// namespace label for alerts and metrics.
#PrometheusRuleExcludeConfig: {
	// Namespace of the excluded PrometheusRule object.
	ruleNamespace: string @go(RuleNamespace)

	// Name of the excluded PrometheusRule object.
	ruleName: string @go(RuleName)
}

#ProxyConfig: {
	// `proxyURL` defines the HTTP proxy server to use.
	//
	// +kubebuilder:validation:Pattern:="^(http|https|socks5)://.+$"
	// +optional
	proxyUrl?: null | string @go(ProxyURL,*string)

	// `noProxy` is a comma-separated string that can contain IPs, CIDR notation, domain names
	// that should be excluded from proxying. IP and domain names can
	// contain port numbers.
	//
	// It requires Prometheus >= v2.43.0, Alertmanager >= v0.25.0 or Thanos >= v0.32.0.
	// +optional
	noProxy?: null | string @go(NoProxy,*string)

	// Whether to use the proxy configuration defined by environment variables (HTTP_PROXY, HTTPS_PROXY, and NO_PROXY).
	//
	// It requires Prometheus >= v2.43.0, Alertmanager >= v0.25.0 or Thanos >= v0.32.0.
	// +optional
	proxyFromEnvironment?: null | bool @go(ProxyFromEnvironment,*bool)

	// ProxyConnectHeader optionally specifies headers to send to
	// proxies during CONNECT requests.
	//
	// It requires Prometheus >= v2.43.0, Alertmanager >= v0.25.0 or Thanos >= v0.32.0.
	// +optional
	// +mapType:=atomic
	proxyConnectHeader?: {[string]: [...v1.#SecretKeySelector]} @go(ProxyConnectHeader,map[string][]v1.SecretKeySelector)
}

// ObjectReference references a PodMonitor, ServiceMonitor, Probe or PrometheusRule object.
#ObjectReference: {
	// Group of the referent. When not specified, it defaults to `monitoring.coreos.com`
	// +optional
	// +kubebuilder:default:="monitoring.coreos.com"
	// +kubebuilder:validation:Enum=monitoring.coreos.com
	group?: string @go(Group)

	// Resource of the referent.
	// +kubebuilder:validation:Required
	// +kubebuilder:validation:Enum=prometheusrules;servicemonitors;podmonitors;probes;scrapeconfigs
	resource: string @go(Resource)

	// Namespace of the referent.
	// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/
	// +kubebuilder:validation:Required
	// +kubebuilder:validation:MinLength=1
	namespace: string @go(Namespace)

	// Name of the referent. When not set, all resources in the namespace are matched.
	// +optional
	name?: string @go(Name)
}

// ArbitraryFSAccessThroughSMsConfig enables users to configure, whether
// a service monitor selected by the Prometheus instance is allowed to use
// arbitrary files on the file system of the Prometheus container. This is the case
// when e.g. a service monitor specifies a BearerTokenFile in an endpoint. A
// malicious user could create a service monitor selecting arbitrary secret files
// in the Prometheus container. Those secrets would then be sent with a scrape
// request by Prometheus to a malicious target. Denying the above would prevent the
// attack, users can instead use the BearerTokenSecret field.
#ArbitraryFSAccessThroughSMsConfig: {
	deny?: bool @go(Deny)
}

// Condition represents the state of the resources associated with the
// Prometheus, Alertmanager or ThanosRuler resource.
// +k8s:deepcopy-gen=true
#Condition: {
	// Type of the condition being reported.
	// +required
	type: #ConditionType @go(Type)

	// Status of the condition.
	// +required
	status: #ConditionStatus @go(Status)

	// lastTransitionTime is the time of the last update to the current status property.
	// +required
	lastTransitionTime: metav1.#Time @go(LastTransitionTime)

	// Reason for the condition's last transition.
	// +optional
	reason?: string @go(Reason)

	// Human-readable message indicating details for the condition's last transition.
	// +optional
	message?: string @go(Message)

	// ObservedGeneration represents the .metadata.generation that the
	// condition was set based upon. For instance, if `.metadata.generation` is
	// currently 12, but the `.status.conditions[].observedGeneration` is 9, the
	// condition is out of date with respect to the current state of the
	// instance.
	observedGeneration?: int64 @go(ObservedGeneration)
}

// +kubebuilder:validation:MinLength=1
#ConditionType: string // #enumConditionType

#enumConditionType:
	#Available |
	#Reconciled

// Available indicates whether enough pods are ready to provide the
// service.
// The possible status values for this condition type are:
// - True: all pods are running and ready, the service is fully available.
// - Degraded: some pods aren't ready, the service is partially available.
// - False: no pods are running, the service is totally unavailable.
// - Unknown: the operator couldn't determine the condition status.
#Available: #ConditionType & "Available"

// Reconciled indicates whether the operator has reconciled the state of
// the underlying resources with the object's spec.
// The possible status values for this condition type are:
// - True: the reconciliation was successful.
// - False: the reconciliation failed.
// - Unknown: the operator couldn't determine the condition status.
#Reconciled: #ConditionType & "Reconciled"

// +kubebuilder:validation:MinLength=1
#ConditionStatus: string // #enumConditionStatus

#enumConditionStatus:
	#ConditionTrue |
	#ConditionDegraded |
	#ConditionFalse |
	#ConditionUnknown

#ConditionTrue:     #ConditionStatus & "True"
#ConditionDegraded: #ConditionStatus & "Degraded"
#ConditionFalse:    #ConditionStatus & "False"
#ConditionUnknown:  #ConditionStatus & "Unknown"

// EmbeddedPersistentVolumeClaim is an embedded version of k8s.io/api/core/v1.PersistentVolumeClaim.
// It contains TypeMeta and a reduced ObjectMeta.
#EmbeddedPersistentVolumeClaim: {
	metav1.#TypeMeta

	// EmbeddedMetadata contains metadata relevant to an EmbeddedResource.
	metadata?: #EmbeddedObjectMetadata @go(EmbeddedObjectMetadata) @protobuf(1,bytes,opt)

	// Defines the desired characteristics of a volume requested by a pod author.
	// More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#persistentvolumeclaims
	// +optional
	spec?: v1.#PersistentVolumeClaimSpec @go(Spec) @protobuf(2,bytes,opt)

	// +optional
	// Deprecated: this field is never set.
	status?: v1.#PersistentVolumeClaimStatus @go(Status) @protobuf(3,bytes,opt)
}

// EmbeddedObjectMetadata contains a subset of the fields included in k8s.io/apimachinery/pkg/apis/meta/v1.ObjectMeta
// Only fields which are relevant to embedded resources are included.
#EmbeddedObjectMetadata: {
	// Name must be unique within a namespace. Is required when creating resources, although
	// some resources may allow a client to request the generation of an appropriate name
	// automatically. Name is primarily intended for creation idempotence and configuration
	// definition.
	// Cannot be updated.
	// More info: http://kubernetes.io/docs/user-guide/identifiers#names
	// +optional
	name?: string @go(Name) @protobuf(1,bytes,opt)

	// Map of string keys and values that can be used to organize and categorize
	// (scope and select) objects. May match selectors of replication controllers
	// and services.
	// More info: http://kubernetes.io/docs/user-guide/labels
	// +optional
	labels?: {[string]: string} @go(Labels,map[string]string) @protobuf(11,bytes,rep)

	// Annotations is an unstructured key value map stored with a resource that may be
	// set by external tools to store and retrieve arbitrary metadata. They are not
	// queryable and should be preserved when modifying objects.
	// More info: http://kubernetes.io/docs/user-guide/annotations
	// +optional
	annotations?: {[string]: string} @go(Annotations,map[string]string) @protobuf(12,bytes,rep)
}

// WebConfigFileFields defines the file content for --web.config.file flag.
// +k8s:deepcopy-gen=true
#WebConfigFileFields: {
	// Defines the TLS parameters for HTTPS.
	tlsConfig?: null | #WebTLSConfig @go(TLSConfig,*WebTLSConfig)

	// Defines HTTP parameters for web server.
	httpConfig?: null | #WebHTTPConfig @go(HTTPConfig,*WebHTTPConfig)
}

// WebHTTPConfig defines HTTP parameters for web server.
// +k8s:openapi-gen=true
#WebHTTPConfig: {
	// Enable HTTP/2 support. Note that HTTP/2 is only supported with TLS.
	// When TLSConfig is not configured, HTTP/2 will be disabled.
	// Whenever the value of the field changes, a rolling update will be triggered.
	http2?: null | bool @go(HTTP2,*bool)

	// List of headers that can be added to HTTP responses.
	headers?: null | #WebHTTPHeaders @go(Headers,*WebHTTPHeaders)
}

// WebHTTPHeaders defines the list of headers that can be added to HTTP responses.
// +k8s:openapi-gen=true
#WebHTTPHeaders: {
	// Set the Content-Security-Policy header to HTTP responses.
	// Unset if blank.
	contentSecurityPolicy?: string @go(ContentSecurityPolicy)

	// Set the X-Frame-Options header to HTTP responses.
	// Unset if blank. Accepted values are deny and sameorigin.
	// https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/X-Frame-Options
	//+kubebuilder:validation:Enum="";Deny;SameOrigin
	xFrameOptions?: string @go(XFrameOptions)

	// Set the X-Content-Type-Options header to HTTP responses.
	// Unset if blank. Accepted value is nosniff.
	// https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/X-Content-Type-Options
	//+kubebuilder:validation:Enum="";NoSniff
	xContentTypeOptions?: string @go(XContentTypeOptions)

	// Set the X-XSS-Protection header to all responses.
	// Unset if blank.
	// https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/X-XSS-Protection
	xXSSProtection?: string @go(XXSSProtection)

	// Set the Strict-Transport-Security header to HTTP responses.
	// Unset if blank.
	// Please make sure that you use this with care as this header might force
	// browsers to load Prometheus and the other applications hosted on the same
	// domain and subdomains over HTTPS.
	// https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Strict-Transport-Security
	strictTransportSecurity?: string @go(StrictTransportSecurity)
}

// WebTLSConfig defines the TLS parameters for HTTPS.
// +k8s:openapi-gen=true
#WebTLSConfig: {
	// Secret or ConfigMap containing the TLS certificate for the web server.
	//
	// Either `keySecret` or `keyFile` must be defined.
	//
	// It is mutually exclusive with `certFile`.
	//
	// +optional
	cert?: #SecretOrConfigMap @go(Cert)

	// Path to the TLS certificate file in the container for the web server.
	//
	// Either `keySecret` or `keyFile` must be defined.
	//
	// It is mutually exclusive with `cert`.
	//
	// +optional
	certFile?: null | string @go(CertFile,*string)

	// Secret containing the TLS private key for the web server.
	//
	// Either `cert` or `certFile` must be defined.
	//
	// It is mutually exclusive with `keyFile`.
	//
	// +optional
	keySecret?: v1.#SecretKeySelector @go(KeySecret)

	// Path to the TLS private key file in the container for the web server.
	//
	// If defined, either `cert` or `certFile` must be defined.
	//
	// It is mutually exclusive with `keySecret`.
	//
	// +optional
	keyFile?: null | string @go(KeyFile,*string)

	// Secret or ConfigMap containing the CA certificate for client certificate
	// authentication to the server.
	//
	// It is mutually exclusive with `clientCAFile`.
	//
	// +optional
	client_ca?: #SecretOrConfigMap @go(ClientCA)

	// Path to the CA certificate file for client certificate authentication to
	// the server.
	//
	// It is mutually exclusive with `client_ca`.
	//
	// +optional
	clientCAFile?: null | string @go(ClientCAFile,*string)

	// The server policy for client TLS authentication.
	//
	// For more detail on clientAuth options:
	// https://golang.org/pkg/crypto/tls/#ClientAuthType
	//
	// +optional
	clientAuthType?: null | string @go(ClientAuthType,*string)

	// Minimum TLS version that is acceptable.
	//
	// +optional
	minVersion?: null | string @go(MinVersion,*string)

	// Maximum TLS version that is acceptable.
	//
	// +optional
	maxVersion?: null | string @go(MaxVersion,*string)

	// List of supported cipher suites for TLS versions up to TLS 1.2.
	//
	// If not defined, the Go default cipher suites are used.
	// Available cipher suites are documented in the Go documentation:
	// https://golang.org/pkg/crypto/tls/#pkg-constants
	//
	// +optional
	cipherSuites?: [...string] @go(CipherSuites,[]string)

	// Controls whether the server selects the client's most preferred cipher
	// suite, or the server's most preferred cipher suite.
	//
	// If true then the server's preference, as expressed in
	// the order of elements in cipherSuites, is used.
	//
	// +optional
	preferServerCipherSuites?: null | bool @go(PreferServerCipherSuites,*bool)

	// Elliptic curves that will be used in an ECDHE handshake, in preference
	// order.
	//
	// Available curves are documented in the Go documentation:
	// https://golang.org/pkg/crypto/tls/#CurveID
	//
	// +optional
	curvePreferences?: [...string] @go(CurvePreferences,[]string)
}

// LabelName is a valid Prometheus label name which may only contain ASCII
// letters, numbers, as well as underscores.
//
// +kubebuilder:validation:Pattern:="^[a-zA-Z_][a-zA-Z0-9_]*$"
#LabelName: string

// Endpoint defines an endpoint serving Prometheus metrics to be scraped by
// Prometheus.
//
// +k8s:openapi-gen=true
#Endpoint: {
	// Name of the Service port which this endpoint refers to.
	//
	// It takes precedence over `targetPort`.
	port?: string @go(Port)

	// Name or number of the target port of the `Pod` object behind the
	// Service. The port must be specified with the container's port property.
	//
	// +optional
	targetPort?: null | intstr.#IntOrString @go(TargetPort,*intstr.IntOrString)

	// HTTP path from which to scrape for metrics.
	//
	// If empty, Prometheus uses the default value (e.g. `/metrics`).
	path?: string @go(Path)

	// HTTP scheme to use for scraping.
	//
	// `http` and `https` are the expected values unless you rewrite the
	// `__scheme__` label via relabeling.
	//
	// If empty, Prometheus uses the default value `http`.
	//
	// +kubebuilder:validation:Enum=http;https
	scheme?: string @go(Scheme)

	// params define optional HTTP URL parameters.
	params?: {[string]: [...string]} @go(Params,map[string][]string)

	// Interval at which Prometheus scrapes the metrics from the target.
	//
	// If empty, Prometheus uses the global scrape interval.
	interval?: #Duration @go(Interval)

	// Timeout after which Prometheus considers the scrape to be failed.
	//
	// If empty, Prometheus uses the global scrape timeout unless it is less
	// than the target's scrape interval value in which the latter is used.
	// The value cannot be greater than the scrape interval otherwise the operator will reject the resource.
	scrapeTimeout?: #Duration @go(ScrapeTimeout)

	// TLS configuration to use when scraping the target.
	//
	// +optional
	tlsConfig?: null | #TLSConfig @go(TLSConfig,*TLSConfig)

	// File to read bearer token for scraping the target.
	//
	// Deprecated: use `authorization` instead.
	bearerTokenFile?: string @go(BearerTokenFile)

	// `bearerTokenSecret` specifies a key of a Secret containing the bearer
	// token for scraping targets. The secret needs to be in the same namespace
	// as the ServiceMonitor object and readable by the Prometheus Operator.
	//
	// +optional
	//
	// Deprecated: use `authorization` instead.
	bearerTokenSecret?: null | v1.#SecretKeySelector @go(BearerTokenSecret,*v1.SecretKeySelector)

	// `authorization` configures the Authorization header credentials to use when
	// scraping the target.
	//
	// Cannot be set at the same time as `basicAuth`, or `oauth2`.
	//
	// +optional
	authorization?: null | #SafeAuthorization @go(Authorization,*SafeAuthorization)

	// When true, `honorLabels` preserves the metric's labels when they collide
	// with the target's labels.
	honorLabels?: bool @go(HonorLabels)

	// `honorTimestamps` controls whether Prometheus preserves the timestamps
	// when exposed by the target.
	//
	// +optional
	honorTimestamps?: null | bool @go(HonorTimestamps,*bool)

	// `trackTimestampsStaleness` defines whether Prometheus tracks staleness of
	// the metrics that have an explicit timestamp present in scraped data.
	// Has no effect if `honorTimestamps` is false.
	//
	// It requires Prometheus >= v2.48.0.
	//
	// +optional
	trackTimestampsStaleness?: null | bool @go(TrackTimestampsStaleness,*bool)

	// `basicAuth` configures the Basic Authentication credentials to use when
	// scraping the target.
	//
	// Cannot be set at the same time as `authorization`, or `oauth2`.
	//
	// +optional
	basicAuth?: null | #BasicAuth @go(BasicAuth,*BasicAuth)

	// `oauth2` configures the OAuth2 settings to use when scraping the target.
	//
	// It requires Prometheus >= 2.27.0.
	//
	// Cannot be set at the same time as `authorization`, or `basicAuth`.
	//
	// +optional
	oauth2?: null | #OAuth2 @go(OAuth2,*OAuth2)

	// `metricRelabelings` configures the relabeling rules to apply to the
	// samples before ingestion.
	//
	// +optional
	metricRelabelings?: [...#RelabelConfig] @go(MetricRelabelConfigs,[]RelabelConfig)

	// `relabelings` configures the relabeling rules to apply the target's
	// metadata labels.
	//
	// The Operator automatically adds relabelings for a few standard Kubernetes fields.
	//
	// The original scrape job's name is available via the `__tmp_prometheus_job_name` label.
	//
	// More info: https://prometheus.io/docs/prometheus/latest/configuration/configuration/#relabel_config
	//
	// +optional
	relabelings?: [...#RelabelConfig] @go(RelabelConfigs,[]RelabelConfig)

	// `proxyURL` configures the HTTP Proxy URL (e.g.
	// "http://proxyserver:2195") to go through when scraping the target.
	//
	// +optional
	proxyUrl?: null | string @go(ProxyURL,*string)

	// `followRedirects` defines whether the scrape requests should follow HTTP
	// 3xx redirects.
	//
	// +optional
	followRedirects?: null | bool @go(FollowRedirects,*bool)

	// `enableHttp2` can be used to disable HTTP2 when scraping the target.
	//
	// +optional
	enableHttp2?: null | bool @go(EnableHttp2,*bool)

	// When true, the pods which are not running (e.g. either in Failed or
	// Succeeded state) are dropped during the target discovery.
	//
	// If unset, the filtering is enabled.
	//
	// More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle/#pod-phase
	//
	// +optional
	filterRunning?: null | bool @go(FilterRunning,*bool)
}

#AttachMetadata: {
	// When set to true, Prometheus attaches node metadata to the discovered
	// targets.
	//
	// The Prometheus service account must have the `list` and `watch`
	// permissions on the `Nodes` objects.
	//
	// +optional
	node?: null | bool @go(Node,*bool)
}

// OAuth2 configures OAuth2 settings.
//
// +k8s:openapi-gen=true
#OAuth2: {
	// `clientId` specifies a key of a Secret or ConfigMap containing the
	// OAuth2 client's ID.
	clientId: #SecretOrConfigMap @go(ClientID)

	// `clientSecret` specifies a key of a Secret containing the OAuth2
	// client's secret.
	clientSecret: v1.#SecretKeySelector @go(ClientSecret)

	// `tokenURL` configures the URL to fetch the token from.
	//
	// +kubebuilder:validation:MinLength=1
	tokenUrl: string @go(TokenURL)

	// `scopes` defines the OAuth2 scopes used for the token request.
	//
	// +optional.
	scopes?: [...string] @go(Scopes,[]string)

	// `endpointParams` configures the HTTP parameters to append to the token
	// URL.
	//
	// +optional
	endpointParams?: {[string]: string} @go(EndpointParams,map[string]string)

	// TLS configuration to use when connecting to the OAuth2 server.
	// It requires Prometheus >= v2.43.0.
	//
	// +optional
	tlsConfig?: null | #SafeTLSConfig @go(TLSConfig,*SafeTLSConfig)

	#ProxyConfig
}

// BasicAuth configures HTTP Basic Authentication settings.
//
// +k8s:openapi-gen=true
#BasicAuth: {
	// `username` specifies a key of a Secret containing the username for
	// authentication.
	username?: v1.#SecretKeySelector @go(Username)

	// `password` specifies a key of a Secret containing the password for
	// authentication.
	password?: v1.#SecretKeySelector @go(Password)
}

// SecretOrConfigMap allows to specify data as a Secret or ConfigMap. Fields are mutually exclusive.
#SecretOrConfigMap: {
	// Secret containing data to use for the targets.
	secret?: null | v1.#SecretKeySelector @go(Secret,*v1.SecretKeySelector)

	// ConfigMap containing data to use for the targets.
	configMap?: null | v1.#ConfigMapKeySelector @go(ConfigMap,*v1.ConfigMapKeySelector)
}

// +kubebuilder:validation:Enum=TLS10;TLS11;TLS12;TLS13
#TLSVersion: string // #enumTLSVersion

#enumTLSVersion:
	#TLSVersion10 |
	#TLSVersion11 |
	#TLSVersion12 |
	#TLSVersion13

#TLSVersion10: #TLSVersion & "TLS10"
#TLSVersion11: #TLSVersion & "TLS11"
#TLSVersion12: #TLSVersion & "TLS12"
#TLSVersion13: #TLSVersion & "TLS13"

// SafeTLSConfig specifies safe TLS configuration parameters.
// +k8s:openapi-gen=true
#SafeTLSConfig: {
	// Certificate authority used when verifying server certificates.
	ca?: #SecretOrConfigMap @go(CA)

	// Client certificate to present when doing client-authentication.
	cert?: #SecretOrConfigMap @go(Cert)

	// Secret containing the client key file for the targets.
	keySecret?: null | v1.#SecretKeySelector @go(KeySecret,*v1.SecretKeySelector)

	// Used to verify the hostname for the targets.
	// +optional
	serverName?: null | string @go(ServerName,*string)

	// Disable target certificate validation.
	// +optional
	insecureSkipVerify?: null | bool @go(InsecureSkipVerify,*bool)

	// Minimum acceptable TLS version.
	//
	// It requires Prometheus >= v2.35.0 or Thanos >= v0.28.0.
	// +optional
	minVersion?: null | #TLSVersion @go(MinVersion,*TLSVersion)

	// Maximum acceptable TLS version.
	//
	// It requires Prometheus >= v2.41.0 or Thanos >= v0.31.0.
	// +optional
	maxVersion?: null | #TLSVersion @go(MaxVersion,*TLSVersion)
}

// TLSConfig extends the safe TLS configuration with file parameters.
// +k8s:openapi-gen=true
#TLSConfig: {
	#SafeTLSConfig

	// Path to the CA cert in the Prometheus container to use for the targets.
	caFile?: string @go(CAFile)

	// Path to the client cert file in the Prometheus container for the targets.
	certFile?: string @go(CertFile)

	// Path to the client key file in the Prometheus container for the targets.
	keyFile?: string @go(KeyFile)
}

// NamespaceSelector is a selector for selecting either all namespaces or a
// list of namespaces.
// If `any` is true, it takes precedence over `matchNames`.
// If `matchNames` is empty and `any` is false, it means that the objects are
// selected from the current namespace.
// +k8s:openapi-gen=true
#NamespaceSelector: {
	// Boolean describing whether all namespaces are selected in contrast to a
	// list restricting them.
	any?: bool @go(Any)

	// List of namespace names to select from.
	matchNames?: [...string] @go(MatchNames,[]string)
}

// Argument as part of the AdditionalArgs list.
// +k8s:openapi-gen=true
#Argument: {
	// Name of the argument, e.g. "scrape.discovery-reload-interval".
	// +kubebuilder:validation:MinLength=1
	name: string @go(Name)

	// Argument value, e.g. 30s. Can be empty for name-only arguments (e.g. --storage.tsdb.no-lockfile)
	value?: string @go(Value)
}

#RoleNode:          "node"
#RolePod:           "pod"
#RoleService:       "service"
#RoleEndpoint:      "endpoints"
#RoleEndpointSlice: "endpointslice"
#RoleIngress:       "ingress"

// NativeHistogramConfig extends the native histogram configuration settings.
// +k8s:openapi-gen=true
#NativeHistogramConfig: {
	// Whether to scrape a classic histogram that is also exposed as a native histogram.
	// It requires Prometheus >= v2.45.0.
	//
	// +optional
	scrapeClassicHistograms?: null | bool @go(ScrapeClassicHistograms,*bool)

	// If there are more than this many buckets in a native histogram,
	// buckets will be merged to stay within the limit.
	// It requires Prometheus >= v2.45.0.
	//
	// +optional
	nativeHistogramBucketLimit?: null | uint64 @go(NativeHistogramBucketLimit,*uint64)

	// If the growth factor of one bucket to the next is smaller than this,
	// buckets will be merged to increase the factor sufficiently.
	// It requires Prometheus >= v2.50.0.
	//
	// +optional
	nativeHistogramMinBucketFactor?: null | resource.#Quantity @go(NativeHistogramMinBucketFactor,*resource.Quantity)

	// Whether to convert all scraped classic histograms into a native histogram with custom buckets.
	// It requires Prometheus >= v3.0.0.
	//
	// +optional
	convertClassicHistogramsToNHCB?: null | bool @go(ConvertClassicHistogramsToNHCB,*bool)
}

// +kubebuilder:validation:Enum=RelabelConfig;RoleSelector
#SelectorMechanism: string // #enumSelectorMechanism

#enumSelectorMechanism:
	#SelectorMechanismRelabel |
	#SelectorMechanismRole

#SelectorMechanismRelabel: #SelectorMechanism & "RelabelConfig"
#SelectorMechanismRole:    #SelectorMechanism & "RoleSelector"
