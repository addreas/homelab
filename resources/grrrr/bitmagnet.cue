package kube

import "encoding/yaml"

k: Deployment: bitmagnet: spec: {
	replicas: 1
	template: {
		metadata: labels: "vpn-egress": "client"
		spec: containers: [{
			name:  "bitmagnet"
			image: "ghcr.io/bitmagnet-io/bitmagnet:v0.10.0"
			command: ["bitmagnet", "worker", "run", "--all"]
			env: [{
				name: "POSTGRES_DSN"
				valueFrom: secretKeyRef: {
					name: "bitmagnet-db-app"
					key:  "uri"
				}
			}, {
				name: "TMDB_API_KEY"
				valueFrom: secretKeyRef: {
					name: "tmdb-api-key"
					key:  "api-key"
				}
			}]
			ports: [{
				name:          "http"
				containerPort: 3333
			}]
			livenessProbe: {
				httpGet: {
					path: "/status"
					port: "http"
				}
				initialDelaySeconds: 30
				periodSeconds:       60
				failureThreshold:    10
			}
			workingDir: "/config"
			volumeMounts: [{
				name:      "config"
				mountPath: "/config"
			}]
			resources: {
				limits: {
					cpu:    "1"
					memory: "2Gi"
				}
				requests: {
					cpu:    "250m"
					memory: "512Mi"
				}
			}
		}]
		spec: volumes: [{
			name: "config"
			configMap: name: "bitmagnet"
		}]
	}
}

k: ConfigMap: bitmagnet: data: {
	"config.yml": yaml.Marshal({
		classifier: {
			"workflow": "movie-tv-only"
			flags: delete_content_types: [
				"audiobook",
				"comic",
				"ebook",
				"game",
				"music",
				"software",
				"unknown",
				"xxx",
			]
		}
	})
	"classifier.yml": yaml.Marshal({
		workflows: "movie-tv-only": [{
			if_else: {
				condition: "([torrent.baseName] + torrent.files.map(f, f.basePath)).join(' ').matches(keywords.xxx)"
				if_action: "delete"
			}
		}, {
			if_else: {
				condition: {
					or: [
						"result.contentType in [contentType.movie, contentType.tv_show]",
						"torrent.files.map(f, f.extension in extensions.video ? f.size : - f.size).sum() > 100*mb",
					]
				}
				if_action: run_workflow: "default"
				else_action: "delete"
			}
		}]
	})
}

k: Service: bitmagnet: {}

k: HTTPRoute: bitmagnet: _authproxy: true

k: PostgresCluster: "bitmagnet-db": spec: {
	instances: 2
	storage: size: "5Gi"
}
