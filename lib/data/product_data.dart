import 'package:union_shop/models/product.dart';

// Using picsum
const String _sweatImage1 = 'https://picsum.photos/seed/union-sweat-1/800/800';
const String _sweatImage2 = 'https://picsum.photos/seed/union-sweat-2/800/800';
const String _hoodieImage1 = 'https://picsum.photos/seed/union-hoodie-1/800/800';
const String _hoodieImage2 = 'https://picsum.photos/seed/union-hoodie-2/800/800';

const String _teeImage1 = 'https://picsum.photos/seed/union-tee-1/800/800';
const String _teeImage2 = 'https://picsum.photos/seed/union-tee-2/800/800';

const String _jacketImage1 = 'https://picsum.photos/seed/union-jacket-1/800/800';
const String _jacketImage2 = 'https://picsum.photos/seed/union-jacket-2/800/800';

const String _accessoryImage1 =
    'https://picsum.photos/seed/union-accessory-1/800/800';
const String _accessoryImage2 =
    'https://picsum.photos/seed/union-accessory-2/800/800';

const List<Product> dummyProducts = [
  // 1–4: Classic Sweatshirts
  Product(
    id: 'p1',
    name: 'Classic Sweatshirt - Black',
    description:
        'Our best selling Classic Sweatshirt in black. Soft, comfortable and perfect for lectures or nights out.',
    price: 23.00,
    mainImage: _sweatImage1,
    galleryImages: [_sweatImage1, _sweatImage2, _hoodieImage1, _teeImage1],
    colours: ['Black', 'Green', 'Purple', 'Grey'],
    sizes: ['S', 'M', 'L', 'XL'],
    collection: 'Hoodies & Sweatshirts',
  ),
  Product(
    id: 'p2',
    name: 'Classic Sweatshirt - Green',
    description:
        'Classic Sweatshirt in green with front Union logo print. 50% cotton, 50% polyester.',
    price: 23.00,
    mainImage: _sweatImage2,
    galleryImages: [_sweatImage2, _sweatImage1, _hoodieImage1, _teeImage1],
    colours: ['Green', 'Black', 'Grey'],
    sizes: ['S', 'M', 'L', 'XL'],
    collection: 'Hoodies & Sweatshirts',
  ),
  Product(
    id: 'p3',
    name: 'Classic Sweatshirt - Purple',
    description:
        'Classic Sweatshirt in Union purple – show your Portsmouth pride on campus.',
    price: 23.00,
    mainImage: _sweatImage1,
    galleryImages: [_sweatImage1, _sweatImage2],
    colours: ['Purple', 'Black', 'Grey'],
    sizes: ['S', 'M', 'L', 'XL'],
    collection: 'Hoodies & Sweatshirts',
  ),
  Product(
    id: 'p4',
    name: 'Classic Sweatshirt - Grey',
    description:
        'Classic Sweatshirt in grey with chest print. A cosy everyday essential.',
    price: 23.00,
    mainImage: _sweatImage2,
    galleryImages: [_sweatImage2, _sweatImage1],
    colours: ['Grey', 'Black'],
    sizes: ['S', 'M', 'L', 'XL'],
    collection: 'Hoodies & Sweatshirts',
  ),

  // 5–8: Hoodies
  Product(
    id: 'p5',
    name: 'Campus Hoodie - Navy',
    description:
        'Navy campus hoodie with bold Portsmouth print. Brushed inside for comfort.',
    price: 28.00,
    mainImage: _hoodieImage1,
    galleryImages: [_hoodieImage1, _hoodieImage2, _sweatImage1],
    colours: ['Navy', 'Black', 'Grey'],
    sizes: ['S', 'M', 'L', 'XL', 'XXL'],
    collection: 'Hoodies & Sweatshirts',
  ),
  Product(
    id: 'p6',
    name: 'Campus Hoodie - Grey',
    description: 'Grey campus hoodie with kangaroo pocket and drawstring hood.',
    price: 28.00,
    mainImage: _hoodieImage2,
    galleryImages: [_hoodieImage2, _hoodieImage1],
    colours: ['Grey', 'Black'],
    sizes: ['S', 'M', 'L', 'XL'],
    collection: 'Hoodies & Sweatshirts',
  ),
  Product(
    id: 'p7',
    name: 'Varsity Hoodie - Purple',
    description:
        'Varsity-style hoodie in signature Union purple with contrast details.',
    price: 30.00,
    mainImage: _hoodieImage1,
    galleryImages: [_hoodieImage1, _hoodieImage2],
    colours: ['Purple', 'Black', 'Grey'],
    sizes: ['XS', 'S', 'M', 'L', 'XL'],
    collection: 'Hoodies & Sweatshirts',
  ),
  Product(
    id: 'p8',
    name: 'Portsmouth Zip Hoodie',
    description: 'Full zip hoodie with subtle Portsmouth chest embroidery.',
    price: 32.00,
    mainImage: _hoodieImage2,
    galleryImages: [_hoodieImage2, _hoodieImage1],
    colours: ['Black', 'Navy'],
    sizes: ['S', 'M', 'L', 'XL'],
    collection: 'Hoodies & Sweatshirts',
  ),

  // 9–14: T-Shirts
  Product(
    id: 'p9',
    name: 'Portsmouth Crest T-Shirt - White',
    description:
        'White tee with printed Portsmouth crest. Lightweight and breathable.',
    price: 15.00,
    mainImage: _teeImage1,
    galleryImages: [_teeImage1, _teeImage2],
    colours: ['White'],
    sizes: ['XS', 'S', 'M', 'L', 'XL'],
    collection: 'T-Shirts',
  ),
  Product(
    id: 'p10',
    name: 'Portsmouth Crest T-Shirt - Black',
    description: 'Black tee with printed Portsmouth crest on chest.',
    price: 15.00,
    mainImage: _teeImage2,
    galleryImages: [_teeImage2, _teeImage1],
    colours: ['Black'],
    sizes: ['XS', 'S', 'M', 'L', 'XL'],
    collection: 'T-Shirts',
  ),
  Product(
    id: 'p11',
    name: 'Portsmouth Crest T-Shirt - Purple',
    description: 'Union purple tee with contrasting white crest print.',
    price: 16.00,
    mainImage: _teeImage1,
    galleryImages: [_teeImage1],
    colours: ['Purple'],
    sizes: ['XS', 'S', 'M', 'L', 'XL'],
    collection: 'T-Shirts',
  ),
  Product(
    id: 'p12',
    name: 'Freshers T-Shirt 2024',
    description:
        'Limited edition Freshers 2024 tee. Perfect souvenir of your first term.',
    price: 18.00,
    mainImage: _teeImage2,
    galleryImages: [_teeImage2],
    colours: ['Black', 'White'],
    sizes: ['S', 'M', 'L', 'XL'],
    collection: 'T-Shirts',
  ),
  Product(
    id: 'p13',
    name: 'Union Logo T-Shirt - Oversized',
    description:
        'Oversized tee with large Union logo print. Relaxed fit for everyday wear.',
    price: 20.00,
    mainImage: _teeImage1,
    galleryImages: [_teeImage1],
    colours: ['White', 'Black'],
    sizes: ['S', 'M', 'L', 'XL'],
    collection: 'T-Shirts',
  ),
  Product(
    id: 'p14',
    name: 'Raglan Long Sleeve Tee',
    description: 'Baseball-style raglan tee with contrast sleeves.',
    price: 22.00,
    mainImage: _teeImage2,
    galleryImages: [_teeImage2],
    colours: ['White/Black'],
    sizes: ['S', 'M', 'L', 'XL'],
    collection: 'T-Shirts',
  ),

  // 15–17: Outerwear
  Product(
    id: 'p15',
    name: 'Stadium Jacket',
    description: 'Lightweight stadium jacket with snap buttons and stripe trim.',
    price: 40.00,
    mainImage: _jacketImage1,
    galleryImages: [_jacketImage1, _jacketImage2],
    colours: ['Navy', 'Black'],
    sizes: ['S', 'M', 'L', 'XL'],
    collection: 'Outerwear',
  ),
  Product(
    id: 'p16',
    name: 'Coach Jacket',
    description:
        'Minimal coach jacket with embroidered logo. Great for layering.',
    price: 42.00,
    mainImage: _jacketImage2,
    galleryImages: [_jacketImage2],
    colours: ['Black'],
    sizes: ['S', 'M', 'L', 'XL'],
    collection: 'Outerwear',
  ),
  Product(
    id: 'p17',
    name: 'Puffer Gilet',
    description: 'Padded body warmer for chilly coastal evenings.',
    price: 45.00,
    mainImage: _jacketImage1,
    galleryImages: [_jacketImage1],
    colours: ['Black'],
    sizes: ['S', 'M', 'L', 'XL'],
    collection: 'Outerwear',
  ),

  // 18–26: Accessories
  Product(
    id: 'p18',
    name: 'Union Beanie',
    description: 'Ribbed knit beanie with woven Union label.',
    price: 10.00,
    mainImage: _accessoryImage1,
    galleryImages: [_accessoryImage1],
    colours: ['Black', 'Purple', 'Grey'],
    sizes: [],
    collection: 'Accessories',
  ),
  Product(
    id: 'p19',
    name: 'Union Cap',
    description: 'Curved-peak cap with embroidered logo.',
    price: 12.00,
    mainImage: _accessoryImage2,
    galleryImages: [_accessoryImage2],
    colours: ['Black', 'Navy'],
    sizes: [],
    collection: 'Accessories',
  ),
  Product(
    id: 'p20',
    name: 'Portsmouth Scarf',
    description:
        'Striped scarf in university colours. Ideal for away days and winter walks.',
    price: 14.00,
    mainImage: _accessoryImage1,
    galleryImages: [_accessoryImage1],
    colours: ['Purple/White'],
    sizes: [],
    collection: 'Accessories',
  ),
  Product(
    id: 'p21',
    name: 'Canvas Tote Bag',
    description: 'Heavy canvas tote bag with Union print on both sides.',
    price: 9.00,
    mainImage: _accessoryImage2,
    galleryImages: [_accessoryImage2],
    colours: ['Natural'],
    sizes: [],
    collection: 'Accessories',
  ),
  Product(
    id: 'p22',
    name: 'Union Notebook',
    description:
        'A5 lined notebook with debossed logo. Perfect for lecture notes.',
    price: 6.00,
    mainImage: _accessoryImage1,
    galleryImages: [_accessoryImage1],
    colours: ['Purple', 'Black'],
    sizes: [],
    collection: 'Accessories',
  ),
  Product(
    id: 'p23',
    name: 'Union Mug',
    description:
        'Ceramic mug with wraparound Portsmouth design. Dishwasher safe.',
    price: 7.50,
    mainImage: _accessoryImage2,
    galleryImages: [_accessoryImage2],
    colours: ['White'],
    sizes: [],
    collection: 'Accessories',
  ),
  Product(
    id: 'p24',
    name: 'Water Bottle - Purple',
    description: 'Reusable metal bottle in Union purple, 750ml.',
    price: 12.50,
    mainImage: _accessoryImage1,
    galleryImages: [_accessoryImage1],
    colours: ['Purple'],
    sizes: [],
    collection: 'Accessories',
  ),
  Product(
    id: 'p25',
    name: 'Lanyard',
    description:
        'Durable lanyard with safety breakaway and repeated Union branding.',
    price: 4.00,
    mainImage: _accessoryImage2,
    galleryImages: [_accessoryImage2],
    colours: ['Purple', 'Black'],
    sizes: [],
    collection: 'Accessories',
  ),
  Product(
    id: 'p26',
    name: 'Sticker Pack',
    description: 'Pack of 10 vinyl stickers featuring Union icons and logos.',
    price: 5.00,
    mainImage: _accessoryImage1,
    galleryImages: [_accessoryImage1],
    colours: [],
    sizes: [],
    collection: 'Accessories',
  ),

  // 27–29: Print Shack custom items
  Product(
    id: 'p27',
    name: 'Print Shack Custom Hoodie',
    description:
        'Design-your-own hoodie. Add custom text and choose from multiple colours.',
    price: 35.00,
    mainImage: _hoodieImage1,
    galleryImages: [_hoodieImage1, _hoodieImage2],
    colours: ['Black', 'Navy', 'Grey', 'Purple'],
    sizes: ['S', 'M', 'L', 'XL'],
    collection: 'Print Shack',
  ),
  Product(
    id: 'p28',
    name: 'Print Shack Custom Tee',
    description:
        'Upload your own artwork or text for a personalised tee printed on campus.',
    price: 22.00,
    mainImage: _teeImage1,
    galleryImages: [_teeImage1, _teeImage2],
    colours: ['White', 'Black'],
    sizes: ['S', 'M', 'L', 'XL'],
    collection: 'Print Shack',
  ),
  Product(
    id: 'p29',
    name: 'Print Shack Custom Tote',
    description: 'Customisable tote bag – perfect for societies and events.',
    price: 16.00,
    mainImage: _accessoryImage2,
    galleryImages: [_accessoryImage2],
    colours: ['Natural'],
    sizes: [],
    collection: 'Print Shack',
  ),

  // 30: Graduation
  Product(
    id: 'p30',
    name: 'Graduation Hoodie 2025',
    description:
        'Limited edition graduation hoodie featuring all course names on the back.',
    price: 38.00,
    mainImage: _hoodieImage2,
    galleryImages: [_hoodieImage2, _hoodieImage1],
    colours: ['Black', 'Navy', 'Purple'],
    sizes: ['S', 'M', 'L', 'XL', 'XXL'],
    collection: 'Hoodies & Sweatshirts',
  ),
];

// Map collection titles (as used on the Collections pages) to Product IDs
const Map<String, List<String>> productIdsByCollection = {
  'Autumn Favourites': ['p1', 'p5', 'p9', 'p18', 'p21'],
  'Black Friday': ['p5', 'p6', 'p9', 'p12'],
  'Clothing': [
    'p1',
    'p2',
    'p3',
    'p4',
    'p5',
    'p6',
    'p7',
    'p8',
    'p9',
    'p10',
    'p11',
    'p12',
    'p13',
    'p14',
    'p15',
    'p16',
    'p17',
    'p27',
    'p28',
    'p29',
    'p30',
  ],
  'Clothing - Original': ['p1', 'p2', 'p5', 'p9', 'p15'],
  'Elections Discounts': ['p5', 'p18', 'p19', 'p21'],
  'Essential Range': ['p1', 'p2', 'p5', 'p9', 'p18', 'p21', 'p22', 'p24', 'p25'],
};

/// Helper used by collection pages to get the real Product objects.
List<Product> productsForCollection(String collectionTitle) {
  final ids = productIdsByCollection[collectionTitle];
  if (ids == null) {
    return const <Product>[];
  }

  return dummyProducts
      .where((product) => ids.contains(product.id))
      .toList(growable: false);
}
