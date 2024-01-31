#! /bin/bash
# shellcheck disable=SC2154
# shellcheck disable=SC2129
# shellcheck disable=SC2086
# shellcheck disable=SC2024

log=/home/ubuntu/init_log
sudo -u ubuntu touch $log
sudo -u ubuntu echo "sudo -u ubuntu whoami: $(whoami)" >> $log 2>&1

sudo apt --yes update >> $log 2>&1

# clone companion repo
sudo -u ubuntu git clone --depth 1 --single-branch https://github.com/David-Lang/cybr-demos.git /home/ubuntu/cybr-demos

# update sshd to allow CyberArk to connect via ssh-rsa
sudo bash -c "echo PubkeyAcceptedAlgorithms +ssh-rsa >> /etc/ssh/sshd_config"
sudo systemctl restart sshd
