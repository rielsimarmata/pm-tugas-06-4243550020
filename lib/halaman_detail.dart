import 'package:material_ui/material_ui.dart';

import 'data.dart';
import 'halaman_daftar.dart';

/// Menampilkan informasi destinasi dengan susunan adaptif.
class HalamanDetail extends StatelessWidget {
  const HalamanDetail({
    super.key,
    required this.destinasi,
    required this.kembali,
  });

  final Destinasi destinasi;
  final VoidCallback kembali;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: 'Kembali',
          onPressed: kembali,
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Detail destinasi'),
      ),
      body: LayoutBuilder(
        builder: (context, batas) {
          final visual = DestinasiVisual(destinasi: destinasi);
          final info = SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  destinasi.nama,
                  style: tema.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        destinasi.kabupatenKota,
                        style: tema.textTheme.titleMedium,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Text(
                  'Tentang destinasi',
                  style: tema.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  destinasi.deskripsi,
                  style: tema.textTheme.bodyLarge?.copyWith(height: 1.6),
                ),
                const SizedBox(height: 24),
                Card(
                  color: tema.colorScheme.secondaryContainer,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Icon(
                          Icons.confirmation_number_outlined,
                          color: tema.colorScheme.onSecondaryContainer,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Harga tiket',
                            style: tema.textTheme.titleMedium,
                          ),
                        ),
                        Text(
                          formatHargaTiket(destinasi.hargaTiket),
                          style: tema.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Harga dapat berubah sesuai kebijakan pengelola.',
                  style: tema.textTheme.bodySmall,
                ),
              ],
            ),
          );

          // Mulai 700 dp, visual dan informasi dapat tampil berdampingan.
          if (batas.maxWidth >= 700) {
            return Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(flex: 5, child: visual),
                  const SizedBox(width: 24),
                  Expanded(flex: 4, child: info),
                ],
              ),
            );
          }
          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            children: [
              AspectRatio(aspectRatio: 1.4, child: visual),
              info,
            ],
          );
        },
      ),
    );
  }
}

/// Memberi pesan dan jalan kembali saat ID destinasi tidak dikenal.
class HalamanTidakDitemukan extends StatelessWidget {
  const HalamanTidakDitemukan({super.key, required this.kembali});

  final VoidCallback kembali;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Destinasi')),
    body: Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.search_off, size: 64),
            const SizedBox(height: 16),
            Text(
              'Destinasi tidak ditemukan',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: kembali,
              icon: const Icon(Icons.arrow_back),
              label: const Text('Kembali'),
            ),
          ],
        ),
      ),
    ),
  );
}
