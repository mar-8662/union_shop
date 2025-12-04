import 'package:flutter/material.dart';

/// Simple model for a product shown on a collection page.
class CollectionProduct {
  final String name;
  final String price; // keep as String for easy formatting
  final String imageUrl;

  const CollectionProduct({
    required this.name,
    required this.price,
    required this.imageUrl,
  });
}

/// Hard-coded products for each collection.
/// This is perfectly fine for the coursework “dummy collection page”.
const Map<String, List<CollectionProduct>> _dummyProductsByCollection = {
  'Autumn Favourites': [
    CollectionProduct(
      name: 'Classic Sweatshirts',
      price: '£23.00',
      imageUrl:
          'https://shop.upsu.net/cdn/shop/files/hoodie-original_1024x1024@2x.jpg',
    ),
    CollectionProduct(
      name: 'Classic T-Shirts',
      price: '£11.00',
      imageUrl:
          'https://shop.upsu.net/cdn/shop/files/hoodie-purple_1024x1024@2x.jpg',
    ),
    CollectionProduct(
      name: 'Classic Hoodies',
      price: '£25.00',
      imageUrl:
          'https://shop.upsu.net/cdn/shop/files/hoodie-original_1024x1024@2x.jpg',
    ),
    CollectionProduct(
      name: 'Classic Beanie Hat',
      price: '£12.00',
      imageUrl:
          'https://shop.upsu.net/cdn/shop/files/black-friday_1024x1024@2x.jpg',
    ),
  ],
  'Black Friday': [
    CollectionProduct(
      name: 'Discount Hoodie',
      price: '£18.00',
      imageUrl:
          'https://shop.upsu.net/cdn/shop/files/black-friday_1024x1024@2x.jpg',
    ),
    CollectionProduct(
      name: 'Discount T-Shirt',
      price: '£8.50',
      imageUrl:
          'https://shop.upsu.net/cdn/shop/files/hoodie-purple_1024x1024@2x.jpg',
    ),
  ],
  'Clothing': [
    CollectionProduct(
      name: 'Purple Hoodie',
      price: '£25.00',
      imageUrl:
          'https://shop.upsu.net/cdn/shop/files/hoodie-purple_1024x1024@2x.jpg',
    ),
    CollectionProduct(
      name: 'Green Sweatshirt',
      price: '£23.00',
      imageUrl:
          'https://shop.upsu.net/cdn/shop/files/hoodie-original_1024x1024@2x.jpg',
    ),
  ],
  'Clothing - Original': [
    CollectionProduct(
      name: 'Original Hoodie',
      price: '£26.00',
      imageUrl:
          'https://shop.upsu.net/cdn/shop/files/hoodie-original_1024x1024@2x.jpg',
    ),
    CollectionProduct(
      name: 'Original Tee',
      price: '£12.00',
      imageUrl:
          'https://shop.upsu.net/cdn/shop/files/hoodie-purple_1024x1024@2x.jpg',
    ),
  ],
  'Elections Discounts': [
    CollectionProduct(
      name: 'Campaign Hoodie',
      price: '£19.99',
      imageUrl:
          'https://shop.upsu.net/cdn/shop/files/black-friday_1024x1024@2x.jpg',
    ),
  ],
  'Essential Range': [
    CollectionProduct(
      name: 'Essential Hoodie',
      price: '£20.00',
      imageUrl:
          'https://shop.upsu.net/cdn/shop/files/hoodie-original_1024x1024@2x.jpg',
    ),
    CollectionProduct(
      name: 'Essential T-Shirt',
      price: '£10.00',
      imageUrl:
          'https://shop.upsu.net/cdn/shop/files/hoodie-purple_1024x1024@2x.jpg',
    ),
  ],
};

class CollectionDetailPage extends StatelessWidget {
  final String collectionTitle;

  const CollectionDetailPage({
    super.key,
    required this.collectionTitle,
  });

  @override
  Widget build(BuildContext context) {
    // Look up products for this collection; fall back to empty list.
    final products =
        _dummyProductsByCollection[collectionTitle] ?? const <CollectionProduct>[];

    return Scaffold(
      appBar: AppBar(
        title: Text(collectionTitle),
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final crossAxisCount = constraints.maxWidth > 1000
              ? 3
              : constraints.maxWidth > 650
                  ? 2
                  : 1;

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Page heading
                  Text(
                    collectionTitle,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Shop all of this season's must haves in one place!",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 24),

                  // Filters / sort row – simplified so it doesn’t overflow in tests.
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Wrap(
                        spacing: 16,
                        runSpacing: 8,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: const [
                          Text('Filter by'),
                          _DropdownChip(label: 'All products'),
                          Text('Sort by'),
                          _DropdownChip(label: 'Featured'),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text('${products.length} products'),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Products grid
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 3 / 4,
                    ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return _ProductCard(product: product);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _DropdownChip extends StatelessWidget {
  final String label;

  const _DropdownChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label),
          const SizedBox(width: 4),
          const Icon(Icons.arrow_drop_down, size: 18),
        ],
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final CollectionProduct product;

  const _ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(
          aspectRatio: 4 / 3,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
              // Avoid test crashes when HTTP 400 happens in flutter test.
              errorBuilder: (context, error, stackTrace) {
                return Container(color: Colors.grey.shade300);
              },
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          product.name,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          product.price,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
