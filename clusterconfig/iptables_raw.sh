#!/bin/sh

sudo transactional-update shell

cat <<EOF > /etc/modules-load.d/iptables_raw.conf
iptables_raw
ip6tables_raw
EOF
exit

sudo reboot
