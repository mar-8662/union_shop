import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/sign_in_page.dart';

void main() {
  testWidgets('Sign in page shows basic auth UI', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SignInPage(),
      ),
    );

    // Logo and headings
    expect(find.text('The UNION'), findsOneWidget);
    expect(find.text('Sign in'), findsOneWidget);
    expect(
      find.text("Choose how you'd like to sign in"),
      findsOneWidget,
    );

    // Main buttons and form field
    expect(find.text('Sign in with shop'), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Continue'), findsOneWidget);
  });

  testWidgets('Sign in page shows some popular products',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SignInPage(),
      ),
    );

    expect(find.text('Popular union products'), findsOneWidget);
    expect(find.text('Portsmouth City Postcard'), findsOneWidget);
    expect(find.text('Union Hoodie'), findsOneWidget);
    expect(find.text('Union Stainless Steel Bottle'), findsOneWidget);
  });
}
