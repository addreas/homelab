package kube

k: PersistentVolume: "sergio-videos": spec: local: path: "/mnt/videos"

k: PersistentVolumeClaim: "sergio-videos": spec: resources: requests: storage: "2Ti"
