import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

import 'package:union_shop/collections_page.dart';
import 'package:union_shop/collection_detail_page.dart';
import 'package:union_shop/product_page.dart';

void main() {
  testWidgets('Collections page shows collection tiles from data model',
      (WidgetTester tester) async {
    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(
        const MaterialApp(
          home: CollectionsPage(),
        ),
      );

      // Page title
      expect(find.text('Collections'), findsOneWidget);

      // A few key collection titles from productIdsByCollection
      // (some others may be off-screen in the scrollable grid).
      expect(find.text('Autumn Favourites'), findsWidgets);
      expect(find.text('Black Friday'), findsWidgets);
      expect(find.text('Clothing'), findsWidgets);
      // We deliberately don't assert on "Essential Range" here because its
      // tile may be off-screen and not yet built by the GridView.

      // The grid itself exists
      expect(
        find.byKey(const ValueKey('collections-grid')),
        findsOneWidget,
      );
    });
  });


  testWidgets(
      'Tap a collection → CollectionDetailPage shows products from product_data → tap product → ProductPage',
      (WidgetTester tester) async {
    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(
        const MaterialApp(
          home: CollectionsPage(),
        ),
      );

      // Tap the "Autumn Favourites" collection tile
      await tester.tap(find.text('Autumn Favourites').first);
      await tester.pumpAndSettle();

      // Now we're on the detail page for that collection
      expect(find.byType(CollectionDetailPage), findsOneWidget);
      expect(find.text('Autumn Favourites'), findsWidgets);

      // One of the products mapped to Autumn Favourites in product_data.dart
      // is "Classic Sweatshirt - Black" (id p1).
      final productFinder = find.text('Classic Sweatshirt - Black');
      expect(productFinder, findsWidgets);

      // Tap the product card to navigate to ProductPage
      await tester.tap(productFinder.first);
      await tester.pumpAndSettle();

      expect(find.byType(ProductPage), findsOneWidget);
      expect(find.text('Classic Sweatshirt - Black'), findsWidgets);
    });
  });
}
