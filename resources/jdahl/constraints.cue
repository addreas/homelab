package kube

k: HTTPRoute: [Name=string]: {
	spec: parentRefs: [{name: "jdahl", namespace: "ingress"}]
	// Name.jdahl.se unless the route sets hostnames; excludes the addem.se default
	spec: hostnames: (*["\(Name).jdahl.se"] | [...string]) & [...{!~"addem\\.se"}]
}
