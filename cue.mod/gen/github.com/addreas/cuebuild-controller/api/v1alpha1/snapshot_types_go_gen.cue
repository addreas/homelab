// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/addreas/cuebuild-controller/api/v1alpha1

package v1alpha1

// Snapshot holds the metadata of the Kubernetes objects
// generated for a source revision
#Snapshot: {
	// The manifests sha1 checksum.
	// +required
	checksum: string @go(Checksum)

	// A list of Kubernetes kinds grouped by namespace.
	// +required
	entries: [...#SnapshotEntry] @go(Entries,[]SnapshotEntry)
}

// Snapshot holds the metadata of namespaced
// Kubernetes objects
#SnapshotEntry: {
	// The namespace of this entry.
	// +optional
	namespace: string @go(Namespace)

	// The list of Kubernetes kinds.
	// +required
	kinds: {[string]: string} @go(Kinds,map[string]string)
}
