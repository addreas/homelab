// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/fluxcd/source-controller/api/v1

package v1

import (
	"github.com/fluxcd/pkg/apis/meta"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

// BucketKind is the string representation of a Bucket.
#BucketKind: "Bucket"

// BucketProviderGeneric for any S3 API compatible storage Bucket.
#BucketProviderGeneric: "generic"

// BucketProviderAmazon for an AWS S3 object storage Bucket.
// Provides support for retrieving credentials from the AWS EC2 service.
#BucketProviderAmazon: "aws"

// BucketProviderGoogle for a Google Cloud Storage Bucket.
// Provides support for authentication using a workload identity.
#BucketProviderGoogle: "gcp"

// BucketProviderAzure for an Azure Blob Storage Bucket.
// Provides support for authentication using a Service Principal,
// Managed Identity or Shared Key.
#BucketProviderAzure: "azure"

// BucketSpec specifies the required configuration to produce an Artifact for
// an object storage bucket.
// +kubebuilder:validation:XValidation:rule="self.provider == 'aws' || self.provider == 'generic' || !has(self.sts)", message="STS configuration is only supported for the 'aws' and 'generic' Bucket providers"
// +kubebuilder:validation:XValidation:rule="self.provider != 'aws' || !has(self.sts) || self.sts.provider == 'aws'", message="'aws' is the only supported STS provider for the 'aws' Bucket provider"
// +kubebuilder:validation:XValidation:rule="self.provider != 'generic' || !has(self.sts) || self.sts.provider == 'ldap'", message="'ldap' is the only supported STS provider for the 'generic' Bucket provider"
// +kubebuilder:validation:XValidation:rule="!has(self.sts) || self.sts.provider != 'aws' || !has(self.sts.secretRef)", message="spec.sts.secretRef is not required for the 'aws' STS provider"
// +kubebuilder:validation:XValidation:rule="!has(self.sts) || self.sts.provider != 'aws' || !has(self.sts.certSecretRef)", message="spec.sts.certSecretRef is not required for the 'aws' STS provider"
#BucketSpec: {
	// Provider of the object storage bucket.
	// Defaults to 'generic', which expects an S3 (API) compatible object
	// storage.
	// +kubebuilder:validation:Enum=generic;aws;gcp;azure
	// +kubebuilder:default:=generic
	// +optional
	provider?: string @go(Provider)

	// BucketName is the name of the object storage bucket.
	// +required
	bucketName: string @go(BucketName)

	// Endpoint is the object storage address the BucketName is located at.
	// +required
	endpoint: string @go(Endpoint)

	// STS specifies the required configuration to use a Security Token
	// Service for fetching temporary credentials to authenticate in a
	// Bucket provider.
	//
	// This field is only supported for the `aws` and `generic` providers.
	// +optional
	sts?: null | #BucketSTSSpec @go(STS,*BucketSTSSpec)

	// Insecure allows connecting to a non-TLS HTTP Endpoint.
	// +optional
	insecure?: bool @go(Insecure)

	// Region of the Endpoint where the BucketName is located in.
	// +optional
	region?: string @go(Region)

	// Prefix to use for server-side filtering of files in the Bucket.
	// +optional
	prefix?: string @go(Prefix)

	// SecretRef specifies the Secret containing authentication credentials
	// for the Bucket.
	// +optional
	secretRef?: null | meta.#LocalObjectReference @go(SecretRef,*meta.LocalObjectReference)

	// CertSecretRef can be given the name of a Secret containing
	// either or both of
	//
	// - a PEM-encoded client certificate (`tls.crt`) and private
	// key (`tls.key`);
	// - a PEM-encoded CA certificate (`ca.crt`)
	//
	// and whichever are supplied, will be used for connecting to the
	// bucket. The client cert and key are useful if you are
	// authenticating with a certificate; the CA cert is useful if
	// you are using a self-signed server certificate. The Secret must
	// be of type `Opaque` or `kubernetes.io/tls`.
	//
	// This field is only supported for the `generic` provider.
	// +optional
	certSecretRef?: null | meta.#LocalObjectReference @go(CertSecretRef,*meta.LocalObjectReference)

	// ProxySecretRef specifies the Secret containing the proxy configuration
	// to use while communicating with the Bucket server.
	// +optional
	proxySecretRef?: null | meta.#LocalObjectReference @go(ProxySecretRef,*meta.LocalObjectReference)

	// Interval at which the Bucket Endpoint is checked for updates.
	// This interval is approximate and may be subject to jitter to ensure
	// efficient use of resources.
	// +kubebuilder:validation:Type=string
	// +kubebuilder:validation:Pattern="^([0-9]+(\\.[0-9]+)?(ms|s|m|h))+$"
	// +required
	interval: metav1.#Duration @go(Interval)

	// Timeout for fetch operations, defaults to 60s.
	// +kubebuilder:default="60s"
	// +kubebuilder:validation:Type=string
	// +kubebuilder:validation:Pattern="^([0-9]+(\\.[0-9]+)?(ms|s|m))+$"
	// +optional
	timeout?: null | metav1.#Duration @go(Timeout,*metav1.Duration)

	// Ignore overrides the set of excluded patterns in the .sourceignore format
	// (which is the same as .gitignore). If not provided, a default will be used,
	// consult the documentation for your version to find out what those are.
	// +optional
	ignore?: null | string @go(Ignore,*string)

	// Suspend tells the controller to suspend the reconciliation of this
	// Bucket.
	// +optional
	suspend?: bool @go(Suspend)
}

