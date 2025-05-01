#!/bin/bash

UUID=$1
PTERO_DIR="/var/lib/pterodactyl/volumes/$UUID"
FASTDL_DIR="/var/www/fastdl/$UUID/cstrike"

if [ -z "$UUID" ]; then
  echo "გამოყენება: $0 <server-uuid>"
  exit 1
fi

echo "📦 FastDL გენერაცია UUID: $UUID"

# 1. შექმენი დირექტორია
mkdir -p "$FASTDL_DIR"

# 2. დააკოპირე საჭირო ფაილები
cd "$PTERO_DIR/cstrike" || { echo "❌ ვერ შედგა cstrike დირექტორიაში გადასვლა"; exit 1; }

for folder in models maps sound sprites; do
  if [ -d "$folder" ]; then
    cp -r "$folder" "$FASTDL_DIR/"
  fi
done

# 3. დაამატე sv_downloadurl server.cfg-ში
CFG_FILE="$PTERO_DIR/cstrike/server.cfg"
DL_URL="http://fastdl.forserv.ge/$UUID/cstrike"

if ! grep -q "sv_downloadurl" "$CFG_FILE"; then
  echo "" >> "$CFG_FILE"
  echo "sv_downloadurl \"$DL_URL\"" >> "$CFG_FILE"
  echo "sv_allowdownload 1" >> "$CFG_FILE"
  echo "sv_allowupload 1" >> "$CFG_FILE"
  echo "✅ ჩაწერილია sv_downloadurl: $DL_URL"
else
  echo "⚠️ უკვე არსებობს sv_downloadurl"
fi
