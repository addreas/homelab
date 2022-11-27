package kube

k: HelmRelease: "grafana-tempo": spec: {
	chart: spec: {
		version: "1.8.11" // TODO: get this into tags.cue
		chart:   "tempo"
		sourceRef: name: "grafana"
	}
	values: {
		tempo: {
			storage: {
				s3: {
					endpoint:         "http://sergio.localdomain:9000/"
					s3ForcePathStyle: true
				}
				bucketNames: {
					chunks: "tempo-chunks"
					ruler:  "tempo-ruler"
					admin:  "tempo-admin"
				}
			}
		}
		gateway: enabled: false
	}
	valuesFrom: [{
		kind:       "Secret"
		name:       "tempo-s3-secret"
		valuesKey:  "secretAccessKey"
		targetPath: "tempo.s3.secretAccessKey"
	}, {
		kind:       "Secret"
		name:       "tempo-s3-secret"
		valuesKey:  "accessKeyId"
		targetPath: "tempo.s3.accessKeyId"
	}]
}

k: Secret: "tempo-s3-secret": stringData: {
	accessKeyId:     "QH6JGdM15KF1Vnss"
	secretAccessKey: "zZK8xDGP2xBY0yJFUC527DbvU8QoXQq1"
}
