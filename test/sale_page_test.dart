import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:union_shop/product_page.dart';
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

      // Some sale products by name
      expect(find.text('Classic Sweatshirt - Black'), findsWidgets);
      expect(find.text('Union Notebook'), findsWidgets);
    },
  );

  testWidgets(
    'Tapping a sale product navigates to ProductPage where user can add to cart',
    (WidgetTester tester) async {
      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(
          const MaterialApp(
            home: SalePage(),
          ),
        );
        await tester.pumpAndSettle();

        final productText =
            find.text('Classic Sweatshirt - Black').first;
        expect(productText, findsOneWidget);

        final productCard = find.ancestor(
          of: productText,
          matching: find.byType(InkWell),
        ).first;

        await tester.ensureVisible(productCard);
        await tester.pump();

        await tester.tap(productCard);
        await tester.pumpAndSettle();

        // We should be on the ProductPage for that item
        expect(find.byType(ProductPage), findsOneWidget);
        expect(find.text('Classic Sweatshirt - Black'), findsWidgets);
        expect(find.text('ADD TO CART'), findsOneWidget);
      });
    },
  );
}
