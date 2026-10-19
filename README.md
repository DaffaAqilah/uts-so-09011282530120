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
(tempel di sini)
```

## Kendala
TODO: tulis error yang benar-benar Anda temui beserta solusinya, misalnya:
- Contoh: `Permission denied` saat menjalankan script -> diatasi dengan `chmod +x script/*.sh`.
