# UTS Sistem Operasi - Backup Otomatis

## Identitas
- Nama  : Mohammad Daffa Aqilah
- NIM   : 09011282530120
- Kelas : SKU3B

## Deskripsi
Script shell untuk mencadangkan file catatan praktikum.
- `script/backup.sh` : mencari semua file `.txt` (termasuk subdirektori) di `~/data_09011282530120` dengan `find`, mengarsipkan dan mengompresnya dengan `tar -czvf` menjadi `~/backup_09011282530120/backup_09011282530120_TANGGAL_JAM.tar.gz`, menampilkan isi arsip dengan `tar -tzvf`, lalu menambahkan satu baris ke `backup.log`.
- `script/backup_loop.sh` : menjalankan `backup.sh` berulang dengan `while true` dan `sleep` sebesar variabel `INTERVAL` (bawaan 60 detik).
- `script/alias.sh` : mendefinisikan alias `bk120` untuk menjalankan `backup.sh`.

## Cara menjalankan
```
$ cd ~/uts-so-09011282530120
$ ./script/backup.sh                 # backup sekali
$ ./script/backup_loop.sh &          # backup berulang di background
$ kill %1                            # hentikan loop
$ source script/alias.sh             # aktifkan alias (atau salin barisnya ke ~/.bashrc)
$ bk120                              # backup lewat alias
```

## Fitur pengembangan
Rotasi arsip: setelah setiap backup, hanya 5 arsip terbaru yang disimpan, arsip yang lebih lama dihapus otomatis.
Cara mencoba: jalankan `./script/backup.sh` lebih dari 5 kali, lalu `ls ~/backup_09011282530120` hanya menampilkan 5 file `.tar.gz`.

## Data uji
Direktori sumber berisi 10 file `.txt` (6 di direktori utama, 2 di `sub1`, 2 di `sub2`), 2 file ekstensi lain (`data.csv`, `gambar.png`), dan 2 subdirektori.

```
$ ls -R ~/data_09011282530120
/home/arca/data_09011282530120:
catatan1.txt  catatan2.txt  catatan3.txt  catatan4.txt  catatan5.txt  catatan6.txt  data.csv  gambar.png  sub1  sub2

/home/arca/data_09011282530120/sub1:
a1.txt  a2.txt

/home/arca/data_09011282530120/sub2:
b1.txt  b2.txt
```

## Bukti job control
Keluaran terminal asli (direkam dengan perintah `script`). Urutan yang diuji: `./script/backup_loop.sh &`, `jobs -l`, `fg`, `Ctrl+Z`, `bg`, `ps x`, `kill %1`, `jobs -l`.

