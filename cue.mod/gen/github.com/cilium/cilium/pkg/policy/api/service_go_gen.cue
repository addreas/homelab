// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/cilium/cilium/pkg/policy/api

package api

// ServiceSelector is a label selector for k8s services
#ServiceSelector: #EndpointSelector

// Service wraps around selectors for services
#Service: {
	// K8sServiceSelector selects services by k8s labels and namespace
	k8sServiceSelector?: null | #K8sServiceSelectorNamespace @go(K8sServiceSelector,*K8sServiceSelectorNamespace)

	// K8sService selects service by name and namespace pair
	k8sService?: null | #K8sServiceNamespace @go(K8sService,*K8sServiceNamespace)
}

// K8sServiceNamespace is an abstraction for the k8s service + namespace types.
#K8sServiceNamespace: {
	serviceName?: string @go(ServiceName)
	namespace?:   string @go(Namespace)
}

// K8sServiceSelectorNamespace wraps service selector with namespace
#K8sServiceSelectorNamespace: {
	// +kubebuilder:validation:Required
	selector:   #ServiceSelector @go(Selector)
	namespace?: string           @go(Namespace)
}