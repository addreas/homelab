package kube

k: StatefulSet: registry: spec: {
	template: spec: {
		containers: [{
			name:  "registry"
			image: "registry:2"
			env: [{
				name:  "REGISTRY_AUTH"
				value: "htpasswd"
			}, {
				name:  "REGISTRY_AUTH_HTPASSWD_REALM"
				value: "Nucles Kpack Registry"
			}, {
				name:  "REGISTRY_AUTH_HTPASSWD_PATH"
				value: "/etc/docker/registry/htpasswd"
			}]
			ports: [{
				containerPort: 5000
			}]
			volumeMounts: [{
				name:      "data"
				mountPath: "/var/lib/registry"
			}, {
				name:      "htpasswd"
				mountPath: "/etc/docker/registry/htpasswd"
				subPath:   "htpasswd"
			}]
		}]
		volumes: [{
			name: "htpasswd"
			secret: secretName: "registry-htpasswd"
		}]
	}
	volumeClaimTemplates: [{
		metadata: name: "data"
		spec: {
			accessModes: ["ReadWriteOnce"]
			resources: requests: storage: "10Gi"
		}
	}]
}

k: Service: registry: {
	_selector: app: "registry"
	spec: ports: [{
		name: "http"
		port: 5000
	}]
}

k: Ingress: registry: {}

k: Namespace: kpack: {}

k: SealedSecret: "registry-htpasswd": spec: encryptedData: htpasswd: "AgCm3Tea5suF0TbBaMDPGKeMcaE4A8SFfyT+i18nwNrvGEGz/mWGGKRiJbbOLXvoiImvN7/k1u+5KcsNt4a0RoTawmQpBnalOP9o5XiGqsos8FCCYFZegIU3bc0StKZW0S0QHXBGQVrpbL8xh6XeUh9l7CNspGhnQCiAaBM0luzKdeG9Gel8RvvREOdPgYr4usGPTF/EPeutU1yuGinfF49qFyLV5Pshw6sggid+HKnPajcv+InjW4OgMw/AUT14UT+1jtkxYHYE8W4AZw2Nqhoho2RLFGUUh3iqnUkkyZp8eGoGGzoOi23xofcKC7dmdXygYSsNj+pwh7aRhWicF7Y6n27S8QLXx5ZsQdkZFp+PzDPk7zJo4Fj57iN6hzb/bZl5QqGaqtnyOBpVpJh22diXWE8JEhpzuQfdu1sGGgNgYzO7ZKOXZPY63nHJZmQqWXQpfyOF5ohwaij1jetpN5U7L8vbRocG/u0+v12j4y1yJ9ffa/VEYpuPZptY8nwreHTagK8g5c1r0XvcSlYufYE1cl91gMEmSaOpWZc2RCWGaEcugVt0PxAT+ZOv8hAdWMIFHft/77Vw9Icash+2+T743EBqxjx6QMZYbGEtAi87HmQvy0F+6rzMfgY9Di7phudsNvvgb4Xk68glECJwacEC0HQ1MpN8VTKWoAEdTfKP/0/UY+V2ip8eEPQqDUbWCovSJQVCJ1vHYUl5Qymr732iBTgtyrqHjtPT2fzVpcn8S44YhgOYh1cV9t3Fu5mVF7Lf+f0j0xOrfMkhusq9QK44AjA="

k: SealedSecret: "registry-credentials": spec: {
	template: type:                     "kubernetes.io/dockerconfigjson"
	encryptedData: ".dockerconfigjson": "AgCYEZKWPCkyWMo7+A84cwk6OykNhkIJbVBhmvPtwbDAxxLM1LKmzHRd/8Y0OC/DZnByV3TXhRX+khQAWcwrDc+TI6IwOZ7vQfnRPVfPf4upJ+SVpToYI+FF31l212FM3qjJDAL4h9K/6qnZJmwBuVSF2De/FF5D95ZDT7hNIEG4m2evQhAFPUzxyjNcTB0NzWBVZ8vuSZ9JYXT+4lKr9i5BjkoXDKAfsWPQ0B0+rgLpBoAhnVOSuHJxISbmMPREzor2tADsxuEl/xWdqBGWzldbXl5XSNMqCinBkdKFnuCLC0pWHnPRenKiRLWj8mSzOqpPh8K5GdLBZgAX9Vyt1XgRWXc0k6YaoAZIK5+FVbVoL/VklAc550F1X0xB2ifxrapuavtI7zE6yPQRyDVwT/6Si7+NOImaQAWitla/cLzYTTPYp0kjeIryfbxuRnEOhR1amA0XEKZnkoCCuSejXh2YYIqwh290990ooESxylEPKtQXnQ0GI2T/GkPZqXcWJY0MiDY79iEXo73iwJY+LD90PYJHJL8qvHIcAFpFsGy14uAo0OumleO8bx96sYXbBrWALANbKT4lTY/C6TsD8uDwDySYtlKTJz0FW9EuwbnD5/MjggnG+1oBqMOxTpTMqogryfE7Q7S5oz9pwhS6FS65w4V2XWjYw89KjjKJLoDTVx6JWw2etgPehBHHuS5sPnRJsGligSCJBIa3btA0dYOGZxvwB475QdnzhOYKiUKppqoFkkNIvNqJFCv5Q5C0cT+5ZXLW8OhpSDNbHRDz4TBPMytzoFz0RAjbE2RI2wJdiYOyqBtCjSqscOG39Dg7gfY37l63RUYTGTJqDsSP+amaow6TSexVJUwUZVB7jYjJlB88cmB/SvYcVzFKWsEju3Rlg3g="
}
