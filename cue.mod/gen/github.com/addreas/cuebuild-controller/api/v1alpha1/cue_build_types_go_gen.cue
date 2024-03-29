// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/addreas/cuebuild-controller/api/v1alpha1

package v1alpha1

import (
	"github.com/fluxcd/pkg/runtime/dependency"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
	"github.com/fluxcd/pkg/apis/meta"
)

#CueBuildKind:              "CueBuild"
#CueBuildFinalizer:         "finalizers.fluxcd.io"
#MaxConditionMessageLength: 20000
#DisabledValue:             "disabled"

// CueBuildSpec defines the desired state of a cueBuild.
#CueBuildSpec: {
	// DependsOn may contain a dependency.CrossNamespaceDependencyReference slice
	// with references to CueBuild resources that must be ready before this
	// CueBuild can be reconciled.
	// +optional
	dependsOn?: [...dependency.#CrossNamespaceDependencyReference] @go(DependsOn,[]dependency.CrossNamespaceDependencyReference)

	// The interval at which to reconcile the CueBuild.
	// +required
	interval: metav1.#Duration @go(Interval)

	// The interval at which to retry a previously failed reconciliation.
	// When not specified, the controller uses the CueBuildSpec.Interval
	// value to retry failures.
	// +optional
	retryInterval?: null | metav1.#Duration @go(RetryInterval,*metav1.Duration)

	// The KubeConfig for reconciling the CueBuild on a remote cluster.
	// When specified, KubeConfig takes precedence over ServiceAccountName.
	// +optional
	kubeConfig?: null | #KubeConfig @go(KubeConfig,*KubeConfig)

	// Packages to include in the cue build.
	// +required
	packages?: [...string] @go(Packages,[]string)

	// Prune enables garbage collection.
	// +required
	prune: bool @go(Prune)

	// A list of resources to be included in the health assessment.
	// +optional
	healthChecks?: [...meta.#NamespacedObjectKindReference] @go(HealthChecks,[]meta.NamespacedObjectKindReference)

	// The name of the Kubernetes service account to impersonate
	// when reconciling this CueBuild.
	// +optional
	serviceAccountName?: string @go(ServiceAccountName)

	// Reference of the source where the cue packages are.
	// +required
	sourceRef: #CrossNamespaceSourceReference @go(SourceRef)

	// This flag tells the controller to suspend subsequent cue build executions,
	// it does not apply to already started executions. Defaults to false.
	// +optional
	suspend?: bool @go(Suspend)

	// Timeout for validation, apply and health checking operations.
	// Defaults to 'Interval' duration.
	// +optional
	timeout?: null | metav1.#Duration @go(Timeout,*metav1.Duration)

	// Validate the Kubernetes objects before applying them on the cluster.
	// The validation strategy can be 'client' (local dry-run), 'server'
	// (APIServer dry-run) or 'none'.
	// When 'Force' is 'true', validation will fallback to 'client' if set to
	// 'server' because server-side validation is not supported in this scenario.
	// +kubebuilder:validation:Enum=none;client;server
	// +optional
	validation?: string @go(Validation)

	// Force instructs the controller to recreate resources
	// when patching fails due to an immutable field change.
	// +kubebuilder:default:=false
	// +optional
	force?: bool @go(Force)
}

// KubeConfig references a Kubernetes secret that contains a kubeconfig file.
#KubeConfig: {
	// SecretRef holds the name to a secret that contains a 'value' key with
	// the kubeconfig file as the value. It must be in the same namespace as
	// the CueBuild.
	// It is recommended that the kubeconfig is self-contained, and the secret
	// is regularly updated if credentials such as a cloud-access-token expire.
	// Cloud specific `cmd-path` auth helpers will not function without adding
	// binaries and credentials to the Pod that is responsible for reconciling
	// the CueBuild.
	// +required
	secretRef?: meta.#LocalObjectReference @go(SecretRef)
}

// CueBuildStatus defines the observed state of a cueBuild.
#CueBuildStatus: {
	// ObservedGeneration is the last reconciled generation.
	// +optional
	observedGeneration?: int64 @go(ObservedGeneration)

	// +optional
	conditions?: [...metav1.#Condition] @go(Conditions,[]metav1.Condition)

	// The last successfully applied revision.
	// The revision format for Git sources is <branch|tag>/<commit-sha>.
	// +optional
	lastAppliedRevision?: string @go(LastAppliedRevision)

	// LastAttemptedRevision is the revision of the last reconciliation attempt.
	// +optional
	lastAttemptedRevision?: string @go(LastAttemptedRevision)

	meta.#ReconcileRequestStatus

	// The last successfully applied revision metadata.
	// +optional
	snapshot?: null | #Snapshot @go(Snapshot,*Snapshot)
}

// GitRepositoryIndexKey is the key used for indexing cueBuilds
// based on their Git sources.
#GitRepositoryIndexKey: ".metadata.gitRepository"

// BucketIndexKey is the key used for indexing cueBuilds
// based on their S3 sources.
#BucketIndexKey: ".metadata.bucket"

// CueBuild is the Schema for the CueBuilds API.
#CueBuild: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)
	spec?:     #CueBuildSpec      @go(Spec)
	status?:   #CueBuildStatus    @go(Status)
}

// CueBuildList contains a list of CueBuilds.
#CueBuildList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#CueBuild] @go(Items,[]CueBuild)
}
