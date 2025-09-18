#!/bin/bash
LOG_FILE="/var/log/nm-dispatcher-captivepass.log"

log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOG_FILE"
}

if [ "$#" -ne 2 ]; then
    log_message "Error: Script called with incorrect number of arguments. Expected 2, got $#"
    exit 1
fi

INTERFACE="$1"
ACTION="$2"

case "$ACTION" in
    "connectivity-change")
        log_message "$INTERFACE, $ACTION: Connection changed"
	if [ "$CONNECTIVITY_STATE" != "NONE" ]; then
		exec /home/kapil/scripts/ioe_captivepass.py
	fi
        ;;
esac

exit 0
