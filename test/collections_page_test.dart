import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/collections_page.dart';

void main() {
  // We keep a reference so we can restore it after the tests.
  late FlutterExceptionHandler? originalOnError;

  setUpAll(() {
    originalOnError = FlutterError.onError;

    // In tests, NetworkImage tries to hit HTTP and always gets 400,
    // which throws a bunch of framework errors we don't care about.
    // For this file, we just swallow ALL framework errors.
    FlutterError.onError = (FlutterErrorDetails details) {
      final exception = details.exception;
      // If you want to be slightly safer, you could filter like this:
      //
      // if (exception is NetworkImageLoadException) {
      //   return;
      // }
      //
      // But given the noisy test environment, it's simpler for coursework
      // to ignore everything here.
      if (exception is NetworkImageLoadException) {
        return; // ignore image loading errors
      }

      // For any other error type, still forward to the original handler:
      originalOnError?.call(details);
    };
  });

  tearDownAll(() {
    // Put the global handler back how we found it.
    FlutterError.onError = originalOnError;
  });

  testWidgets('CollectionsPage shows title and collection tiles',
      (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: CollectionsPage()),
    );
    await tester.pump();

    // AppBar title
    expect(find.text('Collections'), findsOneWidget);

    // Check some known collection names.
    expect(find.text('Autumn Favourites'), findsOneWidget);
    expect(find.text('Black Friday'), findsOneWidget);
    expect(find.text('Clothing'), findsOneWidget);
    expect(find.text('Clothing - Original'), findsOneWidget);

    // There should be multiple tappable tiles (InkWell-wrapped cards).
    final tilesFinder = find.byType(InkWell);
    expect(tilesFinder, findsWidgets);
  });
}
