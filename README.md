# homelab

Kubernetes configuration as CUE, deployed with flux and
[cue-controller](https://github.com/addreas/cue-controller).

## Layout

- `kube_defs.cue` — the `k` registry: `k: <Kind>: <name>: <resource>`. Kinds are
  typed by unification against schemas from `cue.dev/x` deps and CRD defs
  generated into `cue.mod/gen/`.
- `kube_tool.cue` — `cue cmd` helpers: `ls`, `apply`, `diff`, `dump-yaml`,
  `seal`/`unseal` (sops).
- `tags.cue` — GitHub release pins, referenced as
  `githubReleases["org/repo"]`, bumped by renovate.
- `resources/constraints.cue` — cross-cutting defaults (securityContext,
  service ports, ingress/httpRoute hosts, prune labels, `_namespace`, `_homelab`).
- `resources/<area>/<component>/` — one directory per component or app.

## How evaluation works

All files are `package kube`. A CUE instance is the target directory plus all
ancestor directories, so `resources/constraints.cue`, `kube_defs.cue` and
`tags.cue` are always in scope:

```sh
cue cmd ls ./resources/default   # ./ prefix is required
```

`k` unifies schema definitions from the root with concrete resources from leaf
directories, which is what makes per-kind defaults and validation work.

## Conventions

- `_namespace: "foo"` in a directory defaults every resource in it to `foo`
  and creates the Namespace.
- Helm is preferred for controllers: `HelmRepository` + `HelmRelease` for
  published charts, `GitRepository` + chart path for repo-only charts.
- Secrets live in `*.enc.cue` files, sops/age encrypted; flux decrypts them
  with the `qb-homelab` secret in `flux-system`.