```
Script started on 2026-10-19 23:04:41+07:00 [TERM="xterm-256color" TTY="/dev/pts/2" COLUMNS="238" LINES="49"]
arca@linux-VirtualBox:~/Desktop$ cd uts-so-09011282530120
arca@linux-VirtualBox:~/Desktop/uts-so-09011282530120$ ./script/backup_loop.sh &
[1] 8933
arca@linux-VirtualBox:~/Desktop/uts-so-09011282530120$ [loop] menjalankan backup pada 23:04:55
sub1/a2.txt
sub1/a1.txt
catatan4.txt
catatan6.txt
catatan5.txt
catatan3.txt
catatan1.txt
sub2/b2.txt
sub2/b1.txt
catatan2.txt
--- Isi arsip backup_09011282530120_20261019_230455.tar.gz ---
-rw-rw-r-- arca/arca         2 2026-10-19 23:03 sub1/a2.txt
-rw-rw-r-- arca/arca         2 2026-10-19 23:03 sub1/a1.txt
-rw-rw-r-- arca/arca        10 2026-10-19 23:03 catatan4.txt
-rw-rw-r-- arca/arca        10 2026-10-19 23:03 catatan6.txt
-rw-rw-r-- arca/arca        10 2026-10-19 23:03 catatan5.txt
-rw-rw-r-- arca/arca        10 2026-10-19 23:03 catatan3.txt
-rw-rw-r-- arca/arca        10 2026-10-19 23:03 catatan1.txt
-rw-rw-r-- arca/arca         2 2026-10-19 23:04 sub2/b2.txt
-rw-rw-r-- arca/arca         2 2026-10-19 23:04 sub2/b1.txt
-rw-rw-r-- arca/arca        10 2026-10-19 23:03 catatan2.txt
^C
arca@linux-VirtualBox:~/Desktop/uts-so-09011282530120$ jobs -l
[1]+  8933 Running                 ./script/backup_loop.sh &
arca@linux-VirtualBox:~/Desktop/uts-so-09011282530120$ fg
./script/backup_loop.sh
^Z
[1]+  Stopped                 ./script/backup_loop.sh
arca@linux-VirtualBox:~/Desktop/uts-so-09011282530120$ bg
[1]+ ./script/backup_loop.sh &
arca@linux-VirtualBox:~/Desktop/uts-so-09011282530120$ ps x | grep backup_loop
   8851 pts/1    S      0:00 /bin/bash ./script/backup_loop.sh
   8933 pts/3    S      0:00 /bin/bash ./script/backup_loop.sh
   8959 pts/3    S+     0:00 grep --color=auto backup_loop
arca@linux-VirtualBox:~/Desktop/uts-so-09011282530120$ kill %1
arca@linux-VirtualBox:~/Desktop/uts-so-09011282530120$ jobs -l
[1]+  8933 Terminated              ./script/backup_loop.sh
arca@linux-VirtualBox:~/Desktop/uts-so-09011282530120$ exit
exit

Script done on 2026-10-19 23:05:42+07:00 [COMMAND_EXIT_CODE="0"]
```

Keterangan bukti:
1. `./script/backup_loop.sh &` menjalankan loop di background (job `[1]`, PID 8933) dan langsung menghasilkan satu arsip, lengkap dengan isi arsip dari `tar -tzvf`.
2. `jobs -l` menampilkan job `[1]` berstatus `Running`.
3. `fg` membawa job ke foreground, `Ctrl+Z` menghentikannya sementara (`Stopped`), `bg` melanjutkannya di background.
4. `ps x | grep backup_loop` menampilkan prosesnya. PID 8851 adalah loop lama dari terminal lain yang lupa dihentikan, sedangkan PID 8933 adalah job `[1]` yang diuji.
5. `kill %1` menghentikan job, dan `jobs -l` kemudian menampilkan `Terminated`.

## Kendala
1. Mendapatkan Permission Denied karena belum memberi izin eksekusi ke file dengan `chmod +x script/*.sh`.
2. Kesulitan menggunakan Nano, jadi saya memakai VSCode agar lebih mudah menulis kode dan README.
3. Kesulitan memahami panduan, jadi saya meminta bantuan AI untuk menjelaskan tugas lebih rinci, lalu saya ketik dan uji sendiri tiap script.
4. `backup.sh` gagal dengan pesan "Direktori sumber  tidak ditemukan." karena variabel `SRC_DIR` ikut terhapus saat mengubah cara membaca NIM. Diatasi dengan menambahkan kembali `SRC_DIR="$HOME/data_$NIM"`.
5. Nama repositori awalnya tidak sesuai ketentuan (`UTS_SO_...`), diganti menjadi `uts-so-09011282530120` lewat Settings di GitHub.
6. README rusak setelah isi `bukti.txt` hasil `script` ditempel mentah, karena memuat kode warna dan kontrol terminal. Diatasi dengan membersihkan kode tersebut dan hanya memakai bagian sesi job control.
7. `.gitignore` tidak berfungsi karena `bukti.txt` sudah terlanjur dilacak Git sebelum `.gitignore` dibuat. Diatasi dengan menghapusnya dari pelacakan (`git rm`), dan sekarang `bukti.txt` disimpan di luar repositori.
