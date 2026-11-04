package talos

import (
	"strings"
	factory "github.com/siderolabs/image-factory/pkg/schematic"
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
		if t.Role[r].patches != _|_
		for p in t.Role[r].patches {p}, {
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

t: Role: [string]: patches?: [...]
t: Role: [string]: schematic?: factory.#Schematic

_check: ""
for _, node in t.Node
for i, p in node.patches
if p["$patch"] == _|_
if (p & #Patch) == _|_ {
	_check: "invalid patch in \(node.hostname) [\(i)]"
}
