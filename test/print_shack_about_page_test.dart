import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/print_shack_about_page.dart';

void main() {
  testWidgets('Print Shack about page shows heading, copy and products',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: PrintShackAboutPage(),
      ),
    );

    // There are at least one (actually two) "The Union Print Shack" labels
    expect(find.text('The Union Print Shack'), findsWidgets);

    expect(
      find.textContaining('Make it yours at The Union Print Shack'),
      findsOneWidget,
    );

    // Uses the Print Shack products from product_data.dart
    expect(find.text('Popular Print Shack products'), findsOneWidget);
    expect(find.text('Print Shack Custom Hoodie'), findsOneWidget);
    expect(find.text('Print Shack Custom Tee'), findsOneWidget);
    expect(find.text('Print Shack Custom Tote'), findsOneWidget);
  });
}
