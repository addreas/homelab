package kube

import (
	"crypto/md5"
	"encoding/hex"
	"encoding/yaml"
)

k: ConfigMap: "loki": data: "config.yaml": yaml.Marshal({
	auth_enabled: false

	server: {
		http_listen_port: 3100
		grpc_listen_port: 9096
		log_level:        "warn"
	}

	common: {
		instance_addr: "127.0.0.1"
		path_prefix:   "/data"
		storage: filesystem: {
			chunks_directory: "/data/chunks"
			rules_directory:  "/data/rules"
		}
		replication_factor: 1
		ring: kvstore: store: "inmemory"
	}

	query_range: results_cache: cache: embedded_cache: {
		enabled:     true
		max_size_mb: 100
	}

	schema_config: configs: [{
		from:         "2020-10-24"
		store:        "boltdb-shipper"
		object_store: "filesystem"
		schema:       "v11"
		index: {
			prefix: "index_"
			period: "24h"
		}
	}, {
		from:         "2025-01-27"
		store:        "tsdb"
		object_store: "filesystem"
		schema:       "v13"
		index: {
			prefix: "index_"
			period: "24h"
		}
	}]

	limits_config: volume_enabled: true
	pattern_ingester: enabled:     true

	ruler: alertmanager_url: "http://alertmanager-main.monitoring.svc.cluster.local:9093"
})

k: Deployment: loki: spec: template: {
	metadata: labels: "config-hash": hex.Encode(md5.Sum(k.ConfigMap.loki.data["config.yaml"]))
	spec: {
		containers: [{
			image: "grafana/loki:3.3.2"
			args: ["--config.file=/etc/loki/config.yaml"]
			ports: [{name: "http", containerPort: 3100}, {name: "grcp", containerPort: 9096}]
			volumeMounts: [{
				name:      "config"
				mountPath: "/etc/loki"
			}, {
				name:      "data"
				mountPath: "/data"
			}]
		}]
		volumes: [{
			name: "config"
			configMap: name: "loki"
		}, {
			name: "data"
			persistentVolumeClaim: claimName: "sergio-loki"
		}]
	}
}

k: PersistentVolumeClaim: "sergio-loki": spec: resources: requests: storage: "100Gi"
k: PersistentVolume: "sergio-loki": spec: local: path: "/mnt/solid-data/loki"

k: Service: loki: {}
k: ServiceMonitor: loki: {}

k: GrafanaDatasource: "loki": spec: {
	datasource: {
		name:      "Loki"
		type:      "loki"
		url:       "http://loki.monitoring.svc.cluster.local:3100"
		access:    "proxy"
		isDefault: false
		basicAuth: false
	}
}
