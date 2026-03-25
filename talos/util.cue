package talos

import "list"

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
