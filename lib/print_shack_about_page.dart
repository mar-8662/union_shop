import 'package:flutter/material.dart';
import 'package:union_shop/data/product_data.dart';
import 'package:union_shop/footer.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/widgets/responsive_navbar.dart';

class PrintShackAboutPage extends StatelessWidget {
  const PrintShackAboutPage({super.key});

  List<Product> get _printShackProducts =>
      dummyProducts.where((p) => p.collection == 'Print Shack').toList();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final printShackItems = _printShackProducts;
    final size = MediaQuery.of(context).size;
    final bool isNarrow = size.width < 600;

    return Scaffold(
      appBar: const ResponsiveNavbar(),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isNarrow ? 16 : 24,
                  vertical: 32,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: Text(
                        'The Union Print Shack',
                        style: theme.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Simple 3-panel hero
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final isWide = constraints.maxWidth >= 800;
                        final panels = [
                          const _HeroPanel(label: 'Front print examples'),
                          const _HeroPanel(
                            label: 'The Union Print Shack',
                            emphasise: true,
                          ),
                          const _HeroPanel(label: 'Back print examples'),
                        ];

                        if (isWide) {
                          return Row(
                            children: [
                              Expanded(child: panels[0]),
                              const SizedBox(width: 12),
                              Expanded(child: panels[1]),
                              const SizedBox(width: 12),
                              Expanded(child: panels[2]),
                            ],
                          );
                        }

                        return Column(
                          children: [
                            panels[0],
                            const SizedBox(height: 12),
                            panels[1],
                            const SizedBox(height: 12),
                            panels[2],
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 24),

                    // Text sections
                    Text(
                      'Make it yours at The Union Print Shack',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Want to add a personal touch? Our Print Shack team can '
                      'add heat-pressed customisation on most of our clothing. '
                      'Drop in to choose the right garment and get help with your design.',
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Uni gear or your gear – we’ll personalise it',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Bring your own hoodie or pick something from the Union Shop. '
                      'We can add names, society titles or simple text designs '
                      'on the back or front.',
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Simple pricing, no surprises',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Text personalisation starts at £3 for one line, £5 for two. '
                      'We’ll let you know the full cost before you commit.',
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Personalisation terms & conditions',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'We print exactly what you provide, so please double-check spellings '
                      'and capital letters. Personalised items are non-refundable unless '
                      'there is a fault with the garment or print.',
                    ),
                    const SizedBox(height: 24),

                    // Use some of the existing 30 products (the Print Shack ones)
                    if (printShackItems.isNotEmpty) ...[
                      Text(
                        'Popular Print Shack products',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 16,
                        runSpacing: 16,
                        children: printShackItems
                            .map((p) => _PrintShackProductCard(product: p))
                            .toList(),
                      ),
                    ],
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

class _HeroPanel extends StatelessWidget {
  final String label;
  final bool emphasise;

  const _HeroPanel({required this.label, this.emphasise = false});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 4 / 3,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: emphasise ? const Color(0xFF4d2963) : Colors.grey[200],
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: emphasise ? Colors.white : Colors.grey[800],
                fontWeight: emphasise ? FontWeight.w600 : FontWeight.w400,
              ),
        ),
      ),
    );
  }
}

class _PrintShackProductCard extends StatelessWidget {
  final Product product;

  const _PrintShackProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: 240,
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.name,
                style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                '£${product.price.toStringAsFixed(2)}',
                style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[700],
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
