// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/pivotal/kpack/pkg/apis/build/v1alpha2

package v1alpha2

import (
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
	corev1alpha1 "github.com/pivotal/kpack/pkg/apis/core/v1alpha1"
	corev1 "k8s.io/api/core/v1"
)

#ClusterStoreKind: "ClusterStore"

// +k8s:openapi-gen=true
#ClusterStore: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta  @go(ObjectMeta)
	spec:      #ClusterStoreSpec   @go(Spec)
	status:    #ClusterStoreStatus @go(Status)
}

// +k8s:openapi-gen=true
#ClusterStoreSpec: {
	// +listType
	sources?: [...corev1alpha1.#StoreImage] @go(Sources,[]corev1alpha1.StoreImage)
	serviceAccountRef?: null | corev1.#ObjectReference @go(ServiceAccountRef,*corev1.ObjectReference)
}

// +k8s:openapi-gen=true
#ClusterStoreStatus: {
	corev1alpha1.#Status

	// +listType
	buildpacks?: [...corev1alpha1.#StoreBuildpack] @go(Buildpacks,[]corev1alpha1.StoreBuildpack)
}

// +k8s:openapi-gen=true
#ClusterStoreList: {
	metav1.#TypeMeta
	metadata: metav1.#ListMeta @go(ListMeta)

	// +k8s:listType=atomic
	items: [...#ClusterStore] @go(Items,[]ClusterStore)
}