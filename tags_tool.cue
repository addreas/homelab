package kube

import (
	"list"
	"strings"
	"regexp"
	"tool/file"
	"tool/http"
	"tool/exec"
)

#WriteTags: #WriteGeneratedCue & {filename: "tags.cue"}

githubBearerToken: string @tag(githubToken)

// Fetches the latest releases from github and populates `githubReleases` in tags.cue
command: "update-github-tags": {
	let releaseKeys = list.SortStrings([for k, v in githubReleases {k}])

	releases: {
		for r in releaseKeys {
			(r): {

				req: http.Get & {
					url: "https://api.github.com/repos/\(r)/releases"
					if githubBearerToken != _|_ {
						request: header: Authorization: "Bearer \(githubBearerToken)"
					}
					response: {
						statusCode: 200
						body:       string & =~".*tag_name.*"
					}
				}

				jq: exec.Run & {
					cmd: ["jq", "-rj", """
						map(select(.prerelease == false))
							| sort_by(
								.tag_name
								| gsub("[a-z-]+?"; "")
								| split(".")
								| map(tonumber))
							| last
							| .tag_name
						"""]
					stdin:  req.response.body
					stdout: string
				}
			}
		}
	}

	writeTags: #WriteTags & {
		content: githubReleases: {
			for key in releaseKeys {
				(key): releases[key].jq.stdout
			}
		}
	}
}

// Parse the current go.mod file and populate `goModVersions` in tags.cue
command: "update-gomod-tags": {
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
		content: goModVersions: packages
	}
}
