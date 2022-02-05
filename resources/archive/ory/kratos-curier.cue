package kube

k: StatefulSet: "kratos-courier": spec: template: spec: {
	containers: [{
		name:  "kratos-courier"
		image: "oryd/kratos:\(_kratosTag)"
		args: ["courier", "watch", "--config", "/etc/config/kratos.yaml"]
		envFrom: [{secretRef: name: "kratos"}]
		env: [{
			name:  "LOG_FORMAT"
			value: "json"
		}, {
			name:  "LOG_LEVEL"
			value: "trace"
		}]
		volumeMounts: [{
			name:      "kratos-config-volume"
			mountPath: "/etc/config"
			readOnly:  true
		}]
	}]
	volumes: [{
		name: "kratos-config-volume"
		configMap: name: "kratos-config"
	}]
}

k: Service: "kratos-courier": spec: {
	clusterIP: "None"
	ports: [{
		port:       80
		targetPort: "http-public"
		name:       "http"
	}]
}
