package kube

k: CronJob: "kratos-cleanup": spec: {
	schedule:          "0 4 * * *"
	concurrencyPolicy: "Forbid"
	jobTemplate: spec: {
		backoffLimit: 3
		template: spec: {
			containers: [{
				image: _images.kratos
				command: ["kratos"]
				args: ["cleanup", "sql"]
				env: [{
					name: "DSN"
					valueFrom: secretKeyRef: {
						name: "kratos-db-app"
						key:  "uri"
					}
				}]
			}]
		}
	}
}
