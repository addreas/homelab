#!/bin/sh
set -e

mod=$PWD/cue.mod

groups="
cue.toolkit.fluxcd.io
grafana.integreatly.org
k8s.cni.cncf.io
cilium.io hydra.ory.sh
"

kubectl get crd -o name \
	| grep "$(echo $groups | sed 's/\s/|/g')" \
	| xargs kubectl get crd -o yaml \
	| yq -Y ".items[]" \
	> "$mod/gen/crds.yaml"

for group in $groups; do
	(
		mkdir -p "$mod/gen/$group"
		cd "$mod/gen/$group"
		cue get crd --group $group ../crds.yaml
	)
done

rm "$mod/gen/crds.yaml"
