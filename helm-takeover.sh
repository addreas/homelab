# usage: ./helm-takeover.sh haproxy kube-system role haproxy-haproxy-ingress
RELEASE=$1
NAMESPACE=$2
KIND=$3
NAME=$4
kubectl -n $NAMESPACE annotate $KIND $NAME meta.helm.sh/release-name=$RELEASE
kubectl -n $NAMESPACE annotate $KIND $NAME meta.helm.sh/release-namespace=$NAMESPACE
kubectl -n $NAMESPACE label $KIND $NAME app.kubernetes.io/managed-by=Helm
