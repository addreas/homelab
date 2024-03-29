// cue export --out=yaml deps.cue > deps.yaml

import "list"

name: "Homelab Dependency Check"

on: schedule: [{cron: "30 14 * * 6"}]

let setup = [{
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
}]

let createPullRequest = {
	name: "Create Pull Request"
	uses: "peter-evans/create-pull-request@v5"
}

jobs: {
	[string]: {
		"runs-on": "ubuntu-latest"
		steps: [...{
			run?: string
		}]
	}

	"update-deps": {
		steps: setup + [
			{run: "cue cmd -t githubToken=${{ secrets.GITHUB_TOKEN }} update-github-tags"},
			{run: "cue cmd update-jsonnet-defs"},
			{run: "cue cmd update-gomod-defs"},
			{run: "cue cmd update-gomod-tags"},
			{run: "git diff"},
			{run: "cue vet -c ./resources/..."},
			{run: """
				echo "Automatically updated dependencies:" > .pr-body.md
				echo '````diff' >> .pr-body.md
				git diff -U0 main tags.cue | sed '/@.*/d' | tail -n +5 >> .pr-body.md
				echo '````' >> .pr-body.md
				"""},
			createPullRequest & {
				with: {
					title:            "Updated dependencies"
					"body-path":      ".pr-body.md"
					"commit-message": "Automatically update dependencies/definitions"
					branch:           "automatically-update-deps"
				}
			},
		]
	}

	// "update-go-deps": {
	// 	steps: setup + [
	// 		{run: "cue cmd update-gomod-defs"},
	// 		{run: "cue cmd update-gomod-tags"},
	// 		{run: "git diff"},
	// 		{run: "cue vet -c ./resources/..."},
	// 		createPullRequest & {
	// 			with: {
	// 				title: "Updated go dependencies"
	// 				body: """
	// 					Automatically updated go dependencies using the `update-gomod-defs`
	// 					and `update-gomod-tags` tools. The changes have passed a `cue vet -c ./resources/...`.
	// 					"""
	// 				"commit-message": "Automatically update go dependencies/definitions"
	// 				branch:           "automatically-update-go-deps-defs"
	// 			}
	// 		},
	// 	]
	// }

	// "update-jsonnet-deps": {
	// 	steps: setup + [
	// 		{run: "cue cmd update-jsonnet-defs"},
	// 		createPullRequest & {
	// 			with: {
	// 				title: "Updated jsonnet dependencies"
	// 				body: """
	// 					Automatically updated jsonnet dependencies (kube-promethues).
	// 					"""
	// 				"commit-message": "Automatically update jsonnet dependencies/definitions"
	// 				branch:           "automatically-update-jsonnet-defs"
	// 			}
	// 		},
	// 	]
	// }

	// "update-github-release-tags": {
	// 	steps: setup + [
	// 		{run: "cue cmd -t githubToken=${{ secrets.GITHUB_TOKEN }} update-github-tags"},
	// 		createPullRequest & {
	// 			with: {
	// 				title: "Updated github release tags"
	// 				body: """
	// 					Automatically updated github release tags.
	// 					"""
	// 				"commit-message": "Automatically update github release tags"
	// 				branch:           "automatically-update-github-release-tags"
	// 			}
	// 		},
	// 	]
	// }
}
