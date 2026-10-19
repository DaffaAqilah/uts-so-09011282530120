#!/bin/bash
# Nama  : Mohammad Daffa Aqilah
# NIM   : 09011282530120
# Kelas : SKU3B
#
# Fungsi: mencari semua file .txt di direktori sumber, mengarsipkan dan
#         mengompresinya menjadi satu file .tar.gz, lalu mencatatnya ke log.

# ===== BAGIAN 1: variabel dan direktori tujuan =====
NIM=$(cat "$(dirname "$0")/../nim.txt")   # baca NIM dari nim.txt di folder repo
SRC_DIR="$HOME/data_$NIM"            # direktori sumber (tempat file .txt)
BACKUP_DIR="$HOME/backup_$NIM"       # direktori tujuan backup
LOG_FILE="$BACKUP_DIR/backup.log"    # file log
LIST_FILE="$BACKUP_DIR/daftar_file.txt"  # daftar hasil find
MAX_ARSIP=5                          # fitur pengembangan: simpan 5 arsip terbaru

# Buat direktori tujuan jika belum ada (-p: tidak error bila sudah ada)
mkdir -p "$BACKUP_DIR"

# Pastikan direktori sumber ada, kalau tidak ada hentikan script
if [ ! -d "$SRC_DIR" ]; then
    echo "Direktori sumber $SRC_DIR tidak ditemukan." >&2
    exit 1
fi

# ===== BAGIAN 2: pencarian file dengan find =====
# -type f : hanya file, -name "*.txt" : berakhiran .txt (termasuk subdirektori)
# -printf '%P\n' : cetak path relatif terhadap SRC_DIR, satu per baris
find "$SRC_DIR" -type f -name "*.txt" -printf '%P\n' > "$LIST_FILE"
JUMLAH=$(wc -l < "$LIST_FILE")       # hitung jumlah file yang ditemukan

if [ "$JUMLAH" -eq 0 ]; then
    echo "Tidak ada file .txt di $SRC_DIR." >&2
    exit 1
fi

# ===== BAGIAN 3: arsip, kompresi, dan verifikasi =====
WAKTU=$(date +%Y%m%d_%H%M%S)
NAMA_ARSIP="backup_${NIM}_${WAKTU}.tar.gz"
ARSIP="$BACKUP_DIR/$NAMA_ARSIP"

# -C pindah ke SRC_DIR dulu, -T baca daftar file dari LIST_FILE
tar -czvf "$ARSIP" -C "$SRC_DIR" -T "$LIST_FILE"

echo "--- Isi arsip $NAMA_ARSIP ---"
tar -tzvf "$ARSIP"                   # tampilkan isi arsip tanpa mengekstrak

# ===== BAGIAN 4: catat ke log =====
UKURAN=$(du -h "$ARSIP" | cut -f1)   # ukuran arsip yang mudah dibaca (mis. 4.0K)
TANGGAL=$(date "+%Y-%m-%d %H:%M:%S")
echo "$TANGGAL | $NAMA_ARSIP | $JUMLAH | $UKURAN" >> "$LOG_FILE"   # >> menambah, tidak menimpa

# ===== BAGIAN 5: rotasi arsip (hanya simpan MAX_ARSIP terbaru) =====
# Nama arsip memuat tanggal-jam, jadi urutan abjad = urutan waktu.
# head -n -5 : ambil semua baris KECUALI 5 terakhir (= arsip yang lebih lama)
ls -1 "$BACKUP_DIR"/backup_"$NIM"_*.tar.gz | head -n -"$MAX_ARSIP" | while read -r LAMA; do
    rm -f "$LAMA"
    echo "Arsip lama dihapus: $(basename "$LAMA")"
done
