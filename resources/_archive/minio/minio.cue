package kube

k: StatefulSet: minio: spec: {
	replicas: 4
	template: spec: containers: [{
		name:  "minio"
		image: "quay.io/minio/minio:latest"
		args: [
			"server",
			"--console-address",
			"0.0.0.0:9001",
			"http://minio-{0...\(replicas-1)}.minio.minio.svc.cluster.local/data",
		]
		ports: [{
			containerPort: 9000
		}, {
			containerPort: 9001
		}]
		envFrom: [{secretRef: name: "minio-root-credentials"}]
		env: [{
			name:  "MINIO_BROWSER_REDIRECT_URL"
			value: "https://console.minio.addem.se"
		}]
		volumeMounts: [{
			name:      "data"
			mountPath: "/data"
		}]
	}]
	volumeClaimTemplates: [{
		metadata: name: "data"
		spec: {
			accessModes: ["ReadWriteOnce"]
			resources: requests: storage: "10Gi"
		}
	}]
}

k: Service: minio: {
	_selector: app: "minio"
	spec: ports: [{
		name: "s3"
		port: 9000
	}, {
		name: "console"
		port: 9001
	}]
}

k: Ingress: minio: spec: {}

k: Ingress: "console.minio": spec: rules: [{
	http: paths: [{
		backend: service: {
			name: "minio"
			port: number: 9001
		}
	}]
}]

k: SealedSecret: "minio-root-credentials": spec: encryptedData: {
	MINIO_ROOT_PASSWORD: "AgAb5HpPil0p+AQQMEpvoVJBTvGSTP3kin57kchNFhYBZycDyFZMD+LB6X+ooiwrbcij1qyzLeG4nHrvaBdbhuhJHRQSi8AJEgiBOpRAkicrJz5iwLw0FVrdzVe4nFNsR71HOdPoyIMG+zJ0PaQV4c8/1aOojru7m32wo6aRkSwEiamUPoRLc/lofUgQBDL/oYboeU3BxgUvWkdmyqHD1Xf3h7ugW2Z4ECCH26HANOACaxGzRT/qUddh0dBTaT5M7Ct2HlpJxVMKB3X9eWeULRtL64GgShwEl0uTQ9efHI1H6mDzn681mRyRDPdf76RhKOwkgOKk9rno6Pzwy9Of3V/yoDFhgOg/o+E+s/GZ/oa4beDfybIbC72eM0JbSuepLdmiaT8Ab5+bwMRoKPFbBwns7Dmzx8mphoamiG/RBiniH6dEhrc8jbTKz4cwwQy1E2oBLTZ7PeYH+a+dKMi1eSU0Sgk1hfDoz2p+VsEdGS6NQqO4iuK7++onui1F1Qb0OHd/MnWsGY0ORVtVv9qe7jL7R14jr60qZhP7qdoGv4gltmyyHRbNVZrJV/q7FUbm87RXJii3Zbe0zArIsVRWdUY8WyQ2Mi7sKfMlDbjDKUsjjr2ckV3s9ycXVWHBtHgDOaFtwlSmA1AdSmuUh7LdIkGA7HJlJGcmn/NTcSANxtU/UDNNmXF8H9HUISUP78P5MYbWLpsAeArC9kosQYhgUAzxathr+vg6OoY6VRZldg356svvZXhKyNq0DlPbMunx3IM="
	MINIO_ROOT_USER:     "AgCKi0Q59ksy0h/yOquBAIo6Zd+DEs3umSTXoJJ8XlyIV6bPy3JRthBLnmJQETznexlVrFY9Hbft+jwIaEQbgCBYGcIFrnw/T0dbZEgnVdGLLMvpZRgKRok3+BFTbjGMa3J96EtKp7tU6/9KM+zpjPKwPSmJVVgUKI9Wl+ccq9XktahIodvZ63YKR1EA8ih3yeVx61cc8hmFE1rU215q9TR4DujoZEKKdy7xCx2NHwU0BZiykS9BSti11Bfwj1/bKJJ2GZEiCPIGj5VlIpmCbQcBfikJLXmiDwzZXukcp/BQnluauk78Zh6fO9RjJbVJ9SSJe9c8KzG1oaj9qmh5eGQkx33zZ48wZJcSY9ll8ku1vaMdEx0IoDh7EOcmZXERq3W/Bz4RKGSnIMII/IcFebvNtptRGfqtn+MGHWXavqeDa/s5aK0HDv5c2yxU2JDZ6gXUtycXHT87LC5v2BcQTiqer2G3rtaJ7Yv+BbTZr/krkjqmLsmgDcL0ClCTmkxKjCfV7YgEiOJMAqLP9ErwkHsVFCdDYSidsLqwRztbWOIDHNJ5JQHCQjtX6tVNRmrSUgOuk8maW4c0HsHcYUGNYCBvor7R3grDtzT9Dip6ZPC5DFRmxCS3151evvd7RXTgmR8tKI8xFNWqZ0XjeNfzVlzOiKZD0eVRsB30EJ8/PGE4dli1PvqgtZnQWU/U9bnS2qcyLvk3/VN66x6hQZX2b03G+LA6ERq39+E="
}
