import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/widgets/responsive_navbar.dart';

void main() {
  group('Responsive navbar', () {
    testWidgets('shows nav links on wide screens (desktop view)',
        (WidgetTester tester) async {
      // Simulate a wide desktop-sized window
      await tester.binding.setSurfaceSize(const Size(1200, 800));

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            appBar: ResponsiveNavbar(),
            body: SizedBox.shrink(), // no hero/body layout, just navbar
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byKey(const ValueKey('nav_home_desktop')), findsOneWidget);
      expect(find.byKey(const ValueKey('nav_collections_desktop')),
          findsOneWidget);
      expect(find.byKey(const ValueKey('nav_sale_desktop')), findsOneWidget);
      expect(find.byKey(const ValueKey('nav_about_desktop')), findsOneWidget);
      expect(find.byKey(const ValueKey('nav_signin_desktop')), findsOneWidget);
      expect(find.byKey(const ValueKey('nav_cart_desktop')), findsOneWidget);

      // New Print Shack dropdown
      expect(find.byKey(const ValueKey('nav_printshack_desktop')),
          findsOneWidget);

      // On desktop we should not see the mobile menu icon
      expect(find.byIcon(Icons.menu), findsNothing);
    });

    testWidgets('shows menu button and collapsible menu on small screens',
        (WidgetTester tester) async {
      // Narrow screen to trigger the mobile navbar layout
      await tester.binding.setSurfaceSize(const Size(700, 800));

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            appBar: ResponsiveNavbar(),
            body: SizedBox.shrink(), // no hero/body layout here either
          ),
        ),
      );
      await tester.pumpAndSettle();

      // On mobile we see the menu icon instead of the desktop links
      expect(find.byIcon(Icons.menu), findsOneWidget);
      expect(find.byKey(const ValueKey('nav_home_desktop')), findsNothing);
      expect(find.byKey(const ValueKey('nav_collections_desktop')),
          findsNothing);
      expect(find.byKey(const ValueKey('nav_signin_desktop')), findsNothing);
      expect(find.byKey(const ValueKey('nav_cart_desktop')), findsNothing);

      // The mobile nav items should not be visible before opening the sheet
      expect(find.byKey(const ValueKey('nav_home_mobile')), findsNothing);

      // Open the bottom sheet
      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();

      // Now the mobile nav items are visible
      expect(find.byKey(const ValueKey('nav_home_mobile')), findsOneWidget);
      expect(find.byKey(const ValueKey('nav_collections_mobile')),
          findsOneWidget);
      expect(find.byKey(const ValueKey('nav_sale_mobile')), findsOneWidget);
      expect(find.byKey(const ValueKey('nav_about_mobile')), findsOneWidget);
      expect(find.byKey(const ValueKey('nav_signin_mobile')), findsOneWidget);
      expect(find.byKey(const ValueKey('nav_cart_mobile')), findsOneWidget);

      // New Print Shack entries
      expect(
          find.byKey(
              const ValueKey('nav_printshack_personalisation_mobile')),
          findsOneWidget);
      expect(
          find.byKey(const ValueKey('nav_printshack_about_mobile')),
          findsOneWidget);
    });
  });
}
