#!/usr/bin/env bash
set -euo pipefail

MUSIC_DIR="${MUSIC_DIR:-$HOME/music}"
PIFM_BIN="${PIFM_BIN:-/opt/pifm/pifm}"
PIFM_FREQ="${PIFM_FREQ:-103.3}"

LAST_FILE=""

echo "Starting $(basename "$0")..."
if [ ! -e "$PIFM_BIN" ]; then
	echo "'$PIFM_BIN' does not exist."
	exit 1
fi
if [ ! -x "$PIFM_BIN" ]; then
	echo "'$PIFM_BIN' is not an executable file."
	echo "Verify it is actually the the pifm binary, and make it executable via 'chmod +x \"$PIFM_BIN\""
	exit 1
fi
echo "Using pifm at '$PIFM_BIN' to broadcast on $PIFM_FREQ MHz."
if [ ! -d "$MUSIC_DIR" ]; then
	echo "'$MUSIC_DIR' is not a directory."
	exit 1
fi
if [ -z "$(ls -A "$MUSIC_DIR")" ]; then
   echo "WARNING: '$MUSIC_DIR' is empty."
fi
echo "Reading music from '$MUSIC_DIR'."

while true
do
	FILE=$(find "$MUSIC_DIR" -type f | shuf -n 1)
	if [ "$FILE" == "$LAST_FILE" ]; then
		continue
	fi
	LAST_FILE="$FILE"

	echo "$(date "+%F %T %Z"): Playing '$(basename "$FILE")'"
	ffmpeg -nostats -hide_banner -loglevel panic -i "$FILE" -filter:a "volume=0.95" -f s16le -ar 22.05k -ac 1 - | sudo "$PIFM_BIN" - "$PIFM_FREQ"
done