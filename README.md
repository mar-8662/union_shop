# Union Shop – Coursework Flutter Application

A responsive e-commerce style web/app built in Flutter for the **University of Portsmouth Students’ Union (The Union)**.  
The app simulates the official merchandise shop and demonstrates:

- Full navigation with a responsive top navbar and footer links  
- Dynamic collections driven by a shared product data model  
- Product detail pages with image galleries and cart integration  
- A functional cart with quantity editing and price calculations  
- The Print Shack “Personalisation” flow and about page  
- A simple search page and sign-in UI  
- Comprehensive widget tests for key screens and flows  

---

## 1. Project Title and Description

**Title:** Union Shop – Flutter Coursework Project  

**Brief description**

This project recreates a simplified version of The Union’s online shop using Flutter.  
It focuses on:

- **UX & UI:** Matching the look and feel of the existing site as closely as practical  
- **Navigation:** Users can move between Home, Collections, Sale, Print Shack, Search, Cart, and Sign-in  
- **Responsiveness:** Layout adapts between desktop and mobile breakpoints  
- **State & Logic:** Cart management, product filtering/sorting, and personalised items  
- **Testing:** Widget tests to automatically verify core requirements

**Key features**

- Home page with hero banner and featured products  
- Collections grid built dynamically from shared `product_data.dart`  
- Collection detail pages with filters, sorting, and pagination  
- Product detail page with image gallery, colour/size selection, quantity selector, and add-to-cart  
- Cart page with editable quantities, per-item totals, and order subtotal  
- Print Shack:
  - “Personalisation” page (dynamic form and pricing)  
  - “The Union Print Shack” about/landing page  
- Search page with search bar (navbar & footer entry points)  
- Sign-in UI with shop login and simple product strip  
- Consistent footer reused across pages  
- Responsive navbar with desktop links and mobile bottom-sheet menu

---

## 2. Installation and Setup Instructions

### Prerequisites

- **Operating System:**  
  - Windows, macOS, or Linux
- **Flutter SDK:**  
  - Flutter 3.x (or later) – install from the official Flutter docs
- **Dart:**  
  - Included with Flutter
- **Tools:**  
  - Git  
  - An editor/IDE such as VS Code or Android Studio  
  - (Optional) Chrome for running Flutter Web

Confirm Flutter is installed:

```bash
flutter --version

Clone the repository:

git clone <your-repo-url> union_shop
cd union_shop

Install dependencies:

flutter  pub get

Run the project:

flutter run -d chrome

Running tests:

flutter test

## 3. Usage Instructions

### 3.1 Navigation Overview

- **Global responsive navbar (all pages)**
  - **Desktop (≥ 800px)**
    - Links: `Home`, `Collections`, `The Print Shack` (dropdown), `SALE!`, `About`, `Sign in`, `Cart`
    - Icon: search icon → opens `SearchPage`
  - **Mobile (< 800px)**
    - `AppBar` shows title, search icon, and menu button
    - Menu button opens a bottom-sheet menu with:
      - `Home`
      - `Collections`
      - `SALE!`
      - `About`
      - `Print Shack – Personalisation`
      - `Print Shack – About`
      - `Sign in`
      - `Cart`
      - `Search`

---

### 3.2 Main User Flows

#### Home (`HomeScreen`)

- Shows:
  - Top sale banner promoting the Essential Range
  - Hero banner with “Essential Range – Over 20% OFF!”
  - `Featured products` grid using `homeFeaturedProducts` from `main.dart`
- Behaviour:
  - Tapping a featured product → opens `ProductPage` for that product

---

#### Collections (`CollectionsPage`)

- Collections grid built dynamically from:
  - `productIdsByCollection`
  - `dummyProducts` in `product_data.dart`
- **Filter bar**
  - Filter by category: `All collections`, `Seasonal`, `Sale`, `Clothing`, `Essentials`
  - Sort options: `A–Z`, `Z–A`
- Behaviour:
  - Tapping a collection tile (e.g. `Autumn Favourites`, `Essential Range`) → opens `CollectionDetailPage` for that collection

---

#### Collection Details (`CollectionDetailPage`)

- For a selected collection (e.g. `Clothing`), shows:
  - Collection title and subtitle
  - Filter dropdown (e.g. `All products`, `Hoodies & Sweatshirts`, `Accessories`)
  - Sort dropdown (`Featured`, `Price, low to high`, `Price, high to low`)
  - Products loaded via `productsForCollection(...)` from `product_data.dart`
  - Pagination with previous/next page buttons
- Behaviour:
  - Tapping a product card → opens `ProductPage` for that product

---

#### Product Page & Cart Flow (`ProductPage` + `CartModel`)

- Product view:
  - Large square image with thumbnail gallery
  - Product name, price, and “Tax included.” text
  - Dropdowns for `Colour` and `Size` (if defined for that product)
  - Quantity selector with `+ / –` buttons
- **ADD TO CART**:
  - Wraps `Product` as a `CollectionProduct`
  - Adds item to global `cartModel` with:
    - selected colour
    - selected size
    - selected quantity
  - Shows a `SnackBar` with “Added … to your cart” and `VIEW CART` action
- Extra UI:
  - `Buy with Shop` button (UI only)
  - `More payment options` link (UI only)
  - Social share buttons (Share / Tweet / Pin It)
  - `BACK TO AUTUMN FAVOURITES` text link

---

#### Cart (`CartPage`)

- Uses shared `CartModel` to render either:
- **Empty state**
  - Title: `Your cart`
  - Message: `Your cart is currently empty.`
  - Button: `CONTINUE SHOPPING` → returns to `HomeScreen`
- **Filled state**
  - Table-style layout with columns:
    - **Product**: image, name, colour, size, `Remove` link
    - **Price**: unit price
    - **Quantity**: dropdown (1–5)
    - **Total**: per-line total
  - Below items:
    - `Add a note to your order` text area
    - `Subtotal` label using `cartModel.subtotal`
    - Text: `Tax included and shipping calculated at checkout`
    - `UPDATE` button → shows “Cart updated” `SnackBar`
    - `CHECK OUT` button → shows “Order placed (demo only)` and clears cart
  - Quantity changes update line totals and subtotal immediately

