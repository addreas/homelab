# Talos setup

## boot
### boot talos

> Run siderolabs/booter

Might need to disable firewall if running on a laptop. Should even work over wifi if the devices are in the same subnet.


**OPTIONS**
* endpoint
    * flags: --endpoint
    * desc: talos.config=http://this_host:8080/config.yaml?h=${hostname}...
* wipe
    * flags: --wipe
    * desc: run with talos.experimental.wipe

```sh
TALOS_VERSION=$(talosctl version --client --short | grep Talos | sed "s/Talos //")
ARGS="talos.platform=metal"

if [[ $endpoint == "true" ]]; then
    HOST_IP=$(ip --json route | jq -r '.[] | select(.dst == "default") | .prefsrc')
    ENDPOINT='/config.yaml?h=${hostname}&m=${mac}&s=${serial}&u=${uuid}'
    # mkdir www
    # cp worker.yaml www
    # cd www
    # python -m http.server 8080
    # example: /config.yaml?h=&m=1c:69:7a:a0:af:3e&s=G6BE048007TL&u=21a1d1a1-289c-b916-215a-1c697aa0af3e

    ARGS="$ARGS talos.config=http://${HOST_IP}:8080${ENDPOINT}"
fi
if [[ $wipe == "true" ]]; then
    ARGS="$ARGS talos.experimental.wipe=system:EPHEMERAL,STATE"
fi


docker run --rm --network host ghcr.io/siderolabs/booter:v0.3.0 \
    --debug \
    --talos-version=${TALOS_VERSION} \
    --extra-kernel-args="${ARGS}" \
    --extensions="" \
    # --schematic-id=${SCHEMATIC} \
    # perhaps worksk without schematic using just --extensions and --kernel-args instead?
```


### boot pixie

> Ditto using pixiecore.

```sh
#SCHEMATIC=$(curl -d "{}" https://factory.talos.dev/schematics | jq -r .id)
SCHEMATIC=376567988ad370138ad8b2698212367b8edcb69b5fd68c80be1f2ec7d603b4ba
TALOS_VERSION=$(talosctl version --client --short | grep Talos | sed "s/Talos //")
FACTORY_IMAGE=https://factory.talos.dev/image/${SCHEMATIC}/${TALOS_VERSION}


HOST_IP=$(ip --json route | jq -r '.[] | select(.dst == "default") | .prefsrc')
ENDPOINT='/config.yaml?h=${hostname}&m=${mac}&s=${serial}&u=${uuid}'
ARGS="$ARGS talos.config=http://${HOST_IP}:8080${ENDPOINT}"

nix run nixpkgs#pixiecore -- boot \
    ${FACTORY_IMAGE}/kernel-amd64 \
    ${FACTORY_IMAGE}/initramfs-amd64.xz \
    --dhcp-no-bind \
    --port 9734 \
    --debug \
    --cmdline "$(curl -sSL ${FACTORY_IMAGE}/cmdline-metal-amd64) $ARGS"
```


## secrets
### secrets gen-kubeadm

> run on an existing kubeadm master node

```sh
TOKEN=$(kubeadm token create --ttl 0)
talosctl gen secrets --kubernetes-bootstrap-token $TOKEN --from-kubernetes-pki /etc/kubernetes/pki

cat secrets.yaml
```

### secrets gen

```sh
talosctl gen secrets
sops encrypt --in-place secrets.yaml
```

## config
### config gen talosconfig
```sh
talosctl gen config qb https://api.qb:6443 \
    --with-secrets <(sops decrypt secrets.yaml) \
    --output-types talosconfig

if  ! talosctl config context $CLUSTER_NAME; then
    talosctl config merge ./talosconfig
fi
```

### config gen controlplane
```sh
talosctl gen config qb https://api.qb:6443 \
    --with-secrets <(sops decrypt secrets.yaml) \
    --config-patch @patches/machine.yaml \
    --config-patch @patches/cluster.yaml \
    --config-patch @patches/controlplane.yaml \
    --output-types controlplane \
    --output controlplane.yaml
```

### config gen worker

```sh
talosctl gen config qb https://api.qb:6443 \
    --force \
    --with-secrets <(sops decrypt secrets.yaml) \
    --config-patch @patches/machine.yaml \
    --config-patch @patches/cluster.yaml \
    --output-types worker \
    --output worker.yaml
```

