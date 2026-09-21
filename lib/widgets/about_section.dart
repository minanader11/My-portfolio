import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../theme/app_theme.dart';

class AboutSection extends StatefulWidget {
  const AboutSection({super.key});

  @override
  State<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    final isTablet = ResponsiveBreakpoints.of(context).isTablet;

    return VisibilityDetector(
      key: const Key('about-section'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.15 && !_isVisible) {
          setState(() {
            _isVisible = true;
          });
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 20 : (isTablet ? 40 : 80),
          vertical: 90,
        ),
        color: AppTheme.darkBackground,
        child: Column(
          children: [
            _buildSectionHeader(context),
            const SizedBox(height: 56),
            if (isMobile) ...[
              _buildMobileLayout(context),
            ] else ...[
              _buildDesktopLayout(context, isTablet),
            ],
            const SizedBox(height: 48),
            _buildPillarsGrid(context, isMobile, isTablet),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: AppTheme.primaryColor.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppTheme.primaryColor.withValues(alpha: 0.3),
            ),
          ),
          child: Text(
            'GET TO KNOW ME',
            style: TextStyle(
              fontFamily: AppTheme.fontFamily,
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: AppTheme.primaryLight,
              letterSpacing: 1.5,
            ),
          ),
        )
            .animate(target: _isVisible ? 1 : 0)
            .fadeIn(duration: 500.ms)
            .slideY(begin: 0.2),
        const SizedBox(height: 12),
        Text(
          'About Me & My Vision',
          style: TextStyle(
            fontFamily: AppTheme.fontFamily,
            fontSize: 34,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        )
            .animate(target: _isVisible ? 1 : 0)
            .fadeIn(duration: 600.ms, delay: 100.ms)
            .slideY(begin: 0.2),
        const SizedBox(height: 12),
        Container(
          width: 50,
          height: 4,
          decoration: BoxDecoration(
            gradient: AppTheme.primaryGradient,
            borderRadius: BorderRadius.circular(2),
          ),
        )
            .animate(target: _isVisible ? 1 : 0)
            .scaleX(duration: 600.ms, delay: 250.ms),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      children: [
        _buildProfilePhoto(context, 260),
        const SizedBox(height: 36),
        _buildMainTextContent(context),
      ],
    );
  }

  Widget _buildDesktopLayout(BuildContext context, bool isTablet) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: isTablet ? 4 : 4,
          child: Center(
            child: _buildProfilePhoto(context, isTablet ? 300 : 360),
          ),
        ),
        const SizedBox(width: 48),
        Expanded(
          flex: 6,
          child: _buildMainTextContent(context),
        ),
      ],
    );
  }

  Widget _buildProfilePhoto(BuildContext context, double size) {
    return Container(
      width: size,
      height: size * 1.15,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: AppTheme.darkBorderStrong,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryColor.withValues(alpha: 0.2),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/1713665244351.jpeg',
              fit: BoxFit.cover,
            ),
            // Gradient overlay at bottom
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              height: 120,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      AppTheme.darkBackground.withValues(alpha: 0.95),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: AppTheme.darkSurfaceCard.withValues(alpha: 0.9),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppTheme.darkBorder),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Mina Nader',
                          style: TextStyle(
                            fontFamily: AppTheme.fontFamily,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Flutter Engineer',
                          style: TextStyle(
                            fontFamily: AppTheme.fontFamily,
                            fontSize: 12,
                            color: AppTheme.accentCyan,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: AppTheme.accentEmerald.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Cairo, Egypt',
                        style: TextStyle(
                          fontFamily: AppTheme.fontFamily,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.accentEmerald,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    )
        .animate(target: _isVisible ? 1 : 0)
        .fadeIn(duration: 600.ms, delay: 200.ms)
        .slideX(begin: -0.15);
  }

  Widget _buildMainTextContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Engineering Scalable & High-Impact Mobile Apps',
          style: TextStyle(
            fontFamily: AppTheme.fontFamily,
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Colors.white,
            height: 1.3,
          ),
        )
            .animate(target: _isVisible ? 1 : 0)
            .fadeIn(duration: 600.ms, delay: 300.ms)
            .slideY(begin: 0.1),
        const SizedBox(height: 16),
        Text(
          'Passionate Flutter Developer with a strong focus on building high-quality, user-centric applications. Dedicated to delivering efficient, scalable, and intuitive solutions that enhance user experience and drive business success. Always eager to learn, adapt, and contribute to innovative projects.',
          style: TextStyle(
            fontFamily: AppTheme.fontFamily,
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: AppTheme.textLightSecondary,
            height: 1.75,
          ),
        )
            .animate(target: _isVisible ? 1 : 0)
            .fadeIn(duration: 600.ms, delay: 400.ms)
            .slideY(begin: 0.1),
        const SizedBox(height: 14),
        Text(
          'Throughout my work at Initium Solution, Digital Nests, and TransIT, I have engineered and shipped multi-tenant real estate platforms, municipal mobility systems (Capital Taxi), workplace gamification suites, and bilingual enterprise solutions. I specialize in driving measurable improvements — including reducing app loading times by 40% and decoupling complex systems with Clean Architecture.',
          style: TextStyle(
            fontFamily: AppTheme.fontFamily,
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: AppTheme.textLightSecondary,
            height: 1.75,
          ),
        )
            .animate(target: _isVisible ? 1 : 0)
            .fadeIn(duration: 600.ms, delay: 500.ms)
            .slideY(begin: 0.1),
        const SizedBox(height: 28),

        // Quick Facts Tags
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            _buildFactChip(Icons.location_on_outlined, 'Egypt (Open to Remote)'),
            _buildFactChip(Icons.translate_rounded, 'English & Arabic'),
            _buildFactChip(Icons.school_outlined, 'B.Sc. Engineering (A+ Project)'),
            _buildFactChip(Icons.speed_rounded, '40% Performance Boost'),
          ],
        )
            .animate(target: _isVisible ? 1 : 0)
            .fadeIn(duration: 600.ms, delay: 600.ms)
            .slideY(begin: 0.1),
        const SizedBox(height: 32),

        // Download CV & Get In Touch CTA
        Wrap(
          spacing: 16,
          runSpacing: 12,
          children: [
            ElevatedButton.icon(
              onPressed: () => _launchUrl(
                  'https://drive.google.com/file/d/10ZnRNOnzIpsl9qThz18wPVgps2qG9VeZ/view?usp=sharing'),
              icon: const Icon(Icons.download_rounded, size: 18),
              label: Text(
                'Download Full CV',
                style: TextStyle(
                  fontFamily: AppTheme.fontFamily,
                  fontWeight: FontWeight.w700,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              ),
            ),
            OutlinedButton.icon(
              onPressed: () => _launchUrl('mailto:nadermina30@gmail.com'),
              icon: const Icon(Icons.mail_outline_rounded,
                  size: 18, color: AppTheme.accentCyan),
              label: Text(
                'Contact Mina',
                style: TextStyle(
                  fontFamily: AppTheme.fontFamily,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textLightPrimary,
                ),
              ),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppTheme.darkBorderStrong),
                padding:
                    const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
              ),
            ),
          ],
        )
            .animate(target: _isVisible ? 1 : 0)
            .fadeIn(duration: 600.ms, delay: 700.ms)
            .slideY(begin: 0.1),
      ],
    );
  }

  Widget _buildFactChip(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppTheme.darkSurfaceCard,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppTheme.darkBorder),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: AppTheme.accentCyan),
          const SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(
              fontFamily: AppTheme.fontFamily,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppTheme.textLightPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPillarsGrid(BuildContext context, bool isMobile, bool isTablet) {
    final pillars = [
      {
        'icon': Icons.architecture_rounded,
        'title': 'Clean Architecture & MVI',
        'desc':
            'Designing decoupled, testable, and maintainable software structures with clear layer boundaries and unidirectional data flow.',
        'color': AppTheme.primaryColor,
      },
      {
        'icon': Icons.speed_rounded,
        'title': '40% Performance Gains',
        'desc':
            'Profiling memory, eliminating rebuild bottlenecks, optimizing asset bundles, and reducing startup latency across mobile platforms.',
        'color': AppTheme.accentCyan,
      },
      {
        'icon': Icons.sync_alt_rounded,
        'title': 'Real-Time & CRM Sync',
        'desc':
            'Integrating SignalR for instant updates, real-time vehicle tracking via Google Maps, and bi-directional CRM data pipelines.',
        'color': AppTheme.secondaryColor,
      },
      {
        'icon': Icons.payment_rounded,
        'title': 'Payments & Security',
        'desc':
            'Flawless integration of Fawry SDK, Stripe SDK, OAuth2 authentication, and biometric/social authentication mechanisms.',
        'color': AppTheme.accentEmerald,
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: pillars.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isMobile ? 1 : (isTablet ? 2 : 4),
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        childAspectRatio: isMobile ? 2.4 : (isTablet ? 1.6 : 1.15),
      ),
      itemBuilder: (context, index) {
        final item = pillars[index];
        final color = item['color'] as Color;

        return Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: AppTheme.darkSurfaceCard,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppTheme.darkBorder,
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  item['icon'] as IconData,
                  color: color,
                  size: 24,
                ),
              ),
              const SizedBox(height: 14),
              Text(
                item['title'] as String,
                style: TextStyle(
                  fontFamily: AppTheme.fontFamily,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                item['desc'] as String,
                style: TextStyle(
                  fontFamily: AppTheme.fontFamily,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: AppTheme.textLightMuted,
                  height: 1.5,
                ),
              ),
            ],
          ),
        )
            .animate(target: _isVisible ? 1 : 0)
            .fadeIn(duration: 500.ms, delay: (600 + index * 120).ms)
            .slideY(begin: 0.15);
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
