// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/pivotal/kpack/pkg/apis/core/v1alpha1

package v1alpha1

// +k8s:openapi-gen=true
// +k8s:deepcopy-gen=true
#StoreImage: {
	image?: string @go(Image)
}

// +k8s:openapi-gen=true
// +k8s:deepcopy-gen=true
#StoreBuildpack: {
	#BuildpackInfo
	buildpackage?: #BuildpackageInfo @go(Buildpackage)
	storeImage?:   #StoreImage       @go(StoreImage)
	diffId?:       string            @go(DiffId)
	digest?:       string            @go(Digest)
	size?:         int64             @go(Size)
	api?:          string            @go(API)
	homepage?:     string            @go(Homepage)

	// +listType
	order?: [...#OrderEntry] @go(Order,[]OrderEntry)

	// +listType
	stacks?: [...#BuildpackStack] @go(Stacks,[]BuildpackStack)
}

#Order: [...#OrderEntry]

// +k8s:openapi-gen=true
// +k8s:deepcopy-gen=true
#OrderEntry: {
	// +listType
	group?: [...#BuildpackRef] @go(Group,[]BuildpackRef)
}

// +k8s:openapi-gen=true
// +k8s:deepcopy-gen=true
#BuildpackRef: {
	#BuildpackInfo
	optional?: bool @go(Optional)
}

// +k8s:openapi-gen=true
// +k8s:deepcopy-gen=true
#BuildpackInfo: {
	id:       string @go(Id)
	version?: string @go(Version)
}

// +k8s:openapi-gen=true
// +k8s:deepcopy-gen=true
#BuildpackStack: {
	id: string @go(ID)

	// +listType
	mixins?: [...string] @go(Mixins,[]string)
}