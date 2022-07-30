package kube

import (
	"encoding/json"
	"encoding/yaml"
)

k: SealedSecret: kratos: spec: encryptedData: {
	COURIER_SMTP_CONNECTION_URI: "AgDdTEDSe1yS3n/gdQtylkYL/i79oUlA3hWxhmKP6s4eLJWvZdzqI1XyRGO6aecpT5F1hNaMtZgcVOxtCYPAiqTNVbxHRRUuWSJ1zlf+qXoTRe8wYcLegDYZX9SR+sqr9QYq14gMr5WqiCwGNtrAcgs+53uP7mLbBGIoHoDPnAUPdv8cqozqiHnb6L2ikNeO8H2YgXyli9fpI7EfdbiCaeABzURYeDx27He2IAzqDeSoHJROwRxv8c9LubvDG8AZt48hjQNOAQHH/x2P8DnYAIFgPXg4j+VnhVA5Dik9zeOxTmwCJ5yo/5Z3WjHrXev6QKGoQuvLMgsG/A3mxEqk6U60cTnSY9uvly5emk8416IbhFpB+wT7gnS89iqv7YjcL1Ct7XXRzjNBOy5TramO/Oa0gwrh99fNfDbi5SCxc3OJl+mUf/FeAeJ8FhCcJQQI/rertuLoRz0PE8Iio8EJ2GsCJgAZQC0rrezZE0o8Y9wV9lvDy/y8JMzvhjGtTUS0cprFLSMcYspTt9vinQ1T0JTOt7Ngov9208dz9IGtK7e0UtoS1cZRO56pXLGAdCT0fN3Q8yHldn2STf2QyvYOCpzWr6mbh1I+vsyLyUPrIwo9Mg0ivMELc2jEYrPn+H8hrwEJsO+GdJX3ehlHf8mvIBVEU0dbffSvKmMmWkDvQ5VjJpuBjd2knstzQiVlZRwIR3nn/Ji8R+c1JMhadC4KBg5PZ7D/kddLvYFJSoLAa40st1J/l0t+1XOLe7EemNQAJD9sA3Mjy28crOTgcSUKBre2b2JYu9s="
	DSN:                         "AgCk1baQhlj218wyoHPzu2AWl0qqGaZHHlyiB8cp9Egle7+YrgEypEyiGt9IT+f/uGd9r6Mu7l6tSp2xKotTuS0zsCxvjjm7SWksfFF45Sk9o3uUPgnrqIsZ3RZqJ4vfLPFDBNecBZtRBZKXR0P/YRJVc8B2qjWQJCOehJFBEdGMG8pPCSb9sDERPd0vNNHDVF1BGH/3UpWX+14hSoq21NUanF4A7zubyE9yaMeal8tS3iVJxczjyE3DaE6DQp2kD6Dlw/yZbEtr5Xr1OzE6d8j3KAhyX9/iItY118wngj1eTVUJRmNl9o8YJYjOE6IYR++Ok2Jhm548KlEcXPV33QfezI8g8Zr6HwXKNVNNvEbPWzFY2IGHGeyWjuXhGbogePgKoJkRkTKq4k8IGXn2/WQYViWC7oEvmzbtTLPhj7j/mNAkBlt2jboCMr+8X1uY8uHcU79B8dwzVnvjMRjvIUcvUAhuwg3L7OgVtIUVRc5lJxBAN0+3GkfSKtvqTEO5jD3qJ4il3Nq2uWPP9RyMOFBNGZ/gUB4m56zw176rJ9stATPNh2pg1UBJsQhP26Wm5mx35JuiF1kOtzbovZaxDQ3h4C2jyjQ7LTGZt9rgiA6oW3miG13PUoQWy7NvsUBjTDpxrwYvXkHexowx2EgfrbS3P8Di8PvXyxm27CZ7ynVSu0eqJtlJs91zHKabjF5BelkFi9+7oPZYFlRNRXGM0riIfmDn6/CIPoOtHMoSD1Kcz+tPVTt9Q++Bxe57vEw="
	SECRETS_CIPHER:              "AgDGuujIqwKss3bVy1vv4lVzav2Se/E3coJAbk60Rl+L64zE2wz1DVszQORb+RMuwbbtY7JLLAhitAk8S0yTVLOh+y2yRi4eSA+gADnDxbWtSjB3GaPhNzscqd2DBr95xFMHRwv3uvYcNtP8zPBr7I6drU/xs39g3W4TADLCOPVKTGKCArj15b/tNnbYCi7I4kCvSM+oENapDadPXXjodLOdyX9XJ88x76Bql4cKZ3wqFJIhwfV7Ta6bY1SJgO79MbAyWVH0y21f9qhU6/id0nVw9rWmic2bY8YxN0R3Tmtm9k0pvsJQ505EHQ6G53vLaU3XviW/E0kVS50EXWUbcgqwOPLvIqMpj19orcvKoc/b/FBb7CJxLzn/se7BEL+eCnHKuu1js61+J/KBIsdg99QdE6gI/U2ytqrjvGybUo0H9P2yFUdIU8J/j5RJQWRJmSEQ8DsTfYEZ3T37fgP18o4eYwwbUGg0iDm0bfOgJN5CLKO4RH18RAFo7Zu9dSaGIg6Fpbf5/xs3vwLkltSvW4pR1AiXGM6sp+ZqYwYvu//yFLgD3UCpoBHn3yRhshhbL+Tqftsveqj0WI5jFOuls5dpVPHml0TT8l4OCOC4onytRnWJVQlOmaDUgaf3Xz7w8qCrz1bljmULYSMX1z89Dpu+Etz3rb6rmxAeOZCntGmYsgbzY6Ms/rXpkTKThAu2q8SX+vxV3PRHJ/YK3L27HmTwKOVPdwE3lAH5z1XiDZ5imQ=="
	SECRETS_COOKIE:              "AgC33cS7nFOadP6AVLTe1+5FPD8oJX9v+NssSrL716bo+CiqVrXiDlWJoUzQw2suViW6Uapi/CBKDRSaJ4J2nFzq2oXtRjIFjfxOKyWj5OPnIF01ZDskr5Xi8JCV/znsUdkxRCubdz2Ueq4ZZO3J6MqacpxK7G7acn5E0OnO/oUQBJd06eetv+NxyBpmyugO/sNg14CTAlLRWFwV/zNRvRv0Bl1Mo83MiakUVzeerfayOyqTdTOntbTfynMy+SOLdZNwbWqyLcYwywmNkyoN/4yKcX7IRuxSdNn4mDLBx9OL3zRpkkVPY0QXb3f9mod924HAGq1+pswY0IN4mADAMD5nKzsXPYjJg7qYbvlNTTb+uCPlIGKWkLljFPnTTTF7Tr2pOn1IcigjTVc0fcK3a5KUUWHW2S44vmGgOIVS96h+UBn3eXkN4TDWFIApIBdhpPftdF0L0934V2ybAHVpYR8s+Lg5GGeaphBYyzh7TS/ddmNeSDpVtNzKDDhqNvrcptjmMN5Te5K9vMDQ25YuTCIKPOmqcS5WFK3w4TCUJl6T33riYGPO6jgfd8oh6Y41KaTI+Tft+0E6vu+glh+Cv173jstUGZ4/yNlykK+nsYnDMk6d5OMe4t43Pa5VQxgdgJnpqH9Jj+1hPqQbonF+sok62TJpD/ZmF4c47rbcDKwEW2Z/JlVde8jY3CbZzfuvw8KGyImLWgF3/zVAbMqgJRXHFXvkMQNMYaZp9dTekkpiqp/AVA=="
}

