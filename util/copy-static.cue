package util

copyStatic: {
	name:  "copy-static"
	image: "ghcr.io/kinvolk/busybox:latest"
	command: [
		"cp",
		"-r",
		"--no-target-directory",
		"/static",
		"/",
	]
}
