import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:union_shop/footer.dart';
import 'package:union_shop/search_page.dart';
import 'package:union_shop/widgets/responsive_navbar.dart';

void main() {
  testWidgets(
    'Search page shows heading, form and footer',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: SearchPage(),
        ),
      );

      expect(find.text('SEARCH OUR SITE'), findsOneWidget);
      expect(find.byKey(const Key('search_text_field')), findsOneWidget);
      expect(find.byKey(const Key('search_submit_button')), findsOneWidget);

      expect(
        find.textContaining('Use the search box above'),
        findsOneWidget,
      );

      // Footer text
      expect(
        find.text("Union Shop • University of Portsmouth Students' Union"),
        findsOneWidget,
      );
    },
  );

  testWidgets(
    'Search page filters products by query',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: SearchPage(),
        ),
      );

      await tester.enterText(
        find.byKey(const Key('search_text_field')),
        'Hoodie',
      );
      await tester.tap(find.byKey(const Key('search_submit_button')));
      await tester.pumpAndSettle();

      // Results list appears
      expect(
        find.byKey(const ValueKey('search_results_list')),
        findsOneWidget,
      );

      // At least one hoodie product from dummyProducts
      expect(find.textContaining('Hoodie'), findsWidgets);
    },
  );

  testWidgets(
    'Navbar search icon navigates to SearchPage',
    (WidgetTester tester) async {
      await tester.binding.setSurfaceSize(const Size(1200, 800));

      await tester.pumpWidget(
        MaterialApp(
          routes: {
            '/': (context) => const Scaffold(
                  appBar: ResponsiveNavbar(),
                  body: SizedBox.shrink(),
                ),
            '/search': (context) => const SearchPage(),
          },
        ),
      );
      await tester.pumpAndSettle();

      await tester
          .tap(find.byKey(const ValueKey('nav_search_desktop_icon')));
      await tester.pumpAndSettle();

      expect(find.byType(SearchPage), findsOneWidget);
    },
  );

  testWidgets(
    'Footer Search link navigates to SearchPage',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          routes: {
            '/': (context) => const Scaffold(
                  body: Column(
                    children: [
                      Expanded(child: SizedBox.shrink()),
                      UnionFooter(),
                    ],
                  ),
                ),
            '/search': (context) => const SearchPage(),
          },
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Search'));
      await tester.pumpAndSettle();

      expect(find.byType(SearchPage), findsOneWidget);
    },
  );
}
