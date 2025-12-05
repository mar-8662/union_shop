import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:union_shop/models/cart_model.dart';
import 'package:union_shop/personalisation_page.dart';

void main() {
  testWidgets(
      'Personalisation page shows form and updates total when options change',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: PersonalisationPage(),
      ),
    );
    await tester.pumpAndSettle();

    // Basic heading and default price
    expect(find.text('Personalisation'), findsOneWidget);
    expect(find.byKey(const Key('personalisation_price')), findsOneWidget);
    expect(find.text('£3.00'), findsOneWidget);

    // Only first line field visible by default
    expect(find.text('Personalisation line 1'), findsOneWidget);
    expect(find.text('Personalisation line 2'), findsNothing);

    // Estimated total starts at £3.00
    expect(find.byKey(const Key('personalisation_total')), findsOneWidget);
    expect(find.text('Estimated total: £3.00'), findsOneWidget);

    // ---- Change to two lines of text ----
    final dropdownFinder =
        find.byKey(const Key('personalisation_line_dropdown'));

    // Scroll it into view first (important for tests)
    await tester.ensureVisible(dropdownFinder);
    await tester.pump();

    await tester.tap(dropdownFinder);
    await tester.pumpAndSettle();

    await tester.tap(find.text('Two lines of text').last);
    await tester.pumpAndSettle();

    // Second line appears and price increases
    expect(find.text('Personalisation line 2'), findsOneWidget);
    expect(find.text('£5.00'), findsOneWidget);
    expect(find.text('Estimated total: £5.00'), findsOneWidget);

    // ---- Increase quantity to 2 → total £10.00 ----
    final incButtonFinder =
        find.byKey(const Key('personalisation_qty_increase'));

    await tester.ensureVisible(incButtonFinder);
    await tester.pump();

    await tester.tap(incButtonFinder);
    await tester.pumpAndSettle();

    expect(find.text('Estimated total: £10.00'), findsOneWidget);
  });

  testWidgets('Tapping ADD TO CART adds an item and shows a snackbar',
      (WidgetTester tester) async {
    cartModel.clear();

    await tester.pumpWidget(
      const MaterialApp(
        home: PersonalisationPage(),
      ),
    );
    await tester.pumpAndSettle();

    final addButtonFinder =
        find.byKey(const Key('personalisation_add_to_cart'));

    // Scroll the button into view before tapping
    await tester.ensureVisible(addButtonFinder);
    await tester.pump();

    await tester.tap(addButtonFinder);
    await tester.pumpAndSettle();

    // Cart now has one item
    expect(cartModel.totalItems, 1);

    // SnackBar message appears (text begins with "Added")
    expect(find.textContaining('Added'), findsOneWidget);
  });
}
