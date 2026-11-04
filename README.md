# homelab

Kubernetes configuration as CUE, deployed with flux and
[cue-controller](https://github.com/addreas/cue-controller).

## Layout

- `kube_defs.cue` defines schema for `k: <Kind>: <name>: <resource>`. Kinds unified  against schemas from `cue.dev/x` deps and CRD defs generated into `cue.mod/gen/`.
- `kube_tool.cue` contains `cue cmd` tools like `ls`, `apply`, `diff`, `dump-yaml`, `seal`/`unseal` (sops).
- `renovate_tool.cue` contains a lint (`cue cmd lintrenovate ./resources/...`) that validates all referenced versions are in a format that the renovate regex managers pick up.
- `resources/constraints.cue`: cross-cutting defaults and creature comforts (securityContext, automatic service/ingress mapping, `_namespace`).

## How evaluation works

All files are `package kube`. A CUE instance is the target directory plus all
ancestor directories, so `resources/constraints.cue` and `kube_defs.cue` are
always in scope:

```sh
cue cmd ls ./resources/default   # ./ prefix is required
```

`k` unifies schema definitions from the root with concrete resources from leaf
directories, which is what makes per-kind defaults and validation work.

## Conventions

- `_namespace: "foo"` in a directory defaults every resource in it to `foo`
  and creates the Namespace.
