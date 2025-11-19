import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/product_page.dart';

void main() {
  group('Product Page Tests', () {
    Widget createTestWidget() {
      return const MaterialApp(home: ProductPage());
    }

    testWidgets('displays product page with basic elements', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Top banner text
      expect(find.text('PLACEHOLDER HEADER TEXT'), findsOneWidget);

      // Product info
      expect(find.text('Placeholder Product Name'), findsOneWidget);
      expect(find.text('£15.00'), findsOneWidget);
      expect(find.text('Description'), findsOneWidget);

      // Description body (partial match is fine)
      expect(
        find.textContaining('placeholder description for the product'),
        findsOneWidget,
      );
    });

    testWidgets('displays header icons', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      expect(find.byIcon(Icons.search), findsOneWidget);
      expect(find.byIcon(Icons.person_outline), findsOneWidget);
      expect(find.byIcon(Icons.shopping_bag_outlined), findsOneWidget);
      expect(find.byIcon(Icons.menu), findsOneWidget);
    });

    testWidgets('displays footer', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      expect(find.text('Placeholder Footer'), findsOneWidget);
    });
  });
}
