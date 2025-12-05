import 'package:flutter/material.dart';
import 'package:union_shop/data/product_data.dart';
import 'package:union_shop/footer.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/product_page.dart';
import 'package:union_shop/widgets/responsive_navbar.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();
  String _query = '';
  List<Product> _results = const <Product>[];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _runSearch() {
    final raw = _controller.text.trim();
    final q = raw.toLowerCase();

    setState(() {
      _query = raw;
      if (q.isEmpty) {
        _results = const <Product>[];
      } else {
        _results = dummyProducts
            .where(
              (p) =>
                  p.name.toLowerCase().contains(q) ||
                  p.description.toLowerCase().contains(q),
            )
            .toList(growable: false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool isNarrow = size.width < 600;

    return Scaffold(
      appBar: const ResponsiveNavbar(),
      body: Column(
        children: [
          // Scrollable content
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isNarrow ? 16 : 24,
                  vertical: 32,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 8),
                    Text(
                      'SEARCH OUR SITE',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(
                            letterSpacing: 3,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 24),
                    Center(
                      child: ConstrainedBox(
                        constraints:
                            const BoxConstraints(maxWidth: 600),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                key: const Key('search_text_field'),
                                controller: _controller,
                                decoration: const InputDecoration(
                                  labelText: 'Search',
                                  border: OutlineInputBorder(),
                                ),
                                onSubmitted: (_) => _runSearch(),
                              ),
                            ),
                            const SizedBox(width: 8),
                            SizedBox(
                              height: 48,
                              child: ElevatedButton(
                                key: const Key('search_submit_button'),
                                onPressed: _runSearch,
                                child: const Text('SUBMIT'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: _buildResultSummary(context),
                    ),
                    const SizedBox(height: 16),
                    _buildResultsList(context),
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

  Widget _buildResultSummary(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    if (_query.isEmpty) {
      return Text(
        'Use the search box above to find products.',
        style: textTheme.bodyMedium?.copyWith(
          color: Colors.grey[700],
        ),
      );
    }

    if (_results.isEmpty) {
      return Text(
        'No products found for "$_query".',
        style: textTheme.bodyMedium?.copyWith(
          color: Colors.grey[700],
        ),
      );
    }

    return Text(
      '${_results.length} products found for "$_query".',
      style: textTheme.bodyMedium,
    );
  }

  Widget _buildResultsList(BuildContext context) {
    if (_results.isEmpty) {
      return const SizedBox.shrink();
    }

    return ListView.builder(
      key: const ValueKey('search_results_list'),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _results.length,
      itemBuilder: (context, index) {
        final product = _results[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            title: Text(product.name),
            subtitle: Text(
              '£${product.price.toStringAsFixed(2)} • ${product.collection}',
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ProductPage(product: product),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
