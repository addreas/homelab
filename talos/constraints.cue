package talos

import (
	"strings"
	factory "github.com/siderolabs/image-factory/pkg/schematic"
	"github.com/siderolabs/talos/pkg/machinery/config/types/v1alpha1"
	// "github.com/siderolabs/talos/pkg/machinery/config/types/network"
)

#Role: =~strings.Join([for role, _ in t.Role {role}], "|")

#NodeSpec: {
	hostname: string
	mac:      string
	ip?:      string
	role: [#Role]: true
	patches: [...]
	schematic: factory.#Schematic
}

t: Node: [name=string]: #NodeSpec & {
	role: base: _

	ip?: string

	patches: [
		for r, _ in role
		if t.Role[r].patch != _|_ {
			t.Role[r].patch
		}, {
			apiVersion: "v1alpha1"
			kind:       "HostnameConfig"
			hostname:   name
			auto:       "off"
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
