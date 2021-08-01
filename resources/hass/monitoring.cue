package kube

k: VMRule: "hass-yanzi-integration": spec: groups: [{
    name: "hass-yanzi-integration.alerts"
    rules: [{
        alert: "HassYanziIntegrationSilence"
        annotations: message: "A Homeassistant Yanzi location integration is suspiciously silent..."
        expr: #"rate(hass_state_change_total{entity=~"sensor.yanzi_sample_counter_.*"}) < 1/60"#
        for: "5m"
        labels: severity: "critical"
    }]
}]
