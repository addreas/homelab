package kube

_nervesHubWebRevision: "c1dc8c3e8c5c1eb6f6e81a9901285b47aacb15f0"

k: SealedSecret: "s3-credentials": spec: encryptedData: {
	AWS_ACCESS_KEY_ID:     "AgBrc8pkxO+CxgP2NTOiZqSNXZ90sD10dS1U3I1lAiA286R2n972BKh1xfnT6ZDZdsIfLMRlnLZ2VSxiLpQFeNj2ZyZvArpg4qaWqLEM19FbaSUx48JclzzcQG6jWh3UODooy983LbAtvml6S9AZ3rTzdXulK9AHbB0i1cdPdyXvZ0ZkUgRI5jKxVOk/SfSWoZpZw7bUNailKanmZFAby07k55B7gx74OSRdTQQQMr8sTcX5UoXFQdg+I47ha5IHGdYy809H9Nh8QWbRA/zC9PAOZcKlZpW4eNVMVwDLU1WVhw+MjTDBTo4ZsTvIsmsPduvQrH/5WH2uAXJ45f56vEpwSviGAJTziVKZNKHHHsrSs+bJyz4mSCWnpq3FBaRSVVy9bzrzLfeQPbT5WEKFZ7wpVJ/queQdkRxH61ESp25jUp99bUUl6Hvh9XUQxrR1JSYKMjltUJ2+paeNJ4mQ1In02gpLRS1SLoW9PXVAI/FZ49DiCFIqdIINSqieUlveDdrCQbtTxiN+F1cfTZNId2/6aYgEbOx/SWbJsWpB0JG33anfkPjniZCRYMF7kO1pCvHFw9ya6pZZp/vcB8iir9uuh6DFaKbV0uPRq1/R4h5b46T9Mh3jJMsj1mSs1o6sI0+ltJM/fs5gcT3V18TYq/oDNUUokTK6C3SQeBcdKeR9DtAA374Be8qFIQh0wtUrMHOPqgRK6kfXOY3QTmyBKH8s7SDSuA=="
	AWS_SECRET_ACCESS_KEY: "AgAmF0ytXFSuGaysfNB5ayX8qogfMaKIeYDm9AZ9pPVMlROMJivqJOAx8s4dBicv94AqnWCryhRWh8X/Kqy08RGgExZlDVfHiS0f+fELbqxhLvqF49iPUrmSLth6DSdo+/8WpcfaGLyDh69lomGw7PxM+zvQ3/6I+yB8IISBWBgygfRQpIf0tQ3KKdfabRNIx6HYqV67DILqIAjoIUYbkPV8z07b24XBXT9rWSmauT9CbzEADPP2M7kkGuIKixRvso6eXCbNJGmtMNGAhfGr/7K6zvWgoiycPtN+lxJDOK+uz5ZHK5DwJn6RgfkNf2BUNHtu7vdscDWJWwvzqBL09vJqYECrS+K16B8IA8uxZC4jqY1VOPFK7qt6sz4OLvtcQOqBNH8gjbXKtltQfVo3PsimR47dvpLUD37I+MHotnImKELO3ifCkZBSMOaGG2HniPJ7rs/HXYXSxh3DkAd7Y278+CnNQ5GsmkLY/GYiTThrL4EMdd3v7ua5iB4amtIc0WKuF3SZUcVhtDoY+GwGRBT+R02Xms5XGR8Eb+/XgnhCE+tGaJ5cEVbDOf7UbTMt/fCJZgct1FPOAqMGVOtOuolQeFcJ6i/Gikiif4i/CfHdUMhl/H5sJzAGa6bXbUVT0eWJnd/JrXVPlYDjFLRmDL2nGlxHr++yyDXNUlv4Y2sefE147LR3j0xDrLBl0BviMMtRIZRh4a6uwABCPh+ofCkgUNH+Y4Duyc6cwDyMCG+VGS5ZeJLayopR"
}

k: ConfigMap: "s3-config": data: {
	AWS_REGION:         "none"
	S3_SCHEME:          "https"
	S3_PORT:            "443"
	S3_HOST:            "minio.addem.se"
	S3_BUCKET_NAME:     "nh-bucket"
	S3_LOG_BUCKET_NAME: "nh-log-bucket"
}

