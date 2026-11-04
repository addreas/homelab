package kube

k: PostgresCluster: [Name=string]: {
	_backup?: string

	if _backup != _|_ {
		spec: plugins: [{
			name:           "barman-cloud.cloudnative-pg.io"
			isWALArchiver: true
			parameters: {
				barmanObjectName: "nas-s3"
				serverName:       Name
			}
		}]
	}
}

for Name, cluster in k.PostgresCluster if cluster._backup != _|_ {
	let ns = cluster.metadata.namespace

	if _secrets.CNPG_ACCESS_KEY_ID != _|_ {
		k: Secret: "\(ns)/cnpg-s3": stringData: {
			ACCESS_KEY_ID:     _secrets.CNPG_ACCESS_KEY_ID
			ACCESS_SECRET_KEY: _secrets.CNPG_SECRET_ACCESS_KEY
		}
	}

	k: PostgresObjectStore: "\(ns)/nas-s3": spec: {
		configuration: {
			destinationPath: "s3://cnpg-backups/\(ns)"
			endpointURL:     "http://rclone-cnpg-s3-proxy.cnpg-system.svc.cluster.local:8080"
			s3Credentials: {
				accessKeyId: {
					name: "cnpg-s3"
					key:  "ACCESS_KEY_ID"
				}
				secretAccessKey: {
					name: "cnpg-s3"
					key:  "ACCESS_SECRET_KEY"
				}
			}
			wal: compression: "gzip"
		}
		retentionPolicy: "14d"
		instanceSidecarConfiguration: retentionPolicyIntervalSeconds: 1800
	}

	k: PostgresScheduledBackup: "\(ns)/\(Name)-daily": spec: {
		schedule:             k.PostgresCluster[Name]._backup
		backupOwnerReference: "cluster"
		method:               "plugin"
		pluginConfiguration: name: "barman-cloud.cloudnative-pg.io"
		cluster: name: Name
	}
}
