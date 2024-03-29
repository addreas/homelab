// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go net --exclude=HubbleStatus$,ControllerStatus(es)?$,ControllerList$,StatusResponse$,DebugInfo$,Endpoint(Status)?(Slice)?(List)?$

package net

// to be used as a useTCP parameter to exchange
_#useTCPOnly:  true
_#useUDPOrTCP: false

// Maximum DNS packet size.
// Value taken from https://dnsflagday.net/2020/.
_#maxDNSPacketSize: 1232

// hostLookupOrder specifies the order of LookupHost lookup strategies.
// It is basically a simplified representation of nsswitch.conf.
// "files" means /etc/hosts.
_#hostLookupOrder: int

// hostLookupCgo means defer to cgo.
_#hostLookupCgo:      _#hostLookupOrder & 0
_#hostLookupFilesDNS: _#hostLookupOrder & 1
_#hostLookupDNSFiles: _#hostLookupOrder & 2
_#hostLookupFiles:    _#hostLookupOrder & 3
_#hostLookupDNS:      _#hostLookupOrder & 4
