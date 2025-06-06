// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/fluxcd/kustomize-controller/api/v1

package v1

import (
	"github.com/fluxcd/pkg/apis/meta"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
	"github.com/fluxcd/pkg/apis/kustomize"
)

#KustomizationKind:                "Kustomization"
#KustomizationFinalizer:           "finalizers.fluxcd.io"
#MaxConditionMessageLength:        20000
#EnabledValue:                     "enabled"
#DisabledValue:                    "disabled"
#MergeValue:                       "Merge"
#IfNotPresentValue:                "IfNotPresent"
#IgnoreValue:                      "Ignore"
#DeletionPolicyMirrorPrune:        "MirrorPrune"
#DeletionPolicyDelete:             "Delete"
#DeletionPolicyWaitForTermination: "WaitForTermination"
#DeletionPolicyOrphan:             "Orphan"

// KustomizationSpec defines the configuration to calculate the desired state
// from a Source using Kustomize.
#KustomizationSpec: {
	// CommonMetadata specifies the common labels and annotations that are
	// applied to all resources. Any existing label or annotation will be
	// overridden if its key matches a common one.
	// +optional
	commonMetadata?: null | #CommonMetadata @go(CommonMetadata,*CommonMetadata)

	// DependsOn may contain a meta.NamespacedObjectReference slice
	// with references to Kustomization resources that must be ready before this
	// Kustomization can be reconciled.
	// +optional
	dependsOn?: [...meta.#NamespacedObjectReference] @go(DependsOn,[]meta.NamespacedObjectReference)

	// Decrypt Kubernetes secrets before applying them on the cluster.
	// +optional
	decryption?: null | #Decryption @go(Decryption,*Decryption)

	// The interval at which to reconcile the Kustomization.
	// This interval is approximate and may be subject to jitter to ensure
	// efficient use of resources.
	// +kubebuilder:validation:Type=string
	// +kubebuilder:validation:Pattern="^([0-9]+(\\.[0-9]+)?(ms|s|m|h))+$"
	// +required
	interval: metav1.#Duration @go(Interval)

	// The interval at which to retry a previously failed reconciliation.
	// When not specified, the controller uses the KustomizationSpec.Interval
	// value to retry failures.
	// +kubebuilder:validation:Type=string
	// +kubebuilder:validation:Pattern="^([0-9]+(\\.[0-9]+)?(ms|s|m|h))+$"
	// +optional
	retryInterval?: null | metav1.#Duration @go(RetryInterval,*metav1.Duration)

	// The KubeConfig for reconciling the Kustomization on a remote cluster.
	// When used in combination with KustomizationSpec.ServiceAccountName,
	// forces the controller to act on behalf of that Service Account at the
	// target cluster.
	// If the --default-service-account flag is set, its value will be used as
	// a controller level fallback for when KustomizationSpec.ServiceAccountName
	// is empty.
	// +optional
	kubeConfig?: null | meta.#KubeConfigReference @go(KubeConfig,*meta.KubeConfigReference)

	// Path to the directory containing the kustomization.yaml file, or the
	// set of plain YAMLs a kustomization.yaml should be generated for.
	// Defaults to 'None', which translates to the root path of the SourceRef.
	// +optional
	path?: string @go(Path)

	// PostBuild describes which actions to perform on the YAML manifest
	// generated by building the kustomize overlay.
	// +optional
	postBuild?: null | #PostBuild @go(PostBuild,*PostBuild)

	// Prune enables garbage collection.
	// +required
	prune: bool @go(Prune)

	// DeletionPolicy can be used to control garbage collection when this
	// Kustomization is deleted. Valid values are ('MirrorPrune', 'Delete',
	// 'WaitForTermination', 'Orphan'). 'MirrorPrune' mirrors the Prune field
	// (orphan if false, delete if true). Defaults to 'MirrorPrune'.
	// +kubebuilder:validation:Enum=MirrorPrune;Delete;WaitForTermination;Orphan
	// +optional
	deletionPolicy?: string @go(DeletionPolicy)

	// A list of resources to be included in the health assessment.
	// +optional
	healthChecks?: [...meta.#NamespacedObjectKindReference] @go(HealthChecks,[]meta.NamespacedObjectKindReference)

	// NamePrefix will prefix the names of all managed resources.
	// +kubebuilder:validation:MinLength=1
	// +kubebuilder:validation:MaxLength=200
	// +kubebuilder:validation:Optional
	// +optional
	namePrefix?: string @go(NamePrefix)

	// NameSuffix will suffix the names of all managed resources.
	// +kubebuilder:validation:MinLength=1
	// +kubebuilder:validation:MaxLength=200
	// +kubebuilder:validation:Optional
	// +optional
	nameSuffix?: string @go(NameSuffix)

	// Strategic merge and JSON patches, defined as inline YAML objects,
	// capable of targeting objects based on kind, label and annotation selectors.
	// +optional
	patches?: [...kustomize.#Patch] @go(Patches,[]kustomize.Patch)

	// Images is a list of (image name, new name, new tag or digest)
	// for changing image names, tags or digests. This can also be achieved with a
	// patch, but this operator is simpler to specify.
	// +optional
	images?: [...kustomize.#Image] @go(Images,[]kustomize.Image)

	// The name of the Kubernetes service account to impersonate
	// when reconciling this Kustomization.
	// +optional
	serviceAccountName?: string @go(ServiceAccountName)

	// Reference of the source where the kustomization file is.
	// +required
	sourceRef: #CrossNamespaceSourceReference @go(SourceRef)

	// This flag tells the controller to suspend subsequent kustomize executions,
	// it does not apply to already started executions. Defaults to false.
	// +optional
	suspend?: bool @go(Suspend)

	// TargetNamespace sets or overrides the namespace in the
	// kustomization.yaml file.
	// +kubebuilder:validation:MinLength=1
	// +kubebuilder:validation:MaxLength=63
	// +kubebuilder:validation:Optional
	// +optional
	targetNamespace?: string @go(TargetNamespace)

	// Timeout for validation, apply and health checking operations.
	// Defaults to 'Interval' duration.
	// +kubebuilder:validation:Type=string
	// +kubebuilder:validation:Pattern="^([0-9]+(\\.[0-9]+)?(ms|s|m|h))+$"
	// +optional
	timeout?: null | metav1.#Duration @go(Timeout,*metav1.Duration)

	// Force instructs the controller to recreate resources
	// when patching fails due to an immutable field change.
	// +kubebuilder:default:=false
	// +optional
	force?: bool @go(Force)

	// Wait instructs the controller to check the health of all the reconciled
	// resources. When enabled, the HealthChecks are ignored. Defaults to false.
	// +optional
	wait?: bool @go(Wait)

	// Components specifies relative paths to specifications of other Components.
	// +optional
	components?: [...string] @go(Components,[]string)

	// HealthCheckExprs is a list of healthcheck expressions for evaluating the
	// health of custom resources using Common Expression Language (CEL).
	// The expressions are evaluated only when Wait or HealthChecks are specified.
	// +optional
	healthCheckExprs?: [...kustomize.#CustomHealthCheck] @go(HealthCheckExprs,[]kustomize.CustomHealthCheck)
}

// CommonMetadata defines the common labels and annotations.
#CommonMetadata: {
	// Annotations to be added to the object's metadata.
	// +optional
	annotations?: {[string]: string} @go(Annotations,map[string]string)

	// Labels to be added to the object's metadata.
	// +optional
	labels?: {[string]: string} @go(Labels,map[string]string)
}

// Decryption defines how decryption is handled for Kubernetes manifests.
#Decryption: {
	// Provider is the name of the decryption engine.
	// +kubebuilder:validation:Enum=sops
	// +required
	provider: string @go(Provider)

	// ServiceAccountName is the name of the service account used to
	// authenticate with KMS services from cloud providers. If a
	// static credential for a given cloud provider is defined
	// inside the Secret referenced by SecretRef, that static
	// credential takes priority.
	// +optional
	serviceAccountName?: string @go(ServiceAccountName)

	// The secret name containing the private OpenPGP keys used for decryption.
	// A static credential for a cloud provider defined inside the Secret
	// takes priority to secret-less authentication with the ServiceAccountName
	// field.
	// +optional
	secretRef?: null | meta.#LocalObjectReference @go(SecretRef,*meta.LocalObjectReference)
}

// PostBuild describes which actions to perform on the YAML manifest
// generated by building the kustomize overlay.
#PostBuild: {
	// Substitute holds a map of key/value pairs.
	// The variables defined in your YAML manifests that match any of the keys
	// defined in the map will be substituted with the set value.
	// Includes support for bash string replacement functions
	// e.g. ${var:=default}, ${var:position} and ${var/substring/replacement}.
	// +optional
	substitute?: {[string]: string} @go(Substitute,map[string]string)

	// SubstituteFrom holds references to ConfigMaps and Secrets containing
	// the variables and their values to be substituted in the YAML manifests.
	// The ConfigMap and the Secret data keys represent the var names, and they
	// must match the vars declared in the manifests for the substitution to
	// happen.
	// +optional
	substituteFrom?: [...#SubstituteReference] @go(SubstituteFrom,[]SubstituteReference)
}

// SubstituteReference contains a reference to a resource containing
// the variables name and value.
#SubstituteReference: {
	// Kind of the values referent, valid values are ('Secret', 'ConfigMap').
	// +kubebuilder:validation:Enum=Secret;ConfigMap
	// +required
	kind: string @go(Kind)

	// Name of the values referent. Should reside in the same namespace as the
	// referring resource.
	// +kubebuilder:validation:MinLength=1
	// +kubebuilder:validation:MaxLength=253
	// +required
	name: string @go(Name)

	// Optional indicates whether the referenced resource must exist, or whether to
	// tolerate its absence. If true and the referenced resource is absent, proceed
	// as if the resource was present but empty, without any variables defined.
	// +kubebuilder:default:=false
	// +optional
	optional?: bool @go(Optional)
}

// KustomizationStatus defines the observed state of a kustomization.
#KustomizationStatus: {
	meta.#ReconcileRequestStatus

	// ObservedGeneration is the last reconciled generation.
	// +optional
	observedGeneration?: int64 @go(ObservedGeneration)

	// +optional
	conditions?: [...metav1.#Condition] @go(Conditions,[]metav1.Condition)

	// The last successfully applied revision.
	// Equals the Revision of the applied Artifact from the referenced Source.
	// +optional
	lastAppliedRevision?: string @go(LastAppliedRevision)

	// The last successfully applied origin revision.
	// Equals the origin revision of the applied Artifact from the referenced Source.
	// Usually present on the Metadata of the applied Artifact and depends on the
	// Source type, e.g. for OCI it's the value associated with the key
	// "org.opencontainers.image.revision".
	// +optional
	lastAppliedOriginRevision?: string @go(LastAppliedOriginRevision)

	// LastAttemptedRevision is the revision of the last reconciliation attempt.
	// +optional
	lastAttemptedRevision?: string @go(LastAttemptedRevision)

	// Inventory contains the list of Kubernetes resource object references that
	// have been successfully applied.
	// +optional
	inventory?: null | #ResourceInventory @go(Inventory,*ResourceInventory)
}

// Kustomization is the Schema for the kustomizations API.
#Kustomization: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)
	spec?:     #KustomizationSpec @go(Spec)

	// +kubebuilder:default:={"observedGeneration":-1}
	status?: #KustomizationStatus @go(Status)
}

// KustomizationList contains a list of kustomizations.
#KustomizationList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#Kustomization] @go(Items,[]Kustomization)
}
