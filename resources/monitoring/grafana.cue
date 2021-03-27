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
	}
	client: preferService: true
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
	}
	dashboardLabelSelector: [{
		matchLabels: grafana: "enabled"
	}]
}

k: GitRepository: "grafana-operator": spec: {
	interval: "1h"
	ref: branch: "master"
	url: "https://github.com/integr8ly/grafana-operator.git"
	ignore: """
		/*
		!/deploy/crds
		!/deploy/roles
		!/deploy/cluster_roles
		!/deploy/operator.yaml
		"""
}

k: Kustomization: "grafana-operator": spec: {
	healthChecks: [{
		kind:      "Deployment"
		name:      "grafana-operator"
		namespace: "monitoring"
	}]
	interval: "30m"
	path:     "./deploy"
	prune:    true
	sourceRef: {
		kind: "GitRepository"
		name: "grafana-operator"
	}
	targetNamespace: "monitoring"
	patchesStrategicMerge: [{
		apiVersion: "apps/v1"
		kind:       "Deployment"
		metadata: name: "grafana-operator"
		spec: template: spec: containers: [{
			name: "grafana-operator"
			args: ["--scan-all"]
		}]
	}, {
		apiVersion: "rbac.authorization.k8s.io/v1"
		kind:       "ClusterRoleBinding"
		metadata: name: "grafana-operator"
		subjects: [{
			kind:      "ServiceAccount"
			name:      "grafana-operator"
			namespace: "monitoring"
		}]
	}]
}

k: ClusterRoleBinding: "grafana-operator-configmaps": {
	roleRef: {
		apiGroup: "rbac.authorization.k8s.io"
		kind:     "ClusterRole"
		name:     "grafana-operator-configmaps"
	}
	subjects: [{
		kind:      "ServiceAccount"
		name:      "grafana-operator"
		namespace: "monitoring"
	}]
}

k: ClusterRole: "grafana-operator-configmaps": {
	rules: [{
		apiGroups: [""]
		resources: ["configmaps"]
		verbs: ["list", "get"]
	}]
}
