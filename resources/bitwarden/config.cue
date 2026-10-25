package kube

k: ConfigMap: bitwarden: data: {
	SMTP_HOST:          "smtp.gmail.com"
	SMTP_FROM:          "bitwarden@addem.se"
	SMTP_PORT:          "587"
	SMTP_SECURITY:      "starttls"
	SMTP_SSL:           "true"
	WEBSOCKET_ENABLED:  "true"
	DATA_FOLDER:        "/data"
	DOMAIN:             "https://bitwarden.addem.se"
	ROCKET_WORKERS:     "2"
	SHOW_PASSWORD_HINT: "false"
	WEB_VAULT_ENABLED:  "true"
	ROCKET_PORT:        "8080"
}
