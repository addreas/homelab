#!/bin/sh

sudo transactional-update shell

cd /etc/systemd/system
curl -sLO https://raw.githubusercontent.com/containernetworking/plugins/master/plugins/ipam/dhcp/systemd/cni-dhcp.socket
curl -sLO https://raw.githubusercontent.com/containernetworking/plugins/master/plugins/ipam/dhcp/systemd/cni-dhcp.service
sed -i 's#/opt/cni/bin#/usr/libexec/cni#' cni-dhcp.service
systemctl enable cni-dhcp.socket
exit

sudo reboot
