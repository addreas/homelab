package kube

k: Issuer: "selfsigning-issuer": spec: selfSigned: {}

k: Issuer: "root-ca": spec: ca: secretName: "root-ca"
k: Certificate: "root-ca": spec: {
	issuerRef: name: "selfsigning-issuer"
	secretName: "root-ca"
	subject: organizations: ["NervesHub"]
	commonName: "NervesHub Root CA"
	isCA:       true
}

k: Certificate: "device-root-ca": spec: {
	issuerRef: name: "root-ca"
	secretName: "device-root-ca"
	subject: organizations: ["NervesHub"]
	commonName: "NervesHub Device Root CA"
	isCA:       true
}

k: Certificate: "user-root-ca": spec: {
	issuerRef: name: "root-ca"
	secretName: "user-root-ca"
	subject: organizations: ["NervesHub"]
	commonName: "NervesHub user Root CA"
	isCA:       true
}

k: Issuer: "server-root-ca": spec: ca: secretName: "server-root-ca"
k: Certificate: "server-root-ca": spec: {
	issuerRef: name: "root-ca"
	secretName: "server-root-ca"
	subject: organizations: ["NervesHub"]
	commonName: "NervesHub server Root CA"
	isCA:       true
}

k: Job: "nerves-hub-ca-certificates-setup": spec: template: spec: {
	serviceAccount: "default"
	containers: [{
		name:  "cert-setup"
		image: "nixery.dev/shell/kubectl"
		command: [
			"sh",
			"-c",
			"""
				cat /etc/ssl/*/*-ca.pem > /etc/ssl/ca.pem
				cp /etc/ssl/*/*.pem /etc/ssl

				cd  /etc/ssl
				kubectl create secret generic nerves-hub-ca-certificates \\
					--from-file=ca.pem \\
					--from-file=root-ca.pem \\
					--from-file=user-root-ca.pem \\
					--from-file=server-root-ca.pem \\
					--from-file=device-root-ca.pem
				""",
		]
		volumeMounts: [{
			mountPath: "/etc/ssl"
			name:      "etc-ssl"
		}, {
			mountPath: "/etc/ssl/root"
			name:      "root-ca"
		}, {
			mountPath: "/etc/ssl/user"
			name:      "user-root-ca"
		}, {
			mountPath: "/etc/ssl/server"
			name:      "server-root-ca"
		}, {
			mountPath: "/etc/ssl/device"
			name:      "device-root-ca"
		}]
	}]
	volumes: [{
		name: "etc-ssl"
		emptyDir: {}
	}, {
		name: "root-ca"
		secret: {
			secretName: "root-ca"
			items: [{
				key:  "ca.crt"
				path: "root-ca.pem"
			}]
		}
	}, {
		name: "user-root-ca"
		secret: {
			secretName: "user-root-ca"
			items: [{
				key:  "tls.crt"
				path: "user-root-ca.pem"
			}]
		}
	}, {
		name: "server-root-ca"
		secret: {
			secretName: "server-root-ca"
			items: [{
				key:  "tls.crt"
				path: "server-root-ca.pem"
			}]
		}
	}, {
		name: "device-root-ca"
		secret: {
			secretName: "device-root-ca"
			items: [{
				key:  "tls.crt"
				path: "device-root-ca.pem"
			}]
		}
	}]
}
