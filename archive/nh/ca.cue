package kube

k: Deployment: "nerves-hub-ca": spec: template: spec: {
	containers: [{
		name:  "ca"
		image: "ghcr.io/addreas/nerves_hub_ca"
		// command: ["launcher", "mix", "ecto.migrate"]
		ports: [{
			containerPort: 8443
		}]
		readinessProbe: tcpSocket: port: 8443
		envFrom: [
			{secretRef: name: "shared-secrets"},
			{secretRef: name: "postgres-credentials"},
		]
		env: [{
			name:  "DATABASE_URL"
			value: "postgres://$(POSTGRES_USER):$(POSTGRES_PASSWORD)@postgres/nerves"
		}, {
			name:  "APP_NAME"
			value: "nerves_hub_ca"
		}, {
			name:  "HOST"
			value: "nerves-hub-ca.nh.svc.cluster.local"
		}, {
			name: "LOCAL_IPV4"
			valueFrom: fieldRef: fieldPath: "status.podIP"
		}, {
			name:  "LOG_LEVEL"
			value: "info"
		}]
		volumeMounts: [{
			mountPath: "/etc/ssl"
			name:      "etc-ssl"
		}]
	}]
	volumes: [{
		name: "etc-ssl"
		projected: sources: [{
			secret: name: "nerves-hub-ca-certificates"
		}, {
			secret: {
				name: "nerves-hub-ca-cert"
				items: [{
					key:  "tls.key"
					path: "nerves-hub-ca.nh.svc.cluster.local-key.pem"
				}, {
					key:  "tls.crt"
					path: "nerves-hub-ca.nh.svc.cluster.local.pem"
				}]
			}
		}, {
			secret: {
				name: "user-root-ca"
				items: [{
					key:  "tls.key"
					path: "user-root-ca-key.pem"
				}]
			}
		}, {
			secret: {
				name: "device-root-ca"
				items: [{
					key:  "tls.key"
					path: "device-root-ca-key.pem"
				}]
			}
		}]
	}]
}

k: Certificate: "nerves-hub-ca": spec: {
	issuerRef: name: "server-root-ca"
	secretName: "nerves-hub-ca-cert"
	subject: organizations: ["NervesHub"]
	commonName: "NervesHub CA Server"
	dnsNames: ["ca.nh.svc.cluster.local"]
	usages: ["server auth"]
}

k: Service: "nerves-hub-ca": spec: {
	selector: app: "nerves-hub-ca"
	ports: [{
		port:       8443
		targetPort: 8443
	}]
}

k: Image: "nerves-hub-ca": spec: {
	tag:            "ghcr.io/addreas/nerves_hub_ca"
	serviceAccount: "default"
	builder: {
		name: "nh-builder"
		kind: "Builder"
	}
	source: git: {
		url:      "https://github.com/nerves-hub/nerves_hub_ca.git"
		revision: "5d8c7bed3fc0b151b496592b3c1dc4422680699c"
	}
	build: env: [{
		name:  "BP_RELEASE_NAME"
		value: "nerves_hub_ca"
	}]
}
