#!/bin/bash

UUID=$1

echo "📦 FastDL გენერაცია UUID: $UUID"

cd /var/lib/pterodactyl/volumes/$UUID/cstrike || {
    echo "❌ ვერ შედგა cstrike დირექტორიაში გადასვლა"
    exit 1
}

# აქ ჩასვი შენი FastDL გენერაციის ლოგიკა
echo "✅ გადავედით დირექტორიაში, დაწყებული FastDL გენერაცია"
