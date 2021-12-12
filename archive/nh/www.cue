package kube

k: Deployment: "nerves-hub-www": spec: template: spec: containers: [{
	name:  "www"
	image: "ghcr.io/addreas/nerves_hub_www"
	ports: [{
		containerPort: 8080
	}, {
		containerPort: 4369
	}]
	readinessProbe: tcpSocket: port: 8080
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
		value: "postgres://$(POSTGRES_USER):$(POSTGRES_PASSWORD)@postgres.nh.svc.cluster.local/nerves"
	}, {
		name:  "APP_NAME"
		value: "nerves_hub_www"
	}, {
		name:  "PORT"
		value: "8080"
	}, {
		name:  "HOST"
		value: "www.nh.addem.se"
	}, {
		name: "LOCAL_IPV4"
		valueFrom: fieldRef: fieldPath: "status.podIP"
	}, {
		name:  "LOG_LEVEL"
		value: "info"
	}]
}]

k: Service: "nerves-hub-www": spec: {
	selector: app: "nerves-hub-www"
	ports: [{
		name: "http"
		port: 8080
	}]
}

k: Ingress: "nerves-hub-www": spec: {
	tls: [{
		hosts: ["www.nh.addem.se"]
		secretName: "nerves-hub-www-cert"
	}]
	rules: [{
		host: "www.nh.addem.se"
	}]
}

k: Image: "nerves-hub-www": spec: {
	tag:            "ghcr.io/addreas/nerves_hub_www"
	serviceAccount: "default"
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
		value: "nerves_hub_www"
	}, {
		name:  "BP_NODE_VERSION"
		value: "15"
	}, {
		name:  "BP_NODE_PROJECT_PATH"
		value: "./apps/nerves_hub_www/assets"
	}, {
		name:  "BP_MIX_DO"
		value: "assets.deploy"
	}]
}
