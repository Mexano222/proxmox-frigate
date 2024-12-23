#!/usr/bin/env bash

source /dev/stdin <<<"$FUNCTIONS_FILE_PATH"
color
verb_ip6
catch_errors
setting_up_container
network_check
update_os

echo "Installing Docker"
bash -c "$(wget -qLO - https://raw.githubusercontent.com/Mexano222/proxmox-frigate/main/install/docker.sh)" || exit
echo "Installed Docker"

echo "Installing Nvidia drivers"
bash -c "$(wget -qLO - https://raw.githubusercontent.com/Mexano222/proxmox-frigate/main/install/nvidia.sh)" || exit
echo "Installed Nvidia drivers"

echo "Installing Frigate container"
bash -c "$(wget -qLO - https://raw.githubusercontent.com/Mexano222/proxmox-frigate/main/install/frigate.sh)" || exit
echo "Installed Frigate container"
