#!/usr/bin/env bash

set -euo pipefail

LAST_FILE=""

while true
do
	FILE=$(find playlist/mp3 -type f | shuf -n 1)
	if [ "$FILE" == "$LAST_FILE" ]; then
		continue
	fi
	LAST_FILE="$FILE"

	ffmpeg -i "$FILE" -f s16le -ar 22.05k -ac 1 - | sudo ./pifm/pifm - 103.3
done
