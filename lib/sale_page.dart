import 'package:flutter/material.dart';
import 'package:union_shop/footer.dart';

class SaleProduct {
  final String name;
  final double originalPrice;
  final double salePrice;
  final String? statusLabel; // e.g. "Sold out" or "Online only"

  const SaleProduct({
    required this.name,
    required this.originalPrice,
    required this.salePrice,
    this.statusLabel,
  });
}

const List<SaleProduct> saleProducts = [
  // Use some of the products we already created in other pages
  SaleProduct(
    name: 'Classic Sweatshirts - Neutral',
    originalPrice: 17.00,
    salePrice: 10.99,
  ),
  SaleProduct(
    name: 'Recycled Notebook',
    originalPrice: 2.20,
    salePrice: 1.80,
  ),
  SaleProduct(
    name: 'Portsmouth City Postcard',
    originalPrice: 1.00,
    salePrice: 0.50,
  ),
  SaleProduct(
    name: 'A5 Notepad',
    originalPrice: 4.00,
    salePrice: 2.50,
    statusLabel: 'Sold out',
  ),
  SaleProduct(
    name: 'UoP Branded Earbuds (Blue)',
    originalPrice: 5.00,
    salePrice: 3.50,
  ),
  SaleProduct(
    name: 'UoP Branded Earbuds (Red)',
    originalPrice: 5.00,
    salePrice: 3.50,
  ),
];

class SalePage extends StatelessWidget {
  const SalePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Scrollable content
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 16),
                    Center(
                      child: Text(
                        'SALE',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
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
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.grey[700],
                            ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    const _SaleFilterBar(),
                    const SizedBox(height: 24),
                    _SaleGrid(),
                  ],
                ),
              ),
            ),
          ),

          // Re-use your existing footer to keep layout consistent
          const Footer(),
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

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            final product = saleProducts[index];
            return _SaleProductCard(product: product);
          },
        );
      },
    );
  }
}

class _SaleProductCard extends StatelessWidget {
  final SaleProduct product;

  const _SaleProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
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
              product.name,
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
                  '£${product.originalPrice.toStringAsFixed(2)}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    decoration: TextDecoration.lineThrough,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '£${product.salePrice.toStringAsFixed(2)}',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            if (product.statusLabel != null) ...[
              const SizedBox(height: 4),
              Text(
                product.statusLabel!,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.red[700],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
