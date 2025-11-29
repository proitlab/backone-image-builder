#!/bin/sh

# ================================
#  Auto Update /etc/config/rtty
#  Safe re-run, auto replace
# ================================

# --- EDIT THESE (UPDATED AS REQUESTED) ---
ZTINF="$(ifconfig | grep zt | awk '{print $1}')"
MYSERIALNUMBER="$(/usr/bin/get_serialnumber)"
HOSTNAME="$(uci get system.@system[0].hostname)"
ZTIPADDR="$(ip -j addr show ${ZTINF} | jsonfilter -q -e '@[0]["addr_info"][0]["local"]')"
MODEL="$(ubus call system board | jsonfilter -e '@.model')"

HOST="rtty.manage.backone.cloud"
PORT="5912"
TOKEN="dafc4fe50a0bc91555e689b19eae39ee"
DESCRIPTION="${HOSTNAME}/${ZTIPADDR}/${MODEL}"

# --- START ---
echo "Mengecek konfigurasi RTTY..."

# cek apakah section rtty sudah ada
EXIST=$(uci show rtty 2>/dev/null | grep "=rtty" | wc -l)

if [ "$EXIST" -eq 0 ]; then
    echo "Belum ada konfigurasi rtty, membuat baru..."
    uci add rtty rtty > /dev/null
fi

# ambil konfigurasi saat ini
CURR_ID=$(uci get rtty.@rtty[0].id 2>/dev/null)
CURR_HOST=$(uci get rtty.@rtty[0].host 2>/dev/null)
CURR_PORT=$(uci get rtty.@rtty[0].port 2>/dev/null)
CURR_TOKEN=$(uci get rtty.@rtty[0].token 2>/dev/null)
CURR_DESC=$(uci get rtty.@rtty[0].description 2>/dev/null)

# jika sudah sama → selesai
if [ "$CURR_ID" = "$MYSERIALNUMBER" ] &&
   [ "$CURR_HOST" = "$HOST" ] &&
   [ "$CURR_PORT" = "$PORT" ] &&
   [ "$CURR_TOKEN" = "$TOKEN" ] &&
   [ "$CURR_DESC" = "$DESCRIPTION" ]; then

    echo "Konfigurasi sudah sesuai, tidak perlu update."
    exit 0
fi

# jika berbeda → replace
echo "Mengupdate konfigurasi RTTY ..."

uci set rtty.@rtty[0].id="$MYSERIALNUMBER"
uci set rtty.@rtty[0].host="$HOST"
uci set rtty.@rtty[0].port="$PORT"
uci set rtty.@rtty[0].token="$TOKEN"
uci set rtty.@rtty[0].description="$DESCRIPTION"
uci commit rtty

echo " Restart service RTTY..."
/etc/init.d/rtty restart

echo "Selesai! Konfigurasi diperbarui."