k: SealedSecret: "email-credentials": spec: encryptedData: {
	SMTP_PASSWORD: "AgBp6PQOoYCGRXJKNMnjv6kSaddc7P0lWLAK6A2lmFVoHQhBSqdg+lRx5p1GDcHiqYMeZVfyN/Xg4Be3l6xJUwhGM9VVtOMlGPHp5DMQ5dCBLZLZNi0Q4SU1jRJ1ha3PtpPeOySoxBMzsRz1QOYEz5eGloqTXLiMXLAt9uInMsUltVW0KG6XnUc1xs4Ux8A6AC7fAeiEHBXkTe//XcycoreY+uCJikn7w4V3FBSEsYAocbdysRbRC8bJ/ARLZXv0gAVU3+ZR+CC+GcId4BHWlNwFZPS9QqB555w83GTdxP1RPEb/DyYMCd+Pf9fRG+qSugMwqCnuLgPgqdOlpJkJkKKG7ecdg/4hVqbHtiUD62AAPSTHjZK6bGEArjK1LsgyhLUXPDLQEkmSs9+qumsXwOVIT03WRZa0NIktFCQGrJToxXFmr2RLReXkPfEOSDTJ46g5OJW2gaoS204x8gtXYHnt5udsZX2K8r+JGzeCmi0fFAGvwsj6wF7LXJmDy8lRBH5BXoIDe8Er90iBFgxlosBha0f2JgrxXUFOokWjSJx4UI3FhGr7dg9jgVuBW/2BhMI3hUPDggR02tRv88YFyHw6jq3gqdSFjXE9SocHZHSajnLVutvVf92ppUIAtH0V+4Hos2crvzTFpGOlQLdn+LXEjDrHYJxjTC/vdpTOkD4/bYdYK99JPDFaI8G27g0/BuJgK/Wd9TC4vxsQj8nIyTIJ"
	SMTP_USERNAME: "AgB51Fv9RwLImG4DIwwGqrQmPWnP8x5kvaX3195yklrbJRzjHWSLEHpvKgQWdPluwFdbuxO//pjJTwjd7kLuY5lbOOAt5nR0mAoFZLbZTB5VXZaJyb0JcsFJkIqQNtl1cAskZPAobfnsndBosGb5DONt38mpFR6MvkQ1em0t0Vc2sIrMufci2nLBFic267SbBhOxNtIa4pOkefguGqLSbRWF4RhMOPlL9iCu7xSX/ZNlJfl29YQZpqZQWwIwIPWbd/splfdW8Z4FY2CbCedhgbB28peNlFZgSGK+mKEZ68chXJWwxfikM1u+Yh+dsJpjurwmdZfF2yXx2ir7DklnYt+aHhQeTeSP/cijmhGnxDri/xMx9GAkmdw22QTyNrIC/ofivbzMzJoj0rESyAH7mxLWbznBwCEJ6PupuaXPJF7HIfHsNIPK/CEWAazfUg6NUgyxY27dyGzuoK2pZDd9sWsB6YfbWjCcF7a18ZDjWryVq5gyK20Yfa75Mp0gnJLIiZqa2tiH8Kaj310MOZE1aH3qjRGYZ969qQiGoy3GH0YhQ2qjkKvX4agOvJ7vHwfIva/uPwrjQGeUmgHmjSSoJjU6rKy+mLN4w0Hp3bEt7vU0JKtERT39O8uFZKQZsaCtasiPINTx8LJ7aotT8ngY5yc9325thatsOpe5hYHHlIs3GqnY7TinbKho87T7dLtCRnMATSKLaniKVNvV5mHIwBG7QRVLslCO2SIp"
}

k: ConfigMap: "email-config": data: {
	SES_PORT:   "587"
	SES_SERVER: "smtp.gmail.com"
	FROM_EMAIL: "nerves-hub@addem.se"
}

