import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      padding: const EdgeInsets.all(48),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Portfolio',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: 300,
                    child: Text(
                      'Creating beautiful, functional, and user-centered digital experiences that bring your ideas to life.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
              // FloatingActionButton(
              //   onPressed: _scrollToTop,
              //   child: const Icon(Icons.keyboard_arrow_up),
              // ),
            ],
          ),
          const SizedBox(height: 32),
          const Divider(),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Wrap(
              //   spacing: 32,
              //   children: [
              //     _FooterLink('Home', () {}),
              //     _FooterLink('About', () {}),
              //     _FooterLink('Projects', () {}),
              //     _FooterLink('Skills', () {}),
              //    // _FooterLink('Testimonials', () {}),
              //     _FooterLink('Contact', () {}),
              //   ],
              // ),
              // Text(
              //   '© ${DateTime.now().year} John Doe. All rights reserved.',
              //   style: Theme.of(context).textTheme.bodySmall,
              // ),
            ],
          ),
          const SizedBox(height: 16),
          // Text(
          //   'Designed and developed with ❤️ using Flutter',
          //   style: Theme.of(context).textTheme.bodySmall?.copyWith(
          //     color: Theme.of(context).colorScheme.primary,
          //   ),
          //   textAlign: TextAlign.center,
          // ),
        ],
      ),
    ).animate()
        .fadeIn(duration: 800.ms)
        .slideY(begin: 0.2);
  }

  void _scrollToTop() {
    // This would typically scroll to top, but since we're in a single page,
    // we'll just show a simple implementation
  }
}

class _FooterLink extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const _FooterLink(this.text, this.onTap);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
        ),
      ),
    );
  }
}