#!/bin/sh

kubectl apply -f https://github.com/weaveworks/kured/releases/download/1.6.1/kured-1.6.1-dockerhub.yaml

#Configure Kubic to trigger kured:

sudo transactional-update shell

ln -s /usr/bin/systemctl /bin/systemctl
echo "REBOOT_METHOD=kured" > /etc/transactional-update.conf
exit

sudo systemctl reboot
