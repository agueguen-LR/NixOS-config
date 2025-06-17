#!/bin/sh
set -euo pipefail

SOURCE_DIR="/boot/loader/entries"
DEST_DIR="/home/adrien/.dotfiles/savedConfigs"

mkdir -p "$DEST_DIR"

for profile in $(ls "$SOURCE_DIR"/nixos-*-generation-*.conf |
  sed -E 's|.*/nixos-(.*)-generation-[0-9]+\.conf|\1|' | sort -u);
do
  latest_file=$(ls "$SOURCE_DIR"/nixos-"$profile"-generation-*.conf |
    sort -V | tail -n 1)
  dest_file="$DEST_DIR/latest-$profile.conf"
  cp "$latest_file" "$dest_file"
done
