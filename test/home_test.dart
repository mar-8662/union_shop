import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/main.dart';

void main() {
  group('Home Page Tests', () {
    testWidgets('displays home page with hero and products section',
        (tester) async {
      await tester.pumpWidget(const UnionShopApp());
      await tester.pump();

      // Top banner text
      expect(find.text('PLACEHOLDER HEADER TEXT'), findsOneWidget);

      // Hero section
      expect(find.text('Placeholder Hero Title'), findsOneWidget);
      expect(
        find.text('This is placeholder text for the hero section.'),
        findsOneWidget,
      );

      // Products section heading + CTA button
      expect(find.text('PRODUCTS SECTION'), findsOneWidget);
      expect(find.text('BROWSE PRODUCTS'), findsOneWidget);
    });

    testWidgets('displays product cards with titles and prices',
        (tester) async {
      await tester.pumpWidget(const UnionShopApp());
      await tester.pump();

      // Product titles
      expect(find.text('Placeholder Product 1'), findsOneWidget);
      expect(find.text('Placeholder Product 2'), findsOneWidget);
      expect(find.text('Placeholder Product 3'), findsOneWidget);
      expect(find.text('Placeholder Product 4'), findsOneWidget);

      // Prices
      expect(find.text('£10.00'), findsOneWidget);
      expect(find.text('£15.00'), findsOneWidget);
      expect(find.text('£20.00'), findsOneWidget);
      expect(find.text('£25.00'), findsOneWidget);
    });

    testWidgets('displays header icons', (tester) async {
      await tester.pumpWidget(const UnionShopApp());
      await tester.pump();

      expect(find.byIcon(Icons.search), findsOneWidget);
      expect(find.byIcon(Icons.person_outline), findsOneWidget);
      expect(find.byIcon(Icons.shopping_bag_outlined), findsOneWidget);
      expect(find.byIcon(Icons.menu), findsOneWidget);
    });

    testWidgets('displays footer', (tester) async {
      await tester.pumpWidget(const UnionShopApp());
      await tester.pump();

      expect(find.text('Placeholder Footer'), findsOneWidget);
    });
  });
}
