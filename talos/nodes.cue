@experiment(try)
package talos

import (
	"encoding/yaml"
	S "github.com/siderolabs/image-factory/pkg/schematic"
)

#Role: "control-plane" | "worker"
#Tag:  "base" | "intel" | "longhorn"

#NodeSpec: {
	hostname: string

	mac: string

	role: [#Role]: true
	roles: [...#Role]
	roles: [for r, _ in role {r}]

	tag: [#Tag]: true
	tags: [...#Tag]
	tags: [for t, _ in tag {t}]

	patch:     string
	schematic: S.#Schematic
	...
}

clusterName: "qb"
apiHost:     "api.qb"

nodes: {
	let cp = {role: "control-plane": _}
	let worker = {role: "worker": _}
	let longhorn = {tag: "longhorn": _}

	[string]: tag: "intel": _

	"talos-3cf-jbr": {mac: "de:ad:be:ef", cp}
	"talos-lcn-k2p": {mac: "de:ad:be:ef", cp}
	"talos-po9-l54": {mac: "de:ad:be:ef", cp}

	"talos-hz2-2oi": {mac: "de:ad:be:ef", worker, longhorn}
	"talos-o1t-0lm": {mac: "de:ad:be:ef", worker}
}

nodes: [name=string]: #NodeSpec & {
	hostname: name

	roles: [...string]
	tags: [...string]

	patch: yaml.MarshalStream([
		t.Patch.base,
		for role in roles try {
			t.Patch[role]?
		},
		for tag in tags try {
			t.Patch[tag]?
		},
	])

	// merge deep --strategy append...
	schematic: (#MergeAppend & {
		in: [
			t.Schematic.base,
			for role in roles try {t.Schematic[role]?},
			for tag in tags try {t.Schematic[tag]?},
		]
		appendPaths: [["customization", "extraKernelArgs"], ["customization", "systemExtensions", "officialExtensions"]]
	}).out
}
