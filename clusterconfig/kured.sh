#!/bin/sh

kubectl apply -f https://github.com/weaveworks/kured/releases/download/1.6.1/kured-1.6.1-dockerhub.yaml

# Configure Kubic to trigger kured:
# echo "REBOOT_METHOD=kured" > /etc/transactional-update.conf

