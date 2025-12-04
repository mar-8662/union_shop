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
        final bool isDesktop = constraints.maxWidth >= 800;

        if (isDesktop) {
          // DESKTOP / LARGE VIEW: static navbar with links
          return AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: theme.colorScheme.primary,
            elevation: 0,
            titleSpacing: 24,
            title: Row(
              children: [
                Text(
                  'Union Shop',
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 32),
                // The links do not need to work for the brief,
                // but you can uncomment the Navigator lines later if you want.
                _NavLink(label: 'Home', onTap: () {
                  // Navigator.pushNamed(context, '/');
                }),
                _NavLink(label: 'Collections', onTap: () {
                  // Navigator.pushNamed(context, '/collections');
                }),
                _NavLink(label: 'Sale', onTap: () {
                  // Navigator.pushNamed(context, '/sale');
                }),
                _NavLink(label: 'About', onTap: () {
                  // Navigator.pushNamed(context, '/about');
                }),
                _NavLink(label: 'Sign in', onTap: () {
                  // Navigator.pushNamed(context, '/signin');
                }),
              ],
            ),
          );
        } else {
          // MOBILE VIEW: navbar collapses to a menu button
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
                              _MobileNavItem(label: 'Home'),
                              _MobileNavItem(label: 'Collections'),
                              _MobileNavItem(label: 'Sale'),
                              _MobileNavItem(label: 'About'),
                              _MobileNavItem(label: 'Sign in'),
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

  const _NavLink({
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextButton(
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

  const _MobileNavItem({required this.label});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(label),
      // For the coursework, links don’t have to navigate anywhere.
      onTap: () {
        Navigator.pop(context); // just close the menu
      },
    );
  }
}
