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

      // Filter UI labels
      expect(find.text('Filter by'), findsOneWidget);
      expect(find.text('Sort by'), findsOneWidget);
      expect(find.text('All products'), findsOneWidget);
      expect(find.text('Featured'), findsOneWidget);

      // Product grid present
      expect(
        find.byKey(const ValueKey('collection-products-grid')),
        findsOneWidget,
      );

      // Check if some products from product_data.dart appear
      expect(find.text('Classic Sweatshirt - Black'), findsOneWidget);
      expect(find.text('Campus Hoodie - Navy'), findsOneWidget);
    });
  });
}
