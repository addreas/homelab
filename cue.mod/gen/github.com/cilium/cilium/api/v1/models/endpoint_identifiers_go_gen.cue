// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/cilium/cilium/api/v1/models

package models

// EndpointIdentifiers Unique identifiers for this endpoint from outside cilium
//
// +deepequal-gen=true
//
// swagger:model EndpointIdentifiers
#EndpointIdentifiers: {
	// ID assigned to this attachment by container runtime
	"cni-attachment-id"?: string @go(CniAttachmentID)

	// ID assigned by container runtime (deprecated, may not be unique)
	"container-id"?: string @go(ContainerID)

	// Name assigned to container (deprecated, may not be unique)
	"container-name"?: string @go(ContainerName)

	// Docker endpoint ID
	"docker-endpoint-id"?: string @go(DockerEndpointID)

	// Docker network ID
	"docker-network-id"?: string @go(DockerNetworkID)

	// K8s namespace for this endpoint (deprecated, may not be unique)
	"k8s-namespace"?: string @go(K8sNamespace)

	// K8s pod name for this endpoint (deprecated, may not be unique)
	"k8s-pod-name"?: string @go(K8sPodName)

	// K8s pod for this endpoint (deprecated, may not be unique)
	"pod-name"?: string @go(PodName)
}
