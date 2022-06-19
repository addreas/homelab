package kube

import (
	"list"
	"strings"
	"regexp"
	"encoding/json"
	"tool/file"
	"tool/http"
)

#WriteTags: #WriteGeneratedCue & {filename: "tags.cue"}

// Fetches the latest releases from github and populates `githubReleases` in tags.cue
command: "update-github-tags": {
	let releaseKeys = list.SortStrings([ for k, v in githubReleases {k}])
	releases: {
		for r in releaseKeys {
			let split = strings.Split(r, "/")
			let owner = split[0]
			let repo = split[1]

			(r): http.Get & {
				url: "https://api.github.com/repos/\(owner)/\(repo)/releases/latest"
				response: {
					statusCode: 200
					body:       string & =~".*tag_name.*"
				}
				res: json.Unmarshal(response.body) & {
					tag_name: string
				}
			}

		}
	}

	writeTags: #WriteTags & {
		content: githubReleases: {
			for key in releaseKeys {
				(key): releases[key].res.tag_name
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
