package kube

k: Service: "plausible-events-db": spec: ports: [{
	name: "plausible-events-db"
}]

k: ConfigMap: "plausible-events-db-config": data: {
	"clickhouse-config.xml": """
		<yandex>
		    <logger>
		        <level>warning</level>
		        <console>true</console>
		    </logger>

		    <!-- Stop all the unnecessary logging -->
		    <query_thread_log remove="remove"/>
		    <query_log remove="remove"/>
		    <text_log remove="remove"/>
		    <trace_log remove="remove"/>
		    <metric_log remove="remove"/>
		    <asynchronous_metric_log remove="remove"/>
		</yandex>
		"""
	"clickhouse-user-config.xml": """
		<yandex>
		    <profiles>
		        <default>
		            <log_queries>0</log_queries>
		            <log_query_threads>0</log_query_threads>
		        </default>
		    </profiles>
		</yandex>
		"""
}

k: StatefulSet: "plausible-events-db": spec: {
	template: spec: {
		securityContext: {
			runAsUser:  101
			runAsGroup: 101
			fsGroup:    101
		}
		containers: [{
			image: "yandex/clickhouse-server:latest"
			ports: [{containerPort: 8123}]
			readinessProbe: {
				httpGet: {
					path: "/ping"
					port: 8123
				}
				initialDelaySeconds: 20
				failureThreshold:    6
				periodSeconds:       10
			}
			livenessProbe: {
				httpGet: {
					path: "/ping"
					port: 8123
				}
				initialDelaySeconds: 30
				failureThreshold:    3
				periodSeconds:       10
			}
			volumeMounts: [{
				name:      "data"
				mountPath: "/var/lib/clickhouse"
			}, {
				name:      "config"
				mountPath: "/etc/clickhouse-server/config.d/logging.xml"
				subPath:   "clickhouse-config.xml"
				readOnly:  true
			}, {
				name:      "config"
				mountPath: "/etc/clickhouse-server/users.d/logging.xml"
				subPath:   "clickhouse-user-config.xml"
				readOnly:  true
			}]
			env: [{
				name:  "CLICKHOUSE_DB"
				value: "plausible"
			}]
			envFrom: [{secretRef: name: "plausible-events-db-user"}]
		}]
		volumes: [{
			name: "config"
			configMap: name: "plausible-events-db-config"
		}]
	}
	volumeClaimTemplates: [{
		metadata: name: "data"
		spec: {
			accessModes: ["ReadWriteOnce"]
			resources: {
				requests: storage: "128Mi"
				limits: storage:   "20Gi"
			}
		}
	}]
}
