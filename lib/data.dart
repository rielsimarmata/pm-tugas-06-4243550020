import 'package:material_ui/material_ui.dart';

/// Model ringkas untuk informasi satu destinasi wisata.
class Destinasi {
  const Destinasi({
    required this.id,
    required this.nama,
    required this.kabupatenKota,
    required this.kategori,
    required this.deskripsi,
    required this.hargaTiket,
    required this.ikon,
    required this.warna,
  });

  final int id;
  final String nama;
  final String kabupatenKota;
  final String kategori;
  final String deskripsi;
  final int? hargaTiket;
  final IconData ikon;
  final Color warna;
}

const daftarDestinasi = <Destinasi>[
  Destinasi(
    id: 1,
    nama: 'Danau Toba',
    kabupatenKota: 'Kabupaten Toba',
    kategori: 'Alam',
    deskripsi: 'Danau vulkanik terbesar di Indonesia dengan Pulau Samosir di tengahnya. Nikmati panorama perbukitan, budaya Batak, dan udara sejuk di tepi danau.',
    hargaTiket: null,
    ikon: Icons.water,
    warna: Color(0xFF1976D2),
  ),
  Destinasi(
    id: 2,
    nama: 'Bukit Lawang',
    kabupatenKota: 'Kabupaten Langkat',
    kategori: 'Ekowisata',
    deskripsi: 'Pintu masuk menuju Taman Nasional Gunung Leuser yang dikenal sebagai habitat orangutan Sumatera. Pengunjung dapat menikmati sungai dan hutan tropis.',
    hargaTiket: 5000,
    ikon: Icons.forest,
    warna: Color(0xFF388E3C),
  ),
  Destinasi(
    id: 3,
    nama: 'Berastagi',
    kabupatenKota: 'Kabupaten Karo',
    kategori: 'Pegunungan',
    deskripsi: 'Kota dataran tinggi yang sejuk dengan pemandangan Gunung Sinabung dan Sibayak, pasar buah, serta kebun bunga yang menarik untuk dikunjungi.',
    hargaTiket: null,
    ikon: Icons.landscape,
    warna: Color(0xFF8D6E63),
  ),
  Destinasi(
    id: 4,
    nama: 'Istana Maimun',
    kabupatenKota: 'Kota Medan',
    kategori: 'Sejarah',
    deskripsi: 'Istana Kesultanan Deli yang dibangun pada abad ke-19. Arsitekturnya memadukan unsur Melayu, Islam, India, dan Eropa.',
    hargaTiket: 10000,
    ikon: Icons.account_balance,
    warna: Color(0xFFF9A825),
  ),
  Destinasi(
    id: 5,
    nama: 'Air Terjun Sipiso-piso',
    kabupatenKota: 'Kabupaten Karo',
    kategori: 'Air Terjun',
    deskripsi: 'Air terjun setinggi sekitar 120 meter yang jatuh dari dataran tinggi ke lembah dekat Danau Toba. Area pandangnya menawarkan panorama alam yang luas.',
    hargaTiket: 7500,
    ikon: Icons.waterfall_chart,
    warna: Color(0xFF00897B),
  ),
  Destinasi(
    id: 6,
    nama: 'Pantai Pandan',
    kabupatenKota: 'Kabupaten Tapanuli Tengah',
    kategori: 'Pantai',
    deskripsi: 'Pantai populer di Sibolga dengan pasir cerah dan air laut yang tenang. Cocok untuk bersantai dan menikmati pemandangan pesisir barat Sumatera Utara.',
    hargaTiket: 5000,
    ikon: Icons.beach_access,
    warna: Color(0xFF00ACC1),
  ),
];

/// Mencari destinasi berdasarkan ID, atau null jika tidak ditemukan.
Destinasi? cariDestinasi(int id) {
  for (final destinasi in daftarDestinasi) {
    if (destinasi.id == id) return destinasi;
  }
  return null;
}

/// Menambahkan pemisah ribuan dengan format rupiah sederhana.
extension FormatRupiah on int {
  String get formatRupiah {
    final teks = toString();
    final bagian = <String>[];
    for (var akhir = teks.length; akhir > 0; akhir -= 3) {
      final awal = (akhir - 3).clamp(0, teks.length);
      bagian.insert(0, teks.substring(awal, akhir));
    }
    return 'Rp${bagian.join('.')}';
  }
}

String formatHargaTiket(int? harga) =>
    harga == null ? 'Gratis' : harga.formatRupiah;
