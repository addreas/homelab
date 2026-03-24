package talos

import "list"

#Omit: {
	in: {...}
	out: {...}
	skip: [...string]
	out: {for k, v in in if !list.Contains(skip, k) {(k): v}}
}

#MergeAppend: {
	in: [...{...}]
	out: {...}

	appendPaths: [...[...string]]

	out: {
		for i in in {
			(#Omit & {in: i, skip: [for p in appendPaths {p[0]}]}).out
		}
		for p in appendPaths {
			(p[0]): {
				if len(p) == 1 {
					list.Concat([for i in in if i[p[0]] != _|_ {i[p[0]]}])
				}
				if len(p) > 1 {
					_ok: _
					for i in in {
						(#Omit & {in: i[p[0]], skip: [for p in appendPaths if len(p) > 1 {p[1]}]}).out
					}
					(p[1]): {
						if len(p) == 2 {
							list.Concat([for i in in if i[p[0]][p[1]] != _|_ {i[p[0]][p[1]]}])
						}
						if len(p) > 2 {
							for i in in {
								(#Omit & {in: i[p[0]][p[1]], skip: [for p in appendPaths if len(p) > 2 {p[2]}]}).out
							}
							(p[2]): {
								if len(p) == 3 {
									list.Concat([for i in in if i[p[0]][p[1]][p[2]] != _|_ {i[p[0]][p[1]][p[2]]}])
								}
							}
						}
					}
				}
			}
		}
	}
}
