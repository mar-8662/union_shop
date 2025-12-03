import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/collections_page.dart';

void main() {
  // Ignore NetworkImageLoadException during tests for the collections page.
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

  testWidgets('CollectionsPage shows title and all collection tiles',
      (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: CollectionsPage()),
    );
    await tester.pump();

    // AppBar title
    expect(find.text('Collections'), findsOneWidget);

    // Collection names
    expect(find.text('Autumn Favourites'), findsOneWidget);
    expect(find.text('Black Friday'), findsOneWidget);
    expect(find.text('Clothing'), findsOneWidget);
    expect(find.text('Clothing - Original'), findsOneWidget);
    expect(find.text('Elections Discounts'), findsOneWidget);
    expect(find.text('Essential Range'), findsOneWidget);

    // Check that at least one card uses the expected key
    expect(
      find.byKey(const ValueKey('collection-Autumn Favourites')),
      findsOneWidget,
    );
  });
}
