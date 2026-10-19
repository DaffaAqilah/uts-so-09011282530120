#!/bin/bash
# Nama  : Mohammad Daffa Aqilah
# NIM   : 09011282530120
# Kelas : SKU3B
#
# Fungsi: menjalankan backup.sh berulang setiap INTERVAL detik.
# Jalankan di background : ./backup_loop.sh &
# Hentikan               : kill %1   (atau kill PID)

# Jeda antar backup (detik). Nilai bawaan 60, bisa diubah dari luar:
#   INTERVAL=10 ./backup_loop.sh &
INTERVAL="${INTERVAL:-60}"

# Lokasi folder script ini, supaya backup.sh selalu ketemu dari mana pun dijalankan
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

while true; do
    echo "[loop] menjalankan backup pada $(date '+%H:%M:%S')"
    "$SCRIPT_DIR/backup.sh"
    sleep "$INTERVAL"
done
