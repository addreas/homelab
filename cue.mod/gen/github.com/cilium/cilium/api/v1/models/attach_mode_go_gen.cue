// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/cilium/cilium/api/v1/models

package models

// AttachMode Core datapath attachment mode
//
// swagger:model AttachMode
#AttachMode: string // #enumAttachMode

#enumAttachMode:
	#AttachModeTc |
	#AttachModeTcx

// AttachModeTc captures enum value "tc"
#AttachModeTc: #AttachMode & "tc"

// AttachModeTcx captures enum value "tcx"
#AttachModeTcx: #AttachMode & "tcx"
