import 'package:flutter/material.dart';
import 'package:union_shop/collection_detail_page.dart';

class CollectionsPage extends StatelessWidget {
  const CollectionsPage({super.key});

  @override
  Widget build(BuildContext context) {
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
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
              ),
              itemCount: _dummyCollections.length,
              itemBuilder: (context, index) {
                final collection = _dummyCollections[index];
                return _CollectionCard(collection: collection);
              },
            ),
          );
        },
      ),
    );
  }
}

class CollectionItem {
  final String title;
  final String imageUrl;

  const CollectionItem({
    required this.title,
    required this.imageUrl,
  });
}

// Hard-coded dummy data – good enough for the coursework
const List<CollectionItem> _dummyCollections = [
  CollectionItem(
    title: 'Autumn Favourites',
    imageUrl:
        'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561',
  ),
  CollectionItem(
    title: 'Black Friday',
    imageUrl:
        'https://shop.upsu.net/cdn/shop/files/black-friday_1024x1024@2x.jpg',
  ),
  CollectionItem(
    title: 'Clothing',
    imageUrl:
        'https://shop.upsu.net/cdn/shop/files/hoodie-purple_1024x1024@2x.jpg',
  ),
  CollectionItem(
    title: 'Clothing - Original',
    imageUrl:
        'https://shop.upsu.net/cdn/shop/files/hoodie-original_1024x1024@2x.jpg',
  ),
  CollectionItem(
    title: 'Elections Discounts',
    imageUrl:
        'https://shop.upsu.net/cdn/shop/files/elections-discount_1024x1024@2x.jpg',
  ),
  CollectionItem(
    title: 'Essential Range',
    imageUrl:
        'https://shop.upsu.net/cdn/shop/files/essential-range_1024x1024@2x.jpg',
  ),
];

class _CollectionCard extends StatelessWidget {
  final CollectionItem collection;

  const _CollectionCard({required this.collection});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      key: ValueKey('collection-${collection.title}'),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>
                CollectionDetailPage.forTitle(collection.title),
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
            ),
            Container(
              color: Colors.black.withOpacity(0.35),
              alignment: Alignment.center,
              padding: const EdgeInsets.all(16),
              child: Text(
                collection.title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
