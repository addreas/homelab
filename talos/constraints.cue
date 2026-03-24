@experiment(try)
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

	roles: [#Role]: _

	patches: [...string]

	"schematic": schematic.#Schematic
}

t: Node: [name=string]: #NodeSpec & {
	hostname: name

	roles: base: _

	patches: [for role, _ in roles if t.Role[role].patch != _|_ {yaml.Marshal(t.Role[role].patch)}]

	schematic: (#MergeAppend & {
		in: [for role, _ in roles if t.Role[role].schematic != _|_ {t.Role[role].schematic}]
		appendPaths: [["customization", "extraKernelArgs"], ["customization", "systemExtensions", "officialExtensions"]]
	}).out
}
