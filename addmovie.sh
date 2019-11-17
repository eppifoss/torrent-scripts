#!/bin/bash

TOTAL="$#";
if [  $TOTAL -lt 1 ] ; then
    echo "addmovie <TORRENT>";
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


CMD="transmission-remote --download-dir $MOVIE_DIR --add $1 --torrent-done-script /eppifoss/sandbox/torrents/completion.sh";

$CMD ;


