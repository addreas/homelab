module: "github.com/addreas/homelab"
language: {
	version: "v0.14.2"
}
deps: {
	"cue.dev/x/crd/bitnami.com/sealed-secrets@v0": {
		v:       "v0.0.0"
		default: true
	}
	"cue.dev/x/crd/cert-manager.io@v0": {
		v:       "v0.1.0"
		default: true
	}
	"cue.dev/x/crd/fluxcd.io@v0": {
		v:       "v0.0.0"
		default: true
	}
	"cue.dev/x/crd/monitoring.coreos.com@v0": {
		v:       "v0.0.0"
		default: true
	}
	"cue.dev/x/k8s.io@v0": {
		v:       "v0.5.0"
		default: true
	}
}
