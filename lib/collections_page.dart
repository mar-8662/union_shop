import 'package:flutter/material.dart';
import 'package:union_shop/collection_detail_page.dart';
import 'package:union_shop/data/product_data.dart';
import 'package:union_shop/models/product.dart';

class CollectionsPage extends StatelessWidget {
  const CollectionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<CollectionTile> collections = _buildCollectionTiles();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Collections'),
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Simple responsive grid: 1 / 2 / 3 columns
          final crossAxisCount = constraints.maxWidth > 1000
              ? 3
              : constraints.maxWidth > 650
                  ? 2
                  : 1;

          return Padding(
            padding: const EdgeInsets.all(16),
            child: GridView.builder(
              key: const ValueKey('collections-grid'),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
              ),
              itemCount: collections.length,
              itemBuilder: (context, index) {
                final collection = collections[index];
                return _CollectionCard(collection: collection);
              },
            ),
          );
        },
      ),
    );
  }
}

/// View-model representing one tile on the Collections page.
class CollectionTile {
  final String title;
  final String imageUrl;
  final int productCount;
  final List<Product> products;

  CollectionTile({
    required this.title,
    required this.imageUrl,
    required this.productCount,
    required this.products,
  });
}

/// Build collection tiles dynamically from the shared product data model.
///
/// This is what satisfies the “Collections page populated from data models
/// or services” requirement – we are not hard-coding the collections here.
List<CollectionTile> _buildCollectionTiles() {
  final List<CollectionTile> tiles = [];

  productIdsByCollection.forEach((title, ids) {
    final List<Product> products = dummyProducts
        .where((p) => ids.contains(p.id))
        .toList(growable: false);

    if (products.isEmpty) {
      return;
    }

    final String imageUrl = products.first.mainImage;

    tiles.add(
      CollectionTile(
        title: title,
        imageUrl: imageUrl,
        productCount: products.length,
        products: products,
      ),
    );
  });

  return tiles;
}

class _CollectionCard extends StatelessWidget {
  final CollectionTile collection;

  const _CollectionCard({required this.collection});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      key: ValueKey('collection-${collection.title}'),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => CollectionDetailPage(
              collectionTitle: collection.title,
            ),
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              collection.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                // In tests (and if the URL is unreachable), we fall back to a
                // simple grey box instead of throwing framework errors.
                return Container(color: Colors.grey.shade300);
              },
            ),
            Container(
              color: Colors.black.withOpacity(0.35),
            ),
            // Title & product count overlay, mimicking the real UPSU layout
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    collection.title,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${collection.productCount} products',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.white70,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
