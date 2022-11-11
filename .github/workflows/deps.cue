import "list"

name: "Homelab Dependency Check"
on: schedule: [{
	cron: "*/10 * * * *"
}]

jobs: {
	[string]: {
		"runs-on": "ubuntu-latest"
		container: "nixery.dev/shell/cue/jq/git/node"
		_run: [...string]
		_commit_message: string
		steps:           list.FlattenN([
					{
				name: "Check out repository code"
				uses: "actions/checkout@v3"
			},
			[ for cmd in _run {{run: cmd}}],
			{
				name: "Create Pull Request"
				uses: "peter-evans/create-pull-request@v4"
				with: "commit-message": _commit_message
			},
		], 1)
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
