// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go net --exclude=HubbleStatus$,ControllerStatus(es)?$,ControllerList$,StatusResponse$,DebugInfo$,Endpoint(Status)?(Slice)?(List)?$

package net

// UnixAddr represents the address of a Unix domain socket end point.
#UnixAddr: {
	Name: string
	Net:  string
}
