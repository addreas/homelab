#!/usr/bin/env nu

export def "gen secrets" [] {
    talosctl gen secrets
    sops encrypt --in-place secrets.yaml
}

def secrets-yaml [] {
    let pipe = mktemp -d | path join (random uuid)
    mkfifo $pipe
    job spawn {
        sops decrypt secrets.yaml | save --append $pipe
        rm -rf ($pipe | path dirname)
    }
    $pipe
}

export def "gen talosconfig" [cluster_name: string, api_host: string] {
    (talosctl gen config
        $cluster_name
        $"https://($api_host):6443"
        --with-secrets (secrets-yaml)
        --output-types talosconfig)

    if (try { talosconfig context $cluster_name; true} catch { false }) {
        talosctl config merge ./talosconfig
    }
}

export def "gen controlplane" [cluster_name: string, api_host: string] {
    (talosctl gen config
        $cluster_name
        $"https://($api_host):6443"
        --with-secrets (secrets-yaml)
        --config-patch @patches/machine.yaml
        --config-patch @patches/cluster.yaml
        --config-patch @patches/controlplane.yaml
        --output-types controlplane
        --output controlplane.yaml)
}

export def "gen worker" [cluster_name: string, api_host: string] {
    (talosctl gen config
        $cluster_name
        $"https://($api_host):6443"
        --with-secrets (secrets-yaml)
        --config-patch @patches/machine.yaml
        --config-patch @patches/cluster.yaml
        --output-types worker
        --output worker.yaml)
}


export def "config apply" [cluster_name: string, kind: string, node_ip: string] {
    if ((talosctl config info -o json | from json | get context ) != $cluster_name) {
        talosctl config context $cluster_name
    }

    talosctl apply-config --insecure --nodes $node_ip --file $"($kind).yaml"

    def append-node [kind: string] {
        talosctl config info -o json
        | from json
        | get $kind
        | append $node_ip
        | uniq
        | talosctl config $kind...$in
    }

    append-node nodes
    if ($kind == "controlplane") {
        append-node endpoints
    }
}


export def "config boot" [
    cluster_name: string,
    api_host: string,
    ...schematics: string,
    --controlplane
] {
    let args = if $controlplane {
        [--config-patch @patches/controlplane.yaml
         --output-types controlplane]
    } else {
        [--output-types worker]
    }

    (talosctl gen config
        $cluster_name
        $"https://($api_host):6443"
        --with-secrets (secrets-yaml)
        --config-patch @patches/machine.yaml
        --config-patch @patches/cluster.yaml
        ...$args
        --output config.yaml)

    let dir = mktemp -d
    mv config.yaml $dir


    def with-config-server [pixiecore: closure] {
        let job_id = job spawn {
            cd $dir
            python -m http.server 8080
        }

        try {
            do $pixiecore
        } catch {
            job kill $job_id
            rm -rf $dir
        }
    }

    let schematic_id = open schematics/base.yaml ...$schematics
        | reduce { |it| merge deep --strategy append $it }
        | to json
        | http post https://factory.talos.dev/schematics
        | get id
    let talos_version = talosctl version --client --short
        | grep Talos
        | str replace "Talos " ""
    let host_ip = ip --json route
        | from json
        | where dst == "default"
        | get prefsrc
        | first


    let factory_image = $"https://factory.talos.dev/image/($schematic_id)/($talos_version)"
    let extra_args = [
        "talos.platform=metal",
        $"talos.config=http://($host_ip):8080/config.yaml"
    ]

    with-config-server {
        (sudo pixiecore boot
            $"($factory_image)/kernel-amd64"
            $"($factory_image)/initramfs-amd64.xz"
            --dhcp-no-bind
            --port 9734
            --debug
            --cmdline (http get $"($factory_image)/cmdline-metal-amd64"
                        | decode
                        | split row " "
                        | append $extra_args
                        | str join " "))
    }
}


export def "cluster bootstrap" [node_ip: string] {
    talosctl bootstrap --nodes $node_ip
    talosctl kubeconfig --nodes $node_ip
}

export def "cluster resources" [] {
    (cilium install
        --set ipam.mode=kubernetes
        --set kubeProxyReplacement=true
        --set securityContext.capabilities.ciliumAgent="{CHOWN,KILL,NET_ADMIN,NET_RAW,IPC_LOCK,SYS_ADMIN,SYS_RESOURCE,DAC_OVERRIDE,FOWNER,SETGID,SETUID}"
        --set securityContext.capabilities.cleanCiliumState="{NET_ADMIN,SYS_ADMIN,SYS_RESOURCE}"
        --set cgroup.autoMount.enabled=false
        --set cgroup.hostRoot=/sys/fs/cgroup
        --set k8sServiceHost=localhost
        --set k8sServicePort=7445)

    # https://docs.siderolabs.com/kubernetes-guides/cni/multus
    kubectl apply -f https://raw.githubusercontent.com/k8snetworkplumbingwg/multus-cni/master/deployments/multus-daemonset-thick.yml

    flux install --toleration-keys=node-role.kubernetes.io/control-plane

    kubectl apply -k https://github.com/addreas/cue-controller/config/default

    cue cmd apply -t kind=CueExport ./...
}
