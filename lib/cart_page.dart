// lib/cart_page.dart
import 'package:flutter/material.dart';
import 'package:union_shop/footer.dart';
import 'package:union_shop/models/cart_model.dart';
import 'package:union_shop/widgets/responsive_navbar.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  void _goHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ResponsiveNavbar(),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                child: AnimatedBuilder(
                  animation: cartModel,
                  builder: (context, _) {
                    if (cartModel.isEmpty) {
                      return _EmptyCart(
                        onContinueShopping: () => _goHome(context),
                      );
                    }
                    return _FilledCart(
                      onContinueShopping: () => _goHome(context),
                    );
                  },
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

class _EmptyCart extends StatelessWidget {
  final VoidCallback onContinueShopping;

  const _EmptyCart({required this.onContinueShopping});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      key: const Key('cart_empty_state'),
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 32),
        Text(
          'Your cart',
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        const Text(
          'Your cart is currently empty.',
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        ElevatedButton(
          key: const Key('cart_continue_shopping'),
          onPressed: onContinueShopping,
          child: const Text('CONTINUE SHOPPING'),
        ),
      ],
    );
  }
}

class _FilledCart extends StatelessWidget {
  final VoidCallback onContinueShopping;

  const _FilledCart({required this.onContinueShopping});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final List<CartItem> items = cartModel.items;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
          child: Text(
            'Your cart',
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Center(
          child: TextButton(
            onPressed: onContinueShopping,
            child: const Text('Continue shopping'),
          ),
        ),
        const SizedBox(height: 24),

        // Header row
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.black12),
            ),
          ),
          child: Row(
            children: const [
              Expanded(
                flex: 4,
                child: Text(
                  'Product',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  'Price',
                  textAlign: TextAlign.right,
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  'Quantity',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  'Total',
                  textAlign: TextAlign.right,
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),

        // Items
        Column(
          key: const Key('cart_items_list'),
          children: List.generate(
            items.length,
            (index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: _CartItemRow(
                item: items[index],
                index: index,
              ),
            ),
          ),
        ),

        const SizedBox(height: 8),
        const Divider(),
        const SizedBox(height: 16),

        // Note to order
        const Text('Add a note to your order'),
        const SizedBox(height: 8),
        SizedBox(
          height: 80,
          child: TextField(
            maxLines: null,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
        ),
        const SizedBox(height: 24),

        // Subtotal + buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Subtotal: £${cartModel.subtotal.toStringAsFixed(2)}',
                  key: const Key('cart_subtotal'),
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Tax included and shipping calculated at checkout',
                  style: theme.textTheme.bodySmall,
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Cart updated')),
                        );
                      },
                      child: const Text('UPDATE'),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Order placed (demo only)'),
                          ),
                        );
                        cartModel.clear();
                      },
                      child: const Text('CHECK OUT'),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class _CartItemRow extends StatelessWidget {
  final CartItem item;
  final int index;

  const _CartItemRow({
    required this.item,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Product section (image + info)
        Expanded(
          flex: 4,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 80,
                height: 80,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Image.network(
                    item.product.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: Colors.grey[300],
                      child: const Icon(Icons.image_not_supported),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.product.name,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text('Color: ${item.colour}'),
                    Text('Size: ${item.size}'),
                    const SizedBox(height: 4),
                    TextButton(
                      onPressed: () => cartModel.removeItem(item),
                      child: const Text('Remove'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Price
        Expanded(
          flex: 1,
          child: Align(
            alignment: Alignment.centerRight,
            child: Text('Price: £${item.unitPrice.toStringAsFixed(2)}'),
          ),
        ),

        // Quantity dropdown
        Expanded(
          flex: 1,
          child: Center(
            child: DropdownButton<int>(
              key: ValueKey('cart_item_qty_$index'),
              value: item.quantity,
              underline: const SizedBox.shrink(),
              items: const [1, 2, 3, 4, 5]
                  .map(
                    (q) => DropdownMenuItem<int>(
                      value: q,
                      child: Text('$q'),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                if (value == null) return;
                cartModel.updateQuantity(item, value);
              },
            ),
          ),
        ),

        // Total
        Expanded(
          flex: 1,
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              'Total: £${item.totalPrice.toStringAsFixed(2)}',
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
