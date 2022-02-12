package kube

import "strings"

k: [string]: [string]: metadata: namespace: "kube-system"

k: HelmRepository: "akri": spec: {
	url: "https://project-akri.github.io/akri"
}

let rules = [{
	SUBSYSTEM: "tty"
    "ATTRS{idProduct}": "6015"
    "ATTRS{idVendor}": "0403"
	"ATTRS{manufacturer}": "FTDI"
	"ATTRS{product}": "FT230X Basic UART"
}, {
	SUBSYSTEM: "tty"
	"ATTRS{idProduct}": "16c8"
	"ATTRS{idVendor}": "0451"
	"ATTRS{manufacturer}": "Texas Instruments"
	"ATTRS{product}":  "Yanzi Serial Radio"
}, {
	SUBSYSTEM: "tty"
    "ATTRS{idProduct}": "0030"
    "ATTRS{idVendor}": "1cf1"
	"ATTRS{manufacturer}": "dresden elektronik ingenieurtechnik GmbH"
	"ATTRS{product}":  "ConBee II"
}, {
	SUBSYSTEM: "tty"
	"ATTRS{idVendor}": "0658"
	"ATTRS{idModel}":  "0200"
}]

k: HelmRelease: "akri": {
	spec: {
		interval: "1h"
		chart: spec: {
			chart:   "akri-dev"
			version: "0.8.3"
			sourceRef: {
				name:      "akri"
				namespace: "kube-system"
			}
			interval: "1h"
		}
		values: {
			agent: host: containerRuntimeSocket: "/var/run/crio/crio.sock"
			udev: {
				discovery: enabled: true
				configuration: {
					enabled: true
					discoveryDetails: udevRules: [
						for rule in rules {
							strings.Join([
								for key, value in rule {"\(key)==\"\(value)\""}
							], ", ")
						}
					]
				}
			}
		}
	}
}