package kube

import encodingJson "encoding/json"

k: GrafanaDashboard: "periserve-overview": spec: json: encodingJson.Marshal(content)

let content = {
  "annotations": {
    "list": [
      {
        "builtIn": 1,
        "datasource": "-- Grafana --",
        "enable": true,
        "hide": true,
        "iconColor": "rgba(0, 211, 255, 1)",
        "name": "Annotations & Alerts",
        "target": {
          "limit": 100,
          "matchAny": false,
          "tags": [],
          "type": "dashboard"
        },
        "type": "dashboard"
      }
    ]
  },
  "editable": true,
  "fiscalYearStartMonth": 0,
  "graphTooltip": 0,
  "links": [],
  "liveNow": false,
  "panels": [
    {
      "cards": {},
      "color": {
        "cardColor": "#b4ff00",
        "colorScale": "sqrt",
        "colorScheme": "interpolateOranges",
        "exponent": 0.5,
        "mode": "opacity"
      },
      "dataFormat": "tsbuckets",
      "gridPos": {
        "h": 8,
        "w": 24,
        "x": 0,
        "y": 0
      },
      "heatmap": {},
      "hideZeroBuckets": false,
      "highlightCards": true,
      "id": 2,
      "legend": {
        "show": false
      },
      "maxDataPoints": 200,
      "reverseYBuckets": false,
      "targets": [
        {
          "datasource": {
            "type": "prometheus",
            "uid": "PBFA97CFB590B2093"
          },
          "exemplar": true,
          "expr": "rate(sum(http_request_duration_seconds_bucket{namespace=\"periserve\"}) by (le) [$__interval])",
          "format": "heatmap",
          "interval": "",
          "intervalFactor": 1,
          "legendFormat": "{{le}}",
          "refId": "A"
        }
      ],
      "title": "Latency histogram",
      "tooltip": {
        "show": true,
        "showHistogram": false
      },
      "type": "heatmap",
      "xAxis": {
        "show": true
      },
      "yAxis": {
        "format": "short",
        "logBase": 1,
        "show": true
      },
      "yBucketBound": "auto"
    }
  ],
  "schemaVersion": 34,
  "style": "dark",
  "tags": [],
  "templating": {
    "list": []
  },
  "time": {
    "from": "now-2d",
    "to": "now"
  },
  "timepicker": {},
  "timezone": "",
  "title": "Overview",
  "version": 0,
  "weekStart": ""
}
