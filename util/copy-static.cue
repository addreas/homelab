package util

copyStatic: {
	name:  "copy-static"
	image: "ghcr.io/kinvolk/busybox:latest"
	command: [
		"cp",
		"--recursive",
		"--dereference",
		"--no-target-directory",
		"/static",
		"/",
	]
}
