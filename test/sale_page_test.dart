import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/sale_page.dart';

void main() {
  testWidgets(
    'Sale page shows hero messaging and discounted products',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: SalePage(),
        ),
      );

      // Header and messaging
      expect(find.text('SALE'), findsOneWidget);
      expect(
        find.text("Don't miss out! Get yours before they're all gone!"),
        findsOneWidget,
      );
      expect(
        find.text('All prices shown are inclusive of the discount'),
        findsOneWidget,
      );

      // Filter bar
      expect(find.text('FILTER BY'), findsOneWidget);
      expect(find.text('All products'), findsOneWidget);
      expect(find.text('SORT BY'), findsOneWidget);
      expect(find.text('Best selling'), findsOneWidget);
      expect(find.text('${saleProducts.length} products'), findsOneWidget);

      // A couple of specific sale products and prices
      expect(find.text('Classic Sweatshirts - Neutral'), findsOneWidget);
      expect(find.text('£17.00'), findsOneWidget);
      expect(find.text('£10.99'), findsOneWidget);

      expect(find.text('Recycled Notebook'), findsOneWidget);
      expect(find.text('£2.20'), findsOneWidget);
      expect(find.text('£1.80'), findsOneWidget);
    },
  );
}
