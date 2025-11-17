package kube

k: ConfigMap: "hoarder-configuration": data: {
	HOARDER_VERSION: "release"
	NEXTAUTH_URL:    "http://localhost:3000"
}

k: Secret: "hoarder-secrets": stringData: {
	MEILI_MASTER_KEY:   "generated_secret"
	NEXT_PUBLIC_SECRET: "my-super-duper-secret-string"
	NEXTAUTH_SECRET:    "generated_secret"
}