k: ConfigMap: "kratos-config": data: {
	"kratos.yaml":        yaml.Marshal(_kratos_config)
	"person.schema.json": json.Marshal(_person_schema)
}

k: Deployment: kratos: spec: template: spec: {
	containers: [_probes & {
		image: "oryd/kratos:\(githubReleases["ory/hydra"])"
		command: ["kratos"]
		args: [
			"serve",
			"all",
			"--config",
			"/etc/config/kratos.yaml",
		]
		ports: [{
			name:          "http-admin"
			containerPort: 4434
		}, {
			name:          "http-public"
			containerPort: 4433
		}]
		envFrom: [{secretRef: name: "kratos"}]
		volumeMounts: [{
			name:      "kratos-config-volume"
			mountPath: "/etc/config"
			readOnly:  true
		}]
	}]
	volumes: [{
		name: "kratos-config-volume"
		configMap: name: "kratos-config"
	}]
}

k: Service: "kratos-admin": spec: {
	selector: app: "kratos"
	ports: [{
		port:       80
		targetPort: "http-admin"
		name:       "http"
	}]
}

k: Service: "kratos-public": spec: {
	selector: app: "kratos"
	ports: [{
		port:       80
		targetPort: "http-public"
		name:       "http"
	}]
}

k: Job: "kratos-migrate": spec: template: spec: {
	containers: [{
		name:  "migrate"
		image: "oryd/kratos:\(githubReleases["ory/hydra"])"
		command: ["kratos"]
		args: [
			"migrate",
			"sql",
			"-e",
			"-y",
		]
		envFrom: [{secretRef: name: "kratos"}]
	}]
}
