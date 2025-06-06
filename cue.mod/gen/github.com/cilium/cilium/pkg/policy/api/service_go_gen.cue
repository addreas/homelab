// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/cilium/cilium/pkg/policy/api --exclude=HubbleStatus$,ControllerStatus(es)?$,ControllerList$,StatusResponse$,DebugInfo$,Endpoint(Status)?(Slice)?(List)?$

package api

// ServiceSelector is a label selector for k8s services
#ServiceSelector: #EndpointSelector

// Service selects policy targets that are bundled as part of a
// logical load-balanced service.
//
// Currently only Kubernetes-based Services are supported.
#Service: {
	// K8sServiceSelector selects services by k8s labels and namespace
	k8sServiceSelector?: null | #K8sServiceSelectorNamespace @go(K8sServiceSelector,*K8sServiceSelectorNamespace)

	// K8sService selects service by name and namespace pair
	k8sService?: null | #K8sServiceNamespace @go(K8sService,*K8sServiceNamespace)
}

// K8sServiceNamespace selects services by name and, optionally, namespace.
#K8sServiceNamespace: {
	serviceName?: string @go(ServiceName)
	namespace?:   string @go(Namespace)
}

// K8sServiceSelectorNamespace selects services by labels.
#K8sServiceSelectorNamespace: {
	// +kubebuilder:validation:Required
	selector:   #ServiceSelector @go(Selector)
	namespace?: string           @go(Namespace)
}
