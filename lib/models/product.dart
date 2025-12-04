class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String mainImage;
  final List<String> galleryImages;
  final List<String> colours;
  final List<String> sizes;
  final String collection;

  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.mainImage,
    required this.galleryImages,
    required this.colours,
    required this.sizes,
    required this.collection,
  });
}