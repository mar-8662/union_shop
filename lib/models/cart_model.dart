// lib/models/cart_model.dart
import 'package:flutter/foundation.dart';
import 'package:union_shop/models/collection_product.dart';

/// A single line item in the cart.
class CartItem {
  final CollectionProduct product;
  final String colour;
  final String size;
  int quantity;
  final double unitPrice;

  CartItem({
    required this.product,
    required this.colour,
    required this.size,
    required this.quantity,
  }) : unitPrice = _parsePrice(product.price);

  double get totalPrice => unitPrice * quantity;
}

/// Main cart model, used via the global [cartModel] below.
class CartModel extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);

  bool get isEmpty => _items.isEmpty;

  int get totalItems =>
      _items.fold<int>(0, (sum, item) => sum + item.quantity);

  double get subtotal =>
      _items.fold<double>(0.0, (sum, item) => sum + item.totalPrice);

  /// Add an item. If same product/colour/size already exists, bump quantity.
  void addItem(
    CollectionProduct product, {
    required String colour,
    required String size,
    int quantity = 1,
  }) {
    final index = _items.indexWhere(
      (item) =>
          item.product.name == product.name &&
          item.colour == colour &&
          item.size == size,
    );

    if (index >= 0) {
      _items[index].quantity += quantity;
    } else {
      _items.add(
        CartItem(
          product: product,
          colour: colour,
          size: size,
          quantity: quantity,
        ),
      );
    }
    notifyListeners();
  }

  void updateQuantity(CartItem item, int quantity) {
    if (quantity <= 0) {
      _items.remove(item);
    } else {
      final index = _items.indexOf(item);
      if (index != -1) {
        _items[index].quantity = quantity;
      }
    }
    notifyListeners();
  }

  void removeItem(CartItem item) {
    _items.remove(item);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}

/// Global instance used everywhere (and by tests).
final CartModel cartModel = CartModel();

/// "£23.00" -> 23.0
double _parsePrice(String priceString) {
  final cleaned = priceString.replaceAll('£', '').trim();
  return double.tryParse(cleaned) ?? 0.0;
}
