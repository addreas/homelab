// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/fluxcd/helm-controller/api/v2beta2

package v2beta2

// CrossNamespaceObjectReference contains enough information to let you locate
// the typed referenced object at cluster level.
#CrossNamespaceObjectReference: {
	// APIVersion of the referent.
	// +optional
	apiVersion?: string @go(APIVersion)

	// Kind of the referent.
	// +kubebuilder:validation:Enum=HelmRepository;GitRepository;Bucket
	// +required
	kind?: string @go(Kind)

	// Name of the referent.
	// +kubebuilder:validation:MinLength=1
	// +kubebuilder:validation:MaxLength=253
	// +required
	name: string @go(Name)

	// Namespace of the referent.
	// +kubebuilder:validation:MinLength=1
	// +kubebuilder:validation:MaxLength=63
	// +kubebuilder:validation:Optional
	// +optional
	namespace?: string @go(Namespace)
}

// CrossNamespaceSourceReference contains enough information to let you locate
// the typed referenced object at cluster level.
#CrossNamespaceSourceReference: {
	// APIVersion of the referent.
	// +optional
	apiVersion?: string @go(APIVersion)

	// Kind of the referent.
	// +kubebuilder:validation:Enum=OCIRepository;HelmChart
	// +required
	kind: string @go(Kind)

	// Name of the referent.
	// +kubebuilder:validation:MinLength=1
	// +kubebuilder:validation:MaxLength=253
	// +required
	name: string @go(Name)

	// Namespace of the referent, defaults to the namespace of the Kubernetes
	// resource object that contains the reference.
	// +kubebuilder:validation:MinLength=1
	// +kubebuilder:validation:MaxLength=63
	// +kubebuilder:validation:Optional
	// +optional
	namespace?: string @go(Namespace)
}

// ValuesReference contains a reference to a resource containing Helm values,
// and optionally the key they can be found at.
#ValuesReference: {
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

	// ValuesKey is the data key where the values.yaml or a specific value can be
	// found at. Defaults to 'values.yaml'.
	// +kubebuilder:validation:MaxLength=253
	// +kubebuilder:validation:Pattern=`^[\-._a-zA-Z0-9]+$`
	// +optional
	valuesKey?: string @go(ValuesKey)

	// TargetPath is the YAML dot notation path the value should be merged at. When
	// set, the ValuesKey is expected to be a single flat value. Defaults to 'None',
	// which results in the values getting merged at the root.
	// +kubebuilder:validation:MaxLength=250
	// +kubebuilder:validation:Pattern=`^([a-zA-Z0-9_\-.\\\/]|\[[0-9]{1,5}\])+$`
	// +optional
	targetPath?: string @go(TargetPath)

	// Optional marks this ValuesReference as optional. When set, a not found error
	// for the values reference is ignored, but any ValuesKey, TargetPath or
	// transient error will still result in a reconciliation failure.
	// +optional
	optional?: bool @go(Optional)
}
