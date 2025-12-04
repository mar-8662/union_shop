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

      // At least a couple of known collections from productIdsByCollection
      // (others may be off-screen due to pagination).
      expect(find.text('Autumn Favourites'), findsWidgets);
      expect(find.text('Black Friday'), findsWidgets);

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

  testWidgets('Collections filter and sort widgets work',
      (WidgetTester tester) async {
    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(
        const MaterialApp(
          home: CollectionsPage(),
        ),
      );
      await tester.pumpAndSettle();

      // Initially: All collections
      expect(find.text('All collections'), findsOneWidget);
      expect(find.text('A-Z'), findsOneWidget);

      // Filter by "Sale" – should hide Autumn Favourites and show the sale ones
      await tester.tap(find.text('All collections').first);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Sale').last);
      await tester.pumpAndSettle();

      expect(find.text('Autumn Favourites'), findsNothing);
      expect(find.text('Black Friday'), findsWidgets);
      expect(find.text('Elections Discounts'), findsWidgets);

      // Change sorting option – just check that the chosen label updates
      await tester.tap(find.text('A-Z').first);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Z-A').last);
      await tester.pumpAndSettle();

      expect(find.text('Z-A'), findsWidgets);
    });
  });

  testWidgets('Collections pagination shows different pages',
      (WidgetTester tester) async {
    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(
        const MaterialApp(
          home: CollectionsPage(),
        ),
      );
      await tester.pumpAndSettle();

      // With page size 4 and 6 total, there should be at least 2 pages.
      // On the first page we should see "Autumn Favourites"
      expect(find.text('Autumn Favourites'), findsWidgets);

      final nextButton =
          find.byKey(const ValueKey('collections_next_page'));

      await tester.tap(nextButton);
      await tester.pumpAndSettle();

      // On the second page, Autumn Favourites should be gone,
      // and later collections such as "Elections Discounts" should appear.
      expect(find.text('Autumn Favourites'), findsNothing);
      expect(find.text('Elections Discounts'), findsWidgets);
    });
  });
}
