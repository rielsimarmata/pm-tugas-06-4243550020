import 'package:material_ui/material_ui.dart';
import 'package:go_router/go_router.dart';

import 'data.dart';
import 'halaman_daftar.dart';
import 'halaman_detail.dart';
import 'halaman_tentang.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, shell) => KerangkaNavigasi(shell: shell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) => HalamanDaftar(
                bukaDestinasi: (destinasi) =>
                    context.go('/destinasi/${destinasi.id}'),
              ),
              routes: [
                GoRoute(
                  path: 'destinasi/:id',
                  builder: (context, state) {
                    final id = int.tryParse(state.pathParameters['id'] ?? '');
                    final destinasi = id == null ? null : cariDestinasi(id);
                    return destinasi == null
                        ? HalamanTidakDitemukan(kembali: () => context.go('/'))
                        : HalamanDetail(
                            destinasi: destinasi,
                            kembali: () => context.go('/'),
                          );
                  },
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/tentang',
              builder: (context, state) => const HalamanTentang(),
            ),
          ],
        ),
      ],
    ),
  ],
);

void main() => runApp(const AplikasiWisata());

/// Mengatur tema Material 3 dan konfigurasi router aplikasi.
class AplikasiWisata extends StatelessWidget {
  const AplikasiWisata({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp.router(
    title: 'Wisata Sumatera Utara',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF00695C)),
      scaffoldBackgroundColor: const Color(0xFFF7F8F5),
      cardTheme: CardThemeData(
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    ),
    routerConfig: appRouter,
  );
}

/// Menyesuaikan navigasi utama dengan ukuran jendela.
class KerangkaNavigasi extends StatelessWidget {
  const KerangkaNavigasi({super.key, required this.shell});

  final StatefulNavigationShell shell;

  static const _tujuan = <_TujuanNavigasi>[
    _TujuanNavigasi(
      label: 'Destinasi',
      ikon: Icons.explore_outlined,
      ikonAktif: Icons.explore,
    ),
    _TujuanNavigasi(
      label: 'Tentang',
      ikon: Icons.info_outline,
      ikonAktif: Icons.info,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final lebar = MediaQuery.sizeOf(context).width;
    final indeksAktif = shell.currentIndex;
    // Batas 840 dp memilih navigasi bawah atau rail tingkat aplikasi.
    if (lebar < 840) {
      return Scaffold(
        body: shell,
        bottomNavigationBar: NavigationBar(
          selectedIndex: indeksAktif,
          onDestinationSelected: (indeks) =>
              shell.goBranch(indeks, initialLocation: indeks == indeksAktif),
          destinations: [
            for (final tujuan in _tujuan)
              NavigationDestination(
                icon: Icon(tujuan.ikon),
                selectedIcon: Icon(tujuan.ikonAktif),
                label: tujuan.label,
              ),
          ],
        ),
      );
    }
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: indeksAktif,
            onDestinationSelected: (indeks) =>
                shell.goBranch(indeks, initialLocation: indeks == indeksAktif),
            labelType: NavigationRailLabelType.all,
            destinations: [
              for (final tujuan in _tujuan)
                NavigationRailDestination(
                  icon: Icon(tujuan.ikon),
                  selectedIcon: Icon(tujuan.ikonAktif),
                  label: Text(tujuan.label),
                ),
            ],
          ),
          const VerticalDivider(width: 1),
          Expanded(child: shell),
        ],
      ),
    );
  }
}

/// Menyimpan label dan ikon untuk satu tujuan navigasi.
class _TujuanNavigasi {
  const _TujuanNavigasi({
    required this.label,
    required this.ikon,
    required this.ikonAktif,
  });
  final String label;
  final IconData ikon;
  final IconData ikonAktif;
}
