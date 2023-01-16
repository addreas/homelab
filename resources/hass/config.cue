package kube

import (
	"encoding/json"
	"encoding/yaml"
)

k: ConfigMap: "hass-config": data: "configuration.yaml": """
	automation: !include automations.yaml
	script: !include scripts.yaml
	scene: !include scenes.yaml

	logger:
	  default: info

	frontend:
	  themes: !include_dir_merge_named themes

	discovery:

	default_config:

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

// yaml.Marshal cannot do the !include statements, so that's why it's split up
// Prefer adding stuff below and not above
let conf = {
	prometheus: namespace: "hass"

	http: {
		use_x_forwarded_for: true
		trusted_proxies: ["10.0.0.0/8"]
	}

	homeassistant: media_dirs: media: "/media/videos"

	light: [{
		platform: "group"
		name:     "Fönsterlamporna"
		entities: [
			"light.fonstret_vanster_level_light_color_on_off",
			"light.fonstret_mitten_level_light_color_on_off",
			"light.fonstret_hoger_level_light_color_on_off",
		]
	}]

	sensor: {}

	binary_sensor: [{
		platform: "workday"
		country:  "SE"
	}]

	plant: {
		for i in ["xiaomi_hhccjcy01_48_63", "xiaomi_hhccjcy01_48_a6"] {
			"plant_\(i)": {
				min_moisture: 20
				sensors: {
					moisture:     "sensor.\(i)_moisture"
					temperature:  "sensor.\(i)_temperature"
					conductivity: "sensor.\(i)_soil_conductivity"
					brightness:   "sensor.\(i)_illuminance"
				}
			}
		}
	}

	template: [{
		binary_sensor: [{
			name:      "Any motion last 3h"
			delay_off: "3:00:00"
			state:     "states.binary_sensor.any_motion"
		}]
	}]
}

k: ConfigMap: "zwave-js-settings-json": data: "settings.json": json.Marshal({
	mqtt: disabled:         true
	gateway: hassDiscovery: true
	zwave: {
		serverEnabled: true
		serverPort:    3000
		port:          "/dev/aeotec-z-stick"
	}
})
