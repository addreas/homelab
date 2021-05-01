package util

copyStatic: {
	name:  "copy-static"
	image: "busybox:stable"
	command: [
		"cp",
		"-r",
		"--no-target-directory",
		"/static",
		"/",
	]
}
