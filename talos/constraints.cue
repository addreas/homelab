package talos

import (
	"strings"
	factory "github.com/siderolabs/image-factory/pkg/schematic"
	"github.com/siderolabs/talos/pkg/machinery/config/types/v1alpha1"
	// "github.com/siderolabs/talos/pkg/machinery/config/types/network"
)

#Role: =~strings.Join([for role, _ in t.Role {role}], "|")

#NodeSpec: {
	// inputs
	mac: string
	ip?: string
	roles: [...#Role]

	// derived outputs
	hostname: string
	patches: [...]
	schematic: factory.#Schematic
}

t: Node: [name=string]: #NodeSpec & {
	roles: _

	hostname: name

	patches: [
		for r in roles
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
			for r in roles
			if t.Role[r].schematic != _|_ {
				t.Role[r].schematic
			}]
	}).out
}

t: Role: [string]: patch?:     v1alpha1.#Config
t: Role: [string]: schematic?: factory.#Schematic
