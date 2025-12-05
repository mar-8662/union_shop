// lib/footer.dart
import 'package:flutter/material.dart';

class UnionFooter extends StatelessWidget {
  const UnionFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      color: Colors.grey[50],
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Union Shop • University of Portsmouth Students' Union",
            style: textTheme.bodyMedium?.copyWith(
              color: Colors.grey[700],
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),

          // Footer “links”
          Wrap(
            spacing: 16,
            runSpacing: 8,
            children: [
              const _FooterLink(label: 'Contact us'),
              const _FooterLink(label: 'FAQ'),
              const _FooterLink(label: 'Delivery & returns'),
              const _FooterLink(label: 'Terms & conditions'),
              const _FooterLink(label: 'Privacy notice'),
              _FooterLink(
                label: 'Search',
                onPressed: () {
                  Navigator.pushNamed(context, '/search');
                },
              ),
            ],
          ),

          const SizedBox(height: 12),
          Text(
            "© 2025 University of Portsmouth Students' Union. "
            "All purchases help support student activities, clubs and societies.",
            style: textTheme.bodySmall?.copyWith(
              color: Colors.grey[600],
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

class _FooterLink extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;

  const _FooterLink({
    required this.label,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed ?? () {},
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        minimumSize: const Size(0, 0),
      ),
      child: Text(
        label,
        style: const TextStyle(
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
