package util

copyStatic: {
	name:  "copy-static"
	image: "nixery.dev/shell"
	command: ["sh", "-c", "cp --dereference /static\(volumeMounts[0].mountPath)/* \(volumeMounts[0].mountPath)"]
	securityContext: runAsUser: 1000
	volumeMounts: [{mountPath: !~"^/static"}, ...{mountPath: string}]
}
