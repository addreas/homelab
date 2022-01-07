package kube

import _json "encoding/json"

k: ConfigMap: "grafana-home-dashboard": data: "dashboard.json": _json.Marshal({
	"annotations": {
		"list": [
			{
				"builtIn":    1
				"datasource": "-- Grafana --"
				"enable":     true
				"hide":       true
				"iconColor":  "rgba(0, 211, 255, 1)"
				"name":       "Annotations & Alerts"
				"target": {
					"limit":    100
					"matchAny": false
					"tags": []
					"type": "dashboard"
				}
				"type": "dashboard"
			},
		]
	}
	"editable":             true
	"fiscalYearStartMonth": 0
	"graphTooltip":         0
	"links": []
	"liveNow": false
	"panels": [
		{
			"fieldConfig": {
				"defaults": {
					"color": {
						"mode": "palette-classic"
					}
					"custom": {
						"axisGridShow":  false
						"axisLabel":     ""
						"axisPlacement": "hidden"
						"barAlignment":  0
						"drawStyle":     "bars"
						"fillOpacity":   0
						"gradientMode":  "none"
						"hideFrom": {
							"legend":  false
							"tooltip": false
							"viz":     false
						}
						"lineInterpolation": "linear"
						"lineWidth":         1
						"pointSize":         5
						"scaleDistribution": {
							"type": "linear"
						}
						"showPoints": "never"
						"spanNulls":  false
						"stacking": {
							"group": "A"
							"mode":  "none"
						}
						"thresholdsStyle": {
							"mode": "off"
						}
					}
					"mappings": []
					"thresholds": {
						"mode": "absolute"
						"steps": [
							{
								"color": "green"
								"value": null
							},
						]
					}
					"unit": "bool_on_off"
				}
				"overrides": []
			}
			"gridPos": {
				"h": 4
				"w": 24
				"x": 0
				"y": 0
			}
			"id": 123129
			"options": {
				"legend": {
					"calcs": []
					"displayMode": "list"
					"placement":   "bottom"
				}
				"tooltip": {
					"mode": "none"
				}
			}
			"pluginVersion": "8.3.3"
			"targets": [
				{
					"datasource": {
						"type": "prometheus"
						"uid":  "PBFA97CFB590B2093"
					}
					"exemplar":     true
					"expr":         "hass_binary_sensor_state{entity=~\".*motion\"}"
					"interval":     ""
					"legendFormat": "{{ friendly_name }}"
					"refId":        "A"
				},
			]
			"title": "Motion sensors"
			"type":  "timeseries"
		},
		{
			"fieldConfig": {
				"defaults": {
					"color": {
						"mode": "thresholds"
					}
					"mappings": []
					"thresholds": {
						"mode": "absolute"
						"steps": [
							{
								"color": "red"
								"value": null
							},
							{
								"color": "yellow"
								"value": 200
							},
							{
								"color": "green"
								"value": 250
							},
						]
					}
				}
				"overrides": []
			}
			"gridPos": {
				"h": 5
				"w": 4
				"x": 0
				"y": 4
			}
			"id": 123125
			"options": {
				"colorMode":   "value"
				"graphMode":   "area"
				"justifyMode": "auto"
				"orientation": "auto"
				"reduceOptions": {
					"calcs": [
						"lastNotNull",
					]
					"fields": ""
					"values": false
				}
				"textMode": "auto"
			}
			"pluginVersion": "8.3.3"
			"targets": [
				{
					"datasource": {
						"type": "prometheus"
						"uid":  "PBFA97CFB590B2093"
					}
					"exemplar":     true
					"expr":         "count(hass_entity_available == 1) "
					"interval":     ""
					"legendFormat": ""
					"refId":        "A"
				},
			]
			"title": "HASS entities available"
			"type":  "stat"
		},
		{
			"description": ""
			"fieldConfig": {
				"defaults": {
					"color": {
						"mode": "thresholds"
					}
					"mappings": []
					"thresholds": {
						"mode": "absolute"
						"steps": [
							{
								"color": "green"
								"value": null
							},
						]
					}
				}
				"overrides": []
			}
			"gridPos": {
				"h": 5
				"w": 4
				"x": 4
				"y": 4
			}
			"id": 123127
			"options": {
				"colorMode":   "value"
				"graphMode":   "area"
				"justifyMode": "auto"
				"orientation": "auto"
				"reduceOptions": {
					"calcs": [
						"lastNotNull",
					]
					"fields": ""
					"values": false
				}
				"textMode": "auto"
			}
			"pluginVersion": "8.3.3"
			"targets": [
				{
					"datasource": {
						"type": "prometheus"
						"uid":  "PBFA97CFB590B2093"
					}
					"exemplar":     true
					"expr":         "rate(hass_sensor_unit_samples{entity=~\"sensor.yanzi_sample_counter_872855\"}[10m])"
					"interval":     ""
					"legendFormat": ""
					"refId":        "A"
				},
			]
			"title": "HASS Yanzi Component samples / second"
			"type":  "stat"
		},
		{
			"description": ""
			"fieldConfig": {
				"defaults": {
					"color": {
						"mode": "thresholds"
					}
					"mappings": []
					"thresholds": {
						"mode": "absolute"
						"steps": [
							{
								"color": "green"
								"value": null
							},
							{
								"color": "red"
								"value": 80
							},
						]
					}
				}
				"overrides": []
			}
			"gridPos": {
				"h": 5
				"w": 4
				"x": 8
				"y": 4
			}
			"id": 123135
			"options": {
				"colorMode":   "none"
				"graphMode":   "none"
				"justifyMode": "auto"
				"orientation": "horizontal"
				"reduceOptions": {
					"calcs": [
						"lastNotNull",
					]
					"fields": ""
					"values": false
				}
				"textMode": "name"
			}
			"pluginVersion": "8.3.3"
			"targets": [
				{
					"datasource": {
						"type": "prometheus"
						"uid":  "PBFA97CFB590B2093"
					}
					"exemplar":     true
					"expr":         "hass_switch_state == 1"
					"interval":     ""
					"legendFormat": "{{ friendly_name }}"
					"refId":        "A"
				},
			]
			"title": "Switches turned on"
			"type":  "stat"
		},
		{
			"description": ""
			"fieldConfig": {
				"defaults": {
					"color": {
						"mode": "thresholds"
					}
					"mappings": []
					"thresholds": {
						"mode": "absolute"
						"steps": [
							{
								"color": "green"
								"value": null
							},
							{
								"color": "yellow"
								"value": 20
							},
						]
					}
					"unit": "kwatth"
				}
				"overrides": []
			}
			"gridPos": {
				"h": 4
				"w": 12
				"x": 12
				"y": 4
			}
			"id": 123137
			"options": {
				"colorMode":   "value"
				"graphMode":   "none"
				"justifyMode": "auto"
				"orientation": "auto"
				"reduceOptions": {
					"calcs": [
						"lastNotNull",
					]
					"fields": ""
					"values": false
				}
				"textMode": "auto"
			}
			"pluginVersion": "8.3.3"
			"targets": [
				{
					"datasource": {
						"type": "prometheus"
						"uid":  "PBFA97CFB590B2093"
					}
					"exemplar":     true
					"expr":         "topk(3, hass_sensor_energy_kwh)"
					"interval":     ""
					"legendFormat": "{{ friendly_name }}"
					"refId":        "A"
				},
			]
			"title": "Top 3 energy consumers"
			"transformations": [
				{
					"id": "renameByRegex"
					"options": {
						"regex":         ": Electric Consumption \\[kWh\\]"
						"renamePattern": ""
					}
				},
				{
					"id": "renameByRegex"
					"options": {
						"regex":         ""
						"renamePattern": ""
					}
				},
			]
			"type": "stat"
		},
		{
			"description": ""
			"fieldConfig": {
				"defaults": {
					"color": {
						"mode": "continuous-RdYlGr"
					}
					"mappings": []
					"thresholds": {
						"mode": "absolute"
						"steps": [
							{
								"color": "red"
								"value": null
							},
						]
					}
					"unit": "percent"
				}
				"overrides": []
			}
			"gridPos": {
				"h": 6
				"w": 12
				"x": 12
				"y": 8
			}
			"id": 123133
			"options": {
				"colorMode":   "background"
				"graphMode":   "none"
				"justifyMode": "auto"
				"orientation": "horizontal"
				"reduceOptions": {
					"calcs": [
						"lastNotNull",
					]
					"fields": ""
					"values": false
				}
				"text": {}
				"textMode": "value_and_name"
			}
			"pluginVersion": "8.3.3"
			"targets": [
				{
					"datasource": {
						"type": "prometheus"
						"uid":  "PBFA97CFB590B2093"
					}
					"exemplar":     true
					"expr":         "sort(hass_sensor_battery_percent{entity!~\".*battery_level\"} < 50)"
					"interval":     ""
					"legendFormat": "{{ friendly_name }}"
					"refId":        "A"
				},
			]
			"title": "Low battery warning"
			"type":  "stat"
		},
		{
			"fieldConfig": {
				"defaults": {
					"color": {
						"mode": "palette-classic"
					}
					"custom": {
						"axisLabel":     ""
						"axisPlacement": "auto"
						"barAlignment":  0
						"drawStyle":     "line"
						"fillOpacity":   0
						"gradientMode":  "none"
						"hideFrom": {
							"legend":  false
							"tooltip": false
							"viz":     false
						}
						"lineInterpolation": "linear"
						"lineWidth":         1
						"pointSize":         5
						"scaleDistribution": {
							"type": "linear"
						}
						"showPoints": "auto"
						"spanNulls":  false
						"stacking": {
							"group": "A"
							"mode":  "none"
						}
						"thresholdsStyle": {
							"mode": "off"
						}
					}
					"mappings": []
					"thresholds": {
						"mode": "absolute"
						"steps": [
							{
								"color": "green"
								"value": null
							},
							{
								"color": "red"
								"value": 80
							},
						]
					}
				}
				"overrides": []
			}
			"gridPos": {
				"h": 8
				"w": 12
				"x": 0
				"y": 9
			}
			"id": 123131
			"options": {
				"legend": {
					"calcs": []
					"displayMode": "list"
					"placement":   "bottom"
				}
				"tooltip": {
					"mode": "single"
				}
			}
			"targets": [
				{
					"datasource": {
						"type": "prometheus"
						"uid":  "PBFA97CFB590B2093"
					}
					"exemplar":     true
					"expr":         "{__name__=~\"hass_sensor_temperature_celsius|hass_sensor_unit_celsius\", entity!=\"sensor.in2023_battery_temperature\"}"
					"interval":     ""
					"legendFormat": "{{ friendly_name }}"
					"refId":        "A"
				},
			]
			"title": "Temperatures"
			"type":  "timeseries"
		},
		{
			"gridPos": {
				"h": 8
				"w": 12
				"x": 12
				"y": 14
			}
			"id": 3
			"links": []
			"options": {
				"folderId":           0
				"maxItems":           30
				"query":              ""
				"showHeadings":       true
				"showRecentlyViewed": true
				"showSearch":         false
				"showStarred":        false
				"tags": []
			}
			"pluginVersion": "8.3.3"
			"tags": []
			"title": "Dashboards"
			"type":  "dashlist"
		},
	]
	"schemaVersion": 34
	"style":         "dark"
	"tags": []
	"templating": {
		"list": []
	}
	"time": {
		"from": "now-2d"
		"to":   "now"
	}
	"timepicker": {
		"hidden": true
		"refresh_intervals": [
			"5s",
			"10s",
			"30s",
			"1m",
			"5m",
			"15m",
			"30m",
			"1h",
			"2h",
			"1d",
		]
		"time_options": [
			"5m",
			"15m",
			"1h",
			"6h",
			"12h",
			"24h",
			"2d",
			"7d",
			"30d",
		]
		"type": "timepicker"
	}
	"timezone":  "browser"
	"title":     "Home"
	"version":   0
	"weekStart": ""
})
