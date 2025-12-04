import 'dart:math';

import 'package:flutter/material.dart';
import 'package:union_shop/data/product_data.dart';
import 'package:union_shop/models/collection_product.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/product_page.dart';

class CollectionDetailPage extends StatefulWidget {
  final String collectionTitle;

  const CollectionDetailPage({
    super.key,
    required this.collectionTitle,
  });

  /// Convenience constructor used in tests
  const CollectionDetailPage.forTitle(
    String title, {
    Key? key,
  })  : collectionTitle = title,
        super(key: key);

  @override
  State<CollectionDetailPage> createState() => _CollectionDetailPageState();
}

class _CollectionDetailPageState extends State<CollectionDetailPage> {
  static const int _pageSize = 6;

  late final List<Product> _allProducts;
  late final List<String> _filterOptions;

  String _selectedFilter = 'All products';
  String _selectedSort = 'Featured';
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();

    // 1) Load products for this collection from the shared data model
    _allProducts = productsForCollection(widget.collectionTitle);

    // 2) Build filter options from the Product.collection field
    final categories = _allProducts.map((p) => p.collection).toSet().toList()
      ..sort();
    _filterOptions = ['All products', ...categories];
  }

  // ---- derived lists ----

  List<Product> get _filteredAndSorted {
    // Filtering
    List<Product> list;
    if (_selectedFilter == 'All products') {
      list = List<Product>.from(_allProducts);
    } else {
      list = _allProducts
          .where((p) => p.collection == _selectedFilter)
          .toList(growable: false);
    }

    // Sorting
    switch (_selectedSort) {
      case 'Price: Low to High':
        list.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'Price: High to Low':
        list.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 'Alphabetical A–Z':
        list.sort((a, b) => a.name.compareTo(b.name));
        break;
      case 'Featured':
      default:
        // leave in original order
        break;
    }

    return list;
  }

  int get _totalProducts => _filteredAndSorted.length;

  int get _totalPages {
    if (_totalProducts == 0) return 1;
    return ((_totalProducts - 1) / _pageSize).floor() + 1;
  }

  List<Product> get _pageItems {
    final list = _filteredAndSorted;
    if (list.isEmpty) return const <Product>[];

    final start = _currentPage * _pageSize;
    final end = min(start + _pageSize, list.length);
    if (start >= list.length) return const <Product>[];

    return list.sublist(start, end);
  }

  // ---- handlers ----

  void _onFilterChanged(String? value) {
    if (value == null) return;
    setState(() {
      _selectedFilter = value;
      _currentPage = 0; // reset page when filter changes
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
                  // Heading (matches your screenshot text)
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
                            items: const [
                              'Featured',
                              'Price: Low to High',
                              'Price: High to Low',
                              'Alphabetical A–Z',
                            ]
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

                      final countText = Text('$_totalProducts products');

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

                  // PRODUCTS GRID (still using your existing card layout)
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
                      final viewModel = CollectionProduct(
                        name: product.name,
                        price: '£${product.price.toStringAsFixed(2)}',
                        imageUrl: product.mainImage,
                      );
                      return _ProductCard(product: viewModel);
                    },
                  ),

                  const SizedBox(height: 16),

                  // PAGINATION
                  if (_totalProducts > _pageSize)
                    Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            key: const Key('collection_prev_page'),
                            onPressed: _currentPage == 0
                                ? null
                                : _goToPreviousPage,
                            icon: const Icon(Icons.chevron_left),
                          ),
                          Text('Page ${_currentPage + 1} of $_totalPages'),
                          IconButton(
                            key: const Key('collection_next_page'),
                            onPressed: _currentPage >= _totalPages - 1
                                ? null
                                : _goToNextPage,
                            icon: const Icon(Icons.chevron_right),
                          ),
                        ],
                      ),
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
                // Avoid test crashes when HTTP fails in flutter test.
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
