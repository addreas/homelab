package kube

import encodingJson "encoding/json"

k: GrafanaDashboard: "periserve": spec: json: encodingJson.Marshal(content)

let content = {
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
	"id":                   "dfjhskdjhfskdjfh"
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
				"h": 7
				"w": 24
				"x": 0
				"y": 0
			}
			"id": 8
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
					"expr":         "sum(increase(http_requests_total{namespace=\"periserve\"}[1m])) by (path)"
					"interval":     ""
					"legendFormat": "{{path}}"
					"refId":        "A"
				},
			]
			"title": "Panel Title"
			"type":  "timeseries"
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
				"h": 7
				"w": 24
				"x": 0
				"y": 7
			}
			"id": 4
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
					"exemplar":       true
					"expr":           "increase(sum(http_requests_total{namespace=\"periserve\"}) by (status_code)[$__rate_interval])"
					"interval":       ""
					"intervalFactor": 2
					"legendFormat":   ""
					"refId":          "A"
				},
			]
			"title": "Request rate by status code"
			"type":  "timeseries"
		},
		{
			"cards": {}
			"color": {
				"cardColor":   "#b4ff00"
				"colorScale":  "linear"
				"colorScheme": "interpolateOranges"
				"exponent":    0.5
				"mode":        "opacity"
			}
			"dataFormat": "tsbuckets"
			"gridPos": {
				"h": 7
				"w": 24
				"x": 0
				"y": 14
			}
			"heatmap": {}
			"hideZeroBuckets": false
			"highlightCards":  true
			"id":              2
			"legend": {
				"show": false
			}
			"reverseYBuckets": false
			"targets": [
				{
					"datasource": {
						"type": "prometheus"
						"uid":  "PBFA97CFB590B2093"
					}
					"exemplar":       true
					"expr":           "rate(sum(http_request_duration_seconds_bucket{namespace=\"periserve\"}) by(le)[$__rate_interval])"
					"format":         "heatmap"
					"interval":       ""
					"intervalFactor": 2
					"legendFormat":   "{{le}}"
					"refId":          "A"
				},
			]
			"title": "Latency histogram"
			"tooltip": {
				"show":          true
				"showHistogram": false
			}
			"type": "heatmap"
			"xAxis": {
				"show": true
			}
			"yAxis": {
				"format":  "short"
				"logBase": 1
				"show":    true
			}
			"yBucketBound": "auto"
		},
		{
			"fieldConfig": {
				"defaults": {
					"color": {
						"mode": "thresholds"
					}
					"custom": {
						"align":       "auto"
						"displayMode": "auto"
						"filterable":  true
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
				"overrides": [
					{
						"matcher": {
							"id":      "byName"
							"options": "path"
						}
						"properties": [
							{
								"id":    "custom.width"
								"value": 411
							},
						]
					},
				]
			}
			"gridPos": {
				"h": 8
				"w": 24
				"x": 0
				"y": 21
			}
			"id": 6
			"options": {
				"footer": {
					"fields": ""
					"reducer": ["sum"]
					"show": false
				}
				"showHeader": true
				"sortBy": []
			}
			"pluginVersion": "8.3.3"
			"targets": [
				{
					"datasource": {
						"type": "prometheus"
						"uid":  "PBFA97CFB590B2093"
					}
					"exemplar":     false
					"expr":         "sort_desc(sum(http_requests_total{namespace=\"periserve\", path!~\".*js$\"}) by (path))"
					"format":       "table"
					"instant":      true
					"interval":     ""
					"legendFormat": ""
					"refId":        "A"
				},
			]
			"title": "Visited paths"
			"type":  "table"
		},
	]
	"schemaVersion": 34
	"style":         "dark"
	"tags": []
	"templating": {
		"list": []
	}
	"time": {
		"from": "now-30m"
		"to":   "now"
	}
	"timepicker": {}
	"timezone":  ""
	"title":     "Periserve"
	"uid":       "kCYMBay7k"
	"version":   2
	"weekStart": ""
}
