import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../theme/app_theme.dart';

class SkillsSection extends StatefulWidget {
  const SkillsSection({super.key});

  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection> {
  bool _isVisible = false;

  final List<Map<String, dynamic>> _skillCategories = [
    {
      'title': 'Languages & Frameworks',
      'icon': Icons.code_rounded,
      'color': AppTheme.primaryColor,
      'skills': ['Dart', 'Flutter', 'Cross-Platform Engine'],
    },
    {
      'title': 'Architecture & Design Patterns',
      'icon': Icons.architecture_rounded,
      'color': AppTheme.accentCyan,
      'skills': [
        'Clean Architecture',
        'MVI Pattern',
        'MVVM',
        'Repository Pattern',
        'Layered Architecture',
      ],
    },
    {
      'title': 'State Management',
      'icon': Icons.stream_rounded,
      'color': AppTheme.secondaryColor,
      'skills': ['BLoC', 'GetX', 'Provider', 'RxDart'],
    },
    {
      'title': 'Networking & Real-Time',
      'icon': Icons.cloud_sync_rounded,
      'color': AppTheme.accentEmerald,
      'skills': ['Dio', 'HTTP', 'SignalR', 'RESTful APIs', 'WebSockets'],
    },
    {
      'title': 'Backend, Cloud & Auth',
      'icon': Icons.cloud_outlined,
      'color': const Color(0xFFF59E0B),
      'skills': [
        'Firebase Auth',
        'Firestore',
        'Cloud Messaging (FCM)',
        'CRM Systems',
        'OAuth2',
        'Social Login (Google & FB)',
      ],
    },
    {
      'title': 'Storage & Persistence',
      'icon': Icons.storage_rounded,
      'color': const Color(0xFFEC4899),
      'skills': [
        'Hive',
        'SQLite',
        'Drift',
        'Shared Preferences',
        'Localization (AR/EN)',
      ],
    },
    {
      'title': 'Maps, Location & Documents',
      'icon': Icons.map_rounded,
      'color': const Color(0xFF06B6D4),
      'skills': [
        'Google Maps',
        'Geolocation & Tracking',
        'Digital Signature',
        'PDF Generation & Annotation',
        'ID Card Scanning',
      ],
    },
    {
      'title': 'FinTech, Tools & Design',
      'icon': Icons.terminal_rounded,
      'color': const Color(0xFF10B981),
      'skills': [
        'Fawry SDK',
        'Stripe SDK',
        'Git',
        'GitHub',
        'Figma',
        'Adobe XD',
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    final isTablet = ResponsiveBreakpoints.of(context).isTablet;

    return VisibilityDetector(
      key: const Key('skills-section'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.1 && !_isVisible) {
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
        color: AppTheme.darkSurface,
        child: Column(
          children: [
            _buildSectionHeader(context),
            const SizedBox(height: 56),
            _buildSkillsGrid(context, isMobile, isTablet),
            const SizedBox(height: 48),
            _buildProficienciesBanner(context, isMobile),
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
            'TECHNICAL EXPERTISE',
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
          'Skills & Core Competencies',
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
        const SizedBox(height: 14),
        Text(
          'Comprehensive toolkit powering production-grade mobile engineering',
          style: TextStyle(
            fontFamily: AppTheme.fontFamily,
            fontSize: 15,
            color: AppTheme.textLightSecondary,
          ),
          textAlign: TextAlign.center,
        )
            .animate(target: _isVisible ? 1 : 0)
            .fadeIn(duration: 600.ms, delay: 200.ms),
      ],
    );
  }

  Widget _buildSkillsGrid(BuildContext context, bool isMobile, bool isTablet) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _skillCategories.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isMobile ? 1 : (isTablet ? 2 : 4),
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        childAspectRatio: isMobile ? 1.8 : (isTablet ? 1.35 : 1.15),
      ),
      itemBuilder: (context, index) {
        final category = _skillCategories[index];
        final color = category['color'] as Color;
        final skills = category['skills'] as List<String>;

        return Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: AppTheme.darkSurfaceCard,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppTheme.darkBorder,
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: color.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Icon(
                      category['icon'] as IconData,
                      color: color,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      category['title'] as String,
                      style: TextStyle(
                        fontFamily: AppTheme.fontFamily,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: skills.map((skill) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 9, vertical: 5),
                      decoration: BoxDecoration(
                        color: AppTheme.darkBackground,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: AppTheme.darkBorder,
                        ),
                      ),
                      child: Text(
                        skill,
                        style: TextStyle(
                          fontFamily: AppTheme.fontFamily,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppTheme.textLightSecondary,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        )
            .animate(target: _isVisible ? 1 : 0)
            .fadeIn(duration: 500.ms, delay: (200 + index * 60).ms)
            .slideY(begin: 0.1);
      },
    );
  }

  Widget _buildProficienciesBanner(BuildContext context, bool isMobile) {
    final items = [
      {
        'title': 'English Proficiency',
        'desc': 'Professional Working Proficiency',
        'icon': Icons.language_rounded,
        'color': AppTheme.accentCyan,
      },
      {
        'title': 'Arabic Language',
        'desc': 'Native Speaker',
        'icon': Icons.record_voice_over_rounded,
        'color': AppTheme.primaryLight,
      },
      {
        'title': 'Agile & Best Practices',
        'desc': 'Git Flow, CI/CD, Code Review',
        'icon': Icons.task_alt_rounded,
        'color': AppTheme.accentEmerald,
      },
    ];

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 18 : 28,
        vertical: 20,
      ),
      decoration: BoxDecoration(
        color: AppTheme.darkSurfaceCard,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppTheme.darkBorder),
      ),
      child: isMobile
          ? Column(
              children: items.map((item) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: _buildBannerItem(item),
                );
              }).toList(),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: items.map((item) => _buildBannerItem(item)).toList(),
            ),
    )
        .animate(target: _isVisible ? 1 : 0)
        .fadeIn(duration: 600.ms, delay: 700.ms);
  }

  Widget _buildBannerItem(Map<String, dynamic> item) {
    final color = item['color'] as Color;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            shape: BoxShape.circle,
          ),
          child: Icon(
            item['icon'] as IconData,
            color: color,
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              item['title'] as String,
              style: TextStyle(
                fontFamily: AppTheme.fontFamily,
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            Text(
              item['desc'] as String,
              style: TextStyle(
                fontFamily: AppTheme.fontFamily,
                fontSize: 12,
                color: AppTheme.textLightMuted,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
