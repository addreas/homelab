package util

macvlanDefaultRouteFix: {
	name:  "default-route-fix"
	image: "nixery.dev/iproute2"
	command: ["ip", "route", "delete", "default", "via", "10.0.2.1"]
	securityContext: capabilities: add: ["NET_ADMIN"]
}
