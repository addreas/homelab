package kube

import (
	"encoding/json"
)

k: StatefulSet: "hass-matter": spec: {
	template: {
		metadata: annotations: "k8s.v1.cni.cncf.io/networks": json.Marshal([{
			name: "macvlan-conf"
			mac:  "02:00:00:00:00:05" // https://en.wikipedia.org/wiki/MAC_address#IEEE_802c_local_MAC_address_usage
		}])
		spec: {
			nodeName: "nucle4"
			containers: [{
				name:  "matter-server"
				image: "ghcr.io/matter-js/python-matter-server:stable"
				ports: [{containerPort: 5580}]
				volumeMounts: [{
					name:      "data"
					mountPath: "/data"
				}]
			}]
		}
	}
	volumeClaimTemplates: [{
		metadata: name: "data"
		spec: {
			accessModes: ["ReadWriteOnce"]
			resources: requests: storage: "1Gi"
		}
	}]
}

k: Service: "hass-matter": {}
