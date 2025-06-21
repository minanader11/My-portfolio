import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class CustomNavigationBar extends StatefulWidget {
  final Function(GlobalKey) onNavigate;
  final GlobalKey heroKey;
  final GlobalKey aboutKey;
  final GlobalKey projectsKey;
  final GlobalKey skillsKey;
  final GlobalKey testimonialsKey;
  final GlobalKey contactKey;

  const CustomNavigationBar({
    super.key,
    required this.onNavigate,
    required this.heroKey,
    required this.aboutKey,
    required this.projectsKey,
    required this.skillsKey,
    required this.testimonialsKey,
    required this.contactKey,
  });

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final scrollController = Scrollable.of(context).widget.controller;
        scrollController?.addListener(_onScroll);
      }
    });
  }

  void _onScroll() {
    final scrollController = Scrollable.of(context).widget.controller;
    if (scrollController != null) {
      final isScrolled = scrollController.offset > 50;
      if (isScrolled != _isScrolled) {
        setState(() {
          _isScrolled = isScrolled;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: _isScrolled 
            ? Theme.of(context).colorScheme.surface.withOpacity(0.95)
            : Colors.transparent,
        boxShadow: _isScrolled
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 16 : 48,
          vertical: 16,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Portfolio',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (!isMobile) ...[
              Row(
                children: [
                  _NavItem('Home', () => widget.onNavigate(widget.heroKey)),
                  _NavItem('About', () => widget.onNavigate(widget.aboutKey)),
                  _NavItem('Projects', () => widget.onNavigate(widget.projectsKey)),
                  _NavItem('Skills', () => widget.onNavigate(widget.skillsKey)),
               //   _NavItem('Testimonials', () => widget.onNavigate(widget.testimonialsKey)),
                  _NavItem('Contact', () => widget.onNavigate(widget.contactKey)),
                ],
              ),
            ] else ...[
              IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () => _showMobileMenu(context),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _NavItem(String title, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  void _showMobileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _MobileNavItem('Home', () => widget.onNavigate(widget.heroKey)),
            _MobileNavItem('About', () => widget.onNavigate(widget.aboutKey)),
            _MobileNavItem('Projects', () => widget.onNavigate(widget.projectsKey)),
            _MobileNavItem('Skills', () => widget.onNavigate(widget.skillsKey)),
         //   _MobileNavItem('Testimonials', () => widget.onNavigate(widget.testimonialsKey)),
            _MobileNavItem('Contact', () => widget.onNavigate(widget.contactKey)),
          ],
        ),
      ),
    );
  }

  Widget _MobileNavItem(String title, VoidCallback onTap) {
    return ListTile(
      title: Text(title),
      onTap: () {
        Navigator.pop(context);
        onTap();
      },
    );
  }
}