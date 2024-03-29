// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/cilium/cilium/pkg/policy/api --exclude=HubbleStatus$,ControllerStatus(es)?$,ControllerList$,StatusResponse$,DebugInfo$,Endpoint(Status)?(Slice)?(List)?$

package api

// EndpointSelector is a wrapper for k8s LabelSelector.
#EndpointSelector: _

// EndpointSelectorSlice is a slice of EndpointSelectors that can be sorted.
#EndpointSelectorSlice: [...#EndpointSelector]
