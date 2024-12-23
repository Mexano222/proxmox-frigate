#!/usr/bin/env bash

source /dev/stdin <<<"$FUNCTIONS_FILE_PATH"
color
verb_ip6
catch_errors
setting_up_container
network_check
update_os
msg_info
msg_ok

msg_info "Installing Docker"
bash -c "$(wget -qLO - https://raw.githubusercontent.com/Mexano222/proxmox-frigate/main/install/docker.sh)" || exit
msg_ok "Installed Docker"

msg_info "Installing Nvidia drivers"
bash -c "$(wget -qLO - https://raw.githubusercontent.com/Mexano222/proxmox-frigate/main/install/nvidia.sh)" || exit
msg_ok "Installed Nvidia drivers"

msg_info "Installing Frigate container"
bash -c "$(wget -qLO - https://raw.githubusercontent.com/Mexano222/proxmox-frigate/main/install/frigate.sh)" || exit
msg_ok "Installed Frigate container"
