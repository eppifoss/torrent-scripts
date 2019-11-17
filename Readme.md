# Torrent scripts

Torrent scripts is the use of (transmission daemon) [https://linux.die.net/man/1/transmission-remote] and (openvpn)[https://linux.die.net/man/8/openvpn] to add movies and series torrents while
using vpn. Whenever the torrent is added using the scripts, the program checks if the vpn is running or not, and starts the vpn if it is not running. When all the torrents are finished downloading the vpn service is stoped. 

## Requirements

To make use of the script you need the following packages.
1. transmission
2. openvpn
3. transmission-remote
4. transmission-daemon

## Installation and configuration

### Openvpn configuration

Add the openvpn configuration file to /etc/openvpn/ and name it client.conf so that it auto runs.

### Start openvpn fromm script 
Before you can use the scripts we need to make sure that you have `sudo` previlage on the machine.
The scripts uses sudo command inside. The command used is `sudo service openvpn@client [start | stop]`.
You can add the following line to `/etc/sudoers.d/vpn` file. (Any file in the /etc/sudoers.d directory is fine.)
```
USER  ALL = NOPASSWD: /usr/sbin/service openvpn@client *
```
Above, USER is your username.


### Configure transmission daemon

You can use the provided transmission-daemon configuration file. Alternatively change the transmission-daemon configuration file
and make sure `script-torrent-done-enabled` is true and you specify the path to the completion.sh script. 
```
"script-torrent-done-enabled": true,
"script-torrent-done-filename": "/path/to/completion.sh",
```

## Usage

./addmovie.sh torrent

./addserie.sh series-name torrent

## Files
*config/settings.json
*addmovie.sh
*addserie.sh
*completion.sh