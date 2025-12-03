import 'package:flutter/material.dart';

class CollectionProduct {
  final String name;
  final String price;

  const CollectionProduct({
    required this.name,
    required this.price,
  });
}

// Hard-coded dummy products for each collection title.
const Map<String, List<CollectionProduct>> _dummyProductsByCollection = {
  'Autumn Favourites': [
    CollectionProduct(name: 'Classic Sweatshirts', price: '£23.00'),
    CollectionProduct(name: 'Classic T-Shirts', price: '£11.00'),
    CollectionProduct(name: 'Classic Hoodies', price: '£25.00'),
    CollectionProduct(name: 'Classic Beanie Hat', price: '£12.00'),
    CollectionProduct(name: 'Lanyards', price: '£2.75'),
    CollectionProduct(name: 'Keep Cups', price: '£6.50'),
  ],
  'Black Friday': [
    CollectionProduct(name: 'Black Hoodie Sale', price: '£19.99'),
    CollectionProduct(name: 'Discounted T-Shirt', price: '£7.50'),
    CollectionProduct(name: 'Sale Beanie', price: '£5.00'),
  ],
  'Clothing': [
    CollectionProduct(name: 'Green Sweatshirt', price: '£23.00'),
    CollectionProduct(name: 'Purple Hoodie', price: '£25.00'),
    CollectionProduct(name: 'Logo T-Shirt', price: '£11.00'),
  ],
  'Clothing - Original': [
    CollectionProduct(name: 'Original Hoodie', price: '£28.00'),
    CollectionProduct(name: 'Original Sweatshirt', price: '£24.00'),
    CollectionProduct(name: 'Original Tee', price: '£13.00'),
  ],
  'Elections Discounts': [
    CollectionProduct(name: 'Campaign Hoodie', price: '£18.00'),
    CollectionProduct(name: 'Campaign Tee', price: '£9.00'),
    CollectionProduct(name: 'Badge Pack', price: '£3.50'),
  ],
  'Essential Range': [
    CollectionProduct(name: 'Plain Hoodie', price: '£20.00'),
    CollectionProduct(name: 'Plain Sweatshirt', price: '£18.00'),
    CollectionProduct(name: 'Plain Tee', price: '£8.00'),
  ],
};

class CollectionDetailPage extends StatelessWidget {
  final String collectionTitle;
  final List<CollectionProduct> products;

  const CollectionDetailPage({
    super.key,
    required this.collectionTitle,
    required this.products,
  });

  /// Convenience factory to build the page just from a title.
  factory CollectionDetailPage.forTitle(String title) {
    return CollectionDetailPage(
      collectionTitle: title,
      products: _dummyProductsByCollection[title] ?? const [],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(collectionTitle),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),

            // Title + subtitle like the example
            Center(
              child: Column(
                children: [
                  Text(
                    collectionTitle,
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Shop all of this seasons must haves in one place!',
                    style: theme.textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Filter / sort row + product count
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    Text('Filter by'),
                    SizedBox(width: 8),
                    _StaticDropdown(label: 'All products'),
                    SizedBox(width: 24),
                    Text('Sort by'),
                    SizedBox(width: 8),
                    _StaticDropdown(label: 'Featured'),
                  ],
                ),
                Text(
                  '${products.length} products',
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Responsive grid of products
            LayoutBuilder(
              builder: (context, constraints) {
                final crossAxisCount = constraints.maxWidth > 1000
                    ? 3
                    : constraints.maxWidth > 650
                        ? 2
                        : 1;

                return GridView.builder(
                  key: const ValueKey('collection-products-grid'),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: products.length,
                  gridDelegate:
                      SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    mainAxisSpacing: 24,
                    crossAxisSpacing: 24,
                    childAspectRatio: 0.7,
                  ),
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return _CollectionProductCard(product: product);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _StaticDropdown extends StatelessWidget {
  final String label;

  const _StaticDropdown({required this.label});

  @override
  Widget build(BuildContext context) {
    final borderColor = Colors.grey.shade400;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label),
          const SizedBox(width: 4),
          const Icon(Icons.keyboard_arrow_down, size: 18),
        ],
      ),
    );
  }
}

class _CollectionProductCard extends StatelessWidget {
  final CollectionProduct product;

  const _CollectionProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      key: ValueKey('product-${product.name}'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(
          aspectRatio: 4 / 3,
          child: Container(
            // Placeholder instead of network image so tests never fetch HTTP.
            color: Colors.grey.shade300,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          product.name,
          style: theme.textTheme.bodyMedium,
        ),
        const SizedBox(height: 4),
        Text(
          product.price,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
