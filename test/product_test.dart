import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/product_page.dart';

void main() {
  const Product testProduct = Product(
    id: 'test1',
    name: 'Classic Sweatshirts',
    description:
        'Bringing to you our best selling Classic Sweatshirts. Available in multiple colours.',
    price: 23.00,
    mainImage: 'https://example.com/test-image-1.jpg',
    galleryImages: [
      'https://example.com/test-image-1.jpg',
      'https://example.com/test-image-2.jpg',
    ],
    colours: ['Black', 'Green', 'Purple', 'Grey'],
    sizes: ['S', 'M', 'L', 'XL'],
    collection: 'Test Collection',
  );

  testWidgets('Product page shows name, price and basic controls',
      (WidgetTester tester) async {
    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(
        const MaterialApp(
          home: ProductPage(product: testProduct),
        ),
      );

      expect(find.text('Classic Sweatshirts'), findsOneWidget);
      expect(find.text('£23.00'), findsOneWidget);
      expect(find.text('Tax included.'), findsOneWidget);

      // Scroll a bit to bring form controls into view
      await tester.ensureVisible(find.text('Color'));
      await tester.pump();

      expect(find.text('Color'), findsOneWidget);
      expect(find.text('Size'), findsOneWidget);
      expect(find.text('Quantity'), findsOneWidget);

      expect(find.text('ADD TO CART'), findsOneWidget);
      expect(find.text('Buy with Shop'), findsOneWidget);
      expect(find.text('More payment options'), findsOneWidget);
    });
  });

  testWidgets('Quantity increases when + is tapped',
      (WidgetTester tester) async {
    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(
        const MaterialApp(
          home: ProductPage(product: testProduct),
        ),
      );

      final incButton = find.byKey(const Key('quantity_increase'));
      await tester.ensureVisible(incButton);
      await tester.pump();

      // initial
      expect(find.byKey(const Key('quantity_value')), findsOneWidget);
      expect(find.text('1'), findsWidgets);

      await tester.tap(incButton);
      await tester.pump();

      expect(find.text('2'), findsWidgets);
    });
  });

  testWidgets('Colour dropdown can change selection',
      (WidgetTester tester) async {
    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(
        const MaterialApp(
          home: ProductPage(product: testProduct),
        ),
      );

      final colourText = find.text('Black').first;
      await tester.ensureVisible(colourText);
      await tester.pump();

      await tester.tap(colourText);
      await tester.pumpAndSettle();

      await tester.tap(find.text('Green').last);
      await tester.pumpAndSettle();

      expect(find.text('Green'), findsWidgets);
    });
  });
}
