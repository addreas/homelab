package kube

k: ConfigMap: bitwarden: data: {
	SMTP_HOST:          "smtp.gmail.com"
	SMTP_FROM:          "nucles+bitwarden@addem.se"
	SMTP_PORT:          "587"
	SMTP_SECURITY:      "starttls"
	WEBSOCKET_ENABLED:  "true"
	DATA_FOLDER:        "/data"
	DOMAIN:             "https://bitwarden.addem.se"
	ROCKET_WORKERS:     "2"
	SHOW_PASSWORD_HINT: "false"
	WEB_VAULT_ENABLED:  "true"
	ROCKET_PORT:        "8080"
}

k: SealedSecret: "bitwarden-smtp": spec: encryptedData: {
	emailPassword: "AgCN8F92MOsugTj4XoDnL6a71WjMeQtgwg0bxlHArSbkpO8ijyZNhSIrcLq0QOBO11wxX8iqkel1l3ReMLI9FRxXsz8OqC4A7jtDFzpOP5RyefrTcakZc+SoUYhhFs3asdIOSfs3MEBmL3CSXG8GZeFoOdCg1yVVccdcp0PLT5BBrSo9ehXjnF76THctP5BTaP26hhmPKD4/UTQUBGh8sNmEB8fWwQd7J7R6qiigfX6aajmsAsq58IPsKRNam0g1GzSQItrrVBzHW4d1ChCuwXk5zApJCljIcLehyelH7SVQvD3l5u27tzGfuOhClzPMbx5F7mXRZecU6LM3YlewMVhQUUOFcgs6U/NMEMuhvGJJLj6BoZgIpTazTeWUto5djsmyE/1PcEE7q0bP3zKF4kECFWg8cV0uXozYBbz+17vi3WYEwwwLUV7nUXnrfRJyadXkZP0w8255NlDEKeflwhaSU1oeNeUlEHEo0AyC8qcEizI/lS64xK/Vxazo+WIuBDZ8zw3xc14LLAIVRn3avemivWnAQrDNg/YsVrcTQ+imIwz5cN3xuEizpI0Js7aI7bQ/xDhxlubeuFaA/I5DlMMnKvP6puHELFcx071QPaIg7piDf6xKG7bbSLUs8bzec4u9G1vgW2hJVC9TiK/3s4Qac6ahZnV133w1YWffi2iyxMyviAsjQiNMhVS4r0oSXsB104r87LtVRCApYeZVusCL"
	emailUser:     "AgAajuxEB+Oa34xyN2TS51z705B/vXQHM/zHGue9NGOUdw7yMbWTCadaAIATmLiVnIP/UdWSUD+tOfsys9/u3aI2/q6zcp4tobKbxaPT9E8Yatb61akd4R1rbxOrpHD4arsjpzYr6Kg4xc6Luf6248phb5JXnTa7JkJvcb8Tz5gKxiVvWaFhbDJ63NyKvhAh8rAWrJAk6P4ZqANtLoSLImYZckopq5pKKz1B2bf3ToDiT37siXEuEeYzsfHDQb3kDRsejDwy5qLgozLyVj/ROE3sC1YW6o+ms49dYCDqY4Zm/WbN8UWe4UF6L1OWFe5/a+kNGLvCKtvh8vX8o5TtUFpDKUnORu08GxTGAho9np6UAGylhkr8k0OaZHG+3u6L6HTwEQtrfi9ItbGlpAevTj9Nt8i1bIb6uKccehRGCz0sOiy0NMHYqYosKELei23yRa1z6+TPS+4zUS5KtAlF7to+dwLdSf3eZWVsVzo0f+dOt66RpZ3e0RXd9lKg8QCwqR9JhbW6uU6mGng7zVMGbrwqNn3JG9oqFT5dZSsXCxGigSghabG+nz96OkB6WynIdHWuZil8OirmC98E0S3XVcfnzwyIRfYk+x5MYysG8IBBRZgA9uiM7GV2b9CqFXtyOi7+IQT4WC07fKJrZrBE4vg2695AKgZRcfoBJxGMm/28q809hgyTvk525NTSSkzbmFEksvAjjRxjC4tXBInC9+8POnRwkYYg96x+"
}
