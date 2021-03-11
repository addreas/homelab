package kube

k: ConfigMap: bitwarden: {
	data: {
		SMTP_HOST:          "smtp.gmail.com"
		SMTP_FROM:          "nucles+bitwarden@addem.se"
		SMTP_PORT:          "587"
		SMTP_SSL:           "true"
		WEBSOCKET_ENABLED:  "true"
		DATA_FOLDER:        "/data"
		DOMAIN:             "https://bitwarden.addem.se"
		ROCKET_WORKERS:     "2"
		SHOW_PASSWORD_HINT: "false"
		WEB_VAULT_ENABLED:  "true"
		ROCKET_PORT:        "8080"
	}
}

k: SealedSecret: "bitwarden-smtp": spec: encryptedData: {
	emailPassword: "AgBYOYQSLiw+QmsswPr9z+uo9lSGuSUhdZSn/ZiXGQpsrqVxL+OawQDvEv+5zv5ebZZECOdjq1TCBR0N8bNTUXnzVzjLlZHmKEymt6JcPJyIh2OvbHjXLZ6zftYZVUrIvhXZmmxgNEtEuaK4Nq0ZK+l7HIvHfs2NChadXjpj8jighY73lfMZB20oDn079fQulwXITV3Gp0rH8cnnNfi/hGn/bq5gI4Iyp+0jkAb9qY3AVo90cLNUi76ddvqIDeg8PYt8zR+buDj7BVjXd0cqIjrSG9UQdyX11We6gRbxq1/rAVtbf6ZHa1qEd8zFnX41hKzsZH7uONJi3RFhDC8ysoIzgW4QUeJJ75b/U+epOtTKL9KVPCuRAePRkhGFmja/A29Z1EuiV1pMEo6pJHp749xu23vTmgULYJ/5TqCc5ah6eDZaXeukve/HU03+n8CD5a+WGADhH+sFRIBfKWVAGZIdrVCEwsnKhp74R6i4nFwG6GnGEqa3VO2+b/YYBPYW+ibtcT2yiW/kTC5nZdFJIoK5x2YUphMx2vr4SyXnfCJdYHrPPnEsEbZQwOdgzGz5PhiUTmAIB0AECXv3dKMRT5BwEcUTC2jK8C/KpOPVrN4bVHfV1u0BpvryU2n6IRUYwBrG8enfUZJ0R03ffbIQ1/8foDMG5Ak1bNf5ARKQ9CHWA19A7L6h3KJgfBVR/gozvS+DU1HYFoRaSWCvNHYqUk76"
	emailUser:     "AgCfinTEuAhFN0/ZSNzomNyQOIBHgofzlz0uiNPa6daUQdide63dm/fotTaDylMzXldiRIyN9ECPnGuBp3N8mOfGm0z7lSGI/wEfnYh+p6YzCqC+xLRiImLhtg4AkpGNekcv1j3/JXvjJktxKcTp6+4/U3Pm0zLbChmkaeZ7N/lzU3Ow31WVyKycgoIzFdeg/uNDXhKfc17aEriYtZ/LGGntLMFAATpXI9PowDa0anBev4AzMGmpNeKaQrIjKh1GVmMsAPr4Q5RkQQvX0CzF6WTmxIYKjyjCK15Ku/ao0UMEIaAWIqFPX2M9pA9QK4+91z7JfnIgwEIVrDirjXe2RGRW13e4XyRQM/KI9WaO4ia1AJJckje0smG18aoeg5dTCwlY6V761UK9zNvhuPCVHQEdEm6uvpsxUNPQBaIroMJ4ot42lB8Z59GdVD1Z23t0gzdoNeHr2eIWmv4meX1eeuRUkGFit6WB4j/BpRnngd7p+Qw1exTV3dWJdnYgfUgbLirfJDQ6x2cyL/Aex6U5MOrnoT61lVV+E/H5Guk5klT2RHe86TU9qVxvz02XKihj4PAmyI/WXnf0e9Sir97p3lWpK+ca0m/PGdCGNRsPPg/2uRyQZw22jXf4XJEUJEcNSzyA9RgzLTriPQfq0svpxCQKGO0Wtv09L/pkraRlPvtNTyTTbNGlQRoLGicSP0vs6bA+zx2GrIjhO/zj3OgE84THc05uLKlYOQzk"
}
