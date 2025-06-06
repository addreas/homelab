// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/fluxcd/helm-controller/api/v2

package v2

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