k: SealedSecret: "shared-secrets": spec: encryptedData: {
	ERL_COOKIE:             "AgAML4+NWyoOjZQTa8dilnl095AkL+mWHi31TWWuIsPkQAtmtvNaLB3mnridb0QWcd0KsypW+//8JsBvkduTFHiKXxFQHm+U8KNoIyBN0DP0sNKztl9FPR/FTrEFkZE77MD3oS5yz3pX0IRtFbXC3Uda/3YMI7TjnyPlD6cizF8stMXFVk7RzEAbYMX8eztvil33WSAY+PYBMQ2jzYqJl3vHD7/Vy2rtw23hMWjSnqDFs8qqM36T3VRDvePWnIhqHCjXQ3e+PgzMhbrlsePqdPiQhWvXcVve/Hn1lF2/JclQ+hKh+JRDXE0hwPNLAYb3aeEByM5JKayXiQRD1FmdyaR9JVSKjVo68rJQaKCLdWRAHgEePl8hxoK3d70n7IqwqARvJvHatWX983H/rQawTu8kloeX9kMdDLsxhFb5aNsSBIaBs1apCNvSkSTPfi1UxmbcRTHh8csWhg/Zrbsc+UUKPwFqcYqEgAPxhNsQGZeg5eViJZB6uDklUcc6588gss5kzi9ZdlbDooOUjJjvf5UwNZJrZm9cwrbyY7ia9DVCtepRN/DjeupSBx5DmgfPw3jnCYybks0TFHDMaCecmRwPL6p0Oe7u5Ss0onqqf4QEuI9rnDF0vVX+Ns1hUiI/QSqEytRE1Kz3ASHuKfD995wjSzUjFChtiIXPWAegEgXs5hOkG8DHnWUePiRyt3IacO++bGqc8af3m4G52N0r9S0jIEo/e5ZMH4fIkbH+g4gh3g=="
	LIVE_VIEW_SIGNING_SALT: "AgAXozuY1LvtdPVoWZOpPuthkb/Df6eABy/aBB1pCujEd89bJSpjzkQRXfIE8FIZXI0wP8i8ENHfYsq+3zYLieq5M0HZLx3uoKQRJTeNRp6/ym5b/VJh66ws6f+EGoOB3XFHrAenlmml/fjZwigVZX7uoFchY3hPUso1Rwjmz3XQ+/kIwXtJ0WjtKsw9umhiVhUM9GtWSUQmx5I5ixdYlGTBAxS4tkVaQi17CNYj+xsD3ysnT2vrqvZONpM1VlSya17T8bUaa0f50E4NAEWSna8W8/iRGqbMSMD/vmelJk+jcnX85dt+h2oycR1cY1NKPMdPc+txqBFfCjtBgEv3U2GI1DdI1LakNqeroPQY8MaokRNyblvDmk+PK5+E9WR+FIkqXRMR7qYeYESiV0qA9MrfKPaUTiZJZVDNjw4Fm0gH1hXGU9ddYhMRL4dA93y/BHnlRxVrO95gWeEcxYCHcCBOcpcLKE5kJ9mdC6GkKknxsiJyzFkAcv6khm51Vgpp+hNU81hoaeVLXUaGMBZkJsEmj2ITlWFpMYjXW4QiUj6i/99SvZiYAD8aXaC2XZcjQF5eV4w58UnQdtRQ7cZsLbYN/DuLTH4bbKHZv5/xruUakIEpVBbUr0GQ8vnOghkmd2tyEt2l82oVuqI5bQBvwzvEb7G4rapIjCQHCdI9N8VaNx+jZE6WwAC+d9T8ThyrIjDCVpDGAbtuWlTD3qDGrna0FxOG+L2gH3l4uV3BSsIF3A=="
	SECRET_KEY_BASE:        "AgBAerqyhjT/lswLZEoqgDugFaf5+0tUWLBJGcdCmJfhS7W8RI3vMjQSw4wfo2ohc8OP6z+cId3CCwe5UQ2NimYrTXidHJA3B+q/9gbMpCvk3y+DmDdIrz6JUaVShcx61tlhJ1XUDtzefh4RJ0hBhPci23J/WZfv5aGkgWfLz+6JUmb4GHmHa4+ECiUOFWl97+tJKOwmAjVeV+OWrbeorDwsuf6BepZfaH4pdp6sFUd6gC/hxKAeXQgNNKz7gTEH85VlWLRWJaoXSn3AtMRbQvljoGZDH2ags3yc5M1TAG+PydoTIMnM8wnDYvVaRWBYpxEU/sbZjNfs8EftU6NLljiMc+d4At+zX2RUX+o2Qyhen4BtbCcDFRhfFz/FR6SiGb2HqwpsYp6avBbAM+TNAFbPE+QddPv7PMhZdBukLYPT1Wb9PFpRGpD4l9apj3tKJJ8ChYd+4hn0F4THjRIEB6n9C5cJTyFkGaQvRr/KCrT+neb5MP5ZwrpULg4PyJv6acxr5/jqtrdHlRGSNflwLuzUVCAQEqWuvhZ8U/E+A+ofqNxqe9u15+0PDusUVtcckJCLg81mNOlj+JCvmklTZMzST9JKFj7Ilqv5tmTvBBX7frqENX77dxzLTrtXv9OXrz5c4Ha4+zmr8YGGeMshAa0Kt2qdV0eNiqGeF7WrZPzxJzEEIjafl9u7x3IL6aRgSd1fHG1M2nk7gkDXAikU09S2OlQh0Vb9KlZw3GX4THI+QyyGYhZFDjYEk5LWCHiuryK/W1/Z/J5vUjHaxRYXSh8p"
}

