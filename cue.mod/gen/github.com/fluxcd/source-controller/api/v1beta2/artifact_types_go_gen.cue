// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/fluxcd/source-controller/api/v1beta2

package v1beta2

import metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"

// Artifact represents the output of a Source reconciliation.
//
// Deprecated: use Artifact from api/v1 instead. This type will be removed in
// a future release.
#Artifact: {
	// Path is the relative file path of the Artifact. It can be used to locate
	// the file in the root of the Artifact storage on the local file system of
	// the controller managing the Source.
	// +required
	path: string @go(Path)

	// URL is the HTTP address of the Artifact as exposed by the controller
	// managing the Source. It can be used to retrieve the Artifact for
	// consumption, e.g. by another controller applying the Artifact contents.
	// +required
	url: string @go(URL)

	// Revision is a human-readable identifier traceable in the origin source
	// system. It can be a Git commit SHA, Git tag, a Helm chart version, etc.
	// +optional
	revision: string @go(Revision)

	// Checksum is the SHA256 checksum of the Artifact file.
	// Deprecated: use Artifact.Digest instead.
	// +optional
	checksum?: string @go(Checksum)

	// Digest is the digest of the file in the form of '<algorithm>:<checksum>'.
	// +optional
	// +kubebuilder:validation:Pattern="^[a-z0-9]+(?:[.+_-][a-z0-9]+)*:[a-zA-Z0-9=_-]+$"
	digest?: string @go(Digest)

	// LastUpdateTime is the timestamp corresponding to the last update of the
	// Artifact.
	// +required
	lastUpdateTime?: metav1.#Time @go(LastUpdateTime)

	// Size is the number of bytes in the file.
	// +optional
	size?: null | int64 @go(Size,*int64)

	// Metadata holds upstream information such as OCI annotations.
	// +optional
	metadata?: {[string]: string} @go(Metadata,map[string]string)
}