import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:union_shop/cart_page.dart';
import 'package:union_shop/models/cart_model.dart';
import 'package:union_shop/models/collection_product.dart';

void main() {
  const testProduct = CollectionProduct(
    name: 'Classic Sweatshirts',
    price: '£23.00',
    imageUrl:
        'https://shop.upsu.net/cdn/shop/files/hoodie-original_1024x1024@2x.jpg',
  );

  testWidgets('Cart page shows empty state when there are no items',
      (WidgetTester tester) async {
    cartModel.clear();

    await tester.pumpWidget(
      const MaterialApp(
        home: CartPage(),
      ),
    );

    expect(find.text('Your cart'), findsOneWidget);
    expect(find.text('Your cart is currently empty.'), findsOneWidget);
    expect(find.text('CONTINUE SHOPPING'), findsOneWidget);
  });

  testWidgets('Cart page shows items and updates subtotal when quantity changes',
      (WidgetTester tester) async {
    await mockNetworkImagesFor(() async {
      cartModel.clear();
      cartModel.addItem(
        testProduct,
        colour: 'Black',
        size: 'S',
        quantity: 1,
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: CartPage(),
        ),
      );
      await tester.pumpAndSettle();

      // Item visible
      expect(find.text('Classic Sweatshirts'), findsOneWidget);
      expect(find.text('Price: £23.00'), findsOneWidget);
      expect(find.text('Total: £23.00'), findsOneWidget);
      expect(find.byKey(const Key('cart_subtotal')), findsOneWidget);
      expect(find.text('Subtotal: £23.00'), findsOneWidget);

      // Change quantity to 2
      final qtyDropdown =
          find.byKey(const ValueKey('cart_item_qty_0'));
      await tester.tap(qtyDropdown);
      await tester.pumpAndSettle();

      await tester.tap(find.text('2').last);
      await tester.pumpAndSettle();

      expect(find.text('Total: £46.00'), findsOneWidget);
      expect(find.text('Subtotal: £46.00'), findsOneWidget);
    });
  });
}
