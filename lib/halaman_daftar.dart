import 'package:material_ui/material_ui.dart';

import 'data.dart';

class HalamanDaftar extends StatelessWidget {
  const HalamanDaftar({super.key, required this.bukaDestinasi});

  final ValueChanged<Destinasi> bukaDestinasi;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wisata Sumatera Utara'),
        centerTitle: false,
      ),
      body: LayoutBuilder(
        builder: (context, batas) {
          final jumlahKolom = switch (batas.maxWidth) {
            < 600 => 2,
            < 900 => 3,
            _ => 4,
          };
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Jelajahi keindahan Sumut', style: tema.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 6),
                      Text('Temukan alam, budaya, dan cerita dari setiap sudut Sumatera Utara.', style: tema.textTheme.bodyMedium),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverGrid.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: jumlahKolom,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 14,
                    childAspectRatio: batas.maxWidth < 600 ? 0.68 : 0.9,
                  ),
                  itemCount: daftarDestinasi.length,
                  itemBuilder: (context, indeks) => KartuDestinasi(
                    destinasi: daftarDestinasi[indeks],
                    onTap: () => bukaDestinasi(daftarDestinasi[indeks]),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class KartuDestinasi extends StatelessWidget {
  const KartuDestinasi({super.key, required this.destinasi, required this.onTap});

  final Destinasi destinasi;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    return Card(
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 5,
              child: DestinasiVisual(destinasi: destinasi, radius: BorderRadius.zero),
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(destinasi.nama, maxLines: 1, overflow: TextOverflow.ellipsis, style: tema.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text(destinasi.kabupatenKota, maxLines: 1, overflow: TextOverflow.ellipsis, style: tema.textTheme.bodySmall),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.confirmation_number_outlined, size: 17),
                        const SizedBox(width: 5),
                        Expanded(child: Text(formatHargaTiket(destinasi.hargaTiket), maxLines: 1, overflow: TextOverflow.ellipsis, style: tema.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w600))),
                        const Icon(Icons.arrow_forward, size: 18),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DestinasiVisual extends StatelessWidget {
  const DestinasiVisual({super.key, required this.destinasi, this.radius = const BorderRadius.all(Radius.circular(24))});

  final Destinasi destinasi;
  final BorderRadius radius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: radius,
      child: Stack(
        fit: StackFit.expand,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [destinasi.warna, destinasi.warna.withValues(alpha: 0.55)],
              ),
            ),
            child: Center(child: Icon(destinasi.ikon, size: 76, color: Colors.white.withValues(alpha: 0.9))),
          ),
          Positioned(
            top: 12,
            left: 12,
            child: Container(
              constraints: const BoxConstraints(maxWidth: 160),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.48), borderRadius: BorderRadius.circular(30)),
              child: Text(destinasi.kategori, maxLines: 1, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.w600)),
            ),
          ),
        ],
      ),
    );
  }
}

