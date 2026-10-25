package kube

import (
	"crypto/md5"
	"encoding/hex"
	"encoding/json"
)

k: NetworkAttachmentDefinition: "otbr-thread": spec: config: json.Marshal({
	cniVersion: "0.3.0"
	plugins: [{
		type:   "macvlan"
		master: "eno1"
		mode:   "bridge"
		ipam: {
			type: "dhcp"
			provide: [{
				option:  "host-name"
				fromArg: "K8S_POD_NAME"
			}]
		}
	}, {
		type: "sbr"
	}, {
		type: "tuning"
		capabilities: mac: true
		sysctl: {
			"net.ipv6.conf.all.forwarding":                  "1"
			"net.ipv6.conf.net1.accept_ra":                  "2"
			"net.ipv6.conf.net1.accept_ra_rt_info_max_plen": "64"
		}
	}]
})

k: ConfigMap: "otbr-dataset-hook": data: "after_server": """
	(
		set +x
		want=$(tr -d '[:space:]' < /etc/otbr-dataset/dataset.tlv 2>/dev/null)
		for _ in $(seq 1 120); do
			[ -S /run/openthread-wpan0.sock ] && break
			sleep 1
		done
		if [ -n "$want" ]; then
			have=$(ot-ctl dataset active -x 2>/dev/null | head -1)
			if [ "$have" = "$want" ]; then
				echo "otbr-dataset: matches desired dataset"
			else
				echo "otbr-dataset: applying desired dataset"
				ot-ctl dataset set active "$want"
				ot-ctl ifconfig up
				ot-ctl thread start
			fi
		fi
	) &
	"""

k: StatefulSet: "otbr": spec: {
	template: {
		metadata: annotations: {
			"k8s.v1.cni.cncf.io/networks": json.Marshal([{
				name: "otbr-thread"
				mac:  "02:00:00:00:00:06"
			}])
			"addem.se/dataset-hash": hex.Encode(md5.Sum(k.Secret."otbr-dataset".stringData."dataset.tlv"))
		}
		spec: {
			tolerations: [{
				key:      "node-role.kubernetes.io/control-plane"
				operator: "Exists"
				effect:   "NoSchedule"
			}]
			containers: [{
				name:  "otbr"
				image: "openthread/otbr@sha256:f3e43ccd86d6da87323873efa0c9b6f92a2a8cc75a804ea50e34c96680363e2e"
				env: [
					{name: "HTTP_HOST", value: "0.0.0.0"},
					{name: "REST_HOST", value: "::"},
					{name: "NAT64", value: "0"},
					{name: "FIREWALL", value: "0"},
				]
				args: [
					"--radio-url", "spinel+hdlc+uart:///dev/thread-rcp?uart-init-deassert",
					"-B", "net1",
					"--debug-level", "5",
				]
				ports: [{containerPort: 8081}, {containerPort: 80}]
				securityContext: {
					privileged:               true
					runAsNonRoot:             false
					runAsUser:                0
					runAsGroup:               0
					allowPrivilegeEscalation: true
				}
				volumeMounts: [{
					name:      "dataset"
					mountPath: "/etc/otbr-dataset"
				}, {
					name:      "hook"
					mountPath: "/app/examples/platforms/ubuntu"
				}]
				resources: limits: {
					cpu:                       "200m"
					memory:                    "256Mi"
					"addem.se/dev_thread_rcp": "1"
				}
			}]
			volumes: [{
				name: "dataset"
				secret: secretName: "otbr-dataset"
			}, {
				name: "hook"
				configMap: name: "otbr-dataset-hook"
			}]
		}
	}
}

k: Service: "otbr": spec: ports: [{
	name: "rest"
	port: 8081
}, {
	name:       "web"
	port:       8080
	targetPort: 80
}]
