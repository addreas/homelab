# longhorn dependency
sudo transactional-update pkg install open-iscsi

sudo transactional-update --continue shell
    # kured setup
    ln -s /usr/bin/systemctl /bin/systemctl # hardcoded path in kured
    echo "REBOOT_METHOD=kured" > /etc/transactional-update.conf

    # dhcp cni
    cd /etc/systemd/system
    curl -sLO https://raw.githubusercontent.com/containernetworking/plugins/master/plugins/ipam/dhcp/systemd/cni-dhcp.socket
    curl -sLO https://raw.githubusercontent.com/containernetworking/plugins/master/plugins/ipam/dhcp/systemd/cni-dhcp.service
    sed -i 's#/opt/cni/bin#/usr/libexec/cni#' cni-dhcp.service
    systemctl enable cni-dhcp.socket

    exit

# activate new next snapshot
sudo systemctl reboot