// BucketSTSSpec specifies the required configuration to use a Security Token
// Service for fetching temporary credentials to authenticate in a Bucket
// provider.
#BucketSTSSpec: {
	// Provider of the Security Token Service.
	// +kubebuilder:validation:Enum=aws;ldap
	// +required
	provider: string @go(Provider)

	// Endpoint is the HTTP/S endpoint of the Security Token Service from
	// where temporary credentials will be fetched.
	// +required
	// +kubebuilder:validation:Pattern="^(http|https)://.*$"
	endpoint: string @go(Endpoint)

	// SecretRef specifies the Secret containing authentication credentials
	// for the STS endpoint. This Secret must contain the fields `username`
	// and `password` and is supported only for the `ldap` provider.
	// +optional
	secretRef?: null | meta.#LocalObjectReference @go(SecretRef,*meta.LocalObjectReference)

	// CertSecretRef can be given the name of a Secret containing
	// either or both of
	//
	// - a PEM-encoded client certificate (`tls.crt`) and private
	// key (`tls.key`);
	// - a PEM-encoded CA certificate (`ca.crt`)
	//
	// and whichever are supplied, will be used for connecting to the
	// STS endpoint. The client cert and key are useful if you are
	// authenticating with a certificate; the CA cert is useful if
	// you are using a self-signed server certificate. The Secret must
	// be of type `Opaque` or `kubernetes.io/tls`.
	//
	// This field is only supported for the `ldap` provider.
	// +optional
	certSecretRef?: null | meta.#LocalObjectReference @go(CertSecretRef,*meta.LocalObjectReference)
}

// BucketStatus records the observed state of a Bucket.
#BucketStatus: {
	// ObservedGeneration is the last observed generation of the Bucket object.
	// +optional
	observedGeneration?: int64 @go(ObservedGeneration)

	// Conditions holds the conditions for the Bucket.
	// +optional
	conditions?: [...metav1.#Condition] @go(Conditions,[]metav1.Condition)

	// URL is the dynamic fetch link for the latest Artifact.
	// It is provided on a "best effort" basis, and using the precise
	// BucketStatus.Artifact data is recommended.
	// +optional
	url?: string @go(URL)

	// Artifact represents the last successful Bucket reconciliation.
	// +optional
	artifact?: null | #Artifact @go(Artifact,*Artifact)

	// ObservedIgnore is the observed exclusion patterns used for constructing
	// the source artifact.
	// +optional
	observedIgnore?: null | string @go(ObservedIgnore,*string)

	meta.#ReconcileRequestStatus
}

// BucketOperationSucceededReason signals that the Bucket listing and fetch
// operations succeeded.
#BucketOperationSucceededReason: "BucketOperationSucceeded"

// BucketOperationFailedReason signals that the Bucket listing or fetch
// operations failed.
#BucketOperationFailedReason: "BucketOperationFailed"

// Bucket is the Schema for the buckets API.
#Bucket: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)
	spec?:     #BucketSpec        @go(Spec)

	// +kubebuilder:default={"observedGeneration":-1}
	status?: #BucketStatus @go(Status)
}

// BucketList contains a list of Bucket objects.
// +kubebuilder:object:root=true
#BucketList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta @go(ListMeta)
	items: [...#Bucket] @go(Items,[]Bucket)
}
