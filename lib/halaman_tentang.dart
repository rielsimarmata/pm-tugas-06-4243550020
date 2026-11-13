import 'package:material_ui/material_ui.dart';

/// Menampilkan informasi aplikasi dan identitas pengembang.
class HalamanTentang extends StatelessWidget {
  const HalamanTentang({super.key});

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Tentang aplikasi')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              Container(
                height: 190,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF00695C), Color(0xFF80CBC4)],
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.travel_explore,
                    size: 88,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Wisata Sumatera Utara',
                style: tema.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Aplikasi pengenalan destinasi wisata Sumatera Utara. Jelajahi pilihan wisata alam, budaya, sejarah, dan pesisir melalui kartu informasi yang mudah dibaca di berbagai ukuran layar.',
                style: tema.textTheme.bodyLarge?.copyWith(height: 1.6),
              ),
              const SizedBox(height: 20),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Pengembang', style: tema.textTheme.titleLarge),
                      const SizedBox(height: 8),
                      const Text('Nama: Jhon Gabriel Simarmata'),
                      const Text('NIM: 4243550020'),
                      const Text('Kelas: PSIK 24C'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Dibuat untuk tugas Pemrograman Mobile.',
                style: tema.textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
