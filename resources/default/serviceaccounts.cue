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

for user in ["xps13", "jonas"] {
	k: ServiceAccount: "\(user)": {}
	k: ClusterRoleBinding: "\(user)-cluster-admin": {
		metadata: namespace: string
		roleRef: {
			apiGroup: "rbac.authorization.k8s.io"
			kind:     "ClusterRole"
			name:     "cluster-admin"
		}
		subjects: [{
			kind:      "ServiceAccount"
			name:      user
			namespace: metadata.namespace
		}]

	}
}
