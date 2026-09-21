import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';

class CustomNavigationBar extends StatefulWidget {
  final Function(GlobalKey) onNavigate;
  final GlobalKey heroKey;
  final GlobalKey aboutKey;
  final GlobalKey experienceKey;
  final GlobalKey projectsKey;
  final GlobalKey skillsKey;
  final GlobalKey educationKey;
  final GlobalKey contactKey;

  const CustomNavigationBar({
    super.key,
    required this.onNavigate,
    required this.heroKey,
    required this.aboutKey,
    required this.experienceKey,
    required this.projectsKey,
    required this.skillsKey,
    required this.educationKey,
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
  }

  void _onScroll(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      final isScrolled = notification.metrics.pixels > 40;
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

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        _onScroll(notification);
        return false;
      },
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 16 : 48,
            vertical: 12,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 16 : 24,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: _isScrolled
                      ? AppTheme.darkSurfaceCard.withValues(alpha: 0.85)
                      : AppTheme.darkSurface.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: _isScrolled
                        ? AppTheme.darkBorderStrong
                        : AppTheme.darkBorder,
                    width: 1,
                  ),
                  boxShadow: _isScrolled
                      ? [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.35),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ]
                      : null,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Logo / Name
                    InkWell(
                      onTap: () => widget.onNavigate(widget.heroKey),
                      borderRadius: BorderRadius.circular(8),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              gradient: AppTheme.primaryGradient,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Center(
                              child: Text(
                                'M',
                                style: TextStyle(
                                  fontFamily: AppTheme.fontFamily,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Mina Nader',
                            style: TextStyle(
                              fontFamily: AppTheme.fontFamily,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Desktop Nav Items
                    if (!isMobile) ...[
                      Flexible(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _buildNavItem('Home', () => widget.onNavigate(widget.heroKey)),
                            _buildNavItem('About', () => widget.onNavigate(widget.aboutKey)),
                            _buildNavItem('Experience',
                                () => widget.onNavigate(widget.experienceKey)),
                            _buildNavItem('Projects',
                                () => widget.onNavigate(widget.projectsKey)),
                            _buildNavItem(
                                'Skills', () => widget.onNavigate(widget.skillsKey)),
                            _buildNavItem('Education',
                                () => widget.onNavigate(widget.educationKey)),
                            _buildNavItem(
                                'Contact', () => widget.onNavigate(widget.contactKey)),
                            const SizedBox(width: 12),
                            // Resume button
                            Container(
                              decoration: BoxDecoration(
                                gradient: AppTheme.primaryGradient,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ElevatedButton(
                                onPressed: () => _launchUrl(
                                    'https://drive.google.com/file/d/10ZnRNOnzIpsl9qThz18wPVgps2qG9VeZ/view?usp=sharing'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 10),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Text(
                                  'Resume',
                                  style: TextStyle(
                                    fontFamily: AppTheme.fontFamily,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ] else ...[
                      // Mobile Hamburger Button
                      IconButton(
                        icon: const Icon(Icons.menu_rounded, color: Colors.white),
                        onPressed: () => _showMobileMenu(context),
                        style: IconButton.styleFrom(
                          backgroundColor: AppTheme.darkBackground,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(String title, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Text(
            title,
            style: TextStyle(
              fontFamily: AppTheme.fontFamily,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppTheme.textLightSecondary,
            ),
          ),
        ),
      ),
    );
  }

  void _showMobileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppTheme.darkSurfaceCard,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
          border: Border.all(color: AppTheme.darkBorder),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppTheme.textLightMuted.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            _buildMobileNavItem(
                context, Icons.home_rounded, 'Home', () => widget.onNavigate(widget.heroKey)),
            _buildMobileNavItem(
                context, Icons.person_rounded, 'About', () => widget.onNavigate(widget.aboutKey)),
            _buildMobileNavItem(context, Icons.business_center_rounded,
                'Experience', () => widget.onNavigate(widget.experienceKey)),
            _buildMobileNavItem(context, Icons.layers_rounded, 'Projects',
                () => widget.onNavigate(widget.projectsKey)),
            _buildMobileNavItem(context, Icons.code_rounded, 'Skills',
                () => widget.onNavigate(widget.skillsKey)),
            _buildMobileNavItem(context, Icons.school_rounded, 'Education',
                () => widget.onNavigate(widget.educationKey)),
            _buildMobileNavItem(context, Icons.mail_rounded, 'Contact',
                () => widget.onNavigate(widget.contactKey)),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  _launchUrl(
                      'https://drive.google.com/file/d/1TlzfoVQL9OvOtL4GwWhj16UziVHiUq_6/view');
                },
                icon: const Icon(Icons.download_rounded, size: 18),
                label: Text(
                  'Download Resume',
                  style: TextStyle(
                    fontFamily: AppTheme.fontFamily,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileNavItem(
    BuildContext context,
    IconData icon,
    String title,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: Icon(icon, color: AppTheme.accentCyan, size: 20),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: AppTheme.fontFamily,
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      trailing: const Icon(Icons.chevron_right_rounded,
          color: AppTheme.textLightMuted, size: 18),
      onTap: () {
        Navigator.pop(context);
        onTap();
      },
    );
  }

  void _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}