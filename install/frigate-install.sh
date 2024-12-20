#!/usr/bin/env bash

msg_info "Installing Docker"
bash -c "$(wget -qLO - https://raw.githubusercontent.com/community-scripts/ProxmoxVE/main/install/docker.sh)" || exit
msg_ok "Installed Docker"

msg_info "Installing Nvidia drivers"
bash -c "$(wget -qLO - https://raw.githubusercontent.com/community-scripts/ProxmoxVE/main/install/nvidia.sh)" || exit
msg_ok "Installed Nvidia drivers"

msg_info "Installing Frigate container"
bash -c "$(wget -qLO - https://raw.githubusercontent.com/community-scripts/ProxmoxVE/main/install/frigate.sh)" || exit
msg_ok "Installed Frigate container"
