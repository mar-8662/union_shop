import 'package:flutter/material.dart';
import 'package:union_shop/footer.dart';
import 'package:union_shop/widgets/responsive_navbar.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  void navigateToHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ResponsiveNavbar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Top banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8),
              color: const Color(0xFF4d2963),
              child: const Text(
                'Student-run shop for official merch & gifts',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),

            // Main About content
            Container(
              color: Colors.white,
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8),
                  Text(
                    'About the Union Shop',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'The Union Shop is operated by the Students\' Union and '
                    'provides official University of Portsmouth merchandise, '
                    'clothing, gifts and everyday essentials for students.',
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.5,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Every purchase helps to support student activities, clubs '
                    'and societies run by the Students\' Union.',
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.5,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'You can visit us on campus or browse a selection of items '
                    'online through this shop experience.',
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.5,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),

            // Footer
            const UnionFooter(),
          ],
        ),
      ),
    );
  }
}
