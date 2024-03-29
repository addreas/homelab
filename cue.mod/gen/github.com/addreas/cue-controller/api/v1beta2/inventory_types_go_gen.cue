// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/addreas/cue-controller/api/v1beta2

package v1beta2

// ResourceInventory contains a list of Kubernetes resource object references that have been applied by a Kustomization.
#ResourceInventory: {
	// Entries of Kubernetes resource object references.
	entries: [...#ResourceRef] @go(Entries,[]ResourceRef)
}

// ResourceRef contains the information necessary to locate a resource within a cluster.
#ResourceRef: {
	// ID is the string representation of the Kubernetes resource object's metadata,
	// in the format '<namespace>_<name>_<group>_<kind>'.
	id: string @go(ID)

	// Version is the API version of the Kubernetes resource object's kind.
	v: string @go(Version)
}
