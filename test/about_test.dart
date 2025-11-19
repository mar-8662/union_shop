import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/about_page.dart';

void main() {
  testWidgets('AboutUsPage shows heading and company info', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: AboutUsPage()),
    );

    // Heading
    expect(find.text('About the Union Shop'), findsOneWidget);

    // Body text (just check part of it)
    expect(
      find.textContaining('operated by the Students\' Union'),
      findsOneWidget,
    );

    // Footer reused from other pages
    expect(
      find.text("Union Shop • University of Portsmouth Students' Union"),
      findsOneWidget,
    );
  });
}
