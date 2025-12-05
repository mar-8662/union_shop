import 'package:flutter/material.dart';
import 'package:union_shop/data/product_data.dart';
import 'package:union_shop/footer.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/product_page.dart';
import 'package:union_shop/widgets/responsive_navbar.dart';

class SaleProduct {
  final Product product;
  final double salePrice;
  final String? statusLabel; // e.g. "Sold out" or "Online only"

  SaleProduct({
    required this.product,
    required this.salePrice,
    this.statusLabel,
  });

  double get originalPrice => product.price;
}

// Re-use products from product_data.dart
final List<SaleProduct> saleProducts = [
  // p1 – Classic Sweatshirt - Black
  SaleProduct(
    product: dummyProducts[0],
    salePrice: 19.00,
  ),
  // p22 – Union Notebook
  SaleProduct(
    product: dummyProducts[21],
    salePrice: 4.50,
  ),
  // p18 – Union Beanie
  SaleProduct(
    product: dummyProducts[17],
    salePrice: 8.00,
    statusLabel: 'Online only',
  ),
  // p23 – Union Mug
  SaleProduct(
    product: dummyProducts[22],
    salePrice: 5.50,
  ),
];

class SalePage extends StatelessWidget {
  const SalePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ResponsiveNavbar(),
      body: Column(
        children: [
          // Scrollable content
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 16),
                    Center(
                      child: Text(
                        'SALE',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                              letterSpacing: 4,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Center(
                      child: Text(
                        "Don't miss out! Get yours before they're all gone!",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Center(
                      child: Text(
                        'All prices shown are inclusive of the discount',
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(
                              color: Colors.grey[700],
                            ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    const _SaleFilterBar(),
                    const SizedBox(height: 24),
                    const _SaleGrid(),
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
}

class _SaleFilterBar extends StatelessWidget {
  const _SaleFilterBar();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 600;

        final filterRow = Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('FILTER BY', style: textTheme.bodySmall),
            const SizedBox(width: 8),
            DropdownButton<String>(
              value: 'All products',
              underline: const SizedBox.shrink(),
              items: const [
                DropdownMenuItem(
                  value: 'All products',
                  child: Text('All products'),
                ),
              ],
              onChanged: (_) {},
            ),
          ],
        );

        final sortRow = Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('SORT BY', style: textTheme.bodySmall),
            const SizedBox(width: 8),
            DropdownButton<String>(
              value: 'Best selling',
              underline: const SizedBox.shrink(),
              items: const [
                DropdownMenuItem(
                  value: 'Best selling',
                  child: Text('Best selling'),
                ),
              ],
              onChanged: (_) {},
            ),
          ],
        );

        final countText = Text(
          '${saleProducts.length} products',
          style: textTheme.bodySmall,
        );

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
        // Wide layout: use Wrap instead of Row to avoid overflow
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
      },
    );
  }
}

class _SaleGrid extends StatelessWidget {
  const _SaleGrid();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = 1;
        if (constraints.maxWidth >= 1000) {
          crossAxisCount = 3;
        } else if (constraints.maxWidth >= 700) {
          crossAxisCount = 2;
        }

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 24,
            mainAxisSpacing: 24,
            childAspectRatio: 0.75,
          ),
          itemCount: saleProducts.length,
          itemBuilder: (context, index) {
            final saleItem = saleProducts[index];
            return _SaleProductCard(saleProduct: saleItem);
          },
        );
      },
    );
  }
}

class _SaleProductCard extends StatelessWidget {
  final SaleProduct saleProduct;

  const _SaleProductCard({required this.saleProduct});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => ProductPage(product: saleProduct.product),
          ),
        );
      },
      child: Card(
        elevation: 0.5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image placeholder to avoid network calls in tests
              AspectRatio(
                aspectRatio: 4 / 3,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey[200],
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.image_outlined,
                    size: 40,
                    color: Colors.grey[500],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                saleProduct.product.name,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Text(
                    '£${saleProduct.originalPrice.toStringAsFixed(2)}',
                    style: theme.textTheme.bodySmall?.copyWith(
                      decoration: TextDecoration.lineThrough,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '£${saleProduct.salePrice.toStringAsFixed(2)}',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              if (saleProduct.statusLabel != null) ...[
                const SizedBox(height: 4),
                Text(
                  saleProduct.statusLabel!,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.red[700],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
