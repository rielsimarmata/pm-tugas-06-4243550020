# Wisata Sumatera Utara

Aplikasi Flutter multi-layar untuk menjelajahi destinasi wisata di Sumatera Utara. Tampilan menggunakan Material 3, foto dari aset lokal dengan ikon sebagai cadangan, dan navigasi dua bagian: Destinasi serta Tentang.

## Identitas

- Nama: Jhon Gabriel Simarmata
- NIM: 4243550020
- Kelas: PSIK 24C

## Tangkapan layar

Ganti placeholder berikut dengan gambar hasil aplikasi:

1. Daftar destinasi di ponsel: `![Daftar destinasi - ponsel](screenshots/daftar-ponsel.png)`
2. Detail destinasi di ponsel: `![Detail destinasi - ponsel](screenshots/detail-ponsel.png)`
3. Daftar destinasi di tablet: `![Daftar destinasi - tablet](screenshots/daftar-tablet.png)`
4. Detail destinasi di tablet: `![Detail destinasi - tablet](screenshots/detail-tablet.png)`

## Keputusan desain responsif

Tampilan daftar memakai `LayoutBuilder` untuk menentukan jumlah kolom berdasarkan lebar ruang yang benar-benar tersedia. Pada lebar di bawah 600 dp, kartu disusun dalam dua kolom agar tetap nyaman disentuh pada ponsel. Lebar 600 sampai kurang dari 900 dp menggunakan tiga kolom, sementara ruang 900 dp atau lebih memakai empat kolom. Halaman detail memiliki keputusan lokal pada 700 dp: di bawah batas itu visual dan informasi tersusun vertikal agar alur baca tetap alami; mulai 700 dp keduanya ditampilkan berdampingan, dengan informasi yang dapat digulir sendiri. Kerangka aplikasi menggunakan `MediaQuery.sizeOf(context)` untuk keputusan tingkat aplikasi pada 840 dp. Di bawahnya navigasi berada di bagian bawah, sesuai pola ponsel dan tablet sempit. Mulai 840 dp, navigasi berpindah ke rail di sisi layar sehingga area konten utama tetap luas. `LayoutBuilder` cocok untuk grid dan detail karena komponennya perlu merespons batas lokal, termasuk saat berada di dalam panel. `MediaQuery` dipakai pada kerangka karena pemilihan navigasi mengikuti ukuran keseluruhan jendela. Teks nama dan lokasi dibatasi baris serta memakai ellipsis, sedangkan deskripsi panjang dapat digulir agar tidak meluap.

## Pernyataan penggunaan AI

AI digunakan sebagai alat bantu untuk menyusun struktur widget, data contoh destinasi, dokumentasi, dan pengujian. Kode dan hasilnya ditinjau serta diverifikasi kembali dengan `flutter analyze` dan `flutter test`.

## Menjalankan aplikasi

```sh
flutter pub get
flutter run
```

