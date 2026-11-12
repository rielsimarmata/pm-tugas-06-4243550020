import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:wisata_sumut/data.dart';
import 'package:wisata_sumut/halaman_detail.dart';
import 'package:wisata_sumut/main.dart';

void main() {
  testWidgets('daftar membuka detail dan menampilkan kategori', (tester) async {
    await tester.pumpWidget(const AplikasiWisata());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Danau Toba').first);
    await tester.pumpAndSettle();

    expect(find.text('Detail destinasi'), findsOneWidget);
    expect(find.text('Alam'), findsOneWidget);
  });

  testWidgets('ID yang tidak dikenal menampilkan halaman tidak ditemukan', (
    tester,
  ) async {
    await tester.pumpWidget(const AplikasiWisata());
    appRouter.go('/destinasi/99999');
    await tester.pumpAndSettle();

    expect(find.text('Destinasi tidak ditemukan'), findsOneWidget);
  });

  const lebarJendela = <double>[
    320,
    360,
    400,
    480,
    599,
    600,
    700,
    839,
    840,
    899,
    900,
    980,
    1000,
    1100,
    1280,
  ];

  for (final lebar in lebarJendela) {
    for (final skalaTeks in <double>[1, 1.3]) {
      testWidgets(
        'daftar dan detail tanpa overflow: ${lebar.toInt()} dp, skala $skalaTeks',
        (tester) async {
          tester.view.physicalSize = Size(lebar, 900);
          tester.view.devicePixelRatio = 1;
          tester.platformDispatcher.textScaleFactorTestValue = skalaTeks;
          addTearDown(tester.view.resetPhysicalSize);
          addTearDown(tester.view.resetDevicePixelRatio);
          addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);

          await tester.pumpWidget(const AplikasiWisata());
          appRouter.go('/');
          await tester.pumpAndSettle();
          expect(tester.takeException(), isNull, reason: 'Halaman daftar');

          await tester.tap(find.text('Danau Toba').first);
          await tester.pumpAndSettle();
          expect(tester.takeException(), isNull, reason: 'Halaman detail');
        },
      );
    }
  }

  for (final lebar in <double>[360, 1280]) {
    for (final skalaTeks in <double>[1, 1.3]) {
      testWidgets(
        'enam detail tidak overflow pada ${lebar.toInt()} dp, skala $skalaTeks',
        (tester) async {
          tester.view.physicalSize = Size(lebar, 900);
          tester.view.devicePixelRatio = 1;
          tester.platformDispatcher.textScaleFactorTestValue = skalaTeks;
          addTearDown(tester.view.resetPhysicalSize);
          addTearDown(tester.view.resetDevicePixelRatio);
          addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);

          await tester.pumpWidget(const AplikasiWisata());
          for (final destinasi in daftarDestinasi) {
            appRouter.go('/destinasi/${destinasi.id}');
            await tester.pumpAndSettle();
            expect(find.text('Detail destinasi'), findsOneWidget);
            expect(find.text(destinasi.nama), findsOneWidget);
            expect(tester.takeException(), isNull, reason: destinasi.nama);
          }
        },
      );
    }
  }

  for (final (lebar, tipeAda, tipeTiada) in <(double, Type, Type)>[
    (839, NavigationBar, NavigationRail),
    (840, NavigationRail, NavigationBar),
  ]) {
    testWidgets('navigasi responsif pada lebar ${lebar.toInt()} dp', (
      tester,
    ) async {
      tester.view.physicalSize = Size(lebar, 900);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(const AplikasiWisata());
      await tester.pumpAndSettle();

      expect(find.byType(tipeAda), findsOneWidget);
      expect(find.byType(tipeTiada), findsNothing);
    });
  }

  for (final (lebar, kolom) in <(double, int)>[(400, 2), (700, 3), (1280, 4)]) {
    testWidgets('grid memakai $kolom kolom pada lebar ${lebar.toInt()} dp', (
      tester,
    ) async {
      tester.view.physicalSize = Size(lebar, 900);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(const AplikasiWisata());
      appRouter.go('/');
      await tester.pumpAndSettle();
      final grid = tester.widget<SliverGrid>(find.byType(SliverGrid));
      final delegasi =
          grid.gridDelegate as SliverGridDelegateWithFixedCrossAxisCount;

      expect(delegasi.crossAxisCount, kolom);
    });
  }

  testWidgets('detail tetap terbuka setelah pindah tab dan kembali', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(600, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const AplikasiWisata());
    appRouter.go('/destinasi/1');
    await tester.pumpAndSettle();
    expect(find.text('Detail destinasi'), findsOneWidget);

    await tester.tap(find.text('Tentang'));
    await tester.pumpAndSettle();
    expect(find.text('Tentang aplikasi'), findsOneWidget);

    await tester.tap(find.text('Destinasi'));
    await tester.pumpAndSettle();
    expect(find.text('Detail destinasi'), findsOneWidget);
    expect(find.text('Danau Toba'), findsOneWidget);
  });

  testWidgets('path ID non-angka menampilkan halaman tidak ditemukan', (
    tester,
  ) async {
    await tester.pumpWidget(const AplikasiWisata());
    appRouter.go('/destinasi/abc');
    await tester.pumpAndSettle();

    expect(find.text('Destinasi tidak ditemukan'), findsOneWidget);
  });

  for (final (lebar, susunan) in <(double, Type)>[
    (360, ListView),
    (800, Row),
  ]) {
    testWidgets('detail memakai susunan $susunan pada ${lebar.toInt()} dp', (
      tester,
    ) async {
      tester.view.physicalSize = Size(lebar, 900);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(const AplikasiWisata());
      appRouter.go('/destinasi/1');
      await tester.pumpAndSettle();

      expect(
        find.descendant(
          of: find.byType(HalamanDetail),
          matching: susunan == Row
              ? find.byWidgetPredicate(
                  (widget) =>
                      widget is Row &&
                      widget.crossAxisAlignment == CrossAxisAlignment.stretch,
                )
              : find.byType(susunan),
        ),
        findsOneWidget,
      );
    });
  }
}
