// lib/personalisation_page.dart
import 'package:flutter/material.dart';
import 'package:union_shop/footer.dart';
import 'package:union_shop/models/cart_model.dart';
import 'package:union_shop/models/collection_product.dart';
import 'package:union_shop/widgets/responsive_navbar.dart';

enum _PersonalisationLines { one, two }

class PersonalisationPage extends StatefulWidget {
  const PersonalisationPage({super.key});

  @override
  State<PersonalisationPage> createState() => _PersonalisationPageState();
}

class _PersonalisationPageState extends State<PersonalisationPage> {
  static const int _maxCharsPerLine = 10;

  _PersonalisationLines _selectedLines = _PersonalisationLines.one;
  int _quantity = 1;

  final TextEditingController _line1Controller = TextEditingController();
  final TextEditingController _line2Controller = TextEditingController();

  double get _basePrice =>
      _selectedLines == _PersonalisationLines.one ? 3.0 : 5.0;

  double get _estimatedTotal => _basePrice * _quantity;

  @override
  void dispose() {
    _line1Controller.dispose();
    _line2Controller.dispose();
    super.dispose();
  }

  void _changeQuantity(int delta) {
    setState(() {
      _quantity = (_quantity + delta).clamp(1, 99);
    });
  }

  void _addToCart(BuildContext context) {
    final linesLabel = _selectedLines == _PersonalisationLines.one
        ? 'One line of text'
        : 'Two lines of text';

    final product = CollectionProduct(
      name: 'Print Shack Personalisation',
      price: '£${_basePrice.toStringAsFixed(2)}',
      imageUrl:
          'https://picsum.photos/seed/union-printshack-personalisation/800/800',
    );

    cartModel.addItem(
      product,
      colour: 'Custom',
      size: linesLabel,
      quantity: _quantity,
    );

    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          content: Text(
            'Added $_quantity × Print Shack Personalisation to your cart.',
          ),
          action: SnackBarAction(
            label: 'VIEW CART',
            onPressed: () {
              Navigator.pushNamed(context, '/cart');
            },
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isWide = MediaQuery.of(context).size.width >= 900;

    return Scaffold(
      appBar: const ResponsiveNavbar(),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: Text(
                        'Personalisation',
                        style: theme.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Center(
                      child: Text(
                        '£${_basePrice.toStringAsFixed(2)}',
                        key: const Key('personalisation_price'),
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Center(
                      child: Text(
                        'Tax included.',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Two-column layout on wide screens, stacked on mobile
                    if (isWide)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: _buildPreview()),
                          const SizedBox(width: 32),
                          Expanded(child: _buildForm(theme)),
                        ],
                      )
                    else
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildPreview(),
                          const SizedBox(height: 24),
                          _buildForm(theme),
                        ],
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

  Widget _buildPreview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(
          aspectRatio: 3 / 4,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey[300],
            ),
            alignment: Alignment.center,
            child: const Text(
              'YOUR NAME HERE',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 80,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.grey[200],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.grey[200],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.grey[200],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildForm(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Per line',
          style: theme.textTheme.bodyMedium,
        ),
        const SizedBox(height: 4),
        DropdownButtonFormField<_PersonalisationLines>(
          key: const Key('personalisation_line_dropdown'),
          value: _selectedLines,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          ),
          items: const [
            DropdownMenuItem(
              value: _PersonalisationLines.one,
              child: Text('One line of text'),
            ),
            DropdownMenuItem(
              value: _PersonalisationLines.two,
              child: Text('Two lines of text'),
            ),
          ],
          onChanged: (value) {
            if (value == null) return;
            setState(() {
              _selectedLines = value;
            });
          },
        ),
        const SizedBox(height: 16),

        // Line 1
        Text('Personalisation line 1'),
        const SizedBox(height: 4),
        TextField(
          key: const Key('personalisation_line1_field'),
          controller: _line1Controller,
          maxLength: _maxCharsPerLine,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter up to 10 characters',
          ),
        ),
        const SizedBox(height: 8),

        // Line 2 appears only when "two lines" is selected
        if (_selectedLines == _PersonalisationLines.two) ...[
          Text('Personalisation line 2'),
          const SizedBox(height: 4),
          TextField(
            key: const Key('personalisation_line2_field'),
            controller: _line2Controller,
            maxLength: _maxCharsPerLine,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Second line (optional)',
            ),
          ),
          const SizedBox(height: 8),
        ],

        // Quantity selector
        _buildQuantitySelector(),
        const SizedBox(height: 16),

        // Dynamic total
        Text(
          'Estimated total: £${_estimatedTotal.toStringAsFixed(2)}',
          key: const Key('personalisation_total'),
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '£3 for one line of text, £5 for two lines.',
          style: theme.textTheme.bodySmall,
        ),
        const SizedBox(height: 4),
        Text(
          'One line of text is $_maxCharsPerLine characters.',
          style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey[700]),
        ),
        const SizedBox(height: 24),

        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            key: const Key('personalisation_add_to_cart'),
            onPressed: () => _addToCart(context),
            child: const Text('ADD TO CART'),
          ),
        ),
      ],
    );
  }

  Widget _buildQuantitySelector() {
    return Row(
      children: [
        const Text('Quantity'),
        const SizedBox(width: 16),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                key: const Key('personalisation_qty_decrease'),
                onPressed: () => _changeQuantity(-1),
                icon: const Icon(Icons.remove),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                child: Text(
                  '$_quantity',
                  key: const Key('personalisation_qty_value'),
                ),
              ),
              IconButton(
                key: const Key('personalisation_qty_increase'),
                onPressed: () => _changeQuantity(1),
                icon: const Icon(Icons.add),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