### config apply (CLUSTER_NAME) (KIND) (NODE_IP)
> Set up a talos node.

Node IP has to be manually found via talos dashboard, dhcp logs or similar.

```bash
if [[ "$(talosctl config info -ojson | jq -r .context )" != "${CLUSTER_NAME}" ]]; then
    talosctl config context ${CLUSTER_NAME}
fi

talosctl apply-config --insecure --nodes ${NODE_IP} --file ${KIND}.yaml

if [[ "$KIND" == "controlplane" ]]; then
    talosctl config info -o json \
    | (jq -r '.endpoints[]' && echo ${NODE_IP}) \
    | sort -u \
    | xargs talosctl config endpoints 
fi;
```

### config boot (CLUSTER_NAME) (API_HOST) (SCHEMATICS)

> do it all, and pixie boot it

**OPTIONS**
* controlplane
    * flags: --controlplane
    * desc: boot and configure a controlplane node

```sh
TALOS_VERSION=$(talosctl version --client --short | grep Talos | sed "s/Talos //")

DIR=$(mktmp -d)
function cleanup() {
    kill $(jobs -p)
    rm -rf $DIR
}
trap cleanup INT TERM

(
    cd $DIR

    ARGS="--output-types worker"
    if [[ $conotrolplane == "$true" ]]; then
        ARGS="--config-patch @patches/controlplane.yaml --output-types controlplane"
    fi

    talosctl gen config $CLUSTER_NAME https://$API_HOST:6443 \
        --with-secrets <(sops decrypt secrets.yaml) \
        --config-patch @patches/machine.yaml \
        --config-patch @patches/cluster.yaml \
        $ARGS\
        --output config.yaml
    python -m http.server 8080 &
)

SCHEMATIC_JSON=$(nix run nixpkgs#yq-go -- eval-all '. as $item ireduce ({}; . *+ $item)' schematics/base.yaml $SCHEMATICS -o json)
SCHEMATIC_ID=$(curl -d "$SCHEMATIC_JSON" https://factory.talos.dev/schematics | jq -r .id)
FACTORY_IMAGE=https://factory.talos.dev/image/${SCHEMATIC_ID}/${TALOS_VERSION}

HOST_IP=$(ip --json route | jq -r '.[] | select(.dst == "default") | .prefsrc')
ENDPOINT='/config.yaml?h=${hostname}&m=${mac}&s=${serial}&u=${uuid}'
KERNEL_ARGS="talos.platform=metal talos.config=http://${HOST_IP}:8080${ENDPOINT}"

nix run nixpkgs#pixiecore -- boot \
    ${FACTORY_IMAGE}/kernel-amd64 \
    ${FACTORY_IMAGE}/initramfs-amd64.xz \
    --dhcp-no-bind \
    --port 9734 \
    --debug \
    --cmdline "$(curl -sSL ${FACTORY_IMAGE}/cmdline-metal-amd64) $KERNEL_ARGS"
```


## cluster
### cluster bootstrap (NODE_IP)
```sh
talosctl bootstrap --nodes $NODE_IP
talosctl kubeconfig --nodes $NODE_IP
```

### cluster resources
```sh
cilium install \
    --set ipam.mode=kubernetes \
    --set kubeProxyReplacement=true \
    --set securityContext.capabilities.ciliumAgent="{CHOWN,KILL,NET_ADMIN,NET_RAW,IPC_LOCK,SYS_ADMIN,SYS_RESOURCE,DAC_OVERRIDE,FOWNER,SETGID,SETUID}" \
    --set securityContext.capabilities.cleanCiliumState="{NET_ADMIN,SYS_ADMIN,SYS_RESOURCE}" \
    --set cgroup.autoMount.enabled=false \
    --set cgroup.hostRoot=/sys/fs/cgroup \
    --set k8sServiceHost=localhost \
    --set k8sServicePort=7445

# https://docs.siderolabs.com/kubernetes-guides/cni/multus
kubectl apply -f https://raw.githubusercontent.com/k8snetworkplumbingwg/multus-cni/master/deployments/multus-daemonset-thick.yml

flux install --toleration-keys=node-role.kubernetes.io/control-plane

kubectl apply -k https://github.com/addreas/cue-controller/config/default

cue cmd apply -t kind=CueExport ./...
```
