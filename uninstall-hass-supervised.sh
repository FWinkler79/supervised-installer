#!/bin/bash

systemctl stop hassio-supervisor.service
systemctl stop hassio-apparmor.service
rm /etc/systemd/system/hassio-supervisor.service
rm /etc/systemd/system/hassio-apparmor.service
rm /etc/docker/daemon.json
rm -rf /etc/NetworkManager/system-connections
rm -rf /usr/share/hassio
rm /etc/hassio.json
rm /usr/sbin/hassio-apparmor
rm /usr/bin/ha