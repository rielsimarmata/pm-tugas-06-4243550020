import 'dart:ui' show Size;

import 'package:flutter_test/flutter_test.dart';
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
}
