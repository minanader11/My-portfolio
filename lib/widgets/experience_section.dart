import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../theme/app_theme.dart';

class ExperienceSection extends StatefulWidget {
  const ExperienceSection({super.key});

  @override
  State<ExperienceSection> createState() => _ExperienceSectionState();
}

class _ExperienceSectionState extends State<ExperienceSection> {
  bool _isVisible = false;

  final List<Map<String, dynamic>> _experiences = [
    {
      'role': 'Flutter Developer',
      'company': 'Initium Solution',
      'location': 'Cairo, Egypt',
      'period': 'Feb 2025 – Present',
      'type': 'Full Time',
      'isCurrent': true,
      'color': AppTheme.primaryColor,
      'badge': '40% Performance Boost',
      'highlights': [
        'Improved app performance and reduced loading time by 40% across production builds.',
        'Cleaned and refactored legacy Flutter codebases to significantly enhance maintainability and reduce technical debt.',
        'Architected apps using Clean Architecture, GetX, and BLoC for modular, scalable code structure.',
        'Implemented MVI (Model-View-Intent) pattern for predictable state management and event-driven architecture.',
        'Integrated CRM solutions for rapid data fetching, query execution, and mobile synchronization.',
      ],
      'projects': ['Palm Hills', 'PropertyPro Sales', 'IGames'],
      'techStack': [
        'Flutter',
        'Clean Architecture',
        'BLoC',
        'GetX',
        'MVI',
        'CRM Integration',
      ],
    },
    {
      'role': 'Flutter Developer',
      'company': 'Digital Nests',
      'location': 'Cairo, Egypt',
      'period': 'Sept 2025 – Present',
      'type': 'Part Time',
      'isCurrent': true,
      'color': AppTheme.accentCyan,
      'badge': 'Core Architecture',
      'highlights': [
        'Refactored legacy Flutter code to elevate cross-device stability and runtime performance.',
        'Engineered new features and resolved critical issues for client production applications.',
        'Leveraged GetX for efficient reactive state management, routing, and clean navigation flows.',
      ],
      'projects': ['ICCD Hub', 'MyHomeCare'],
      'techStack': [
        'Flutter',
        'Dart',
        'GetX',
        'REST APIs',
        'Code Refactoring',
      ],
    },
    {
      'role': 'Flutter Developer',
      'company': 'TransIT',
      'location': 'Cairo, Egypt',
      'period': 'Feb 2024 – Feb 2025',
      'type': 'Full Time',
      'isCurrent': false,
      'color': AppTheme.secondaryColor,
      'badge': 'Real-Time & Mobility',
      'highlights': [
        'Built responsive user interfaces with seamless bilingual (Arabic & English) support.',
        'Integrated Google Maps for real-time ride tracking, place autocomplete search, and custom map styling.',
        'Secured applications with enterprise OAuth2 authentication and token management.',
        'Managed reactive streams and complex asynchronous state using RxDart.',
        'Integrated Fawry SDK, Stripe SDK, and Social Authentication (Gmail, Facebook).',
        'Integrated SignalR for real-time live data synchronization and user notifications.',
      ],
      'projects': ['Capital Taxi', 'HR App', 'Sales Agents (ENR)'],
      'techStack': [
        'Flutter',
        'Google Maps',
        'SignalR',
        'RxDart',
        'OAuth2',
        'Fawry & Stripe',
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    final isTablet = ResponsiveBreakpoints.of(context).isTablet;

    return VisibilityDetector(
      key: const Key('experience-section'),
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
        color: AppTheme.darkSurface,
        child: Column(
          children: [
            _buildSectionHeader(context),
            const SizedBox(height: 56),
            _buildExperienceTimeline(context, isMobile),
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
            'CAREER PATHWAY',
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
          'Professional Experience',
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
        const SizedBox(height: 16),
        Text(
          'Proven track record of engineering scalable, high-performance mobile applications',
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

  Widget _buildExperienceTimeline(BuildContext context, bool isMobile) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _experiences.length,
      separatorBuilder: (context, index) => const SizedBox(height: 28),
      itemBuilder: (context, index) {
        final exp = _experiences[index];
        return _ExperienceCard(
          experience: exp,
          index: index,
          isVisible: _isVisible,
          isMobile: isMobile,
        );
      },
    );
  }
}

class _ExperienceCard extends StatefulWidget {
  final Map<String, dynamic> experience;
  final int index;
  final bool isVisible;
  final bool isMobile;

  const _ExperienceCard({
    required this.experience,
    required this.index,
    required this.isVisible,
    required this.isMobile,
  });

  @override
  State<_ExperienceCard> createState() => _ExperienceCardState();
}

class _ExperienceCardState extends State<_ExperienceCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final exp = widget.experience;
    final color = exp['color'] as Color;
    final highlights = exp['highlights'] as List<String>;
    final techStack = exp['techStack'] as List<String>;
    final projects = exp['projects'] as List<String>;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        transform: Matrix4.translationValues(0.0, _isHovered ? -4.0 : 0.0, 0.0),
        padding: EdgeInsets.all(widget.isMobile ? 20 : 28),
        decoration: BoxDecoration(
          color: AppTheme.darkSurfaceCard,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _isHovered
                ? color.withValues(alpha: 0.6)
                : AppTheme.darkBorder,
            width: _isHovered ? 1.5 : 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: _isHovered
                  ? color.withValues(alpha: 0.2)
                  : Colors.black.withValues(alpha: 0.25),
              blurRadius: _isHovered ? 24 : 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Row: Role, Company, Period, Type
            widget.isMobile
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeaderTitle(color, exp),
                      const SizedBox(height: 12),
                      _buildBadgesRow(color, exp),
                    ],
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: _buildHeaderTitle(color, exp)),
                      _buildBadgesRow(color, exp),
                    ],
                  ),
            const SizedBox(height: 20),

            // Divider
            Divider(color: AppTheme.darkBorder),
            const SizedBox(height: 16),

            // Bullet Points
            ...highlights.map(
              (highlight) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 6),
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: color,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        highlight,
                        style: TextStyle(
                          fontFamily: AppTheme.fontFamily,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppTheme.textLightSecondary,
                          height: 1.6,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Associated Projects & Tech Stack
            Wrap(
              spacing: 8,
              runSpacing: 8,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  'Key Apps:',
                  style: TextStyle(
                    fontFamily: AppTheme.fontFamily,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.accentCyan,
                  ),
                ),
                ...projects.map(
                  (p) => Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppTheme.accentCyan.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: AppTheme.accentCyan.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Text(
                      p,
                      style: TextStyle(
                        fontFamily: AppTheme.fontFamily,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.accentCyan,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ...techStack.map(
                  (tech) => Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppTheme.darkBackground,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppTheme.darkBorder),
                    ),
                    child: Text(
                      tech,
                      style: TextStyle(
                        fontFamily: AppTheme.fontFamily,
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: AppTheme.textLightMuted,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    )
        .animate(target: widget.isVisible ? 1 : 0)
        .fadeIn(duration: 600.ms, delay: (200 + widget.index * 150).ms)
        .slideY(begin: 0.1);
  }

  Widget _buildHeaderTitle(Color color, Map<String, dynamic> exp) {
    return Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color.withValues(alpha: 0.3)),
          ),
          child: Icon(
            Icons.business_center_rounded,
            color: color,
            size: 22,
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                exp['role'] as String,
                style: TextStyle(
                  fontFamily: AppTheme.fontFamily,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 2),
              Row(
                children: [
                  Text(
                    exp['company'] as String,
                    style: TextStyle(
                      fontFamily: AppTheme.fontFamily,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: color,
                    ),
                  ),
                  Text(
                    ' — ${exp['location']}',
                    style: TextStyle(
                      fontFamily: AppTheme.fontFamily,
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: AppTheme.textLightMuted,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBadgesRow(Color color, Map<String, dynamic> exp) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      alignment: WrapAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: AppTheme.darkBackground,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppTheme.darkBorder),
          ),
          child: Text(
            exp['period'] as String,
            style: TextStyle(
              fontFamily: AppTheme.fontFamily,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppTheme.textLightPrimary,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: color.withValues(alpha: 0.4)),
          ),
          child: Text(
            exp['type'] as String,
            style: TextStyle(
              fontFamily: AppTheme.fontFamily,
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}
