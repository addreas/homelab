// cue export --out=yaml deps.cue > deps.yaml

import "list"

name: "Homelab Dependency Check"
on: ["workflow_dispatch"]
// on: schedule: [{
//  cron: "*/10 * * * *"
// }]
let setup = [{
	name: "Check out repository code"
	uses: "actions/checkout@v3"
}, {
	name: "Setup CUE environment"
	uses: "cue-lang/setup-cue@v1.0.0-alpha.2"
	with: version: "v0.4.3"
}, {
	name: "Install JQ"
	run: """
		JQ=/usr/bin/jq
		sudo curl -sLo $JQ https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64
		sudo chmod +x $JQ
		"""
}]

let createPullRequest = {
	name: "Create Pull Request"
	uses: "peter-evans/create-pull-request@v4"
}

jobs: {
	[string]: {
		"runs-on": "ubuntu-latest"
		_run: [...string]
	}

	"update-go-deps": {
		steps: setup + [
			{run: "cue cmd update-gomod-defs"},
			{run: "cue cmd update-gomod-tags"},
			{run: "cue vet -c ./resources/..."},
			createPullRequest & {
				with: {
					title: "Updated go dependencies"
					body: """
						Automatically updated go dependencies using the `update-gomod-defs`
						and `update-gomod-tags` tools. The changes have passed a `cue vet -c ./resources/...`.
						"""
					"commit-message": "Automatically update go dependencies/definitions"
					branch:           "automatically-update-go-deps-defs"
				}
			},
		]
	}

	"update-jsonnet-deps": {
		steps: setup + [
			{run: ["cue cmd update-jsonnet-defs"]},
			createPullRequest & {
				with: {
					title: "Updated jsonnet dependencies"
					body: """
						Automatically updated jsonnet dependencies (kube-promethues).
						"""
					"commit-message": "Automatically update jsonnet dependencies/definitions"
					branch:           "automatically-update-jsonnet-defs"
				}
			},
		]
	}

	"update-github-release-tags": {
		steps: setup + [
			{run: "cue cmd -t githubToken=${{ secrets.GITHUB_TOKEN }} update-github-tags"},
			createPullRequest & {
				with: {
					title: "Updated github release tags"
					body: """
						Automatically updated github release tags.
						"""
					"commit-message": "Automatically update github release tags"
					branch:           "automatically-update-github-release-tags"
				}
			},
		]
	}
}
