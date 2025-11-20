package v1beta2

import (
	"time"
	"strings"
)

#CueExport: {
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
	metadata?: {}

	// CueExportSpec defines the configuration to calculate the
	// desired state from a Source using Kustomize.
	spec?: {
		// CommonMetadata specifies the common labels and annotations that
		// are
		// applied to all resources. Any existing label or annotation will
		// be
		// overridden if its key matches a common one.
		commonMetadata?: {
			// Annotations to be added to the object's metadata.
			annotations?: [string]: string

			// Labels to be added to the object's metadata.
			labels?: [string]: string
		}

		// DeletionPolicy can be used to control garbage collection when
		// this
		// Kustomization is deleted. Valid values are ('MirrorPrune',
		// 'Delete',
		// 'WaitForTermination', 'Orphan'). 'MirrorPrune' mirrors the
		// Prune field
		// (orphan if false, delete if true). Defaults to 'MirrorPrune'.
		deletionPolicy?: "MirrorPrune" | "Delete" | "WaitForTermination" | "Orphan"

		// DependsOn may contain a meta.NamespacedObjectReference slice
		// with references to CueExport resources that must be ready
		// before this
		// CueExport can be reconciled.
		dependsOn?: [...{
			// Name of the referent.
			name!: string

			// Namespace of the referent, defaults to the namespace of the
			// Kustomization
			// resource object that contains the reference.
			namespace?: string

			// ReadyExpr is a CEL expression that can be used to assess the
			// readiness
			// of a dependency. When specified, the built-in readiness check
			// is replaced by the logic defined in the CEL expression.
			// To make the CEL expression additive to the built-in readiness
			// check,
			// the feature gate `AdditiveCELDependencyCheck` must be set to
			// `true`.
			readyExpr?: string
		}]

		// The CUE expression(s) to execute.
		expressions?: [...string]

		// Force instructs the controller to recreate resources
		// when patching fails due to an immutable field change.
		force?: bool

		// A list of CUE expressions that must be true for the CUE
		// instance to be
		// reconciled
		gates?: [...{
			// The CUE expression to evaluate.
			expr!: string

			// The name of the gate.
			name!: string
		}]

		// HealthCheckExprs is a list of healthcheck expressions for
		// evaluating the
		// health of custom resources using Common Expression Language
		// (CEL).
		// The expressions are evaluated only when Wait or HealthChecks
		// are specified.
		healthCheckExprs?: [...{
			// APIVersion of the custom resource under evaluation.
			apiVersion!: string

			// Current is the CEL expression that determines if the status
			// of the custom resource has reached the desired state.
			current!: string

			// Failed is the CEL expression that determines if the status
			// of the custom resource has failed to reach the desired state.
			failed?: string

			// InProgress is the CEL expression that determines if the status
			// of the custom resource has not yet reached the desired state.
			inProgress?: string

			// Kind of the custom resource under evaluation.
			kind!: string
		}]

		// A list of resources to be included in the health assessment.
		healthChecks?: [...{
			// API version of the referent, if not specified the Kubernetes
			// preferred version will be used.
			apiVersion?: string

			// Kind of the referent.
			kind!: string

			// Name of the referent.
			name!: string

			// Namespace of the referent, when not specified it acts as
			// LocalObjectReference.
			namespace?: string
		}]

		// The interval at which to reconcile the CueExport.
		// This interval is approximate and may be subject to jitter to
		// ensure
		// efficient use of resources.
		interval!: =~"^([0-9]+(\\.[0-9]+)?(ms|s|m|h))+$"

		// The KubeConfig for reconciling the CueExport on a remote
		// cluster.
		// When used in combination with CueExportSpec.ServiceAccountName,
		// forces the controller to act on behalf of that Service Account
		// at the
		// target cluster.
		// If the --default-service-account flag is set, its value will be
		// used as
		// a controller level fallback for when
		// CueExportSpec.ServiceAccountName
		// is empty.
		kubeConfig?: {
			// ConfigMapRef holds an optional name of a ConfigMap that
			// contains
			// the following keys:
			//
			// - `provider`: the provider to use. One of `aws`, `azure`,
			// `gcp`, or
			// `generic`. Required.
			// - `cluster`: the fully qualified resource name of the
			// Kubernetes
			// cluster in the cloud provider API. Not used by the `generic`
			// provider. Required when one of `address` or `ca.crt` is not
			// set.
			// - `address`: the address of the Kubernetes API server. Required
			// for `generic`. For the other providers, if not specified, the
			// first address in the cluster resource will be used, and if
			// specified, it must match one of the addresses in the cluster
			// resource.
			// If audiences is not set, will be used as the audience for the
			// `generic` provider.
			// - `ca.crt`: the optional PEM-encoded CA certificate for the
			// Kubernetes API server. If not set, the controller will use the
			// CA certificate from the cluster resource.
			// - `audiences`: the optional audiences as a list of
			// line-break-separated strings for the Kubernetes ServiceAccount
			// token. Defaults to the `address` for the `generic` provider, or
			// to specific values for the other providers depending on the
			// provider.
			// - `serviceAccountName`: the optional name of the Kubernetes
			// ServiceAccount in the same namespace that should be used
			// for authentication. If not specified, the controller
			// ServiceAccount will be used.
			//
			// Mutually exclusive with SecretRef.
			configMapRef?: {
				// Name of the referent.
				name!: string
			}

			// SecretRef holds an optional name of a secret that contains a
			// key with
			// the kubeconfig file as the value. If no key is set, the key
			// will default
			// to 'value'. Mutually exclusive with ConfigMapRef.
			// It is recommended that the kubeconfig is self-contained, and
			// the secret
			// is regularly updated if credentials such as a
			// cloud-access-token expire.
			// Cloud specific `cmd-path` auth helpers will not function
			// without adding
			// binaries and credentials to the Pod that is responsible for
			// reconciling
			// Kubernetes resources. Supported only for the generic provider.
			secretRef?: {
				// Key in the Secret, when not specified an
				// implementation-specific default key is used.
				key?: string

				// Name of the Secret.
				name!: string
			}
		}

		// The CUE package to use for the CUE instance. This is useful
		// when applying
		// a CUE schema to plain yaml files.
		package?: string

		// The paths at which the CUE instances will be built from.
		paths?: [...string]

		// Prune enables garbage collection.
		prune!: bool

		// The interval at which to retry a previously failed
		// reconciliation.
		// When not specified, the controller uses the
		// CueExportSpec.Interval
		// value to retry failures.
		retryInterval?: =~"^([0-9]+(\\.[0-9]+)?(ms|s|m|h))+$"

		// The module root of the CUE instance.
		root?: string

		// The name of the Kubernetes service account to impersonate
		// when reconciling this CueExport.
		serviceAccountName?: string

		// Reference of the source where the cue files are.
		sourceRef!: {
			// API version of the referent.
			apiVersion?: string

			// Kind of the referent.
			kind!: "OCIRepository" | "GitRepository" | "Bucket"

			// Name of the referent.
			name!: string

			// Namespace of the referent, defaults to the namespace of the
			// Kubernetes resource object that contains the reference.
			namespace?: string
		}

		// This flag tells the controller to suspend subsequent cue
		// exports,
		// it does not apply to already started executions. Defaults to
		// false.
		suspend?: bool

		// Tags that will be injected into the CUE instance.
		tags?: [...{
			name!:  string
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

		// Timeout for validation, apply and health checking operations.
		// Defaults to 'Interval' duration.
		timeout?: =~"^([0-9]+(\\.[0-9]+)?(ms|s|m|h))+$"

		// Wait instructs the controller to check the health of all the
		// reconciled resources.
		// When enabled, the HealthChecks are ignored. Defaults to false.
		wait?: bool
	}

	// CueExportStatus defines the observed state of a CueExport.
	status?: {
		conditions?: [...{
			// lastTransitionTime is the last time the condition transitioned
			// from one status to another.
			// This should be when the underlying condition changed. If that
			// is not known, then using the time when the API field changed
			// is acceptable.
			lastTransitionTime!: time.Time

			// message is a human readable message indicating details about
			// the transition.
			// This may be an empty string.
			message!: strings.MaxRunes(
					32768)

			// observedGeneration represents the .metadata.generation that the
			// condition was set based upon.
			// For instance, if .metadata.generation is currently 12, but the
			// .status.conditions[x].observedGeneration is 9, the condition
			// is out of date
			// with respect to the current state of the instance.
			observedGeneration?: int64 & int & >=0

			// reason contains a programmatic identifier indicating the reason
			// for the condition's last transition.
			// Producers of specific condition types may define expected
			// values and meanings for this field,
			// and whether the values are considered a guaranteed API.
			// The value should be a CamelCase string.
			// This field may not be empty.
			reason!: strings.MaxRunes(
					1024) & strings.MinRunes(
					1) & =~"^[A-Za-z]([A-Za-z0-9_,:]*[A-Za-z0-9_])?$"

			// status of the condition, one of True, False, Unknown.
			status!: "True" | "False" | "Unknown"

			// type of condition in CamelCase or in foo.example.com/CamelCase.
			type!: strings.MaxRunes(
				316) & =~"^([a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*/)?(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])$"
		}]

		// History contains a set of snapshots of the last reconciliation
		// attempts
		// tracking the revision, the state and the duration of each
		// attempt.
		history?: [...{
			// Digest is the checksum in the format `<algo>:<hex>` of the
			// resources in this snapshot.
			digest!: string

			// FirstReconciled is the time when this revision was first
			// reconciled to the cluster.
			firstReconciled!: time.Time

			// LastReconciled is the time when this revision was last
			// reconciled to the cluster.
			lastReconciled!: time.Time

			// LastReconciledDuration is time it took to reconcile the
			// resources in this revision.
			lastReconciledDuration!: string

			// LastReconciledStatus is the status of the last reconciliation.
			lastReconciledStatus!: string

			// Metadata contains additional information about the snapshot.
			metadata?: [string]: string

			// TotalReconciliations is the total number of reconciliations
			// that have occurred for this snapshot.
			totalReconciliations!: int64 & int
		}]

		// Inventory contains the list of Kubernetes resource object
		// references that have been successfully applied.
		inventory?: {
			// Entries of Kubernetes resource object references.
			entries!: [...{
				// ID is the string representation of the Kubernetes resource
				// object's metadata,
				// in the format '<namespace>_<name>_<group>_<kind>'.
				id!: string

				// Version is the API version of the Kubernetes resource object's
				// kind.
				v!: string
			}]
		}

		// The last successfully applied origin revision.
		// Equals the origin revision of the applied Artifact from the
		// referenced Source.
		// Usually present on the Metadata of the applied Artifact and
		// depends on the
		// Source type, e.g. for OCI it's the value associated with the
		// key
		// "org.opencontainers.image.revision".
		lastAppliedOriginRevision?: string

		// The last successfully applied revision.
		// Equals the Revision of the applied Artifact from the referenced
		// Source.
		lastAppliedRevision?: string

		// LastAttemptedRevision is the revision of the last
		// reconciliation attempt.
		lastAttemptedRevision?: string

		// LastHandledReconcileAt holds the value of the most recent
		// reconcile request value, so a change of the annotation value
		// can be detected.
		lastHandledReconcileAt?: string

		// ObservedGeneration is the last reconciled generation.
		observedGeneration?: int64 & int
	}

	_embeddedResource: {
		apiVersion!: string
		kind!:       string
		metadata?: {
			...
		}
	}
	apiVersion: "cue.toolkit.fluxcd.io/v1beta2"
	kind:       "CueExport"
	metadata!: {
		name!:      string
		namespace!: string
		labels?: [string]: string
		annotations?: [string]: string
		...
	}
}
