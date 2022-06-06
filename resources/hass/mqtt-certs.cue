package kube

k: Issuer: "mqtt-selfsigning-issuer": spec: selfSigned: {}
k: Issuer: "mqtt-root-issuer": spec: ca: secretName: "mqtt-root-ca-cert"

k: Certificate: "mqtt-root-ca-cert": spec: {
	issuerRef: name: "mqtt-selfsigning-issuer"
	secretName: "mqtt-root-ca-cert"
	subject: organizations: ["MQTT"]
	commonName: "MQTT Root CA"
	isCA:       true
	usages: ["cert sign", "crl sign"]
}

k: Certificate: "mqtt-mosquitto-cert": spec: {
	issuerRef: name: "mqtt-root-issuer"
	secretName: "mqtt-mosquitto-cert"
	subject: organizations: ["MQTT"]
	commonName: "mosquitto"
	dnsNames: ["mqtt.addem.se"]
}

k: Certificate: "mqtt-hass-cert": spec: {
	issuerRef: name: "mqtt-root-issuer"
	secretName: "mqtt-hass-cert"
	subject: organizations: ["MQTT"]
	commonName: "hass"
	dnsNames: ["hass.addem.se"]
}

k: Certificate: "mqtt-switchbot-proxy-cert": spec: {
	issuerRef: name: "mqtt-root-issuer"
	secretName: "mqtt-switchbot-proxy-cert"
	subject: organizations: ["MQTT"]
	duration:   "\(24*365*20)h"
	commonName: "switchbot"
}
