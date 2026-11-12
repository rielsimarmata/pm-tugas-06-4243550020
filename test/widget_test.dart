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

  testWidgets('ID yang tidak dikenal menampilkan halaman tidak ditemukan', (tester) async {
    await tester.pumpWidget(const AplikasiWisata());
    appRouter.go('/destinasi/99999');
    await tester.pumpAndSettle();

    expect(find.text('Destinasi tidak ditemukan'), findsOneWidget);
  });

  for (final ukuran in <Size>[
    const Size(360, 800),
    const Size(800, 1280),
    const Size(1280, 800),
  ]) {
    testWidgets('tidak overflow pada ${ukuran.width.toInt()}x${ukuran.height.toInt()}', (tester) async {
      tester.view.physicalSize = ukuran;
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(const AplikasiWisata());
      appRouter.go('/');
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);

      await tester.tap(find.text('Danau Toba').first);
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
    });
  }
}
