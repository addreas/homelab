# longhorn dependency
sudo transactional-update pkg install open-iscsi

# kube-vip ipvs debug util
sudo transactional-update --continue pkg install ipvsadm

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

cat etc/sysctl.d/10-inotify.conf > /etc/sysctl.d/10-inotify.conf
sed -i /targetpw/d /etc/sudoers
cat etc/sudoers/wheel > /etc/sudoers.d/wheel

cue export --out yaml etc/kubernetes/manifests/kube-vip.cue > /etc/kubernetes/manifests/kube-vip.yaml

groupadd -r wheel
useradd -m -U -G wheel addem

# activate new next snapshot
sudo systemctl reboot
