// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/fluxcd/source-controller/api/v1

package v1

import "github.com/fluxcd/pkg/apis/meta"

// OCIRepositoryVerification verifies the authenticity of an OCI Artifact
#OCIRepositoryVerification: {
	// Provider specifies the technology used to sign the OCI Artifact.
	// +kubebuilder:validation:Enum=cosign;notation
	// +kubebuilder:default:=cosign
	provider: string @go(Provider)

	// SecretRef specifies the Kubernetes Secret containing the
	// trusted public keys.
	// +optional
	secretRef?: null | meta.#LocalObjectReference @go(SecretRef,*meta.LocalObjectReference)

	// MatchOIDCIdentity specifies the identity matching criteria to use
	// while verifying an OCI artifact which was signed using Cosign keyless
	// signing. The artifact's identity is deemed to be verified if any of the
	// specified matchers match against the identity.
	// +optional
	matchOIDCIdentity?: [...#OIDCIdentityMatch] @go(MatchOIDCIdentity,[]OIDCIdentityMatch)
}

// OIDCIdentityMatch specifies options for verifying the certificate identity,
// i.e. the issuer and the subject of the certificate.
#OIDCIdentityMatch: {
	// Issuer specifies the regex pattern to match against to verify
	// the OIDC issuer in the Fulcio certificate. The pattern must be a
	// valid Go regular expression.
	// +required
	issuer: string @go(Issuer)

	// Subject specifies the regex pattern to match against to verify
	// the identity subject in the Fulcio certificate. The pattern must
	// be a valid Go regular expression.
	// +required
	subject: string @go(Subject)
}
