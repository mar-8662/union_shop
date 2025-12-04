import 'package:flutter/material.dart';
import 'package:union_shop/footer.dart';
import 'package:union_shop/models/product.dart';

class ProductPage extends StatefulWidget {
  final Product product;

  const ProductPage({super.key, required this.product});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late List<String> _imageUrls;
  int _selectedImageIndex = 0;

  String? _selectedColor;
  String? _selectedSize;
  int _quantity = 1;

  @override
  void initState() {
    super.initState();

    // Build the gallery from the product model.
    _imageUrls = [
      widget.product.mainImage,
      ...widget.product.galleryImages,
    ];

    // Make sure we have at least 4 tiles so the gallery strip looks full.
    while (_imageUrls.length < 4) {
      _imageUrls.add(widget.product.mainImage);
    }

    _selectedColor = widget.product.colours.isNotEmpty
        ? widget.product.colours.first
        : null;
    _selectedSize = widget.product.sizes.isNotEmpty
        ? widget.product.sizes.first
        : null;
  }

  @override
  Widget build(BuildContext context) {
    final bool isWide = MediaQuery.of(context).size.width >= 900;

    return Scaffold(
      appBar: AppBar(
        title: const Text('The Union'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              isWide
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: _buildImageGallery(context)),
                        const SizedBox(width: 32),
                        Expanded(child: _buildDetails(context)),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildImageGallery(context),
                        const SizedBox(height: 24),
                        _buildDetails(context),
                      ],
                    ),
              const SizedBox(height: 32),
              const Divider(),
              const SizedBox(height: 16),
              const Text(
                'Product description',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.product.description,
              ),
              const SizedBox(height: 16),
              const Text(
                'Soft, comfortable, 50% cotton and 50% polyester.',
              ),
              const SizedBox(height: 24),
              Wrap(
                spacing: 8,
                children: [
                  OutlinedButton(onPressed: () {}, child: const Text('SHARE')),
                  OutlinedButton(onPressed: () {}, child: const Text('TWEET')),
                  OutlinedButton(
                      onPressed: () {}, child: const Text('PIN IT')),
                ],
              ),
              const SizedBox(height: 24),
              TextButton.icon(
                onPressed: () {
                  Navigator.of(context).maybePop();
                },
                icon: const Icon(Icons.arrow_back),
                label: const Text('BACK TO AUTUMN FAVOURITES'),
              ),
              const SizedBox(height: 24),
              const UnionFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageGallery(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              _imageUrls[_selectedImageIndex],
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) =>
                  Container(color: Colors.grey.shade300),
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 90,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: _imageUrls.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final bool isSelected = index == _selectedImageIndex;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedImageIndex = index;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      width: 2,
                      color: isSelected
                          ? Theme.of(context).colorScheme.primary
                          : Colors.grey.shade300,
                    ),
                  ),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(2),
                      child: Image.network(
                        _imageUrls[index],
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            Container(color: Colors.grey.shade300),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDetails(BuildContext context) {
    final product = widget.product;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.name,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '£${product.price.toStringAsFixed(2)}',
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Tax included.',
          style: TextStyle(color: Colors.grey.shade700),
        ),
        const SizedBox(height: 24),

        // Color / Size row – only show dropdowns if the product has values.
        Row(
          children: [
            if (product.colours.isNotEmpty && _selectedColor != null)
              Expanded(
                child: _buildDropdown(
                  label: 'Color',
                  value: _selectedColor!,
                  options: product.colours,
                  onChanged: (value) {
                    if (value == null) return;
                    setState(() => _selectedColor = value);
                  },
                ),
              ),
            if (product.colours.isNotEmpty && _selectedColor != null)
              const SizedBox(width: 16),
            if (product.sizes.isNotEmpty && _selectedSize != null)
              Expanded(
                child: _buildDropdown(
                  label: 'Size',
                  value: _selectedSize!,
                  options: product.sizes,
                  onChanged: (value) {
                    if (value == null) return;
                    setState(() => _selectedSize = value);
                  },
                ),
              ),
          ],
        ),
        const SizedBox(height: 16),
        _buildQuantitySelector(context),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {},
            child: const Text('ADD TO CART'),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {},
            child: const Text('Buy with Shop'),
          ),
        ),
        const SizedBox(height: 8),
        TextButton(
          onPressed: () {},
          child: const Text('More payment options'),
        ),
      ],
    );
  }

  Widget _buildDropdown({
    required String label,
    required String value,
    required List<String> options,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 4),
        DropdownButtonFormField<String>(
          value: value,
          items: options
              .map(
                (option) => DropdownMenuItem<String>(
                  value: option,
                  child: Text(option),
                ),
              )
              .toList(),
          onChanged: onChanged,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          ),
        ),
      ],
    );
  }

  Widget _buildQuantitySelector(BuildContext context) {
    return Row(
      children: [
        const Text('Quantity'),
        const SizedBox(width: 16),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade400),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                key: const Key('quantity_decrease'),
                onPressed: () {
                  setState(() {
                    if (_quantity > 1) _quantity--;
                  });
                },
                icon: const Icon(Icons.remove),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                child: Text(
                  '$_quantity',
                  key: const Key('quantity_value'),
                ),
              ),
              IconButton(
                key: const Key('quantity_increase'),
                onPressed: () {
                  setState(() => _quantity++);
                },
                icon: const Icon(Icons.add),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
