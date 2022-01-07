package kube

k: Deployment: "nerves-hub-device": spec: template: spec: {
	containers: [{
		name:  "device"
		image: "ghcr.io/addreas/nerves_hub_device"
		// command: ["launcher", "nerves_hub_api", "eval", "NervesHubWebCore.Release.Tasks.migrate_and_seed()"]
		ports: [{
			containerPort: 8443
		}, {
			containerPort: 4369
		}]
		readinessProbe: tcpSocket: port: 8443
		volumeMounts: [{
			mountPath: "/etc/ssl"
			name:      "etc-ssl"
		}]
		envFrom: [
			{secretRef: name:    "s3-credentials"},
			{secretRef: name:    "email-credentials"},
			{secretRef: name:    "shared-secrets"},
			{secretRef: name:    "postgres-credentials"},
			{configMapRef: name: "s3-config"},
			{configMapRef: name: "email-config"},
			{configMapRef: name: "shared-config"},
		]
		env: [{
			name:  "DATABASE_URL"
			value: "postgres://$(POSTGRES_USER):$(POSTGRES_PASSWORD)@postgres/nerves"
		}, {
			name:  "APP_NAME"
			value: "nerves_hub_device"
		}, {
			name:  "PORT"
			value: "8443"
		}, {
			name:  "HOST"
			value: "device.nh.addem.se"
		}, {
			name: "LOCAL_IPV4"
			valueFrom: fieldRef: fieldPath: "status.podIP"
		}, {
			name:  "LOG_LEVEL"
			value: "info"
		}]
	}]
	volumes: [{
		name: "etc-ssl"
		projected: sources: [{
			secret: name: "nerves-hub-ca-certificates"
		}, {
			secret: {
				name: "nerves-hub-device-cert"
				items: [{
					key:  "tls.key"
					path: "device.nh.addem.se-key.pem"
				}, {
					key:  "tls.crt"
					path: "device.nh.addem.se.pem"
				}]
			}
		}]
	}]
}

k: Certificate: "nerves-hub-device": spec: {
	issuerRef: name: "server-root-ca"
	secretName: "nerves-hub-device-cert"
	subject: organizations: ["NervesHub"]
	commonName: "NervesHub Device Server"
	dnsNames: ["device.nh.addem.se"]
	usages: ["server auth"]
}

k: Service: "nerves-hub-device": spec: {
	selector: app: "nerves-hub-device"
	ports: [{
		name: "https"
		port: 8443
	}]
}

k: Ingress: "nerves-hub-device": {
	metadata: annotations: close({"ingress.kubernetes.io/ssl-passthrough": "true"})
	spec: {
		tls: []
		rules: [{
			host: "device.nh.addem.se"
		}]
	}
}

k: Image: "nerves-hub-device": spec: {
	tag:            "ghcr.io/addreas/nerves_hub_device"
	builder: {
		name: "nh-builder"
		kind: "Builder"
	}
	source: git: {
		url:      "https://github.com/addreas/nerves_hub_web.git"
		revision: _nervesHubWebRevision
	}
	build: env: [{
		name:  "BP_RELEASE_NAME"
		value: "nerves_hub_device"
	}]
}
