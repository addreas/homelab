#!/bin/sh

kubectl apply -f https://github.com/jetstack/cert-manager/releases/download/v1.1.0/cert-manager.yaml

cat << EOF | kubectl apply -f -
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
    name: addem-se-letsencrypt
spec:
    acme:
        email: andreas+acme@addem.se
        server: https://acme-v02.api.letsencrypt.org/directory
        privateKeySecretRef:
            name: addem-se-letsencrypt-private-key
        solvers:
            - http01:
                ingress: {}
EOF
