package kube

import (
	"strings"
	"regexp"
	"encoding/json"
	"tool/exec"
	"tool/file"
	"tool/http"
)

let githubReleaseRepositories = [
	"home-assistant/core",
	"zwave-js/zwavejs2mqtt",
	"dani-garcia/vaultwarden",
	"ory/hydra",
	"ory/kratos",
	"grafana/grafana",
	"longhorn/longhorn",
	"jcmoraisjr/haproxy-ingress",
]

#WriteTags: {
	subset: string
	values: _

	eval: exec.Run & {
		cmd: ["cue", "eval",
			"--show-attributes",
			"--show-hidden",
			"--show-optional",
			"cue:", "tags.cue",
			"json:", "-"]
		stdin:  json.Marshal({(subset): values})
		stdout: string
	}

	fmt: exec.Run & {
		cmd: ["cue", "fmt", "--simplify", "-"]
		stdin:  eval.stdout
		stdout: string
	}

	write: file.Create & {
		filename: "tags.cue"
		contents: """
		package kube
		
		\(fmt.stdout)
		"""
	}
}

command: "update-github-releases": {
	releases: {
		for r in githubReleaseRepositories {
			let split = strings.Split(r, "/")
			let owner = split[0]
			let repo = split[1]

			(r): http.Get & {
				url: "https://api.github.com/repos/\(owner)/\(repo)/releases/latest"
				response: body: string
				res: json.Unmarshal(response.body)
				res: tag_name: string
			}

		}
	}

	writeTags: #WriteTags & {
		subset: "githubReleases"
		values: {
			for key, value in releases {
				(key): value.res.tag_name
			}
		}
	}
}

command: "update-gomod-versions": task: {
	readGoMod: file.Read & {
		filename: "go.mod"
		contents: string
	}
	let re = #"^\s+([-\w./]+)\s+([-\w.]+)$"#
	let packages = {
		for line in strings.Split(readGoMod.contents, "\n") if line =~ re {
			let match = regexp.FindSubmatch(re, line)
			"\(match[1])": match[2]
		}
	}

	writeTags: #WriteTags & {
		subset: "goModVersions"
		values: packages
	}
}
