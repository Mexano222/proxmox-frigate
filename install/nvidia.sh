#!/usr/bin/env bash

wget https://us.download.nvidia.com/XFree86/Linux-x86_64/565.57.01/NVIDIA-Linux-x86_64-565.57.01.run
chmod +x NVIDIA-Linux-x86_64-565.57.01.run
./NVIDIA-Linux-x86_64-565.57.01.run --no-kernel-module

echo "Cleaning up"
$STD apt-get -y autoremove
$STD apt-get -y autoclean
echo "Cleaned"