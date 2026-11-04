package kube

import (
	"encoding/yaml"
	"encoding/hex"
	"crypto/md5"
)

k: Deployment: vikunja: spec: template: metadata: labels: "config-hash":
	hex.Encode(md5.Sum(k.ConfigMap."vikunja-config".data."config.yml"))

k: Deployment: vikunja: spec: template: spec: {
	containers: [{
		image: "vikunja/vikunja:1.1.0"
		ports: [{name: "http", containerPort: 3456}]

		env: [{
			name:  "VIKUNJA_DATABASE_PATH"
			value: "/data/vikunja.db"
		}, {
			name: "VIKUNJA_AUTH_OPENID_PROVIDERS_LAUSET_CLIENTID"
			valueFrom: secretKeyRef: {
				name: "vikunja-oauth2-client-credentials"
				key:  "CLIENT_ID"
			}
		}, {
			name: "VIKUNJA_AUTH_OPENID_PROVIDERS_LAUSET_CLIENTSECRET"
			valueFrom: secretKeyRef: {
				name: "vikunja-oauth2-client-credentials"
				key:  "CLIENT_SECRET"
			}
		}]

		resources: {
			limits: {
				cpu:    "250m"
				memory: "1Gi"
			}
			requests: {
				cpu:    "250m"
				memory: "1Gi"
			}
		}
		volumeMounts: [{
			mountPath: "/data"
			name:      "data"
			subPath:   "data"
		}, {
			mountPath: "/.cache"
			name:      "data"
			subPath:   ".cache"
		}, {
			mountPath: "/etc/vikunja/config.yml"
			name:      "config"
			subPath:   "config.yml"
		}]
	}]
	volumes: [{
		name: "data"
		persistentVolumeClaim: claimName: "vikunja-data"
	}, {
		name: "config"
		configMap: name: "vikunja-config"
	}]
}

k: Service: vikunja: {}
k: Ingress: vikunja: {}

k: ConfigMap: "vikunja-config": data: "config.yml": yaml.Marshal({
	service: publicurl: "https://vikunja.addem.se/"
	database: path:     "/data/vikunja.db"
	files: basepath:    "/data/files"
	auth: {
		local: enabled:  false
		openid: enabled: true
		openid: providers: lauset: {
			name:          "Lauset"
			authurl:       "https://auth.addem.se/hydra/"
			forceuserinfo: true
		}
	}
})

k: PersistentVolumeClaim: "vikunja-data": spec: {
	accessModes: ["ReadWriteOnce"]
	resources: requests: storage: "1Gi"
}

k: OAuth2Client: "vikunja": spec: {
	secretName: "vikunja-oauth2-client-credentials"
	redirectUris: ["https://vikunja.addem.se/auth/openid/lauset"]
}
