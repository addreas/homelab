#!/bin/sh

kubectl create -f https://raw.githubusercontent.com/cilium/cilium/v1.9/install/kubernetes/quick-install.yaml
kubectl apply -f https://raw.githubusercontent.com/cilium/cilium/v1.9/install/kubernetes/quick-hubble-install.yaml

# perhaps?
# https://archive.fosdem.org/2020/schedule/event/containers_bpf/
# https://docs.cilium.io/en/v1.9/gettingstarted/kubeproxy-free/

cat << EOF | kubectl apply -f -
apiVersion: networking.k8s.io/v1beta1
kind: Ingress
metadata:
  name: hubble-ui
  namespace: kube-system
  annotations:
    cert-manager.io/cluster-issuer: addem-se-letsencrypt
    ingress.kubernetes.io/force-ssl-redirect: "true"
spec:
  rules:
    - host: hubble.addem.se
      http:
        paths:
          - path: /
            backend:
              serviceName: hubble-ui
              servicePort: 8443
  tls:
    - hosts:
        - hubble.addem.se
      secretName: hubble-cert
EOF
