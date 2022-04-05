
helm repo add cilium https://helm.cilium.io/

helm install cilium cilium/cilium --version 1.11.3 \
  --namespace kube-system

helm upgrade cilium cilium/cilium --version 1.11.3 \
   --namespace kube-system \
   --reuse-values \
   --set cni.exclusive=false \
   --set hubble.relay.enabled=true \
   --set hubble.ui.enabled=true

helm upgrade cilium cilium/cilium --version 1.11.3 \
   --namespace kube-system \
   --reuse-values \
   --set cni.chainingMode=none \
   --set cni.customConf=false \
   # --set cni.chainingMode=generic-veth \
   # --set cni.customConf=true \
   --set cni.configMap=cni-configuration

kubectl apply -f multus.yaml

# curl -sSL https://raw.githubusercontent.com/k8snetworkplumbingwg/multus-cni/master/deployments/multus-daemonset.yml | sed -e '/^.*args:/p' -e 's/args:/- "--restart-crio"/' -e 's/0.3.1/0.4.0/' | kubectl apply -f -
# curl -sSL https://raw.githubusercontent.com/k8snetworkplumbingwg/multus-cni/master/deployments/multus-daemonset.yml | sed -e '/^.*args:/p' -e 's/args:/- "--restart-crio"/' -e 's/file=auto/file=/' | kubectl apply -f -
