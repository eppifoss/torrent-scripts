#!/bin/bash


TOTAL="$#";
if [  $TOTAL -lt 2 ] ; then
    echo "addserie <SERIES_NAME> <TORRENT>";
    exit
fi;


SERVICE="openvpn"
START_CMD="sudo service openvpn@client start"
if pgrep -x "$SERVICE" >/dev/null
then
    echo "$SERVICE is running"
else
    echo "$SERVICE is not running. \n Starting $SERVICE ..."
    $START_CMD
fi

CMD="transmission-remote --download-dir $TVDIR$1 --add $2 --torrent-done-script /eppifoss/sandbox/torrents/completion.sh";

$CMD
exit
