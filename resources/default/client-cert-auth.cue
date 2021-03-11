package kube

k: Issuer: "client-auth-selfsigned": spec: selfSigned: {}

k: Issuer: "client-auth-root-issuer": spec: ca: secretName: "client-auth-root-ca-cert"

k: Certificate: "client-auth-root-ca": {
	spec: {
		issuerRef: name: "client-auth-selfsigned"
		secretName: "client-auth-root-ca-cert"
		commonName: "addem.se"
		isCA:       true
		usages: [
			"cert sign",
			"crl sign",
		]
	}
}

k: Certificate: addem: {
	spec: {
		issuerRef: name: "client-auth-root-issuer"
		secretName: "addem-cert"
		commonName: "addem"
		usages: [
			"client auth",
		]
	}
}

k: Certificate: jonas: {
	spec: {
		issuerRef: name: "client-auth-root-issuer"
		secretName: "jonas-cert"
		commonName: "jonas"
		usages: ["client auth"]
	}
}
