package talos

t: Node: {
	let cp = {role: {"control-plane": _, "intel": _}}
	"talos-3cf-jbr": {mac: "1c:69:7a:a0:af:3e", cp}
	"talos-lcn-k2p": {mac: "1c:69:7a:6f:c2:b8", cp}
	"talos-po9-l54": {mac: "1c:69:7a:01:84:76", cp}
}

t: Node: {
	let worker = {role: {"worker": _, "intel": _, "longhorn": _}}
	"talos-hz2-2oi": {mac: "30:24:a9:87:60:bf", worker}
	"talos-o1t-0lm": {mac: "e8:d8:d1:54:d7:df", worker}

	"nucle3": {mac: "38:22:e2:0d:85:f6", worker}
	"nucle4": {mac: "84:a9:3e:10:c4:66", worker}
}
