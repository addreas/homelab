// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go net --exclude=HubbleStatus$,ControllerStatus(es)?$,ControllerList$,StatusResponse$,DebugInfo$,Endpoint(Status)?(Slice)?(List)?$

package net

// mdnsTest is for testing only.
_#mdnsTest: int

_#mdnsFromSystem:         _#mdnsTest & 0
_#mdnsAssumeExists:       _#mdnsTest & 1
_#mdnsAssumeDoesNotExist: _#mdnsTest & 2
