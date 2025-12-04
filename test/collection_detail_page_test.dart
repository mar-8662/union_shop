import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

import 'package:union_shop/collection_detail_page.dart';

void main() {
  testWidgets(
      'CollectionDetailPage shows title, filters and products from product_data for Clothing',
      (tester) async {
    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(
        const MaterialApp(
          home: CollectionDetailPage.forTitle('Clothing'),
        ),
      );
      await tester.pumpAndSettle();

      // Title in app bar and heading
      expect(find.text('Clothing'), findsWidgets);

      // Subtitle
      expect(
        find.text('Shop all of this seasons must haves in one place!'),
        findsOneWidget,
      );

      // Filter / sort UI
      expect(find.text('Filter by'), findsOneWidget);
      expect(find.text('Sort by'), findsOneWidget);
      expect(find.text('All products'), findsOneWidget);
      expect(find.text('Featured'), findsOneWidget);

      // Product grid present
      expect(
        find.byKey(const ValueKey('collection-products-grid')),
        findsOneWidget,
      );

      // At least a couple of real products from product_data.dart appear
      expect(find.text('Classic Sweatshirt - Black'), findsOneWidget);
      expect(find.text('Campus Hoodie - Navy'), findsOneWidget);
    });
  });

  testWidgets('CollectionDetailPage filter and sort controls work',
      (tester) async {
    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(
        const MaterialApp(
          home: CollectionDetailPage.forTitle('Clothing'),
        ),
      );
      await tester.pumpAndSettle();

      // Filter to T-Shirts
      await tester.tap(find.byKey(const Key('collection_filter_dropdown')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('T-Shirts').last);
      await tester.pumpAndSettle();

      // After filtering, sweatshirt disappears, T-shirt remains
      expect(find.text('Classic Sweatshirt - Black'), findsNothing);
      expect(find.text('Portsmouth Crest T-Shirt - White'), findsWidgets);

      // Ensure sort dropdown is visible, then change sort
      await tester.ensureVisible(
        find.byKey(const Key('collection_sort_dropdown')),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('collection_sort_dropdown')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Price: High to Low').last);
      await tester.pumpAndSettle();

      expect(find.text('Price: High to Low'), findsWidgets);
    });
  });

  testWidgets('CollectionDetailPage paginates products', (tester) async {
    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(
        const MaterialApp(
          home: CollectionDetailPage.forTitle('Clothing'),
        ),
      );
      await tester.pumpAndSettle();

      // First page has "Classic Sweatshirt - Black"
      expect(find.text('Classic Sweatshirt - Black'), findsWidgets);

      // Find the next-page button (pagination control must exist)
      final nextButtonFinder = find.byKey(const Key('collection_next_page'));
      expect(nextButtonFinder, findsOneWidget);

      // Make sure it is actually on-screen
      await tester.ensureVisible(nextButtonFinder);
      await tester.pumpAndSettle();

      // Check if the button is enabled
      final IconButton nextButtonWidget =
          tester.widget<IconButton>(nextButtonFinder);

      if (nextButtonWidget.onPressed != null) {
        // There is more than one page – tapping should change the visible items
        await tester.tap(nextButtonFinder);
        await tester.pumpAndSettle();

        // After paging, the first product from page 1 should no longer be visible
        expect(find.text('Classic Sweatshirt - Black'), findsNothing);
      } else {
        // If there is only one page (button disabled), we still assert pagination UI is present.
        expect(find.textContaining('Page '), findsOneWidget);
      }
    });
  });
}
