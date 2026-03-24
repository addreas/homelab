package talos

import (
	"encoding/yaml"
	"strings"
	"github.com/siderolabs/image-factory/pkg/schematic"
)

#Role: =~strings.Join([for role, _ in t.Role {role}], "|")

#NodeSpec: {
	hostname: string

	mac: string

	role: [#Role]: _

	patches: [...string]

	"schematic": schematic.#Schematic
}

t: Node: [name=string]: #NodeSpec & {
	hostname: name

	role: base: _

	patches: [
		for r, _ in role
		if t.Role[r].patch != _|_ {
			yaml.Marshal(t.Role[r].patch)
		}]

	schematic: (#MergeAppend & {
		in: [
			for r, _ in role
			if t.Role[r].schematic != _|_ {
				t.Role[r].schematic
			}]
		appendPaths: [
			["customization", "extraKernelArgs"],
			["customization", "systemExtensions", "officialExtensions"],
		]
	}).out
}
