package kube

k: Deployment: "nerves-hub-api": spec: template: spec: {
	containers: [{
		name:  "api"
		image: "ghcr.io/addreas/nerves_hub_api"
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
			value: "nerves_hub_api"
		}, {
			name:  "PORT"
			value: "8443"
		}, {
			name:  "HOST"
			value: "api.nh.addem.se"
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
				name: "nerves-hub-api-cert"
				items: [{
					key:  "tls.key"
					path: "api.nh.addem.se-key.pem"
				}, {
					key:  "tls.crt"
					path: "api.nh.addem.se.pem"
				}]
			}

		}]
	}]
}

k: Certificate: "nerves-hub-api": spec: {
	issuerRef: name: "server-root-ca"
	secretName: "nerves-hub-api-cert"
	subject: organizations: ["NervesHub"]
	commonName: "NervesHub API Server"
	dnsNames: ["api.nh.addem.se"]
	usages: ["server auth"]
}

k: Service: "nerves-hub-api": spec: ports: [{
	name: "https"
	port: 8443
}]

k: Ingress: "nerves-hub-api": {
	metadata: annotations: close({"ingress.kubernetes.io/ssl-passthrough": "true"})
	spec: {
		tls: []
		rules: [{
			host: "api.nh.addem.se"
		}]
	}
}

k: Image: "nerves-hub-api": spec: {
	tag: "ghcr.io/addreas/nerves_hub_api"
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
		value: "nerves_hub_api"
	}]
}
