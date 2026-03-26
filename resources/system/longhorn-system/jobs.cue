package kube

k: LonghornRecurringJob: "backup-5-daily": spec: {
	task:   "backup"
	cron:   "0 0 * * *"
	retain: 5
	groups: ["default"]
}

k: LonghornRecurringJob: "backup-12-weekly": spec: {
	task:   "backup"
	cron:   "0 0 ? * SAT"
	retain: 12
	groups: ["long"]
}

k: LonghornRecurringJob: "trim-daily": spec: {
	task:        "filesystem-trim"
	cron:        "0 4 * * *"
	concurrency: 5
	groups: ["default"]
}
