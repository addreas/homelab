package talos

import (
	"list"
	"encoding/json"
)

#MergeAppend: {
	in: [...{...}]
	out: {...}

	#scalar: null | bool | bytes | string | number

	out: {
		for v0 in in {
			for k1, v1 in v0 {
				(k1): {
					if (v1 & #scalar) != _|_ {v1}
					if (v1 & [...]) != _|_ {list.Concat([for i in in if i[k1] != _|_ {i[k1]}])}
					if (v1 & {...}) != _|_ {
						for k2, v2 in v1 {
							(k2): {
								if (v2 & #scalar) != _|_ {v2}
								if (v2 & [...]) != _|_ {list.Concat([for i in in if i[k1][k2] != _|_ {i[k1][k2]}])}
								if (v2 & {...}) != _|_ {
									for k3, v3 in v2 {
										(k3): {
											if (v3 & #scalar) != _|_ {v3}
											if (v3 & [...]) != _|_ {list.Concat([for i in in if i[k1][k2] != _|_ {i[k1][k2][k3]}])}
											if (v3 & {...}) != _|_ {
												// for k4, v4 in v3 { ... }
												v3
											}
										}
									}
								}
							}
						}
					}
				}
			}
		}
	}
}

#githubLatest: {
	$repo: string

	req: {
		url: "https://api.github.com/repos/\($repo)/releases"
		response: {
			statusCode: 200
			body:       string & =~".*tag_name.*"
			value:      json.Unmarshal(body)
			...
		}
		...
	}

	value: [for r in req.response.value if r.prerelease != true {r}][0].tag_name
}
