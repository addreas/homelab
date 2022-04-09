package kube

let config = """
	automation: !include automations.yaml
	script: !include scripts.yaml
	scene: !include scenes.yaml

	logger:
	  default: info

	frontend:
	  themes: !include_dir_merge_named themes

	discovery:

	default_config:

	http:
	  use_x_forwarded_for: true
	  trusted_proxies: ["10.0.0.0/8"]

	"""
k: Deployment: hass2: {
	spec: {
		template: {
			spec: {
				initContainers: [{
					name: "init-components"
					image: containers[0].image
					command: ["sh", "-c"]
					args: ["""
						cd /config
						curl -sSLO https://github.com/addreas/yanzi-home-assistant/archive/refs/heads/mtls.zip
						unzip mtls.zip
						mv yanzi-home-assistant-mtls/custom_components/ .
						
						cat <<EOF > configuration.yaml
						\(config)
						EOF
						
						cat configuration.yaml
						touch automations.yaml
						touch scripts.yaml
						touch scenes.yaml
						mkdir themes

						"""]
					volumeMounts: [{
						name:      "config"
						mountPath: "/config"
					}]
				}]
				containers: [{
					name:  "hass"
					image: "ghcr.io/home-assistant/home-assistant:2022.3.1"
					command: ["hass", "-c", "/config"]
					ports: [{
						name: "http"
						containerPort: 8123
					}]
					volumeMounts: [{
						name:      "config"
						mountPath: "/config"
					}]
				}]
				volumes: [{
					name: "config"
					emptyDir: {}
				}]
			}
		}
	}
}

k: Service: hass2: {}
k: Ingress: hass2: {}
