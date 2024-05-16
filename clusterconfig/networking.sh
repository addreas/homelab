
helm repo add cilium https://helm.cilium.io/
helm repo update

# helm install cilium cilium/cilium --version $CILIUM_VERSION \
#    --namespace kube-system \
#    -f cilium-values.yaml

# helm upgrade cilium cilium/cilium --version 1.15.2 --namespace kube-system -f cilium-values.yaml

helm upgrade cilium cilium/cilium --version $(helm show chart cilium/cilium | yq -r .version) --namespace kube-system -f cilium-values.yaml

kubectl apply -f multus.yaml

# curl -sSL https://raw.githubusercontent.com/k8snetworkplumbingwg/multus-cni/master/deployments/multus-daemonset.yml | sed -e '/^.*args:/p' -e 's/args:/- "--restart-crio"/' -e 's/0.3.1/0.4.0/' | kubectl apply -f -
# curl -sSL https://raw.githubusercontent.com/k8snetworkplumbingwg/multus-cni/master/deployments/multus-daemonset.yml | sed -e '/^.*args:/p' -e 's/args:/- "--restart-crio"/' -e 's/file=auto/file=/' | kubectl apply -f -
