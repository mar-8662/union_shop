import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:union_shop/data/product_data.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/product_page.dart';

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
  static const int _pageSize = 8;

  late final List<Product> _allProducts;

  String _selectedFilter = 'All products';
  String _selectedSort = 'Featured';
  int _currentPage = 0;

  static const List<String> _filterOptions = [
    'All products',
    'Hoodies & Sweatshirts',
    'T-Shirts',
    'Outerwear',
    'Accessories',
    'Print Shack',
  ];

  static const List<String> _sortOptions = [
    'Featured',
    'Price: Low to High',
    'Price: High to Low',
    'Alphabetical A–Z',
  ];

  @override
  void initState() {
    super.initState();
    _allProducts = productsForCollection(widget.collectionTitle);
  }

  List<Product> get _filteredProducts {
    if (_selectedFilter == 'All products') return _allProducts;

    return _allProducts
        .where((p) => p.collection == _selectedFilter)
        .toList(growable: false);
  }

  List<Product> get _sortedProducts {
    final products = List<Product>.from(_filteredProducts);

    switch (_selectedSort) {
      case 'Price: Low to High':
        products.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'Price: High to Low':
        products.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 'Alphabetical A–Z':
        products.sort((a, b) => a.name.compareTo(b.name));
        break;
      case 'Featured':
      default:
        // Keep original order (as from data model).
        break;
    }

    return products;
  }

  int get _totalPages {
    final total = _sortedProducts.length;
    if (total == 0) return 1;
    return ((total - 1) / _pageSize).floor() + 1;
  }

  List<Product> get _pageItems {
    final sorted = _sortedProducts;
    if (sorted.isEmpty) return const [];

    final start = _currentPage * _pageSize;
    final end = math.min(start + _pageSize, sorted.length);
    if (start >= sorted.length) return const [];
    return sorted.sublist(start, end);
  }

  void _onFilterChanged(String? value) {
    if (value == null) return;
    setState(() {
      _selectedFilter = value;
      _currentPage = 0;
    });
  }

  void _onSortChanged(String? value) {
    if (value == null) return;
    setState(() {
      _selectedSort = value;
    });
  }

  void _goToPreviousPage() {
    setState(() {
      if (_currentPage > 0) _currentPage--;
    });
  }

  void _goToNextPage() {
    setState(() {
      if (_currentPage < _totalPages - 1) _currentPage++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final products = _pageItems;
    final totalProducts = _sortedProducts.length;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.collectionTitle),
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
                    widget.collectionTitle,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Shop all of this seasons must haves in one place!',
                  ),
                  const SizedBox(height: 24),

                  // FILTER / SORT / COUNT ROW
                  LayoutBuilder(
                    builder: (context, innerConstraints) {
                      final isNarrow = innerConstraints.maxWidth < 700;

                      final filterRow = Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text('Filter by'),
                          const SizedBox(width: 8),
                          DropdownButton<String>(
                            key: const Key('collection_filter_dropdown'),
                            value: _selectedFilter,
                            underline: const SizedBox.shrink(),
                            items: _filterOptions
                                .map(
                                  (opt) => DropdownMenuItem<String>(
                                    value: opt,
                                    child: Text(opt),
                                  ),
                                )
                                .toList(),
                            onChanged: _onFilterChanged,
                          ),
                        ],
                      );

                      final sortRow = Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text('Sort by'),
                          const SizedBox(width: 8),
                          DropdownButton<String>(
                            key: const Key('collection_sort_dropdown'),
                            value: _selectedSort,
                            underline: const SizedBox.shrink(),
                            items: _sortOptions
                                .map(
                                  (opt) => DropdownMenuItem<String>(
                                    value: opt,
                                    child: Text(opt),
                                  ),
                                )
                                .toList(),
                            onChanged: _onSortChanged,
                          ),
                        ],
                      );

                      final countText =
                          Text('$totalProducts products');

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

                      // Wide layout – use Wrap to avoid overflow in tests
                      return Wrap(
                        spacing: 24,
                        runSpacing: 8,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        alignment: WrapAlignment.spaceBetween,
                        children: [
                          filterRow,
                          sortRow,
                          countText,
                        ],
                      );
                    },
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

                  const SizedBox(height: 16),

                  if (_totalPages > 1)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          key: const Key('collection_prev_page'),
                          icon: const Icon(Icons.chevron_left),
                          onPressed:
                              _currentPage == 0 ? null : _goToPreviousPage,
                        ),
                        Text('Page ${_currentPage + 1} of $_totalPages'),
                        IconButton(
                          key: const Key('collection_next_page'),
                          icon: const Icon(Icons.chevron_right),
                          onPressed: _currentPage >= _totalPages - 1
                              ? null
                              : _goToNextPage,
                        ),
                      ],
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
