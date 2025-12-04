import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

import 'package:union_shop/main.dart';
import 'package:union_shop/collections_page.dart';
import 'package:union_shop/product_page.dart';

void main() {
  testWidgets('Home shows banner, nav, hero and featured products',
      (WidgetTester tester) async {
    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(const UnionShopApp());

      expect(
        find.textContaining('BIG SALE! OUR ESSENTIAL RANGE HAS DROPPED'),
        findsOneWidget,
      );

      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Collections'), findsOneWidget);
      expect(find.text('SALE!'), findsOneWidget);
      expect(find.text('About'), findsOneWidget);

      expect(
        find.text('Essential Range - Over 20% OFF!'),
        findsOneWidget,
      );
      expect(find.text('BROWSE COLLECTION'), findsOneWidget);

      // Scroll a bit to make sure featured products are in view
      await tester.drag(find.byType(SingleChildScrollView).first,
          const Offset(0, -10));
      await tester.pump();

      expect(find.text('Featured products'), findsOneWidget);
      expect(find.text('Classic Sweatshirts'), findsWidgets);
    });
  });

  testWidgets('Tapping Collections navigates to CollectionsPage',
      (WidgetTester tester) async {
    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(const UnionShopApp());

      await tester.tap(find.text('Collections'));
      await tester.pumpAndSettle();

      expect(find.byType(CollectionsPage), findsOneWidget);
      expect(find.text('Collections'), findsOneWidget);
      expect(find.text('Autumn Favourites'), findsWidgets);
    });
  });

  testWidgets('Tapping a featured product opens its ProductPage',
      (WidgetTester tester) async {
    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(const UnionShopApp());

      // Ensure the featured grid is visible
      final productText = find.text('Classic Sweatshirts').first;
      await tester.ensureVisible(productText);
      await tester.pump();

      await tester.tap(productText);
      await tester.pumpAndSettle();

      expect(find.byType(ProductPage), findsOneWidget);
      expect(find.text('Classic Sweatshirts'), findsWidgets);
      expect(find.text('ADD TO CART'), findsOneWidget);
    });
  });
}
