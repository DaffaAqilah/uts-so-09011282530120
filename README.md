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

## Bukti job control
TODO: tempel keluaran terminal ASLI Anda di sini (bukan gambar), hasil dari:
`./script/backup_loop.sh &`, `jobs -l`, `fg`, Ctrl+Z, `bg`, `ps x`, `kill`.

```
S
Waktu mulai sesi:
Script started on 2026-10-19 23:04:41+07:00 [TERM="xterm-256color" TTY="/dev/pts/2" COLUMNS="238" LINES="49"]

Script started on 2026-10-19 23:04:41+07:00 [TERM="xterm-256color" TTY="/dev/pts/2" COLUMNS="238" LINES="49"]
arca@linux-VirtualBox:~/Desktop$ cd uts-so-09011282530120

[2] Menjalankan proses backup di background
arca@linux-VirtualBox:~/Desktop/uts-so-09011282530120$ ./script/backup_loop.sh ./script/backup_loop.sh &
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

[3] Memeriksa job yang berjalan
arca@linux-VirtualBox:~/Desktop/uts-so-09011282530120$ jobs -jobs -l

[2] Menjalankan proses backup di background
[1]+  8933 Running                 ./script/backup_loop.sh &
arca@linux-VirtualBox:~/Desktop/uts-so-09011282530120$ fg
./script/backup_loop.sh
^Z
[1]+  Stopped                 ./script/backup_loop.sh
arca@linux-VirtualBox:~/Desktop/uts-so-09011282530120$ bg

[2] Menjalankan proses backup di background
[1]+ ./script/backup_loop.sh &

[6] Memeriksa proses backup
arca@linux-VirtualBox:~/Desktop/uts-so-09011282530120$ ps x | grep backup_loops x | grep backup_loop
   8851 pts/1    S      0:00 /bin/bash ./script/backup_loop.sh
   8933 pts/3    S      0:00 /bin/bash ./script/backup_loop.sh
   8959 pts/3    S+     0:00 grep --color=auto backup_loop

[7] Menghentikan job background
arca@linux-VirtualBox:~/Desktop/uts-so-09011282530120$ kill %kill %1

[3] Memeriksa job yang berjalan
arca@linux-VirtualBox:~/Desktop/uts-so-09011282530120$ jobs -jobs -l
[1]+  8933 Terminated              ./script/backup_loop.sh
arca@linux-VirtualBox:~/Desktop/uts-so-09011282530120$ exit

Waktu akhir sesi:
Script done on 2026-10-19 23:05:42+07:00 [COMMAND_EXIT_CODE="0"]
Script done on 2026-10-19 23:05:42+07:00 [COMMAND_EXIT_CODE="0"]
04l

[8] Menyiapkan data pengujian
arca@linux-VirtualBox:~/Desktop/uts-so-09011282530120$ cd ~/data_090112825301cd ~/data_09011282530120
Perintah pembuatan enam file catatan:
arca@linux-VirtualBox:~/data_09011282530120$ for i in 1 2 3 4 5 6; do echo "catatan $i" > catatan$i.txt; donefor i in 1 2 3 4 5 6; do echo "catatan $i" > catatan$i.txt; done
arca@linux-VirtualBox:~/data_09011282530120$ echo a > sub1/a1.txt; echo a > sub1/a2.techo a > sub1/a1.txt; echo a > sub1/a2.txt
arca@linux-VirtualBox:~/data_09011282530120$ echo b > sub2/b1.txt; echo b > sub2/b2.techo b > sub2/b1.txt; echo b > sub2/b2.txt
arca@linux-VirtualBox:~/data_09011282530120$ echo x > gambar.png; echo y > data.cecho x > gambar.png; echo y > data.csv

[9] Memeriksa struktur direktori
arca@linux-VirtualBox:~/data_09011282530120$ ls -ls -R
.:
catatan1.txt  catatan2.txt  catatan3.txt  catatan4.txt  catatan5.txt  catatan6.txt  data.csv  gambar.png  sub1  sub2
./sub1:
a1.txt  a2.txt
./sub2:
b1.txt  b2.txt
arca@linux-VirtualBox:~/data_09011282530120$ ls -echo x > gambar.png; echo y > data.csv[loop] menjalankan backup pada 23:04:39
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
--- Isi arsip backup_09011282530120_20261019_230439.tar.gz ---
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
[loop] menjalankan backup pada 23:05:39
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
--- Isi arsip backup_09011282530120_20261019_230539.tar.gz ---
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
[loop] menjalankan backup pada 23:06:40
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
--- Isi arsip backup_09011282530120_20261019_230640.tar.gz ---
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
[loop] menjalankan backup pada 23:07:40
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
--- Isi arsip backup_09011282530120_20261019_230740.tar.gz ---
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
[loop] menjalankan backup pada 23:08:40
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
--- Isi arsip backup_09011282530120_20261019_230840.tar.gz ---
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
Arsip lama dihapus: backup_09011282530120_20261019_230439.tar.gz
[loop] menjalankan backup pada 23:09:40
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
--- Isi arsip backup_09011282530120_20261019_230940.tar.gz ---
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
Arsip lama dihapus: backup_09011282530120_20261019_230455.tar.gz
[loop] menjalankan backup pada 23:10:40
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
--- Isi arsip backup_09011282530120_20261019_231040.tar.gz ---
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
Arsip lama dihapus:

```

## Kendala

1. Mendapatkan Permission Denied karna tidak memberikan izin ke file dengan chmod
2. Kesulitan menggunakan Nano jadi saya memakai VSCode agar lebih gampang debugging dan menulis kode + Readme
3. Adanya kesulitan dalam Memahami panduan jadi saya memutuskan untuk meminta bantuan AI untuk Menjelaskan lebih rinci terkait tugas yang diberikan
