
#!/bin/bash


LOG_FILE='/eppifoss/sandbox/torrents/log'

ACTIVE_TORRENT=0
# use transmission-remote to get torrent list from transmission-remote list
TORRENTLIST=`transmission-remote $SERVER --list | sed -e '1d' -e '$d' | awk '{print $1}' | sed -e 's/[^0-9]*//g'`

echo "Checking for active torrents ..."
# for each torrent in the list
for TORRENTID in $TORRENTLIST
do
    INFO=$(transmission-remote $SERVER --torrent $TORRENTID --info)
    echo -e "Processing #$TORRENTID - $(echo $INFO | sed -e 's/.*Name: \(.*\) Hash.*/\1/')"
    
    # check if torrent download is completed
    DL_COMPLETED=`echo $INFO | grep "Done: 100%"`
    # check torrents current state is
    STATE_STOPPED=`echo $INFO | grep "State: Seeding\|State: Stopped\|State: Finished\|State: Idle"`

    # if the torrent is "Stopped", "Finished", or "Idle after downloading 100%"
    if [ "$DL_COMPLETED" ] && [ "$STATE_STOPPED" ]; then
        echo "Torrent #$TORRENTID is completed. Removing torrent from list."
	echo "$(date)  Removing torrent file ..." >> $LOG_FILE	
        transmission-remote --torrent $TORRENTID --remove
    else
        echo "Torrent #$TORRENTID is not completed. Ignoring."
	ACTIVE_TORRENT=$((ACTIVE_TORRENT + 1))
    fi
done


if [ $ACTIVE_TORRENT -le 0 ] ;
then
    SERVICE="openvpn"
    STOP_CMD="sudo service openvpn@client stop"
    echo "No active torrents found ... "
    if pgrep -x "$SERVICE" >/dev/null
    then
	echo "$SERVICE is running. Stopping $SERVICE ..."
	echo "$(date)  stoping $SERVICE " >> $LOG_FILE
        $STOP_CMD
    else
	echo "$SERVICE is not running. "
    fi
fi
