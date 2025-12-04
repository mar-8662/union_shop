# Union Shop – Coursework Checklist

Use this checklist to track which spec items you’ve implemented.  
(Leave boxes as `[ ]` and tick them as you go: `[x]`.) :contentReference[oaicite:0]{index=0}  

---

## 1. Application Features (30% of overall coursework)

### 1.1 Basic Features (40% of application mark)

- [x] **Static Homepage** (5%)  
  - Layout built in Flutter  
  - Static content (hardcoded is fine)  
  - Designed primarily for **mobile view**

- [x] **About Us Page** (5%)  
  - Separate page from the homepage  
  - Static company information about the Union Shop

- [x] **Footer** (4%)  
  - Footer widget with dummy links/info  
  - Present on at least one page (preferably reused everywhere)

- [x] **Dummy Collections Page** (5%)  
  - Page showing multiple product collections  
  - Data can be hardcoded/dummy

- [x] **Dummy Collection Page** (5%)  
  - Page that shows products within a single collection  
  - Includes dropdowns/filters (do **not** have to function yet)

- [x] **Dummy Product Page** (4%)  
  - Product details page with image(s), price, description  
  - Includes dropdowns, buttons, and other widgets (do not need to function yet)

- [ ] **Sale Collection Page** (4%)  
  - Page listing “sale” products  
  - Shows discounted prices and basic promo messaging

- [ ] **Authentication UI** (3%)  
  - Login (sign-in) page with email/password fields etc.  
  - Signup (register) page with relevant form fields  
  - Forms do **not** have to talk to real auth yet

- [ ] **Static Navbar** (5%)  
  - Top navigation bar in desktop view  
  - Links/buttons can be non-functional, but layout must be present  
  - Collapses to a **menu button** in mobile view

---

### 1.2 Intermediate Features (35% of application mark)

- [ ] **Dynamic Collections Page** (6%)  
  - Collections loaded from data models or services  
  - Sorting / filtering / pagination widgets that actually work

- [ ] **Dynamic Collection Page** (6%)  
  - Products for a collection loaded from data models or services  
  - Working sorting / filtering / pagination

- [ ] **Functional Product Pages** (6%)  
  - Product details populated from data models/services  
  - Working dropdowns (e.g. size/colour)  
  - Working counters (quantity selector)  
  - Add to cart button **does not** have to modify a real cart yet

- [ ] **Shopping Cart** (6%)  
  - Add items to cart from product pages  
  - View a cart page with list of items  
  - Basic cart behaviour (e.g. show totals, simple checkout button)  
  - Checkout can place a “fake” order: no real payment needed

- [ ] **Print Shack** (3%)  
  - Dedicated personalisation page  
  - Associated “About Print Shack” info section  
  - Form fields that dynamically update what’s shown based on user choices

- [ ] **Navigation** (3%)  
  - User can navigate across **all pages** using:  
    - Buttons/links in the UI  
    - Navbar / menu  
    - Direct URLs (named routes)

- [ ] **Responsiveness** (5%)  
  - App works correctly in mobile view (main focus)  
  - Layout adapts reasonably on wider screens (desktop view)  

---

### 1.3 Advanced Features (25% of application mark)

- [ ] **Authentication System** (8%)  
  - Real user authentication (e.g. Firebase Auth, Google, etc.)  
  - Account dashboard & relevant account functionality  
  - Not limited to Shop.app – any suitable auth provider is acceptable

- [ ] **Cart Management** (6%)  
  - Full cart behaviour: add/remove items, change quantities  
  - Correct price calculations (line totals, subtotal, etc.)  
  - Cart **persists** (e.g. across app restarts or sessions)

- [ ] **Search System** (4%)  
  - Search input that filters products/collections  
  - Search buttons in navbar and footer actually work  
  - Results page / inline results behaviour implemented

---

## 2. Software Development Practices (25% of coursework mark)

- [ ] **Git Usage** (8%)  
  - Regular, small, meaningful commits  
  - Clear, descriptive commit messages (no huge “big dump” commits)

- [ ] **README** (5%)  
  - Existing starter README removed or replaced  
  - New README explains:  
    - What the app does  
    - How to run it (Flutter commands, device setup)  
    - Features implemented (linking back to this checklist)  
    - Any limitations / known issues  
    - How external services are used  
    - Links to live deployment (if any)

- [ ] **Testing** (6%)  
  - Widget / unit tests covering most key pages & logic  
  - All tests pass (`flutter test`)  
  - Tests kept up to date as features change

- [ ] **External Services Integration** (6%)  
  - At least **two** separate cloud/external services (e.g. Firebase Auth, Firestore/Realtime DB, Hosting, Analytics, etc.)  
  - Fully wired into the app (not just configured)  
  - Documented clearly in README (what each service does + how to use/check it)

- [ ] **Code Quality** (implicit requirement)  
  - Code is formatted (`dart format`)  
  - No errors/warnings/suggestions in `flutter analyze`  
  - Structure is sensible (widgets split into files, minimal repetition)  
  - You understand all code you’ve committed

---

## 3. Setup & Submission

- [ ] Forked the official `union_shop` repository under my GitHub account  
- [ ] Cloned fork locally (or into Firebase Studio) and ran `flutter pub get`  
- [ ] App runs on Chrome in mobile view (`flutter run -d chrome`)  
- [ ] Public GitHub repo link tested in an incognito window  
- [ ] Repo link submitted to Moodle **before** deadline  
- [ ] No commits pushed **after** the deadline

