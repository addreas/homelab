// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/addreas/cue-controller/api/v1beta2

package v1beta2

// HealthyCondition represents the last recorded
// health assessment result.
#HealthyCondition: "Healthy"

// PruneFailedReason represents the fact that the
// pruning of the Kustomization failed.
#PruneFailedReason: "PruneFailed"

// ArtifactFailedReason represents the fact that the
// source artifact download failed.
#ArtifactFailedReason: "ArtifactFailed"

// BuildFailedReason represents the fact that the
// kustomize build failed.
#BuildFailedReason: "BuildFailed"

// GateFailedReason represents the fact that the
// cue build failed.
#GateFailedReason: "GateFailedReason"

// HealthCheckFailedReason represents the fact that
// one of the health checks failed.
#HealthCheckFailedReason: "HealthCheckFailed"

// DependencyNotReadyReason represents the fact that
// one of the dependencies is not ready.
#DependencyNotReadyReason: "DependencyNotReady"

// ReconciliationSucceededReason represents the fact that
// the reconciliation succeeded.
#ReconciliationSucceededReason: "ReconciliationSucceeded"

// ReconciliationFailedReason represents the fact that
// the reconciliation failed.
#ReconciliationFailedReason: "ReconciliationFailed"

// ProgressingWithRetryReason represents the fact that
// the reconciliation encountered an error that will be retried.
#ProgressingWithRetryReason: "ProgressingWithRetry"