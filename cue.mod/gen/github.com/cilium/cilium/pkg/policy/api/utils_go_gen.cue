// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/cilium/cilium/pkg/policy/api --exclude=HubbleStatus$,ControllerStatus(es)?$,ControllerList$,StatusResponse$,DebugInfo$,Endpoint(Status)?(Slice)?(List)?$

package api

#Option: int // #enumOption

#enumOption:
	#ForceNamespace

#values_Option: ForceNamespace: #ForceNamespace

#ForceNamespace: #Option & 0