package kube

import "encoding/yaml"

k: ServiceAccount: "hydra-hydra-maester-account": {}

k: ConfigMap: hydra: data: "config.yaml": yaml.Marshal({
	existingSecret: ""
	serve: {
		admin: port:  4445
		public: port: 4444
		tls: allow_termination_from: ["10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16"]
	}
	urls: self: {}
})

k: ClusterRole: "hydra-hydra-maester-role": rules: [{
	apiGroups: ["hydra.ory.sh"]
	resources: ["oauth2clients", "oauth2clients/status"]
	verbs: ["get", "list", "watch", "create", "update", "patch", "delete"]
}, {
	apiGroups: [""]
	resources: ["secrets"]
	verbs: ["list", "watch", "create"]
}]

k: ClusterRoleBinding: "hydra-hydra-maester-role-binding": {
	subjects: [{
		kind:      "ServiceAccount"
		name:      "hydra-hydra-maester-account" // Service account assigned to the controller pod.
		namespace: "ory"
	}]
	roleRef: {
		apiGroup: "rbac.authorization.k8s.io"
		kind:     "ClusterRole"
		name:     "hydra-hydra-maester-role"
	}
}

k: Role: "hydra-hydra-maester-role-ory": rules: [{
	apiGroups: [""]
	resources: ["secrets"]
	verbs: ["get", "list", "watch", "create"]
}]

k: RoleBinding: "hydra-hydra-maester-role-binding-ory": {
	subjects: [{
		kind:      "ServiceAccount"
		name:      "hydra-hydra-maester-account" // Service account assigned to the controller pod.
		namespace: "ory"
	}]
	roleRef: {
		apiGroup: "rbac.authorization.k8s.io"
		kind:     "Role"
		name:     "hydra-hydra-maester-role-ory"
	}
}

k: Service: "hydra-admin": spec: {
	type: "ClusterIP"
	ports: [{
		port:       4445
		targetPort: "http-admin"
		name:       "http"
	}]
	selector: app: "hydra"
}

k: Service: "hydra-public": spec: {
	type: "ClusterIP"
	ports: [{
		port:       4444
		targetPort: "http-public"
		name:       "http"
	}]
	selector: app: "hydra"
}

k: Deployment: "hydra-hydra-maester": spec: template: spec: {
	containers: [{
		name:            "hydra-maester"
		image:           "oryd/hydra-maester:v0.0.24"
		imagePullPolicy: "IfNotPresent"
		command: ["/manager"]
		args: [
			"--metrics-addr=127.0.0.1:8080",
			"--hydra-url=http://hydra-admin",
			"--hydra-port=4445",
		]
	}]
	serviceAccountName:           "hydra-hydra-maester-account"
	automountServiceAccountToken: true
}

k: Deployment: hydra: spec: template: spec: {
	volumes: [{
		name: "hydra-config-volume"
		configMap: name: "hydra"
	}]
	serviceAccountName: "hydra"
	containers: [{
		name:  "hydra"
		image: "oryd/hydra:v1.10.5"
		command: ["hydra"]
		volumeMounts: [{
			name:      "hydra-config-volume"
			mountPath: "/etc/config"
			readOnly:  true
		}]
		args: [
			"serve",
			"all",
			"--config",
			"/etc/config/config.yaml",
		]
		ports: [{
			name:          "http-public"
			containerPort: 4444
		}, {
			name:          "http-admin"
			containerPort: 4445
		}]
		livenessProbe: httpGet: {
			path: "/health/alive"
			port: "http-admin"
		}
		readinessProbe: httpGet: {
			path: "/health/ready"
			port: "http-admin"
		}
		env: [{
			name:  "URLS_SELF_ISSUER"
			value: "http://127.0.0.1:4444/"
		}, {
			name: "DSN"
			valueFrom: secretKeyRef: {
				name: "hydra"
				key:  "dsn"
			}
		}, {
			name: "SECRETS_SYSTEM"
			valueFrom: secretKeyRef: {
				name: "hydra"
				key:  "secretsSystem"
			}
		}, {
			name: "SECRETS_COOKIE"
			valueFrom: secretKeyRef: {
				name: "hydra"
				key:  "secretsCookie"
			}
		}]
	}]
}

k: Secret: hydra: stringData: {
	// Generate a random secret if the user doesn't give one. User given password has priority
	secretsSystem: "NGc0QTY2Sk14NWpuTFZvN0p4ZFVmZlNQYzFpUk9wVkY="
	secretsCookie: "bHZPQUphY1o3WWNyN2RBMUprRnpxWU5HRmZrWmhpRTI="
	dsn:           ""
}
