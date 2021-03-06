// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/cilium/cilium/api/v1/models

package models

// ClusterMeshStatus Status of ClusterMesh
//
// +k8s:deepcopy-gen=true
//
// swagger:model ClusterMeshStatus
#ClusterMeshStatus: {
	// List of remote clusters
	clusters: [...null | #RemoteCluster] @go(Clusters,[]*RemoteCluster)

	// Number of global services
	"num-global-services"?: int64 @go(NumGlobalServices)
}
