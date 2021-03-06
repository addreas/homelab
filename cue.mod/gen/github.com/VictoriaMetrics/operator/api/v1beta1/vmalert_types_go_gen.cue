// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/VictoriaMetrics/operator/api/v1beta1

package v1beta1

import (
	"k8s.io/api/core/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
	appsv1 "k8s.io/api/apps/v1"
)

// MetaVMAlertDeduplicateRulesKey - controls behavior for vmalert rules deduplication
// its useful for migration from prometheus.
#MetaVMAlertDeduplicateRulesKey: "operator.victoriametrics.com/vmalert-deduplicate-rules"

// VMAlertSpec defines the desired state of VMAlert
// +k8s:openapi-gen=true
// +kubebuilder:printcolumn:name="Version",type="string",JSONPath=".spec.version",description="The version of VMAlert"
// +kubebuilder:printcolumn:name="ReplicaCount",type="integer",JSONPath=".spec.replicas",description="The desired replicas number of VmAlerts"
// +kubebuilder:printcolumn:name="Age",type="date",JSONPath=".metadata.creationTimestamp"
#VMAlertSpec: {
	// PodMetadata configures Labels and Annotations which are propagated to the VMAlert pods.
	podMetadata?: null | #EmbeddedObjectMetadata @go(PodMetadata,*EmbeddedObjectMetadata)

	// Image - docker image settings for VMAlert
	// if no specified operator uses default config version
	// +optional
	image?: #Image @go(Image)

	// ImagePullSecrets An optional list of references to secrets in the same namespace
	// to use for pulling images from registries
	// see http://kubernetes.io/docs/user-guide/images#specifying-imagepullsecrets-on-a-pod
	// +optional
	imagePullSecrets?: [...v1.#LocalObjectReference] @go(ImagePullSecrets,[]v1.LocalObjectReference)

	// Secrets is a list of Secrets in the same namespace as the VMAlert
	// object, which shall be mounted into the VMAlert Pods.
	// The Secrets are mounted into /etc/vm/secrets/<secret-name>.
	// +optional
	secrets?: [...string] @go(Secrets,[]string)

	// ConfigMaps is a list of ConfigMaps in the same namespace as the VMAlert
	// object, which shall be mounted into the VMAlert Pods.
	// The ConfigMaps are mounted into /etc/vm/configs/<configmap-name>.
	// +optional
	configMaps?: [...string] @go(ConfigMaps,[]string)

	// LogFormat for VMAlert to be configured with.
	//default or json
	// +optional
	// +kubebuilder:validation:Enum=default;json
	logFormat?: string @go(LogFormat)

	// LogLevel for VMAlert to be configured with.
	// +optional
	// +kubebuilder:validation:Enum=INFO;WARN;ERROR;FATAL;PANIC
	logLevel?: string @go(LogLevel)

	// ReplicaCount is the expected size of the VMAlert cluster. The controller will
	// eventually make the size of the running cluster equal to the expected
	// size.
	// +optional
	// +operator-sdk:csv:customresourcedefinitions:type=spec,displayName="Number of pods",xDescriptors="urn:alm:descriptor:com.tectonic.ui:podCount,urn:alm:descriptor:io.kubernetes:custom"
	replicaCount?: null | int32 @go(ReplicaCount,*int32)

	// Volumes allows configuration of additional volumes on the output Deployment definition.
	// Volumes specified will be appended to other volumes that are generated as a result of
	// StorageSpec objects.
	// +optional
	volumes?: [...v1.#Volume] @go(Volumes,[]v1.Volume)

	// VolumeMounts allows configuration of additional VolumeMounts on the output Deployment definition.
	// VolumeMounts specified will be appended to other VolumeMounts in the VMAlert container,
	// that are generated as a result of StorageSpec objects.
	// +optional
	volumeMounts?: [...v1.#VolumeMount] @go(VolumeMounts,[]v1.VolumeMount)

	// Resources container resource request and limits, https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/
	// +operator-sdk:csv:customresourcedefinitions:type=spec,displayName="Resources",xDescriptors="urn:alm:descriptor:com.tectonic.ui:resourceRequirements"
	// +optional
	resources?: v1.#ResourceRequirements @go(Resources)

	// Affinity If specified, the pod's scheduling constraints.
	// +optional
	affinity?: null | v1.#Affinity @go(Affinity,*v1.Affinity)

	// Tolerations If specified, the pod's tolerations.
	// +optional
	tolerations?: [...v1.#Toleration] @go(Tolerations,[]v1.Toleration)

	// SecurityContext holds pod-level security attributes and common container settings.
	// This defaults to the default PodSecurityContext.
	// +optional
	securityContext?: null | v1.#PodSecurityContext @go(SecurityContext,*v1.PodSecurityContext)

	// ServiceAccountName is the name of the ServiceAccount to use to run the
	// VMAlert Pods.
	// +optional
	serviceAccountName?: string @go(ServiceAccountName)

	// SchedulerName - defines kubernetes scheduler name
	// +optional
	schedulerName?: string @go(SchedulerName)

	// RuntimeClassName - defines runtime class for kubernetes pod.
	//https://kubernetes.io/docs/concepts/containers/runtime-class/
	// +optional
	runtimeClassName?: null | string @go(RuntimeClassName,*string)

	// PodSecurityPolicyName - defines name for podSecurityPolicy
	// in case of empty value, prefixedName will be used.
	// +optional
	podSecurityPolicyName?: string @go(PodSecurityPolicyName)

	// Containers property allows to inject additions sidecars or to patch existing containers.
	// It can be useful for proxies, backup, etc.
	// +optional
	containers?: [...v1.#Container] @go(Containers,[]v1.Container)

	// InitContainers allows adding initContainers to the pod definition. Those can be used to e.g.
	// fetch secrets for injection into the VMAlert configuration from external sources. Any
	// errors during the execution of an initContainer will lead to a restart of the Pod. More info: https://kubernetes.io/docs/concepts/workloads/pods/init-containers/
	// Using initContainers for any use case other then secret fetching is entirely outside the scope
	// of what the maintainers will support and by doing so, you accept that this behaviour may break
	// at any time without notice.
	// +optional
	initContainers?: [...v1.#Container] @go(InitContainers,[]v1.Container)

	// Priority class assigned to the Pods
	// +optional
	priorityClassName?: string @go(PriorityClassName)

	// HostNetwork controls whether the pod may use the node network namespace
	// +optional
	hostNetwork?: bool @go(HostNetwork)

	// DNSPolicy sets DNS policy for the pod
	// +optional
	dnsPolicy?: v1.#DNSPolicy @go(DNSPolicy)

	// TopologySpreadConstraints embedded kubernetes pod configuration option,
	// controls how pods are spread across your cluster among failure-domains
	// such as regions, zones, nodes, and other user-defined topology domains
	// https://kubernetes.io/docs/concepts/workloads/pods/pod-topology-spread-constraints/
	// +optional
	topologySpreadConstraints?: [...v1.#TopologySpreadConstraint] @go(TopologySpreadConstraints,[]v1.TopologySpreadConstraint)

	// EvaluationInterval how often evalute rules by default
	// +optional
	// +kubebuilder:validation:Pattern:="[0-9]+(ms|s|m|h)"
	evaluationInterval?: string @go(EvaluationInterval)

	// EnforcedNamespaceLabel enforces adding a namespace label of origin for each alert
	// and metric that is user created. The label value will always be the namespace of the object that is
	// being created.
	// +optional
	enforcedNamespaceLabel?: string @go(EnforcedNamespaceLabel)

	// RuleSelector selector to select which VMRules to mount for loading alerting
	// rules from.
	// +optional
	ruleSelector?: null | metav1.#LabelSelector @go(RuleSelector,*metav1.LabelSelector)

	// RuleNamespaceSelector to be selected for VMRules discovery. If unspecified, only
	// the same namespace as the vmalert object is in is used.
	// +optional
	ruleNamespaceSelector?: null | metav1.#LabelSelector @go(RuleNamespaceSelector,*metav1.LabelSelector)

	// Port for listen
	// +optional
	port?: string @go(Port)

	// Notifier prometheus alertmanager endpoint spec. Required at least one of  notifier or notifiers. e.g. http://127.0.0.1:9093
	// If specified both notifier and notifiers, notifier will be added as last element to notifiers.
	notifier?: null | #VMAlertNotifierSpec @go(Notifier,*VMAlertNotifierSpec)

	// Notifiers prometheus alertmanager endpoints. Required at least one of  notifier or notifiers. e.g. http://127.0.0.1:9093
	// If specified both notifier and notifiers, notifier will be added as last element to notifiers.
	notifiers?: [...#VMAlertNotifierSpec] @go(Notifiers,[]VMAlertNotifierSpec)

	// RemoteWrite Optional URL to remote-write compatible storage where to write timeseriesbased on active alerts. E.g. http://127.0.0.1:8428
	// +optional
	remoteWrite?: null | #VMAlertRemoteWriteSpec @go(RemoteWrite,*VMAlertRemoteWriteSpec)

	// RemoteRead victoria metrics address for loading state
	// This configuration makes sense only if remoteWrite was configured before and has
	// been successfully persisted its state.
	// +optional
	remoteRead?: null | #VMAlertRemoteReadSpec @go(RemoteRead,*VMAlertRemoteReadSpec)

	// RulePath to the file with alert rules.
	// Supports patterns. Flag can be specified multiple times.
	// Examples:
	// -rule /path/to/file. Path to a single file with alerting rules
	// -rule dir/*.yaml -rule /*.yaml. Relative path to all .yaml files in folder,
	// absolute path to all .yaml files in root.
	// by default operator adds /etc/vmalert/configs/base/vmalert.yaml
	// +optional
	rulePath?: [...string] @go(RulePath,[]string)

	// Datasource Victoria Metrics or VMSelect url. Required parameter. e.g. http://127.0.0.1:8428
	datasource: #VMAlertDatasourceSpec @go(Datasource)

	// ExtraArgs that will be passed to  VMAlert pod
	// for example -remoteWrite.tmpDataPath=/tmp
	// +optional
	extraArgs?: {[string]: string} @go(ExtraArgs,map[string]string)

	// ExtraEnvs that will be added to VMAlert pod
	// +optional
	extraEnvs?: [...v1.#EnvVar] @go(ExtraEnvs,[]v1.EnvVar)

	// ExternalLabels in the form 'name: value' to add to all generated recording rules and alerts.
	// +optional
	externalLabels?: {[string]: string} @go(ExternalLabels,map[string]string)

	// ServiceSpec that will be added to vmalert service spec
	// +optional
	serviceSpec?: null | #ServiceSpec @go(ServiceSpec,*ServiceSpec)

	// UpdateStrategy - overrides default update strategy.
	// +kubebuilder:validation:Enum=Recreate;RollingUpdate
	// +optional
	updateStrategy?: null | appsv1.#DeploymentStrategyType @go(UpdateStrategy,*appsv1.DeploymentStrategyType)

	// RollingUpdate - overrides deployment update params.
	// +optional
	rollingUpdate?: null | appsv1.#RollingUpdateDeployment @go(RollingUpdate,*appsv1.RollingUpdateDeployment)

	// PodDisruptionBudget created by operator
	// +optional
	podDisruptionBudget?: null | #EmbeddedPodDisruptionBudgetSpec @go(PodDisruptionBudget,*EmbeddedPodDisruptionBudgetSpec)

	#EmbeddedProbes
}

// VMAgentRemoteReadSpec defines the remote storage configuration for VmAlert to read alerts from
// +k8s:openapi-gen=true
#VMAlertDatasourceSpec: {
	// Victoria Metrics or VMSelect url. Required parameter. E.g. http://127.0.0.1:8428
	url: string @go(URL)

	// BasicAuth allow datasource to authenticate over basic authentication
	// +optional
	basicAuth?: null | #BasicAuth @go(BasicAuth,*BasicAuth)

	// TLSConfig describes tls configuration for datasource target
	tlsConfig?: null | #TLSConfig @go(TLSConfig,*TLSConfig)
}

// VMAlertNotifierSpec defines the notifier url for sending information about alerts
// +k8s:openapi-gen=true
#VMAlertNotifierSpec: {
	// AlertManager url. Required parameter. E.g. http://127.0.0.1:9093
	url: string @go(URL)

	// BasicAuth allow notifier to authenticate over basic authentication
	// +optional
	basicAuth?: null | #BasicAuth @go(BasicAuth,*BasicAuth)

	// TLSConfig describes tls configuration for notifier
	tlsConfig?: null | #TLSConfig @go(TLSConfig,*TLSConfig)
}

// VMAgentRemoteReadSpec defines the remote storage configuration for VmAlert to read alerts from
// +k8s:openapi-gen=true
#VMAlertRemoteReadSpec: {
	// URL of the endpoint to send samples to.
	url: string @go(URL)

	// BasicAuth allow an endpoint to authenticate over basic authentication
	// +optional
	basicAuth?: null | #BasicAuth @go(BasicAuth,*BasicAuth)

	// Lookback defines how far to look into past for alerts timeseries. For example, if lookback=1h then range from now() to now()-1h will be scanned. (default 1h0m0s)
	// Applied only to RemoteReadSpec
	// +optional
	lookback?: null | string @go(Lookback,*string)

	// TLSConfig describes tls configuration for remote read target
	tlsConfig?: null | #TLSConfig @go(TLSConfig,*TLSConfig)
}

// VMAgentRemoteWriteSpec defines the remote storage configuration for VmAlert
// +k8s:openapi-gen=true
#VMAlertRemoteWriteSpec: {
	// URL of the endpoint to send samples to.
	url: string @go(URL)

	// BasicAuth allow an endpoint to authenticate over basic authentication
	// +optional
	basicAuth?: null | #BasicAuth @go(BasicAuth,*BasicAuth)

	// Defines number of readers that concurrently write into remote storage (default 1)
	// +optional
	concurrency?: null | int32 @go(Concurrency,*int32)

	// Defines interval of flushes to remote write endpoint (default 5s)
	// +optional
	// +kubebuilder:validation:Pattern:="[0-9]+(ms|s|m|h)"
	flushInterval?: null | string @go(FlushInterval,*string)

	// Defines defines max number of timeseries to be flushed at once (default 1000)
	// +optional
	maxBatchSize?: null | int32 @go(MaxBatchSize,*int32)

	// Defines the max number of pending datapoints to remote write endpoint (default 100000)
	// +optional
	maxQueueSize?: null | int32 @go(MaxQueueSize,*int32)

	// TLSConfig describes tls configuration for remote write target
	tlsConfig?: null | #TLSConfig @go(TLSConfig,*TLSConfig)
}

// VmAlertStatus defines the observed state of VmAlert
// +k8s:openapi-gen=true
// +kubebuilder:subresource:status
#VMAlertStatus: {
	// ReplicaCount Total number of non-terminated pods targeted by this VMAlert
	// cluster (their labels match the selector).
	replicas: int32 @go(Replicas)

	// UpdatedReplicas Total number of non-terminated pods targeted by this VMAlert
	// cluster that have the desired version spec.
	updatedReplicas: int32 @go(UpdatedReplicas)

	// AvailableReplicas Total number of available pods (ready for at least minReadySeconds)
	// targeted by this VMAlert cluster.
	availableReplicas: int32 @go(AvailableReplicas)

	// UnavailableReplicas Total number of unavailable pods targeted by this VMAlert cluster.
	unavailableReplicas: int32 @go(UnavailableReplicas)
}

// VMAlert  executes a list of given alerting or recording rules against configured address.
// +operator-sdk:gen-csv:customresourcedefinitions.displayName="VMAlert App"
// +operator-sdk:gen-csv:customresourcedefinitions.resources="Deployment,v1"
// +operator-sdk:gen-csv:customresourcedefinitions.resources="Service,v1"
// +operator-sdk:gen-csv:customresourcedefinitions.resources="Secret,v1"
// +genclient
// +k8s:openapi-gen=true
// +k8s:deepcopy-gen:interfaces=k8s.io/apimachinery/pkg/runtime.Object
// +kubebuilder:subresource:status
// +kubebuilder:resource:path=vmalerts,scope=Namespaced
#VMAlert: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)
	spec?:     #VMAlertSpec       @go(Spec)
	status?:   #VMAlertStatus     @go(Status)
}

// VMAlertList contains a list of VMAlert
#VMAlertList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#VMAlert] @go(Items,[]VMAlert)
}
