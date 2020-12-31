#!/bin/bash

echo "Backing up config files"
echo "  - /etc/network/interfaces"
echo "  - /etc/docker/daemon.json"
echo "  - /etc/NetworkManager/NetworkManager.conf"
echo "  - /etc/NetworkManager/system-connections/default"

mkdir -p ./backup/etc/network/
mkdir -p ./backup/etc/docker/
mkdir -p ./backup/etc/NetworkManager/
mkdir -p ./backup/etc/NetworkManager/system-connections/

cp /etc/network/interfaces                        ./backup/etc/network/                           2>/dev/null || :
cp /etc/docker/daemon.json                        ./backup/etc/docker/                            2>/dev/null || :
cp /etc/NetworkManager/NetworkManager.conf        ./backup/etc/NetworkManager/                    2>/dev/null || :
cp /etc/NetworkManager/system-connections/default ./backup/etc/NetworkManager/system-connections/ 2>/dev/null || :