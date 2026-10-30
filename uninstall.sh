#!/bin/bash
set -euo pipefail

APP_PATH="${1:-/Applications/Dungeon Keeper Gold™.app}"
RESOURCES="$APP_PATH/Contents/Resources"
restored=0
for launcher in script_sp script_s script_c; do
    backup="$RESOURCES/$launcher.pre-dosbox-staging"
    if [ -f "$backup" ]; then
        cp -p "$backup" "$RESOURCES/$launcher"
        restored=$((restored + 1))
    fi
done

if [ "$restored" -eq 0 ]; then
    echo "No original launcher backups were found in: $RESOURCES" >&2
    exit 1
fi

echo "Restored $restored original GOG launcher(s)."
echo "The harmless game/dosboxDK_staging.conf file may remain in place."
