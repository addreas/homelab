package kube

import (
	"encoding/json"
	"encoding/yaml"
)

let conf = {
	automation: "automations.yaml" @yaml(,tag="!include")
	script:     "scripts.yaml"     @yaml(,tag="!include")
	scene:      "scenes.yaml"      @yaml(,tag="!include")

	frontend: {
		themes: "themes" @yaml(,tag="!include_dir_merge_named")
	}

	recorder: {
		db_url: "DB_URL" @yaml(,tag="!env_var")
	}

	google_assistant: {
		project_id:      "hass-dke"
		service_account: "hass-dke-8e86dc9cd8ce.json" @yaml(,tag="!include")
		report_state:    true
		exposed_domains: ["switch", "light"]
	}

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

	prometheus: namespace: "hass"

	tts: [{platform: "google_translate"}]
}

k: ConfigMap: "hass-config": data: "configuration.yaml": yaml.Marshal(conf)

k: ConfigMap: "zwave-js-settings-json": data: "settings.json": json.Marshal({
	mqtt: disabled:         true
	gateway: hassDiscovery: true
	zwave: {
		serverEnabled: true
		serverPort:    3000
		port:          "/dev/aeotec-z-stick"
	}
})
