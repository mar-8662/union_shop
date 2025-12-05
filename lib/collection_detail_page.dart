import 'package:flutter/material.dart';
import 'package:union_shop/data/product_data.dart';
import 'package:union_shop/footer.dart';
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
  String _selectedFilter = 'All products';
  String _selectedSort = 'Featured';

  late final List<Product> _allProducts;

  @override
  void initState() {
    super.initState();
    _allProducts = productsForCollection(widget.collectionTitle);
  }

  List<Product> get _visibleProducts {
    final products = List<Product>.from(_allProducts);

    if (_selectedFilter != 'All products') {
    }

    switch (_selectedSort) {
      case 'A-Z':
        products.sort((a, b) => a.name.compareTo(b.name));
        break;
      case 'Z-A':
        products.sort((a, b) => b.name.compareTo(a.name));
        break;
      case 'Featured':
      default:
        // Keep original order
        break;
    }

    return products;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    int crossAxisCount = 2;
    if (size.width >= 1100) {
      crossAxisCount = 4;
    } else if (size.width >= 800) {
      crossAxisCount = 3;
    } else if (size.width < 500) {
      crossAxisCount = 1;
    }

    return Scaffold(
      appBar: const ResponsiveNavbar(),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: Text(
                        widget.collectionTitle,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Center(
                      child: Text(
                        'Shop all of this seasons must haves in one place!',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildFilterBar(context),
                    const SizedBox(height: 16),
                    GridView.builder(
                      key: const ValueKey('collection-products-grid'),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _visibleProducts.length,
                      gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        childAspectRatio: 0.7,
                      ),
                      itemBuilder: (context, index) {
                        final product = _visibleProducts[index];
                        return _CollectionProductCard(product: product);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          const UnionFooter(),
        ],
      ),
    );
  }

  Widget _buildFilterBar(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 600;

        final filterRow = Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Filter by', style: textTheme.bodySmall),
            const SizedBox(width: 8),
            DropdownButton<String>(
              value: _selectedFilter,
              underline: const SizedBox.shrink(),
              items: const [
                DropdownMenuItem(
                  value: 'All products',
                  child: Text('All products'),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedFilter = value ?? 'All products';
                });
              },
            ),
          ],
        );

        final sortRow = Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Sort by', style: textTheme.bodySmall),
            const SizedBox(width: 8),
            DropdownButton<String>(
              value: _selectedSort,
              underline: const SizedBox.shrink(),
              items: const [
                DropdownMenuItem(
                  value: 'Featured',
                  child: Text('Featured'),
                ),
                DropdownMenuItem(
                  value: 'A-Z',
                  child: Text('A-Z'),
                ),
                DropdownMenuItem(
                  value: 'Z-A',
                  child: Text('Z-A'),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedSort = value ?? 'Featured';
                });
              },
            ),
          ],
        );

        if (isNarrow) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              filterRow,
              const SizedBox(height: 8),
              sortRow,
            ],
          );
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            filterRow,
            sortRow,
          ],
        );
      },
    );
  }
}

class _CollectionProductCard extends StatelessWidget {
  final Product product;

  const _CollectionProductCard({required this.product});

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
                product.mainImage,
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
                  Text('£${product.price.toStringAsFixed(2)}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
