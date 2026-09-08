package kube

k: CronJob: "hydra-cleanup": spec: {
	schedule:                   "0 4 * * *"
	timeZone:                   "Europe/Stockholm"
	concurrencyPolicy:          "Forbid"
	successfulJobsHistoryLimit: 3
	failedJobsHistoryLimit:     1
	jobTemplate: spec: {
		backoffLimit: 3
		template: spec: {
			containers: [{
				image: _images.hydra
				command: ["hydra"]
				args: ["janitor", "-e", "--grants", "--requests", "--tokens", "--keep-if-younger=24h", "--access-lifespan=1h", "--refresh-lifespan=40h", "--consent-request-lifespan=10m"]
				env: [{
					name: "DSN"
					valueFrom: secretKeyRef: {
						name: "hydra-db-app"
						key:  "uri"
					}
				}]
			}]
		}
	}
}