k: SealedSecret: "postgres-credentials": spec: encryptedData: {
	POSTGRES_PASSWORD: "AgChSOVShoE8/DLvih7hUeBK+XJlzCCr2KhU7OCgBE7RoX385116fF4Crt/lkBiARl7/9vVeiaKe0VnqKKT04c5MKxc+0GgPTIT6BOBEKqTr4Tb1xzMv4cPZ35snJKjdUdVXzEOZL2zgNfpXdOJLXaWqxAJ7VMZkSxT0691X7oRbfnxkk+l74uzOKCgSDmLnVHliBzujJIQ3UfzkDWjRp8NkrOMBqSUUqH5o4X5/il7OAOyivee4KPMUKONHbvoYzKIJqDUYs53gF7euJoHGsPRtQ1B6+pJJg15HIoZ7GX9wWkaQj6vpTyWFJLn37ZAixyeoSf5/n6ZblgpvuUVM/H4Fti0y3d/QB366iijTBxnAls23ClxBZh5zFg1yFOeXfUCz2J20OFZn+ZTfNZvTIcI5jWoPE/mJPUJgeN+5OG+nUnTVGs4vn2E1techI+1ep8ujBJ+AUO0xxsLnOlSSkVEnNFY5236ohomRSPvh7uacLOCb5DR5PqT44HoWVk5hxyCsWzehuuN5OzXjxG0m6p54RIPXIyXJh2ywIZnB2woW1XNepwUtSC3xvXgkx1TYFSmE+iuh61+85ZeP41HtYQjo8Allj9tW4geJVKIWMCPACOcxRapuBe34oInAtF2qQgTshZJsX/B5q7dOUYB3br4Jz/jkh6BTt4/s9YAr5BChgDo5D/15/NJA3fKS8HLIjHC6msz3KTa5SeDqFN7WyvVLITEHJCi0bPMxq1DBMz915A=="
	POSTGRES_USER:     "AgBn970onhRymv8PcWMuug6zJG00dDPeowawBeSxA3CJ6Bekv+ngPcvGDPcGtHew7d6Nj/fvzAsmPHX2GXoO/3eLhvyv41jwofIMrlr1Blk9sdsmQivnmgUdsjbo9MPdbiX7+6rlvSX2r2tvcFWwNab9skTnr6KwP/knpwPi3hoOKidQAUN8sZD3mzs4VAx0agRJ+gAmkhTFZpdvwu+un3mmHBYlXdjA1iDwrGhYYW88aq7P3uOXFLdvVhfch5EuU7FUdJ1ASKCMzYvjVrnhsakMtC1wFA3zOS+TOWgdowaxEae0WaQ/imPt8wr4EOrUD1SXqaIu94VX9C9Pxx3jwzX+2VM5xqGbdBwMH3+djmeXCLSxc9IkyHD14n+VI8tEdkmYfIdvzW4seBzeohlfvPD4u7zzYi2rr6az6pFtx8xNf2uIN42Go7DcbZngRd4kcsxVVvQrtKK1CLZt9yYLkv+mEx5Fwl+V2ck14q9DNK0i2sK6WWu4v2DwegZDn+0rqcT2kKpmzfTnz6w/RAqPPqPgzBQ/TGhN6qlGid7hEzsfO2B5l631qje06ABi3p0+O8B0WcIDACJnaMly1S30U3pIDDdg1Qwb6yfJio/T2uYoqV2/FXj8ClPYfby5nxI292czmj2qy+ZkT0LpKRpZw210ZvR2FUfmXq450W1YCx+OS8cnY8f/+Qvbuvp0okbd+0NTmCLow5Q="
}

k: ConfigMap: "postgres-config": data: POSTGRES_DB: "nerves"

k: ConfigMap: "shared-config": data: CA_HOST: "nerves-hub-ca.nh.svc.cluster.local"

k: Role: "pod-getter": rules: [{
	apiGroups: [""]
	resources: ["pods"]
	verbs: ["get", "list"]
}]

k: Role: "secret-creator": rules: [{
	apiGroups: [""]
	resources: ["secrets"]
	verbs: ["create", "patch"]
}]

k: RoleBinding: "default-pod-getter": {
	roleRef: {
		apiGroup: "rbac.authorization.k8s.io"
		kind:     "Role"
		name:     "pod-getter"
	}
	subjects: [{
		kind:      "ServiceAccount"
		name:      "default"
		namespace: "nh"
	}]
}

k: RoleBinding: "default-secret-creator": {
	roleRef: {
		apiGroup: "rbac.authorization.k8s.io"
		kind:     "Role"
		name:     "secret-creator"
	}
	subjects: [{
		kind:      "ServiceAccount"
		name:      "default"
		namespace: "nh"
	}]
}
