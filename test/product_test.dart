import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/product_page.dart';

void main() {
  // Ignore NetworkImageLoadException during tests for product page too.
  late FlutterExceptionHandler? originalOnError;

  setUpAll(() {
    originalOnError = FlutterError.onError;
    FlutterError.onError = (FlutterErrorDetails details) {
      final exception = details.exception;
      if (exception is NetworkImageLoadException) {
        return; // ignore network image failures
      }
      originalOnError?.call(details);
    };
  });

  tearDownAll(() {
    FlutterError.onError = originalOnError;
  });

  group('Product Page Tests', () {
    Widget createTestWidget() {
      return const MaterialApp(home: ProductPage());
    }

    testWidgets('displays product page with basic elements', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Top banner text
      expect(
        find.text('Student-run shop for official merch & gifts'),
        findsOneWidget,
      );

      // Product info
      expect(find.text('Portsmouth City Magnet'), findsOneWidget);
      expect(find.text('£15.00'), findsOneWidget);
      expect(find.text('Description'), findsOneWidget);

      // Description body (partial match is fine)
      expect(
        find.textContaining('Illustrated tin magnet celebrating Portsmouth'),
        findsOneWidget,
      );
    });

testWidgets('displays footer', (tester) async {
  await tester.pumpWidget(createTestWidget());
  await tester.pump();

  expect(
    find.text("Union Shop • University of Portsmouth Students' Union"),
    findsOneWidget,
  );

  // Dummy footer links
  expect(find.text('Contact us'), findsOneWidget);
});
  });
}
