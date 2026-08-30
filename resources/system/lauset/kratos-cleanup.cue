package kube

k: CronJob: "kratos-cleanup": spec: {
	schedule:                   "0 4 * * *"
	timeZone:                   "Europe/Stockholm"
	concurrencyPolicy:          "Forbid"
	successfulJobsHistoryLimit: 3
	failedJobsHistoryLimit:     1
	jobTemplate: spec: {
		backoffLimit: 3
		template: spec: {
			containers: [{
				image: "oryd/kratos:\(githubReleases["ory/kratos"])"
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
