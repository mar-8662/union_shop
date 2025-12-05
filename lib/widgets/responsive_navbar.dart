import 'package:flutter/material.dart';

/// A responsive top navigation bar:
/// - On wide screens (desktop/tablet) it shows text links in a row.
/// - On narrow screens (mobile) it shows a menu button that opens a bottom sheet.
class ResponsiveNavbar extends StatelessWidget implements PreferredSizeWidget {
  const ResponsiveNavbar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        // Desktop / large view breakpoint
        final bool isDesktop = constraints.maxWidth >= 800;

        if (isDesktop) {
          // DESKTOP: static navbar with links
          return AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: theme.colorScheme.primary,
            elevation: 0,
            titleSpacing: 16,
            title: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Text(
                    'Union Shop',
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 24),
                  _NavLink(
                    label: 'Home',
                    navKey: const ValueKey('nav_home_desktop'),
                    onTap: () {
                      Navigator.pushNamed(context, '/');
                    },
                  ),
                  _NavLink(
                    label: 'Collections',
                    navKey: const ValueKey('nav_collections_desktop'),
                    onTap: () {
                      Navigator.pushNamed(context, '/collections');
                    },
                  ),
                  _NavLink(
                    label: 'SALE!',
                    navKey: const ValueKey('nav_sale_desktop'),
                    onTap: () {
                      Navigator.pushNamed(context, '/sale');
                    },
                  ),
                  _NavLink(
                    label: 'About',
                    navKey: const ValueKey('nav_about_desktop'),
                    onTap: () {
                      Navigator.pushNamed(context, '/about');
                    },
                  ),
                  _NavLink(
                    label: 'Sign in',
                    navKey: const ValueKey('nav_signin_desktop'),
                    onTap: () {
                      Navigator.pushNamed(context, '/signin');
                    },
                  ),
                  _NavLink(
                    label: 'Cart',
                    navKey: const ValueKey('nav_cart_desktop'),
                    onTap: () {
                      Navigator.pushNamed(context, '/cart');
                    },
                  ),
                ],
              ),
            ),
          );
        } else {
          // MOBILE: collapses to a menu button
          return AppBar(
            backgroundColor: theme.colorScheme.primary,
            elevation: 0,
            title: const Text('Union Shop'),
            actions: [
              Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.menu),
                  tooltip: 'Open navigation menu',
                  onPressed: () {
                    showModalBottomSheet<void>(
                      context: context,
                      builder: (context) {
                        return SafeArea(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              _MobileNavItem(
                                label: 'Home',
                                navKey: ValueKey('nav_home_mobile'),
                                routeName: '/',
                              ),
                              _MobileNavItem(
                                label: 'Collections',
                                navKey: ValueKey('nav_collections_mobile'),
                                routeName: '/collections',
                              ),
                              _MobileNavItem(
                                label: 'SALE!',
                                navKey: ValueKey('nav_sale_mobile'),
                                routeName: '/sale',
                              ),
                              _MobileNavItem(
                                label: 'About',
                                navKey: ValueKey('nav_about_mobile'),
                                routeName: '/about',
                              ),
                              _MobileNavItem(
                                label: 'Sign in',
                                navKey: ValueKey('nav_signin_mobile'),
                                routeName: '/signin',
                              ),
                              _MobileNavItem(
                                label: 'Cart',
                                navKey: ValueKey('nav_cart_mobile'),
                                routeName: '/cart',
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          );
        }
      },
    );
  }
}

class _NavLink extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final Key? navKey;

  const _NavLink({
    required this.label,
    required this.onTap,
    this.navKey,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextButton(
        key: navKey,
        onPressed: onTap,
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}

class _MobileNavItem extends StatelessWidget {
  final String label;
  final Key? navKey;
  final String routeName;

  const _MobileNavItem({
    required this.label,
    required this.routeName,
    this.navKey,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: navKey,
      title: Text(label),
      onTap: () {
        Navigator.pop(context); // close the sheet
        Navigator.pushNamed(context, routeName);
      },
    );
  }
}
