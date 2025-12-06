// cue export --out=yaml deps.cue > deps.yaml

name: "Homelab Dependency Check"

on: schedule: [{cron: "30 14 1 * *"}]

jobs: {
	[string]: {
		"runs-on": "ubuntu-latest"
		steps: [...{
			run?: string
		}]
	}

	"update-deps": {
		steps: [
			{
				uses: "actions/checkout@v3"
				with: submodules: true
			}, {
				uses: "actions/setup-go@v3"
				with: "go-version": "^1.22"
			}, {
				name: "Install `cue`, `jsonnet`, `jb`, `jq`"
				run: """
					go install cuelang.org/go/cmd/cue@latest
					go install github.com/google/go-jsonnet/cmd/jsonnet@latest
					go install github.com/jsonnet-bundler/jsonnet-bundler/cmd/jb@latest

					JQ=/usr/bin/jq
					sudo curl -sLo $JQ https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64
					sudo chmod +x $JQ
					"""
			},
			{run: "cue cmd -t githubToken=${{ secrets.GITHUB_TOKEN }} update-github-tags"},
			{run: "cd ./resources/system/monitoring/kube-prometheus && ./export.sh && popd"},
			{run: "git diff"},
			{run: "cue vet -c ./resources/..."},
			{run: """
				echo "Automatically updated dependencies:" > .pr-body.md
				echo '````diff' >> .pr-body.md
				git diff -U0 main tags.cue | sed '/@.*/d' | tail -n +5 >> .pr-body.md
				echo '````' >> .pr-body.md
				"""
			}, {
				name: "Create Pull Request"
				uses: "peter-evans/create-pull-request@v5"
				with: {
					title:            "Updated dependencies"
					"body-path":      ".pr-body.md"
					"commit-message": "Automatically update dependencies/definitions"
					branch:           "automatically-update-deps"
				}
			},
		]
	}
}
