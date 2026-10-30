#!/bin/bash
set -euo pipefail

APP_PATH="${1:-/Applications/Dungeon Keeper Gold™.app}"
RESOURCES="$APP_PATH/Contents/Resources"
BACKUP="$RESOURCES/script_sp.pre-dosbox-staging"

if [ ! -f "$BACKUP" ]; then
    echo "Original launcher backup not found: $BACKUP" >&2
    exit 1
fi

cp -p "$BACKUP" "$RESOURCES/script_sp"
echo "Original GOG single-player launcher restored."
echo "The harmless game/dosboxDK_staging.conf file may remain in place."
