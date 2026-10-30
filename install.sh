#!/bin/bash
set -euo pipefail

APP_PATH="${1:-/Applications/Dungeon Keeper Gold™.app}"
RESOURCES="$APP_PATH/Contents/Resources"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
DOSBOX_BIN="/opt/homebrew/bin/dosbox"

if [ ! -d "$RESOURCES/game" ]; then
    echo "Dungeon Keeper installation not found at: $APP_PATH" >&2
    echo "Pass the correct .app path as the first argument." >&2
    exit 1
fi

if [ ! -x "$DOSBOX_BIN" ]; then
    echo "DOSBox Staging is not installed." >&2
    echo "Install it first with: brew install dosbox-staging" >&2
    exit 1
fi

if [ ! -f "$RESOURCES/script_sp.pre-dosbox-staging" ]; then
    cp -p "$RESOURCES/script_sp" "$RESOURCES/script_sp.pre-dosbox-staging"
fi

cp "$SCRIPT_DIR/files/script_sp" "$RESOURCES/script_sp"
cp "$SCRIPT_DIR/files/dosboxDK_staging.conf" "$RESOURCES/game/dosboxDK_staging.conf"
chmod +x "$RESOURCES/script_sp"

echo "Installed successfully."
echo "Open Dungeon Keeper Gold™ and choose Singleplayer."
