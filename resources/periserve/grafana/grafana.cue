package kube

import encodingJson "encoding/json"

k: GrafanaDashboard: "periserve-overview": spec: json: encodingJson.Marshal(content)

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
	"id":                   33
	"links": []
	"liveNow": false
	"panels": [
		{
			"cards": {}
			"color": {
				"cardColor":   "#b4ff00"
				"colorScale":  "sqrt"
				"colorScheme": "interpolateOranges"
				"exponent":    0.5
				"mode":        "opacity"
			}
			"dataFormat": "tsbuckets"
			"gridPos": {
				"h": 8
				"w": 24
				"x": 0
				"y": 0
			}
			"heatmap": {}
			"hideZeroBuckets": false
			"highlightCards":  true
			"id":              2
			"legend": {
				"show": false
			}
			"maxDataPoints":   200
			"reverseYBuckets": false
			"targets": [
				{
					"datasource": {
						"type": "prometheus"
						"uid":  "PBFA97CFB590B2093"
					}
					"exemplar":       true
					"expr":           "rate(sum(http_request_duration_seconds_bucket{namespace=\"periserve\"}) by (le) [$__interval])"
					"format":         "heatmap"
					"interval":       ""
					"intervalFactor": 1
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
				"h": 9
				"w": 24
				"x": 0
				"y": 8
			}
			"id":            4
			"maxDataPoints": 100
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
					"expr":         "increase(sum(http_requests_total{namespace=\"periserve\", path!~\"^.*js$\"}) by (path))"
					"interval":     ""
					"legendFormat": "{{path}}"
					"refId":        "A"
				},
			]
			"title": "Visited paths"
			"type":  "timeseries"
		},
	]
	"schemaVersion": 34
	"style":         "dark"
	"tags": []
	"templating": {
		"list": []
	}
	"time": {
		"from": "now-6h"
		"to":   "now"
	}
	"timepicker": {}
	"timezone":  ""
	"title":     "Overview"
	"uid":       "4f7343639871f570de8b121a78462c34e0f786d8"
	"version":   671
	"weekStart": ""
}
