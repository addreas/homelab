package talos

t: Node: {
	let cp = {role: {"control-plane": _, "intel": _}}
	"talos-3cf-jbr": {mac: "de:ad:be:ef", cp}
	"talos-lcn-k2p": {mac: "de:ad:be:01", cp}
	"talos-po9-l54": {mac: "de:ad:be:02", cp}
}

t: Node: {
	let worker = {role: {"worker": _, "intel": _}}
	let longhorn = {role: {"longhorn": _}}
	"talos-hz2-2oi": {mac: "de:ad:be:03", worker, longhorn}
	"talos-o1t-0lm": {mac: "de:ad:be:04", worker}
}
