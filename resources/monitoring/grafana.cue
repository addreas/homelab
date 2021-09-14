package kube

k: Grafana: grafana: spec: {
	baseImage: "grafana/grafana:latest"
	config: {
		server: root_url: "https://grafana.addem.se/"
		auth: {
			disable_login_form:   true
			disable_signout_menu: true
		}
		"auth.anonymous": {
			enabled:  true
			org_role: "Admin"
		}
		alerting: enabled: false
	}
	client: {
		timeout:       5
		preferService: true
	}
	ingress: {
		enabled:       true
		hostname:      "grafana.addem.se"
		tlsEnabled:    true
		tlsSecretName: "grafana-cert"
		annotations: {
			"cert-manager.io/cluster-issuer": "addem-se-letsencrypt"
			// ingress.kubernetes.io/auth-tls-error-page: getcert.addem.se
			"ingress.kubernetes.io/auth-tls-secret":        "default/client-auth-root-ca-cert"
			"ingress.kubernetes.io/auth-tls-strict":        "true"
			"ingress.kubernetes.io/auth-tls-verify-client": "on"
		}
		path:     "/"
		pathType: "Prefix"
	}
	dashboardLabelSelector: [{
		matchLabels: grafana: "enabled"
	}]
}

k: GitRepository: "grafana-operator": spec: {
	interval: "1h"
	ref: branch: "master"
	url: "https://github.com/grafana-operator/grafana-operator.git"
	ignore: """
		/*
		!/config
		"""
}

k: Kustomization: "grafana-operator": spec: {
	healthChecks: [{
		kind:      "Deployment"
		name:      "grafana-operator-controller-manager"
		namespace: "monitoring"
	}]
	interval: "30m"
	path:     "./config/default"
	prune:    true
	sourceRef: {
		kind: "GitRepository"
		name: "grafana-operator"
	}
	targetNamespace: "monitoring"
	images: [{
		name:    "quay.io/integreatly/grafana-operator:latest"
		newName: "ghcr.io/addreas/grafana-operator"
	}]
	patchesStrategicMerge: [{
		apiVersion: "apps/v1"
		kind:       "Deployment"
		metadata: {
			name:      "controller-manager"
			namespace: "system"
		}
		spec: template: spec: containers: [{
			name: "manager"
			args: ["--scan-all"]
			resources: limits: memory: "256Mi"
			env: [{
				name: "WATCH_NAMESPACE"
				valueFrom: fieldRef: fieldPath: "metadata.namespace"
			}, {
				name: "POD_NAME"
				valueFrom: fieldRef: fieldPath: "metadata.name"
			}]
		}]
	}]
}

k: ClusterRoleBinding: "grafana-operator-missing-resources": {
	roleRef: {
		apiGroup: "rbac.authorization.k8s.io"
		kind:     "ClusterRole"
		name:     "grafana-operator-missing-resources"
	}
	subjects: [{
		kind:      "ServiceAccount"
		name:      "default"
		namespace: "monitoring"
	}]
}

k: ClusterRole: "grafana-operator-missing-resources": {
	rules: [{
		apiGroups: [""]
		resources: [
			"pods",
			"services",
			"endpoints",
			"persistentvolumeclaims",
			"configmaps",
			"secrets",
			"serviceaccounts",
			"configmaps",
		]
		verbs: [
			"get",
			"list",
			"create",
			"update",
			"delete",
			"deletecollection",
			"watch",
		]
	}, {
		apiGroups: [""]
		resources: [
			"events",
		]
		verbs: [
			"get",
			"list",
			"watch",
			"create",
			"delete",
			"update",
			"patch",
		]
	}, {
		apiGroups: ["apps"]
		resources: [
			"deployments",
			"deployments/finalizers",
			"daemonsets",
			"replicasets",
			"statefulsets",
		]
		verbs: [
			"get",
			"list",
			"create",
			"update",
			"delete",
			"deletecollection",
			"watch",
		]
	}, {
		apiGroups: ["route.openshift.io"]
		resources: [
			"routes",
			"routes/custom-host",
		]
		verbs: [
			"get",
			"list",
			"create",
			"update",
			"delete",
			"deletecollection",
			"watch",
			"create",
		]
	}, {
		apiGroups: ["extensions"]
		resources: ["ingresses"]
		verbs: [
			"get",
			"list",
			"create",
			"update",
			"delete",
			"deletecollection",
			"watch",
		]
	}, {
		apiGroups: ["integreatly.org"]
		resources: [
			"grafanas",
			"grafanas/status",
			"grafanas/finalizers",
			"grafanadashboards",
			"grafanadatasources",
			"grafanadatasources/status",
		]
		verbs: [
			"get",
			"list",
			"create",
			"update",
			"delete",
			"deletecollection",
			"watch",
		]
	}, {
		apiGroups: ["networking.k8s.io"]
		resources: ["ingresses"]
		verbs: [
			"get",
			"list",
			"create",
			"update",
			"delete",
			"deletecollection",
			"watch",
			"create",
		]
	}]
}
