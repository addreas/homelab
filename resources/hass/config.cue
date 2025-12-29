package kube

import (
	"encoding/json"
	"encoding/yaml"
)

// yaml.Marshal cannot do the !include statements, so that's why it's split up
// Prefer adding stuff here instead of in the configmap below
let conf = {
	logger: default: "info"
	logger: logs: {
		"habluetooth.wrappers":                             "warning"
		"custom_components.bravia_quad.bravia_quad_client": "warning"
		"custom_components.pax_ble":                        "error"
	}
	logger: filters: {
		"homeassistant.components.mqtt.entity": [
			"The configuration for entity sensor..+ uses the deprecated option `object_id`",
		]
	}

	default_config: {}

	http: {
		use_x_forwarded_for: true
		trusted_proxies: ["10.0.0.0/8", "192.168.0.0/24"]
	}

	// homeassistant: media_dirs: media: "/media/videos"

	prometheus: namespace: "hass"

	tts: [{platform: "google_translate"}]
}

k: ConfigMap: "hass-config": data: "configuration.yaml": """
	automation: !include automations.yaml
	script: !include scripts.yaml
	scene: !include scenes.yaml

	frontend:
	  themes: !include_dir_merge_named themes

	recorder:
	  db_url: !env_var DB_URL

	google_assistant:
	  project_id: hass-dke
	  service_account: !include hass-dke-8e86dc9cd8ce.json
	  report_state: true
	  exposed_domains:
	  - switch
	  - light

	\(yaml.Marshal(conf))
	"""

k: ConfigMap: "zwave-js-settings-json": data: "settings.json": json.Marshal({
	mqtt: disabled:         true
	gateway: hassDiscovery: true
	zwave: {
		serverEnabled: true
		serverPort:    3000
		port:          "/dev/aeotec-z-stick"
	}
})
