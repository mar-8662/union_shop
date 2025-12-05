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

Navigation overview

The top responsive navbar appears on all pages:

Desktop view (≥ 800px):

Home, Collections, The Print Shack (dropdown), SALE!, About, Sign in, Cart, and a Search icon

Mobile view (< 800px):

AppBar shows title, Search icon, and a menu button

Menu opens a bottom sheet with links to all major pages, including:

Home

Collections

SALE!

About

Print Shack – Personalisation

Print Shack – About

Sign in

Cart

Search

Main user flows
Home

Shows:

Top sale banner

Hero banner promoting the Essential Range

“Featured products” grid using homeFeaturedProducts from main.dart

Clicking a featured product opens the ProductPage for that item.

Collections

CollectionsPage displays a dynamic grid of collection tiles built from productIdsByCollection and dummyProducts.

Filter bar:

Filter by category: Seasonal, Sale, Clothing, Essentials, etc.

Sort A–Z or Z–A

Clicking a tile (e.g. “Autumn Favourites”, “Essential Range”) opens CollectionDetailPage.

Collection details

For a given collection (e.g. “Clothing”):

Displays:

Collection title and subtitle

Filter dropdown: All products, Hoodies & Sweatshirts, Accessories

Sort dropdown: Featured, Price, low to high, Price, high to low

Products loaded from product_data.dart via productsForCollection.

Pagination with next/previous page buttons.

Clicking any product card opens its ProductPage.

Product page and cart flow

On ProductPage:

Large image with thumbnail gallery

Product name, price, “Tax included” text

Dropdowns for Colour and Size (when available)

Quantity selector (+/– buttons)

ADD TO CART button:

Converts the Product into a CollectionProduct

Adds it to the global cartModel with chosen colour, size, and quantity

Shows a Snackbar with an option to “VIEW CART”

Additional buttons:

“Buy with Shop” (UI only)

“More payment options” (UI only)

Social share buttons and “BACK TO AUTUMN FAVOURITES” link

Cart page

CartPage uses the shared CartModel:

Empty state:

“Your cart is currently empty” + “CONTINUE SHOPPING” button

Filled state:

Table-style layout showing:

Product (image, name, colour, size, “Remove” link)

Price (unit)

Quantity (dropdown 1–5)

Total per item

Subtotal, note field, UPDATE and CHECK OUT buttons

Quantity changes update totals and subtotal live.

Print Shack – Personalisation

PersonalisationPage provides:

Dropdown for number of lines of text

Text fields for each personalisation line

Quantity selector

Dynamic total price based on options

ADD TO CART button that adds a “Print Shack Custom” style item to the cart

Layout follows the same visual style as other product pages.

Print Shack – About

PrintShackAboutPage acts as a marketing/info page:

Large hero image row (hoodie, logo, back print)

Section headings: “Make It Yours at The Union Print Shack”, etc.

Bullet-style paragraphs on pricing, turnaround, terms & conditions

A small selection of related products from dummyProducts (e.g. custom hoodie/tee/tote)

Search

SearchPage:

“SEARCH OUR SITE” heading

Input field + “SUBMIT” button

Basic search over dummyProducts names and descriptions

Results list of matching products (clicking could open their ProductPage)

Sign in

SignInPage:

Card UI with “The UNION” wordmark

“Sign in with shop” primary button (UI only)

Email input and grey “Continue” button (UI only)

A horizontal product strip titled “Popular union products”

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