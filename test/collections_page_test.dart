import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

import 'package:union_shop/collections_page.dart';
import 'package:union_shop/collection_detail_page.dart';
import 'package:union_shop/product_page.dart';

void main() {
  testWidgets('Collections page shows collection tiles',
      (WidgetTester tester) async {
    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(
        const MaterialApp(
          home: CollectionsPage(),
        ),
      );

      expect(find.text('Collections'), findsOneWidget);
      expect(find.text('Autumn Favourites'), findsWidgets);
      expect(find.text('Black Friday'), findsWidgets);
      // we don't strictly rely on Essential Range text here
    });
  });

  testWidgets(
      'Tap a collection → CollectionDetailPage → tap product → ProductPage',
      (WidgetTester tester) async {
    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(
        const MaterialApp(
          home: CollectionsPage(),
        ),
      );

      // Tap the "Autumn Favourites" collection
      await tester.tap(find.text('Autumn Favourites').first);
      await tester.pumpAndSettle();

      // We should now be on its detail page
      expect(find.byType(CollectionDetailPage), findsOneWidget);
      expect(find.text('Autumn Favourites'), findsWidgets);

      final productFinder = find.text('Classic Sweatshirts');
      expect(productFinder, findsWidgets);

      await tester.tap(productFinder.first);
      await tester.pumpAndSettle();

      expect(find.byType(ProductPage), findsOneWidget);
      expect(find.text('Classic Sweatshirts'), findsWidgets);
    });
  });
}
