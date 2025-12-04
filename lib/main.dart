import 'package:flutter/material.dart';
import 'package:union_shop/about_page.dart';
import 'package:union_shop/collections_page.dart';
import 'package:union_shop/footer.dart';
import 'package:union_shop/models/collection_product.dart';
import 'package:union_shop/product_page.dart';

void main() {
  runApp(const UnionShopApp());
}

class UnionShopApp extends StatelessWidget {
  const UnionShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Union Shop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4d2963)),
      ),
      home: const HomeScreen(),
      routes: {
        '/collections': (context) => const CollectionsPage(),
        '/about': (context) => const AboutUsPage(),
      },
    );
  }
}

/// Products shown on the homepage “Featured products” section.
const List<CollectionProduct> homeFeaturedProducts = [
  CollectionProduct(
    name: 'Classic Sweatshirts',
    price: '£23.00',
    imageUrl:
        'https://shop.upsu.net/cdn/shop/files/hoodie-original_1024x1024@2x.jpg',
  ),
  CollectionProduct(
    name: 'Essential Hoodie',
    price: '£20.00',
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
    name: 'Classic Beanie Hat',
    price: '£12.00',
    imageUrl:
        'https://shop.upsu.net/cdn/shop/files/black-friday_1024x1024@2x.jpg',
  ),
];

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isWide = MediaQuery.of(context).size.width >= 800;

    return Scaffold(
      body: Column(
        children: [
          // Top sale banner
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            color: const Color(0xFF4d2963),
            child: const Text(
              'BIG SALE! OUR ESSENTIAL RANGE HAS DROPPED IN PRICE! OVER 20% OFF! '
              'COME GRAB YOURS WHILE STOCK LASTS!',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
          ),

          // Nav row (scrollable horizontally to avoid overflow in tests)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  const Text(
                    'The UNION',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 24),
                  TextButton(
                    onPressed: () {},
                    child: const Text('Home'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/collections');
                    },
                    child: const Text('Collections'),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('The Print Shack'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/collections');
                    },
                    child: const Text('SALE!'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/about');
                    },
                    child: const Text('About'),
                  ),
                ],
              ),
            ),
          ),

          // Scrollable page content
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Hero banner
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: AspectRatio(
                      aspectRatio: isWide ? 16 / 5 : 16 / 6,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.network(
                            'https://shop.upsu.net/cdn/shop/files/essential-range_1024x1024@2x.jpg',
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) =>
                                Container(color: Colors.grey.shade300),
                          ),
                          Container(
                            color: Colors.black.withOpacity(0.35),
                          ),
                          Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  'Essential Range - Over 20% OFF!',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'Over 20% off our Essential Range. '
                                  'Come and grab yours while stock lasts!',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                      context,
                                      '/collections',
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 24, vertical: 12),
                                  ),
                                  child: const Text('BROWSE COLLECTION'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Featured products
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Featured products',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        LayoutBuilder(
                          builder: (context, constraints) {
                            final crossAxisCount = constraints.maxWidth > 1000
                                ? 4
                                : constraints.maxWidth > 650
                                    ? 3
                                    : 2;

                            return GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: homeFeaturedProducts.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: crossAxisCount,
                                mainAxisSpacing: 16,
                                crossAxisSpacing: 16,
                                childAspectRatio: 0.7,
                              ),
                              itemBuilder: (context, index) {
                                final product = homeFeaturedProducts[index];
                                return _HomeProductCard(product: product);
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),
                  const UnionFooter(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HomeProductCard extends StatelessWidget {
  final CollectionProduct product;

  const _HomeProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => ProductPage(product: product),
          ),
        );
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                errorBuilder: (_, __, ___) =>
                    Container(color: Colors.grey.shade300),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 4),
                  Text(product.price),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
