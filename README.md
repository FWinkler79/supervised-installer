# This installation method is for advanced users only

Forked from https://github.com/home-assistant/supervised-installer

Changed `installer.sh` slightly to not mess up my Raspbian installation and still make things work.

## Installation

Pre-Requisites:

1. Clone this repository onto your raspberry pi.
1. Have docker installed on your Raspi as explained [here](https://fwinkler79.github.io/blog/docker-on-raspberry.html).
2. Have jq installed, using
   ```bash
   apt-get update
   apt-get install jq
   ```

Run as root (sudo su):

1. Backup the configs that will be changed: 
   ```bash
   ./backup-configs.sh
   ```

2. Edit your `/etc/NetworkManager/NetworkManager.conf` file.  
   Make sure it exists, otherwise install network manager using 
   ```bash
   apt-get update
   apt-get install network-manager
   ```
   Make sure the file contains (additional to your own configurations) the contents of the following file:
   https://raw.githubusercontent.com/home-assistant/supervised-installer/master/files/NetworkManager.conf

3. If you don't have one yet, create the file `etc/NetworkManager/system-connections/default` and have it contain the contents of the following file: 
   https://raw.githubusercontent.com/home-assistant/supervised-installer/master/files/system-connection-default

4. Edit your `/etc/network/interfaces` file (create it if it does not exist) to contain the following (along your own configs):
   https://raw.githubusercontent.com/home-assistant/supervised-installer/master/files/interfaces

5. Restart the NetworkManager service.
   ❗Beware: doing so from a remote (ssh) session, will terminate the connection. Make sure your Network Manager configurations from above are proper, so that the device gets the same IP as before, for you to re-connect. As an alternative do it on the actual device.❗
   ```bash
   systemctl restart NetworkManager.service
   ```

6. Make sure you are logged in to Docker, otherwise do a `docker login` on the command line!
   
7. Execute the modified installer script.
   ```bash
   sudo ./installer.sh --machine raspberrypi4
   ```

## Uninstalling

In case you decide against this way of running home assistant, you can revert the changes done above.

To do so, simply execute:

```bash
sudo ./uninstall-hass-supervised.sh
```

Afterwards copy all the files in the `backup` folder to their respective locations (using `sudo`) and restart `NetworkManager` and the docker service using:

```bash
   systemctl restart NetworkManager.service
   systemctl restart docker.service
```

❗Note: you might have to kill some of the docker containers that the Home Assistant supervisor has created. Type `docker container ls` to see them. You can then stop them using `docker container stop <container name>`. You can also use `docker container purge` to free any space those containers occupied. Similarly use `docker image purge` to free any space occupied by no longer used images.

### Command line arguments
| argument           | default                                                                                                                                                                             | description                                            |
|--------------------|----------------------|--------------------------------------------------------|
| -m \| --machine    |                      | On a special platform they need set a machine type use |
| -d \| --data-share | $PREFIX/share/hassio | data folder for hass.io installation                   |
| -p \| --prefix     | /usr                 | Binary prefix for hass.io installation                 |
| -s \| --sysconfdir | /etc                 | Configuration directory for hass.io installation       |

you can set these parameters by appending ` --<parameter> <value>` like:

```bash
curl -Lo installer.sh https://raw.githubusercontent.com/home-assistant/supervised-installer/master/installer.sh
bash installer.sh --machine MY_MACHINE
```

## Supported Machine types

- intel-nuc
- odroid-c2
- odroid-n2
- odroid-xu
- qemuarm
- qemuarm-64
- qemux86
- qemux86-64
- raspberrypi
- raspberrypi2
- raspberrypi3
- raspberrypi4
- raspberrypi3-64
- raspberrypi4-64
- tinker

## Troubleshooting

If somethings going wrong, use `journalctl -f` to get your system logs. If you are not familiar with Linux and how you can fix issues, we recommend to use our Home Assistant OS.
