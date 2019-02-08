#!/usr/bin/env bash

set -euo pipefail

LAST_FILE=""

while true
do
	FILE=$(find ~/music/playlist -type f | shuf -n 1)
	if [ "$FILE" == "$LAST_FILE" ]; then
		continue
	fi
	LAST_FILE="$FILE"

	ffmpeg -i "$FILE" -filter:a "volume=0.95" -f s16le -ar 22.05k -ac 1 - | sudo ~/music/pifm/pifm - 103.3
done