---

#### Print Shack – Personalisation (`PersonalisationPage`)

- Configurable personalisation “product”:
  - Dropdown: `One line of text` / `Two lines of text`
  - Text fields for each line with character limit
  - Quantity selector
  - Dynamic `Estimated total`:
    - £3 for one line
    - £5 for two lines
    - multiplied by quantity
- **ADD TO CART**:
  - Creates a `CollectionProduct` named `Print Shack Personalisation`
  - Adds to `cartModel` with:
    - colour `"Custom"`
    - size = selected line option
  - Shows `SnackBar` with `VIEW CART` action
- Layout mirrors product-style page (preview on one side, form on the other)

---

#### Print Shack – About (`PrintShackAboutPage`)

- Static info/marketing page for the print service:
  - Three-panel hero row:
    - Front print examples
    - Main “The Union Print Shack” panel
    - Back print examples
  - Section headings (e.g. *Make it yours at The Union Print Shack*, *Simple pricing, no surprises*, *Personalisation terms & conditions*)
  - Supporting copy explaining:
    - what can be personalised
    - basic pricing
    - non-refundable terms
  - “Popular Print Shack products” section using Print Shack items from `dummyProducts`
    - e.g. `Print Shack Custom Hoodie`, `Print Shack Custom Tee`, `Print Shack Custom Tote`

---

#### Search (`SearchPage`)

- UI:
  - Heading: `SEARCH OUR SITE`
  - Search input field + `SUBMIT` button
  - Helper text when no query has been entered
- Behaviour:
  - Searches `dummyProducts` by:
    - product `name`
    - product `description`
  - Shows a list of matching products:
    - name + price + collection
    - tapping a result opens that product’s `ProductPage`

---

#### Sign In (`SignInPage`)

- Centered auth-style card:
  - `The UNION` wordmark
  - Heading: `Sign in to your shop account`
  - Primary `Sign in with shop` button (UI only)
  - Divider with “or”
  - Email `TextField`
  - Grey `Continue` button (UI only)
- Below the card:
  - `Popular union products` strip with simple product cards, e.g.:
    - `Portsmouth City Postcard`
    - `Union Hoodie`
    - `Union Stainless Steel Bottle`
- Footer reused from other pages for a consistent layout


4. Project Structure and Technologies Used
Folder structure (high-level)
lib/
  data/
    product_data.dart         # Shared dummy product catalogue
  models/
    product.dart              # Product model used on main pages
    collection_product.dart   # Simplified product model used in cart
    cart_model.dart           # CartModel + CartItem (ChangeNotifier)
  widgets/
    responsive_navbar.dart    # Shared responsive navbar (desktop/mobile)
  about_page.dart
  cart_page.dart
  collection_detail_page.dart
  collections_page.dart
  footer.dart
  main.dart                   # App entry, routes, HomeScreen
  personalisation_page.dart   # Print Shack personalisation flow
  print_shack_about_page.dart # Print Shack marketing/about page
  product_page.dart
  sale_page.dart
  search_page.dart
  sign_in_page.dart

test/
  about_test.dart
  cart_page_test.dart
  collection_detail_page_test.dart
  collections_page_test.dart
  home_test.dart
  navbar_test.dart
  personalisation_page_test.dart
  print_shack_about_page_test.dart
  product_test.dart
  sale_page_test.dart
  sign_in_page_test.dart

Technologies and packages

Framework: Flutter (Dart)

UI: Material Design widgets, responsive layout via LayoutBuilder and MediaQuery

State Management: ChangeNotifier (CartModel) with a global instance for simplicity

Images: Image.network with errorBuilder for tests and offline situations

Testing: flutter_test, network_image_mock for mocking network images in widget tests

5. Known Issues / Limitations & Future Improvements
Known limitations

No real backend or authentication – all data is in memory and resets on hot restart.

Payments and checkout are non-functional (Snackbars only).

Some footer “links” are placeholders with no navigation.

Images use placeholder URLs (picsum.photos) rather than the real Union images.

Search is basic (simple text filter on dummy product list).

Possible future improvements

Connect to a real backend / API for products and orders

Persist cart items locally (e.g. using SharedPreferences or a database)

Add sorting and filtering options to the Sale and Search pages

Improve accessibility (semantics, focus order, ARIA-style hints)

Add localisation for currency, language, and date formats

6. Contact Information

Student:
Maria Hrisca - BSc Computer Science, University of Portsmouth

Contact:

Email: up2305949@myport.ac.uk

GitHub: mar-8662