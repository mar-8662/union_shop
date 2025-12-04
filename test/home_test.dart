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

      // Top sale banner
      expect(
        find.textContaining('BIG SALE! OUR ESSENTIAL RANGE HAS DROPPED'),
        findsOneWidget,
      );

      // There are nav items in the responsive navbar
      expect(find.text('Home'), findsWidgets);
      expect(find.text('Collections'), findsWidgets);
      expect(find.text('SALE!'), findsWidgets);
      expect(find.text('About'), findsWidgets);

      // Hero section
      expect(
        find.text('Essential Range - Over 20% OFF!'),
        findsOneWidget,
      );
      expect(find.text('BROWSE COLLECTION'), findsOneWidget);

      // Scroll a bit to make sure featured products are in view
      await tester.drag(
        find.byType(SingleChildScrollView).first,
        const Offset(0, -10),
      );
      await tester.pump();

      expect(find.text('Featured products'), findsOneWidget);

      // First featured product now comes from dummyProducts p1:
      // "Classic Sweatshirt - Black"
      expect(find.text('Classic Sweatshirt - Black'), findsWidgets);
    });
  });

  testWidgets('Tapping Collections navigates to CollectionsPage',
      (WidgetTester tester) async {
    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(const UnionShopApp());

      // Tap the Collections item in the HEADER nav bar.
      await tester.tap(find.byKey(const ValueKey('nav_collections_desktop')));
      await tester.pumpAndSettle();

      expect(find.byType(CollectionsPage), findsOneWidget);
      // There may be multiple "Collections" labels (title, nav, etc.)
      expect(find.text('Collections'), findsWidgets);
      expect(find.text('Autumn Favourites'), findsWidgets);
    });
  });

  testWidgets('Tapping a featured product opens its ProductPage',
      (WidgetTester tester) async {
    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(const UnionShopApp());

      // Ensure the featured grid is visible and tap the first featured product
      final productText = find.text('Classic Sweatshirt - Black').first;
      await tester.ensureVisible(productText);
      await tester.pump();

      await tester.tap(productText);
      await tester.pumpAndSettle();

      expect(find.byType(ProductPage), findsOneWidget);
      expect(find.text('Classic Sweatshirt - Black'), findsWidgets);
      expect(find.text('ADD TO CART'), findsOneWidget);
    });
  });

  testWidgets('Home page has Sign in nav and no Print Shack',
      (WidgetTester tester) async {
    await tester.pumpWidget(const UnionShopApp());

    // "Sign in" appears in the responsive navbar.
    expect(find.text('Sign in'), findsWidgets);
    expect(find.text('The Print Shack'), findsNothing);
  });
}
