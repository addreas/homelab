KIND=$1
NAME=$2
NAMESPACE=$3
RELEASE=$4
kubectl -n $3 annotate $KIND $NAME meta.helm.sh/release-name=$RELEASE
kubectl -n $3 annotate $KIND $NAME meta.helm.sh/release-namespace=$NAMESPACE
kubectl -n $3 label $KIND $NAME app.kubernetes.io/managed-by=Helm
