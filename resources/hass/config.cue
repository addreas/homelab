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

	webostv: {
		host: "192.168.1.245"
		turn_on_action: {
			service: "media_player.turn_on"
			target: entity_id: "media_player.vardagsrummet_tv"
		}
	}

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

}

k: NetworkAttachmentDefinition: "macvlan-conf": {
	spec: {
		config: json.Marshal({
			cniVersion: "0.3.0"
			type:       "macvlan"
			master:     "eno1"
			mode:       "bridge"
			ipam: type: "dhcp"
		})
	}
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

k: SealedSecret: "zwave-network-key": spec: encryptedData: key: "AgAO8N40Ry+9p+fe+YehhHIGy9GfFMCkQq7KvpQhzUJ6rLzOaDs0pHwL8Ha8JQPPa5JZp/3qAObO0ZYOffsOcZGU+P749AZnbvvBStBmbBQ8v9H4+Ov12AsyHbCADfHwo5oCiZVJLVqcflaUJxqR7+mk2ZRf+RYh7g8Lyx6QZxfhdBmgqlalFPv85HCMf4mvGNmVS9vx2ieru7cyy6UPfr0eFoLZfOieqGPsmn9nLd73XAtUJYs/eoqN374wU4lidxjdwn9ISHaBOd/Wnan4YxIHecOrZeD+MkwszR4jlLe2ZZJc43fJxHzgo5+Pj311TuRI0mqonFzNaBboehAP5fqMFjX5DHmRuaIVixsgegJYDSLnjawv0KbCS3TKM5ERwlS3P3uTFBX6fnnw7bRWzRmeIIbVr9KLFw/C958WI8zLVxSIEDKL8dxnNyZb+xtfpeFsm5Jt/plVpIH8jhB6A5dbykP8BZFfQ5FZubyYy1ueALm9YRiFwzF0GOM56ElD6rrignv8APeXVW0b67t1H52XRo/ZbF4L0PWCuq2BOe+uBNmklz7E44zV6S1fvKo4abP5Q7IQOCvyKprVNBUiv3mD9HulDKrqOqXPZa8SF+YzaceOg/yCzFs8WYws/lBdPPHfnPvjixyyC7C8cdwTAxQhBSrdhiJz31bFfagHzksiUHexQfMmkmNGcmw3cVZxUwyYF2fg4UtduAUKBeE8wVtg+/GTZ6UZ7MbxeWznLkWo2A=="

k: SealedSecret: "hass-gcp-credential-json": spec: encryptedData: "hass-dke-8e86dc9cd8ce.json": "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"

k: SealedSecret: "hass-prometheus-api-key": spec: encryptedData: key: "AgCK8Wr/BWYhT5RSlCFehm+NK99vd8uZrmhsKy4IlW3NSJhbH1JbZrfUqH0ztYdlRxO3vhD4/WGRjBLOr8ngpBCPD0NWv9Lg/GVsbALB+nUxHkDZjLIgtemYQmiGwDBtISzhfd81+MyrGelt5XYude9QzQNYMMlUWq8NSsMTtB6Z2/NqyRDZC2HUeqVOk7r7Orh5Gsx4nHcWiEAOjgvqejp0AkofES0ptNiOPrIVxcyOOjbPuevM84Z9B83V5gKENGAvpITqARkUB378qXe4moxmeACvov4oUEsfEtlefPtCYpmUOCuhjYu2rzws24YOk7od+pmxwpokOLbnbfjy0vdiC8PlozS8kv7OF2XkBQ0v9iFcYxuOg76vI+SHzjHeQStOJxfFre/ieClP8AAkMwTr55AiJFXhGpRmNiBUFOOTdGRBgGm42CgSwlNwzaS8Pubt1IVhBh+PmKMkVYOXemXPoIVjNUKEYkpJJCjtxvKK2+LZ3+nFf5ZVqsyEvYlEABOomnuShPcRtrWS3cIt4cC7K9udiojzwMPqMJCFIFFPEnsatUnPHTbApwIqI2RTXA99RkVkE/aghnRHNuz++M1qQOCLBGsv3lFdqWFy8M/t1tLHtuYy/gxRcplIOZrUUpDEE77OggDCiH4FqYvtqd12NygwnnSwD/YKF7YxJgNYgcoD8c34xfoYYyt1FSyyCuuSwTyWl1sA81MbkXIfyTrpphHpn86/ayaxlsLMDfjW+QMRJpxlgmCPyq5IOXUQg5xuiylW+xsz2YHnN6ti/fKzHTs+LhMuR6nILVRHwAru0ZRa8Br+uhwl2uR8vPYV0IxaXQYgAIlmi9PMAtOxSvqnFHcTncZCOQxUaKt86c/tJqxle6AjBI4/IGlyAiRRhPAN4bFVd/4mwgjJm63brk6R2vwLb+NXYGPbHjCzGcqnWtJuiAxlmGI="

k: SealedSecret: "hass-postgres-credentials": spec: encryptedData: {
	POSTGRES_PASSWORD: "AgB5DW2ASb17LxRvzWbSJMEGP8DlGXq8ZSUMu7mU7B93UMvZXDaOB3DF6Ph5Hzt8H8zBg8mCJOWhg2EabHMld4cDhY3E6o+vRo7s/59dm21UkfKRIjXYP/+76jsrGas7pWEyxTZyFT4FyjzGcuV/Zc1S3W7MMsZfR7FihxRKmjni8Uvu+JIhDPCDynqnaUehMK7fGViPotI4qCyoCVe2uFNRuJ4QiLl8rSawKdyHhEumGAqtn1sf0/JcqQRuWYkH1U9LCgJxaiR3T4NroHAP4O2FOsAdSL802NGN+G5v4/wu6lV00DIsJcPKSTPUrAkvJvcK/yMxTmoBMXqeccRV2FMsCULEXBm2iHJoiFRTu8v0ftPLqztf6BYWrkZZLcCzTu5bD//t0pXpIqUO7tSn8POwb6kj98+TxvmFGLb+6Bvmw4DYF1ssUBjKejX/iZgO2AKvo/hCmr09w4sfHvFB8tFwPrpdvO3Cg8MVMVy4I+MD22BT8q240MnFR19VfRYiz1Z8rylgA+BLNysJ4u7e+TR4U918sl6QJd7WGCGL/Me9T5sVKfFlxgtjXpjXvBhX+/tzqaVajihrMOYlgBnVECxmnTDNGIbbTKfbOaYpnlV+v4uo2VVpsWRHuhYVOBh6JgtKtdLlnpVUStkFERp9KmpFZpOsDlZdANkcXsLrZWl9gHovchl2JPfC30MTB/IkOCUjlPrE7H37lU+Ba023q0foaIXRP786xCBe2ZBW370wHQ=="
	POSTGRES_USER:     "AgAIdNpD3TT5PyHLy27o+WnIInKR2AZGOyiqYQ5s9BS8YuHSONNP/AOwdCZhF32q9vdtIwG8rGanDIiswDBj1Z2Mt2zpDoKSRhrzWVsPUjCyIJ46gjEKjkXCj776vkv53sye5+uI+kTeyUlkUbJ+vrBb1BbzpHtqOM0wuBCBFzG1LMCzkKZpf9Lmah3+fd/EzJCCWzJC16LwqSKgmAmwFLrgy35lSJTCLhH05maVfKAed+sIFWim+YmkemE1fDILuHfawm6vBqWfDH6yJ0m3X8k/xThymEtlbJa1/R+KanDDeQhatHI8slkVcZrri7/gw1XEJlt5N+HmvAYoyyS+DJWT02/wp88OiG3+63l6ROp/DAnXI4UHHc8wvFqx0zGBGrYiSRSb5Pe1Dc+T0irynzdfHeUGNC2tSHudnT8Fm00x+Gj5+8oHFgLs/T6iwGJApnP7yqgz0tnjy93wBchHDslaeIOdNAVW9mBOEKcdk3kimU9EV9nHIwZrTj3KK/PisdVoNC06o1D3ZfrmUPx7da5oOwTm3ljuNDyzPUNTPHBRvC2iadEXbP1xe43Ur76yB6EySQpetHwT/9wjijsExItoTiMtkuxYlh2OtYUSBOGMg/p9EHSpnYOj8ANuooZybZe2dmiWgHJTmXcZffg5v8uSs/2gxzhsHsphjn8ekug5Uiqp1Z3zBzYriLIwFd4XV5QdeGgr"
}
