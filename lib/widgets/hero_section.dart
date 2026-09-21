import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback? onExploreProjects;
  final VoidCallback? onContactMe;

  const HeroSection({
    super.key,
    this.onExploreProjects,
    this.onContactMe,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    final isTablet = ResponsiveBreakpoints.of(context).isTablet;
    final size = MediaQuery.of(context).size;

    return Container(
      constraints: BoxConstraints(
        minHeight: size.height,
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppTheme.darkBackground,
        // Ambient background gradient glow
        gradient: RadialGradient(
          center: const Alignment(0.6, -0.4),
          radius: 1.2,
          colors: [
            AppTheme.primaryColor.withValues(alpha: 0.15),
            AppTheme.secondaryColor.withValues(alpha: 0.05),
            AppTheme.darkBackground,
          ],
        ),
      ),
      child: Stack(
        children: [
          // Background decorative grid / circles
          Positioned(
            top: -100,
            left: -100,
            child: Container(
              width: 350,
              height: 350,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.accentCyan.withValues(alpha: 0.06),
              ),
            ),
          ),
          Positioned(
            bottom: 50,
            right: -80,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.secondaryColor.withValues(alpha: 0.08),
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 20 : (isTablet ? 40 : 80),
              vertical: isMobile ? 100 : 120,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (isMobile) ...[
                  _buildMobileLayout(context),
                ] else ...[
                  _buildDesktopLayout(context, isTablet),
                ],
                const SizedBox(height: 56),
                _buildMetricsRow(context, isMobile),
                const SizedBox(height: 40),
                _buildScrollIndicator(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      children: [
        _buildProfileAvatar(context, 200),
        const SizedBox(height: 36),
        _buildTextContent(context, true),
      ],
    );
  }

  Widget _buildDesktopLayout(BuildContext context, bool isTablet) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 6,
          child: _buildTextContent(context, false),
        ),
        const SizedBox(width: 48),
        Expanded(
          flex: 5,
          child: Center(
            child: _buildProfileAvatar(context, isTablet ? 280 : 360),
          ),
        ),
      ],
    );
  }

  Widget _buildTextContent(BuildContext context, bool isMobile) {
    return Column(
      crossAxisAlignment:
          isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        // Available for work badge
        _buildStatusBadge(context, isMobile),
        const SizedBox(height: 20),

        // Greeting
        Text(
          "Hello, I'm",
          style: TextStyle(
            fontFamily: AppTheme.fontFamily,
            fontSize: isMobile ? 18 : 22,
            fontWeight: FontWeight.w500,
            color: AppTheme.accentCyan,
            letterSpacing: 0.5,
          ),
        ).animate().fadeIn(duration: 500.ms).slideX(begin: -0.15),
        const SizedBox(height: 8),

        // Name
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Colors.white, Color(0xFFC7D2FE), Color(0xFFA5B4FC)],
          ).createShader(bounds),
          child: Text(
            'Mina Nader',
            style: TextStyle(
              fontFamily: AppTheme.fontFamily,
              fontSize: isMobile ? 38 : 56,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              height: 1.15,
            ),
            textAlign: isMobile ? TextAlign.center : TextAlign.left,
          ),
        ).animate().fadeIn(duration: 600.ms, delay: 150.ms).slideX(begin: -0.15),
        const SizedBox(height: 12),

        // Role title
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment:
              isMobile ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppTheme.primaryColor.withValues(alpha: 0.25),
                    AppTheme.secondaryColor.withValues(alpha: 0.25),
                  ],
                ),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: AppTheme.primaryColor.withValues(alpha: 0.4),
                  width: 1,
                ),
              ),
              child: Text(
                'Flutter Developer',
                style: TextStyle(
                  fontFamily: AppTheme.fontFamily,
                  fontSize: isMobile ? 16 : 20,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.primaryLight,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              '•  Mobile Engineer',
              style: TextStyle(
                fontFamily: AppTheme.fontFamily,
                fontSize: isMobile ? 14 : 16,
                fontWeight: FontWeight.w500,
                color: AppTheme.textLightMuted,
              ),
            ),
          ],
        ).animate().fadeIn(duration: 600.ms, delay: 300.ms).slideX(begin: -0.15),
        const SizedBox(height: 24),

        // Bio based on CV
        Text(
          'Passionate Flutter Developer dedicated to building high-quality, scalable, and intuitive mobile solutions. Specialized in Clean Architecture, robust state management (BLoC, GetX), and high-performance cross-platform delivery with a proven 40% performance boost in production.',
          style: TextStyle(
            fontFamily: AppTheme.fontFamily,
            fontSize: isMobile ? 15 : 17,
            fontWeight: FontWeight.w400,
            color: AppTheme.textLightSecondary,
            height: 1.7,
          ),
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
        ).animate().fadeIn(duration: 600.ms, delay: 450.ms).slideY(begin: 0.15),
        const SizedBox(height: 32),

        // CTA Buttons
        _buildActionButtons(context, isMobile),
        const SizedBox(height: 28),

        // Social Links
        _buildSocialLinks(context, isMobile),
      ],
    );
  }

  Widget _buildStatusBadge(BuildContext context, bool isMobile) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: AppTheme.accentEmerald.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: AppTheme.accentEmerald.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppTheme.accentEmerald,
              boxShadow: [
                BoxShadow(
                  color: AppTheme.accentEmerald.withValues(alpha: 0.6),
                  blurRadius: 8,
                  spreadRadius: 2,
                ),
              ],
            ),
          )
              .animate(onPlay: (c) => c.repeat(reverse: true))
              .scale(
                begin: const Offset(0.9, 0.9),
                end: const Offset(1.3, 1.3),
                duration: 900.ms,
              ),
          const SizedBox(width: 8),
          Text(
            'Available for new opportunities',
            style: TextStyle(
              fontFamily: AppTheme.fontFamily,
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppTheme.accentEmerald,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 500.ms).slideY(begin: -0.2);
  }

  Widget _buildProfileAvatar(BuildContext context, double size) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Outer pulsing ring
        Container(
          width: size + 24,
          height: size + 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: SweepGradient(
              colors: [
                AppTheme.primaryColor.withValues(alpha: 0.7),
                AppTheme.accentCyan.withValues(alpha: 0.7),
                AppTheme.secondaryColor.withValues(alpha: 0.7),
                AppTheme.primaryColor.withValues(alpha: 0.7),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: AppTheme.primaryColor.withValues(alpha: 0.35),
                blurRadius: 36,
                spreadRadius: 4,
              ),
            ],
          ),
        ),

        // Dark spacer ring
        Container(
          width: size + 12,
          height: size + 12,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppTheme.darkBackground,
          ),
        ),

        // Actual Image container
        Container(
          width: size,
          height: size,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage('assets/1713665244351.jpeg'),
              fit: BoxFit.cover,
            ),
          ),
        ),

        // Floating Experience badge
        Positioned(
          bottom: 10,
          right: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: AppTheme.darkSurfaceCard,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: AppTheme.primaryColor.withValues(alpha: 0.4),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.5),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.verified_rounded,
                  color: AppTheme.accentCyan,
                  size: 18,
                ),
                const SizedBox(width: 6),
                Text(
                  'Clean Architecture',
                  style: TextStyle(
                    fontFamily: AppTheme.fontFamily,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ).animate().fadeIn(duration: 700.ms, delay: 500.ms).slideY(begin: 0.2),
        ),

        // Floating Flutter badge
        Positioned(
          top: 10,
          left: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppTheme.darkSurfaceCard,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: AppTheme.accentCyan.withValues(alpha: 0.4),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.4),
                  blurRadius: 12,
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.flutter_dash,
                  color: AppTheme.accentCyan,
                  size: 16,
                ),
                const SizedBox(width: 6),
                Text(
                  'Dart & Flutter',
                  style: TextStyle(
                    fontFamily: AppTheme.fontFamily,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.textLightPrimary,
                  ),
                ),
              ],
            ),
          ).animate().fadeIn(duration: 700.ms, delay: 600.ms).slideY(begin: -0.2),
        ),
      ],
    ).animate().scale(duration: 700.ms, delay: 200.ms);
  }

  Widget _buildActionButtons(BuildContext context, bool isMobile) {
    return Wrap(
      spacing: 16,
      runSpacing: 14,
      alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
      children: [
        // Primary: Explore Projects
        Container(
          decoration: BoxDecoration(
            gradient: AppTheme.primaryGradient,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: AppTheme.primaryColor.withValues(alpha: 0.35),
                blurRadius: 18,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: onExploreProjects,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.rocket_launch_rounded, size: 18),
                const SizedBox(width: 8),
                Text(
                  'Explore Projects',
                  style: TextStyle(
                    fontFamily: AppTheme.fontFamily,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),

        // Secondary: Download CV
        OutlinedButton.icon(
          onPressed: () => _launchUrl(
              'https://drive.google.com/file/d/1TlzfoVQL9OvOtL4GwWhj16UziVHiUq_6/view'),
          icon: const Icon(Icons.download_rounded, size: 18, color: AppTheme.accentCyan),
          label: Text(
            'Download CV',
            style: TextStyle(
              fontFamily: AppTheme.fontFamily,
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: AppTheme.textLightPrimary,
            ),
          ),
          style: OutlinedButton.styleFrom(
            side: BorderSide(
              color: AppTheme.accentCyan.withValues(alpha: 0.4),
              width: 1.5,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            backgroundColor: AppTheme.darkSurfaceCard.withValues(alpha: 0.6),
          ),
        ),

        // Tertiary: Contact Me
        TextButton.icon(
          onPressed: onContactMe ??
              () => _launchUrl('mailto:nadermina30@gmail.com'),
          icon: const Icon(Icons.mail_outline_rounded,
              size: 18, color: AppTheme.primaryLight),
          label: Text(
            'Get in Touch',
            style: TextStyle(
              fontFamily: AppTheme.fontFamily,
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: AppTheme.primaryLight,
            ),
          ),
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          ),
        ),
      ],
    ).animate().fadeIn(duration: 600.ms, delay: 600.ms).slideY(begin: 0.15);
  }

  Widget _buildSocialLinks(BuildContext context, bool isMobile) {
    final links = [
      {
        'icon': Icons.code_rounded,
        'label': 'GitHub',
        'url': 'https://github.com/minanader11',
        'color': const Color(0xFFE2E8F0),
      },
      {
        'icon': Icons.work_outline_rounded,
        'label': 'LinkedIn',
        'url': 'https://www.linkedin.com/in/mina-nader-b6b3b526a/',
        'color': const Color(0xFF38BDF8),
      },
      {
        'icon': Icons.email_outlined,
        'label': 'Email',
        'url': 'mailto:nadermina30@gmail.com',
        'color': const Color(0xFFA78BFA),
      },
      {
        'icon': Icons.phone_outlined,
        'label': 'Phone',
        'url': 'tel:+201223397467',
        'color': const Color(0xFF34D399),
      },
    ];

    return Row(
      mainAxisAlignment:
          isMobile ? MainAxisAlignment.center : MainAxisAlignment.start,
      children: links.asMap().entries.map((entry) {
        final index = entry.key;
        final item = entry.value;
        return Padding(
          padding: const EdgeInsets.only(right: 12),
          child: Tooltip(
            message: item['label'] as String,
            child: InkWell(
              onTap: () => _launchUrl(item['url'] as String),
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.darkSurfaceCard,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppTheme.darkBorder,
                    width: 1,
                  ),
                ),
                child: Icon(
                  item['icon'] as IconData,
                  color: item['color'] as Color,
                  size: 20,
                ),
              ),
            ),
          ),
        )
            .animate()
            .fadeIn(duration: 500.ms, delay: (750 + index * 80).ms)
            .slideX(begin: 0.1);
      }).toList(),
    );
  }

  Widget _buildMetricsRow(BuildContext context, bool isMobile) {
    final metrics = [
      {'value': '3+', 'label': 'Years of Experience'},
      {'value': '8+', 'label': 'Production Apps'},
      {'value': '40%', 'label': 'Performance Gain'},
      {'value': '100%', 'label': 'Commitment & Delivery'},
    ];

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 28,
        vertical: 20,
      ),
      decoration: BoxDecoration(
        color: AppTheme.darkSurfaceCard.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppTheme.darkBorder,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: isMobile
          ? GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: metrics.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2.2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemBuilder: (context, i) => _buildMetricItem(
                metrics[i]['value']!,
                metrics[i]['label']!,
              ),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: metrics.asMap().entries.map((entry) {
                final index = entry.key;
                final m = entry.value;
                return Row(
                  children: [
                    _buildMetricItem(m['value']!, m['label']!),
                    if (index < metrics.length - 1)
                      Container(
                        height: 36,
                        width: 1,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        color: AppTheme.darkBorder,
                      ),
                  ],
                );
              }).toList(),
            ),
    ).animate().fadeIn(duration: 700.ms, delay: 850.ms).slideY(begin: 0.2);
  }

  Widget _buildMetricItem(String value, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [AppTheme.accentCyan, AppTheme.primaryLight],
          ).createShader(bounds),
          child: Text(
            value,
            style: TextStyle(
              fontFamily: AppTheme.fontFamily,
              fontSize: 26,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              height: 1.1,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontFamily: AppTheme.fontFamily,
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: AppTheme.textLightMuted,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildScrollIndicator(BuildContext context) {
    return Column(
      children: [
        Text(
          'Scroll to explore',
          style: TextStyle(
            fontFamily: AppTheme.fontFamily,
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: AppTheme.textLightMuted,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 6),
        Icon(
          Icons.keyboard_arrow_down_rounded,
          color: AppTheme.primaryLight,
          size: 22,
        )
            .animate(onPlay: (controller) => controller.repeat())
            .moveY(begin: 0, end: 8, duration: 1.2.seconds)
            .then()
            .moveY(begin: 8, end: 0, duration: 1.2.seconds),
      ],
    );
  }

  void _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}