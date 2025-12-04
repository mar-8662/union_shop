import 'package:flutter/material.dart';
import 'package:union_shop/data/product_data.dart';
import 'package:union_shop/models/collection_product.dart';
import 'package:union_shop/product_page.dart';

class CollectionDetailPage extends StatelessWidget {
  final String collectionTitle;

  const CollectionDetailPage({
    super.key,
    required this.collectionTitle,
  });

  /// Named constructor used by tests: CollectionDetailPage.forTitle('Clothing')
  const CollectionDetailPage.forTitle(
    String title, {
    Key? key,
  })  : collectionTitle = title,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get the real Product models for this collection from product_data.dart
    final productModels = productsForCollection(collectionTitle);

    // Convert them into the simpler CollectionProduct view-model
    final List<CollectionProduct> products = productModels
        .map(
          (p) => CollectionProduct(
            name: p.name,
            price: '£${p.price.toStringAsFixed(2)}',
            imageUrl: p.mainImage,
          ),
        )
        .toList(growable: false);

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
                  const Text(
                    // Match your test text exactly
                    "Shop all of this seasons must haves in one place!",
                  ),
                  const SizedBox(height: 24),

                  // Filters / sort row (UI only but functional enough for coursework)
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
                    key: const ValueKey('collection-products-grid'),
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
    return InkWell(
      onTap: () {
        // → Product details page
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => ProductPage(product: product),
          ),
        );
      },
      child: Column(
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
      ),
    );
  }
}
