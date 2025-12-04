// lib/models/collection_product.dart
class CollectionProduct {
  final String name;
  final String price; // e.g. "£23.00"
  final String imageUrl;

  const CollectionProduct({
    required this.name,
    required this.price,
    required this.imageUrl,
  });
}
