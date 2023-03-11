package kube

import "strings"

k: Deployment: "wireguard-server": spec: template: spec: {
	containers: [{
		name:  "wireguard"
		image: "nixery.dev/shell/wireguard/iproute"
		command: ["sh", "-c", """
			cd /etc/wireguard/
			
			cat <<- --- > wg0.conf
				[Interface]
				Address = 172.16.0.0/12
				PrivateKey = $SERVER_PRIVATE_KEY
				PostUp = iptables -A FORWARD -i %i -j ACCEPT; iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
				PostDown = iptables -D FORWARD -i %i -j ACCEPT; iptables -t nat -D POSTROUTING -o eth0 -j MASQUERADE
				ListenPort = 51820
			---

			\(strings.Join([ for index, client in clients {
			"""
				cat <<- --- >> wg0.conf
					[Peer]
					AllowedIPs = 172.16.42.\(index+1)/32
					PublicKey = $(cat /etc/wireguard-peers/\(client)/peer.pub)
					PresharedKey = $(cat /etc/wireguard-peers/\(client)/peer.psk)
				---

				"""
		}], "\n"))
			
			
			wg-quick up wg0
			tail -f /dev/null
			"""]
		env: [{
			name: "SERVER_PRIVATE_KEY"
			valueFrom: secretKeyRef: {
				name: "wireguard-server-key"
				key:  "server.key"
			}
		}]
		securityContext: {
			// privileged: true // not sure which cap is required for sysctl
			capabilities: add: ["NET_ADMIN", "NET_RAW"]
			runAsNonRoot: false
			runAsUser:    0
			runAsGroup:   0
		}
		ports: [{
			name:          "wg"
			containerPort: 51820
			protocol:      "UDP"
		}]
		volumeMounts: [{
			name:      "etc-wireguard"
			mountPath: "/etc/wireguard"
		}, {
			name:      "peers"
			mountPath: "/etc/wireguard-peers"
		}]
	}]
	volumes: [{
		name: "etc-wireguard"
		emptyDir: {}
	}, {
		name: "peers"
		projected: sources: [ for client in clients {
			secret: {
				name: "wireguard-\(client)-key"
				items: [{
					key:  "peer.pub"
					path: "\(client)/peer.pub"
				}, {
					key:  "peer.psk"
					path: "\(client)/peer.psk"
				}]
			}
		}]
	}]
}

k: Service: "wireguard-server": {}

k: Job: "wireguard-server-key": spec: template: spec: {
	serviceAccount: "secret-creator"
	containers: [{
		name:  "create"
		image: "nixery.dev/shell/wireguard/kubectl"
		command: ["sh", "-c", """
			[[ -f /etc/existing/server.key ]] && [[ -f /etc/existing/server.pub ]] && exit 0

			wg genkey > server.key
			wg pubkey < server.key > server.pub
			kubectl create secret generic wireguard-server-key --from-file=server.key --from-file=server.pub
			"""]
		volumeMounts: [{
			name:      "existing"
			mountPath: "/etc/existing"
		}]
	}]
	volumes: [{
		name: "existing"
		secret: {
			secretName: "wireguard-server-key"
			optional:   true
		}
	}]
}

let clients = ["peer1", "peer2"]

for index, client in clients {
	k: Job: "wireguard-\(client)-key": spec: template: spec: {
		serviceAccount: "secret-creator"
		containers: [{
			name:  "create"
			image: "nixery.dev/shell/wireguard/kubectl"
			command: ["sh", "-c", """
				cd /etc/wireguard-client

				if [[ ! -f peer.key ]] ; then
					wg genkey > peer.key
					wg pubkey < peer.key > peer.pub
					wg genpsk > peer.psk

					kubectl create secret generic wireguard-\(client)-key --from-file=peer.key --from-file=peer.pub --from-file=peer.psk
				fi
				
				echo "# do the thing!"

				cat <<- ----
					cat <<- --- > /etc/wireguard/wg0.conf
					[Interface]
					Address = 172.16.42.\(index+1)/32
					PrivateKey = $(cat peer.key)
				
					[Peer]
					PublicKey = $(cat /etc/wireguard-server/server.pub)
					AllowedIPs = 0.0.0.0/0, ::0
					Endpoint = 127.0.0.1:51820
					PersistentKeepalive = 25
					---

					wstunnel -v --udp --udpTimeoutSec -1 -L 127.0.0.1:51820:wireguard-server:51820 wss://wstunnel.addem.se/ &
					wg-quick up wg0
				----
				"""]
			volumeMounts: [{
				name:      "client"
				mountPath: "/etc/wireguard-client"
			}, {
				name: "server"
				mountPath: "/etc/wireguard-server"
			}]
		}]
		volumes: [{
			name: "client"
			secret: {
				secretName: "wireguard-\(client)-key"
				optional:   true
			}
		}, {
			name: "server"
			secret: {
				secretName: "wireguard-server-key"
				items: [{
					key: "server.pub"
					path: "server.pub"
				}]
			}
		}]
	}
}

k: ServiceAccount: "secret-creator": {}
k: RoleBinding: "secret-creator": {}
k: Role: "secret-creator": rules: [{
	apiGroups: [""]
	resources: ["secrets"]
	verbs: ["create"]
}]
