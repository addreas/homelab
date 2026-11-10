package kube

import (
	"strings"
	"tool/cli"
)

let _routes = [for kind, rs in k if kind == "HTTPRoute" for _, r in rs {r}]

let _grants = [for kind, rs in k if kind == "ReferenceGrant" for _, g in rs {g}]

let _authFilters = [
	for r in _routes
	for rule in r.spec.rules
	for f in *rule.filters | []
	if f.type == "ExternalAuth"
	if f.externalAuth != _|_
	if f.externalAuth.backendRef != _|_
	{
		key:         "\(r.metadata.namespace)/\(r.metadata.name)"
		routeNs:     *r.metadata.namespace | ""
		serviceNs:   *f.externalAuth.backendRef.namespace | ""
		serviceName: f.externalAuth.backendRef.name
	}
]

// ReferenceGrant entries (in the backend's namespace) that cover an auth filter
let _granted = [
	for a in _authFilters
	for g in _grants
	if (*g.metadata.namespace | "") == a.serviceNs
	for to in g.spec.to
	if (*to.group | "") == ""
	if to.kind == "Service"
	if (*to.name | a.serviceName) == a.serviceName
	for from in g.spec.from
	if from.kind == "HTTPRoute"
	if from.group == "gateway.networking.k8s.io"
	if from.namespace == a.routeNs
	{
		key:         a.key
		routeNs:     a.routeNs
		serviceNs:   a.serviceNs
		serviceName: a.serviceName
	}
]

_violations: {
	for a in _authFilters {
		if len([for x in _granted if x == a {x}]) == 0 {
			"\(a.key): ExternalAuth backend \(a.serviceNs)/\(a.serviceName) has no ReferenceGrant from HTTPRoute in \(a.routeNs)": true
		}
	}

	for r in _routes {
		if r._authproxy != _|_ {
			if r._authproxy {
				if len([for x in _authFilters if x.key == "\(r.metadata.namespace)/\(r.metadata.name)" {x}]) == 0 {
					"\(r.metadata.namespace)/\(r.metadata.name): _authproxy: true but no ExternalAuth filter": true
				}
			}
		}
	}

	for g in _grants {
		if len(g.spec.from) > 16 {
			"\(g.metadata.namespace)/\(g.metadata.name): \(len(g.spec.from)) from entries, ReferenceGrant allows at most 16": true
		}
	}
}

command: lintauthproxy: cli.Print & {
	text: strings.Join([for m, _ in _violations {m}], "; ")

	// "" unifies with "" and passes; any violation conflicts and the joined
	// message is the error
	status: ""
	status: text
}
