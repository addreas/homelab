// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/fluxcd/source-controller/api/v1beta1

package v1beta1

// SourceIndexKey is the key used for indexing resources
// resources based on their Source.
#SourceIndexKey: ".metadata.source"

// Source interface must be supported by all API types.
// +k8s:deepcopy-gen=false
#Source: _