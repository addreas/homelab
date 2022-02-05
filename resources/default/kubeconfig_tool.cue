package kube

// First time:
// MASTER=nucle1.localdomain
// ssh $MASTER -- kubectl apply -f xps13.yaml
// SECRET=$(ssh $MASTER -- kubectl get sa xps13 -o jsonpath='{.secrets[0].name}')
// CA=$(ssh $MASTER -- kubectl get secret $SECRET -o jsonpath={'.data.ca\.crt'})
// TOKEN=$(ssh $MASTER -- kubectl get secret $SECRET -o jsonpath={'.data.token'} | python -m base64 -d)

// After that:
// SECRET=$(kubectl get sa jonas -o jsonpath='{.secrets[0].name}')
// CA=$(kubectl get secret $SECRET -o jsonpath={'.data.ca\.crt'})
// TOKEN=$(kubectl get secret $SECRET -o jsonpath={'.data.token'} | python -m base64 -d)

// Given the above variables:
// kubectl config set-cluster nucles --server https://nucles.localdomain:6443 --certificate-authority <(echo $CA | python -m base64 -d) --embed-certs
// kubectl config set-credentials nucles --token $TOKEN
// kubectl config set-context nucles --cluster nucles --user nucles

import (
	"tool/exec"
	"tool/cli"
	"encoding/yaml"
	"encoding/base64"
)

command: kubeconfig: task: {
	saName: string @tag(user)
	let saNamespace = k.ServiceAccount[saName].metadata.namespace

	secretName: exec.Run & {
		cmd: ["kubectl", "-n", saNamespace, "get", "sa", saName, "-o", "jsonpath={.secrets[0].name}"]
		stdout: string
	}
	
	secret: exec.Run & {
		cmd: ["kubectl", "-n", saNamespace, "get", "secret", secretName.stdout, "-o", "yaml"]
		stdout: string
		_parsed: yaml.Unmarshal(stdout)
	}
	
	let ca = secret._parsed.data["ca.crt"]
	let token = base64.Decode(null, secret._parsed.data["token"])
	
	output: cli.Print & {
		text: yaml.Marshal({
			apiVersion: "v1"
			kind: "Config"
			clusters: [{
				name: "nucles"
				clusters: {
					"certificate-authority-data": ca
					server: "https://nucles.localdomain:6443"
				}
			}]
			contexts: [{ 
				name: "nucles"
				namespace: "default"
				user: saName
				
			}]
			users: [{ 
				name: saName
				user: "token": "\(token)"
			}]
		})
	}
}