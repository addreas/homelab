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
			storageClassName: "standard"
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
	template: type: "kubernetes.io/dockerconfigjson"
	encryptedData: ".dockerconfigjson": "AgA6KakMxJmUeNEAhlLMsXPdPoMIv85x+SLfQxTQXUIpHWNNFor57CSO3UrpXAX2IYlnjKyPNEJUqueczKXN6xsOXqwbfP03ubA1W02b3r/y26naIgUBoljiNnsGErWdRZ4UDLnz2FRKqPzF6GCdW+aUKW/BbLeVu7dGuvlk+g9xtQklw9B6tgciGAht3TYWZYPlStUhf0KPbQflWzwxNmwyWQKYJ/PJsVIsMJruN4O7lW3+BRHZmkWJdaTeTd9wp+H9EKKHFUIemLKQ1wqRPLTTk+PAO4MiIus8qK8+27VwTRF1J5lPpq71uDNw1xTJSWlBw388FThINkbYyiTcK1iTnSkYvsFZfqK4LkuhL38TV8+bR13Gpdcu3MSEPT7EGxr7DRzve0ZV1TAU9ZpMci3FOxwQ30WY5BWB/jEvAOQu204jcm6k4oDPy86DGyKOJ3bTjPw1S3yvYfSLir2+PWK/Kk18wDa0P/AVlqqG19tBbgoIzu8+bt9PGxG/ow27aaLcieLiEQSz4pCbG0psb6J2miQhgUB5VcJizfqxNlHmBL6pN6txbQUQB/29M4I50doERiA9bB24QGfk3E7wCkFtETdQxx7Prhd0hTr76k3Zs7A08lNiMwk+sAWJu/5yqu/I/I2LPtY6tUb/45ey9cdhNmoXubpNV91pVP46vMU5mOGyJeVM2MnWDuYTkan263uLRqQQd5o9ZWCOgfdamCKpIpnjte+gctbXAUwpEh7u1JFw3K6oxIOz/0iAWJ8gkdPuo3SaaXzaxng6XDUYMBywYYC20DHpNOq0OHZVMWBwndHoaYn6b0CQkqKsNhwb3efBZxRcqXnAQwOn5NGbdRyxYCDqqZh1Th0ONF8+JxlIgEilj97pgCIH2x4tJ3T2YEMtn9LSKxAUq/bJTX8L48WReMP9FAVmJGzau9d/HZx54BTnezoef5k013ZOvs6yANHaw0Ab"
}
