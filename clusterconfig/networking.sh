
helm repo add cilium https://helm.cilium.io/
helm repo update

CILIUM_VERSION=1.13.0

helm install cilium cilium/cilium --version $CILIUM_VERSION \
   --namespace kube-system \
   -f cilium-values.yaml

helm upgrade cilium cilium/cilium --version $CILIUM_VERSION \
   --namespace kube-system \
   -f cilium-values.yaml

# https://docs.cilium.io/en/v1.12/gettingstarted/bgp/
# probably conflicts with kube-vip?
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: ConfigMap
metadata:
  name: bgp-config
  namespace: kube-system
data:
  config.yaml: |
    peers:
      - peer-address: 192.168.1.1
        peer-asn: 64512
        my-asn: 64512
    address-pools:
      - name: default
        protocol: bgp
        addresses:
          - 192.168.10.0/24
EOF

kubectl apply -f multus.yaml

# curl -sSL https://raw.githubusercontent.com/k8snetworkplumbingwg/multus-cni/master/deployments/multus-daemonset.yml | sed -e '/^.*args:/p' -e 's/args:/- "--restart-crio"/' -e 's/0.3.1/0.4.0/' | kubectl apply -f -
# curl -sSL https://raw.githubusercontent.com/k8snetworkplumbingwg/multus-cni/master/deployments/multus-daemonset.yml | sed -e '/^.*args:/p' -e 's/args:/- "--restart-crio"/' -e 's/file=auto/file=/' | kubectl apply -f -
