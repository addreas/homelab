package kube

k: Deployment: parseable: spec: template: spec: {
	containers: [{
		image: "parseable/parseable:v0.4.0"
		args: ["parseable", "local-store"]
		ports: [{containerPort: 8000, name: "http"}]
		env: [ for k, v in {
			RUST_LOG:                    "info"
			P_USERNAME:                  "parseable"
			P_PASSWORD:                  "parseable"
			P_ADDR:                      "0.0.0.0:8000"
			P_STAGING_DIR:               "/staging"
			P_FS_DIR:                    "/data"
			P_SEND_ANONYMOUS_USAGE_DATA: "false"
			P_PARQUET_COMPRESSION_ALGO:  "lz4" // UNCOMPRESSED, SNAPPY, GZIP, LZO, BROTLI, LZ4, ZSTD
		} {
			name:  k
			value: v
		}]
		volumeMounts: [{
			name:      "data"
			mountPath: "/data"
			subPath:   "data"
		}, {
			name:      "data"
			mountPath: "/staging"
			subPath:   "staging"
		}]
	}]
	volumes: [{
		name: "data"
		persistentVolumeClaim: claimName: "sergio-parseable-logs"
	}]
}

k: Service: parseable: {}
