package talos

import (
	"strings"
	factory "github.com/siderolabs/image-factory/pkg/schematic"
	"github.com/siderolabs/talos/pkg/machinery/config/types/v1alpha1"
)

#Role: =~strings.Join([for role, _ in t.Role {role}], "|")

#NodeSpec: {
	hostname: string
	mac:      string
	role: [#Role]: true
	patches: [...v1alpha1.#Config]
	schematic: factory.#Schematic
}

t: Node: [name=string]: #NodeSpec & {
	hostname: name

	role: base: _

	patches: [
		for r, _ in role
		if t.Role[r].patch != _|_ {
			t.Role[r].patch
		}]

	schematic: (#MergeAppend & {
		in: [
			for r, _ in role
			if t.Role[r].schematic != _|_ {
				t.Role[r].schematic
			}]
	}).out
}

t: Role: [string]: patch?:     v1alpha1.#Config
t: Role: [string]: schematic?: factory.#Schematic
