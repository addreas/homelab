// cue export --out=yaml deps.cue > deps.yaml

import "list"

name: "Homelab Dependency Check"
on: ["workflow_dispatch"]
// on: schedule: [{
// 	cron: "*/10 * * * *"
// }]

jobs: {
	[string]: {
		"runs-on": "ubuntu-latest"
		_run: [...string]
		_commit_message: string

		steps: list.FlattenN([{
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
		}, [
			for cmd in _run {run: cmd},
		], {
			name: "Create Pull Request"
			uses: "peter-evans/create-pull-request@v4"
			with: "commit-message": _commit_message
		}], 1)
	}

	"update-go-deps": {
		_commit_message: "Automatically update go dependencies/definitions"
		_run: [
			"cue cmd update-gomod-defs",
			"cue cmd update-gomod-tags",
			"cue vet -c ./resources/...",
		]
	}

	"update-jsonnet-deps": {
		_commit_message: "Automatically update jsonnet dependencies/definitions"
		_run: ["cue cmd update-jsonnet-defs"]
	}

	"update-github-release-tags": {
		_commit_message: "Automatically update github release tags"
		_run: ["cue cmd update-github-tags"]
	}
}
