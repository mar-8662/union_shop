import 'dart:math';

import 'package:flutter/material.dart';
import 'package:union_shop/data/product_data.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/product_page.dart';
import 'package:union_shop/widgets/responsive_navbar.dart';


class CollectionDetailPage extends StatefulWidget {
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
  State<CollectionDetailPage> createState() => _CollectionDetailPageState();
}

class _CollectionDetailPageState extends State<CollectionDetailPage> {
  static const int _pageSize = 9;

  String _selectedFilter = 'All products';
  String _selectedSort = 'Featured';
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    // Get the real Product models for this collection from product_data.dart
    final List<Product> allProducts =
        productsForCollection(widget.collectionTitle);

    // 1) Apply filter
    Iterable<Product> filtered = allProducts;
    if (_selectedFilter == 'Hoodies & Sweatshirts') {
      filtered = filtered.where((p) =>
          p.name.contains('Hoodie') || p.name.contains('Sweatshirt'));
    } else if (_selectedFilter == 'Accessories') {
      filtered = filtered.where((p) =>
          p.name.contains('Beanie') ||
          p.name.contains('Cap') ||
          p.name.contains('Tote') ||
          p.name.contains('Scarf') ||
          p.name.contains('Bottle') ||
          p.name.contains('Lanyard') ||
          p.name.contains('Notebook') ||
          p.name.contains('Mug') ||
          p.name.contains('Sticker'));
    }

    // 2) Apply sort
    final List<Product> working = filtered.toList();
    if (_selectedSort == 'Price, low to high') {
      working.sort((a, b) => a.price.compareTo(b.price));
    } else if (_selectedSort == 'Price, high to low') {
      working.sort((a, b) => b.price.compareTo(a.price));
    }
    // "Featured" keeps original order.

    // 3) Pagination
    final int totalProducts = working.length;
    final int totalPages =
        totalProducts == 0 ? 1 : ((totalProducts - 1) / _pageSize).floor() + 1;

    final int start = _currentPage * _pageSize;
    final int end = min(start + _pageSize, totalProducts);
    final List<Product> pageProducts = (start < totalProducts)
        ? working.sublist(start, end)
        : const <Product>[];

    return Scaffold(
      appBar: const ResponsiveNavbar(),
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
                    widget.collectionTitle,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Shop all of this seasons must haves in one place!",
                  ),
                  const SizedBox(height: 24),

                  // Filters / sort row (now functional)
                  _buildFilterBar(
                    context: context,
                    maxWidth: constraints.maxWidth,
                    totalProducts: totalProducts,
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
                    itemCount: pageProducts.length,
                    itemBuilder: (context, index) {
                      final Product product = pageProducts[index];
                      return _ProductCard(product: product);
                    },
                  ),

                  // Pagination controls
                  if (totalPages > 1) ...[
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          key: const ValueKey('collection_prev_page'),
                          onPressed: _currentPage == 0
                              ? null
                              : () {
                                  setState(() {
                                    _currentPage--;
                                  });
                                },
                          icon: const Icon(Icons.chevron_left),
                        ),
                        Text('Page ${_currentPage + 1} of $totalPages'),
                        IconButton(
                          key: const ValueKey('collection_next_page'),
                          onPressed: _currentPage >= totalPages - 1
                              ? null
                              : () {
                                  setState(() {
                                    _currentPage++;
                                  });
                                },
                          icon: const Icon(Icons.chevron_right),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFilterBar({
    required BuildContext context,
    required double maxWidth,
    required int totalProducts,
  }) {
    final textTheme = Theme.of(context).textTheme;

    final filterRow = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('Filter by'),
        const SizedBox(width: 8),
        DropdownButton<String>(
          key: const ValueKey('collection_filter_dropdown'),
          value: _selectedFilter,
          underline: const SizedBox.shrink(),
          items: const [
            DropdownMenuItem(
              value: 'All products',
              child: Text('All products'),
            ),
            DropdownMenuItem(
              value: 'Hoodies & Sweatshirts',
              child: Text('Hoodies & Sweatshirts'),
            ),
            DropdownMenuItem(
              value: 'Accessories',
              child: Text('Accessories'),
            ),
          ],
          onChanged: (value) {
            if (value == null) return;
            setState(() {
              _selectedFilter = value;
              _currentPage = 0;
            });
          },
        ),
      ],
    );

    final sortRow = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('Sort by'),
        const SizedBox(width: 8),
        DropdownButton<String>(
          key: const ValueKey('collection_sort_dropdown'),
          value: _selectedSort,
          underline: const SizedBox.shrink(),
          items: const [
            DropdownMenuItem(
              value: 'Featured',
              child: Text('Featured'),
            ),
            DropdownMenuItem(
              value: 'Price, low to high',
              child: Text('Price, low to high'),
            ),
            DropdownMenuItem(
              value: 'Price, high to low',
              child: Text('Price, high to low'),
            ),
          ],
          onChanged: (value) {
            if (value == null) return;
            setState(() {
              _selectedSort = value;
              _currentPage = 0;
            });
          },
        ),
      ],
    );

    final countText = Text(
      '$totalProducts products',
      style: textTheme.bodySmall,
    );

    final isNarrow = maxWidth < 600;

    if (isNarrow) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          filterRow,
          const SizedBox(height: 8),
          sortRow,
          const SizedBox(height: 8),
          countText,
        ],
      );
    }

    return Wrap(
      spacing: 24,
      runSpacing: 8,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        filterRow,
        sortRow,
        countText,
      ],
    );
  }
}

class _ProductCard extends StatelessWidget {
  final Product product;

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
                product.mainImage,
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
            '£${product.price.toStringAsFixed(2)}',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
