import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  bool _isVisible = false;
  String _selectedCategory = 'All';

  final List<String> _categories = [
    'All',
    'Enterprise & Community',
    'Mobility & Real-Time',
    'Healthcare & Services',
  ];

  final List<Map<String, dynamic>> _projects = [
    {
      'title': 'PALM HILLS',
      'company': 'Initium Solution',
      'category': 'Enterprise & Community',
      'description':
          'A community app for Palm Hills Developments residents to manage their homes, request services, access facilities, invite guests, report issues, and stay updated with nearby shops and activities.',
      'image': 'assets/palmhills.jpg',
      'technologies': ['Flutter', 'Clean Architecture', 'BLoC', 'Firebase'],
      'ios': 'https://apps.apple.com/eg/app/palm-hills/id6477568109',
      'android':
          'https://play.google.com/store/apps/details?id=com.palmhills.communityapp&hl=en',
      'color': const Color(0xFF6366F1),
      'featured': true,
    },
    {
      'title': 'Capital Taxi',
      'company': 'TransIT',
      'category': 'Mobility & Real-Time',
      'description':
          'A taxi app made for people in The New Administrative Capital to easily book rides and get around the city with live GPS vehicle tracking.',
      'image': 'assets/taxi.jpg',
      'technologies': ['Flutter', 'Google Maps', 'SignalR', 'OAuth2', 'RxDart'],
      'ios': 'https://apps.apple.com/eg/app/capital-taxi/id6714467257',
      'android':
          'https://play.google.com/store/apps/details?id=com.capitalTaxiApp&hl=en',
      'color': const Color(0xFFF59E0B),
      'featured': true,
    },
    {
      'title': 'ICCD Hub',
      'company': 'Digital Nests',
      'category': 'Enterprise & Community',
      'description':
          'A mobile platform for the Islamic Chamber of Commerce and Development that connects international members, shares market news, and provides business resources.',
      'technologies': ['Flutter', 'GetX', 'REST APIs', 'Localization'],
      'android': 'https://play.google.com/store/apps/details?id=com.iccdhub.app',
      'color': const Color(0xFF10B981),
      'icon': Icons.hub_rounded,
      'image': 'assets/iccd.png',
      'featured': true,
    },
    {
      'title': 'PropertyPro Sales',
      'company': 'Initium Solution',
      'category': 'Enterprise & Community',
      'description':
          'A sales tool for real estate agents to collect client needs and instantly match them with available units. Stay organized, respond faster, and close deals more efficiently.',
      'technologies': ['Flutter', 'CRM Integration', 'MVI Pattern', 'BLoC'],
      'ios': 'https://apps.apple.com/us/app/propertypro-sales/id6747418237',
      'android':
          'https://play.google.com/store/apps/details?id=com.bareeq.salesagent',
      'color': const Color(0xFF8B5CF6),
      'icon': Icons.real_estate_agent_rounded,
      'image': 'assets/propertypro.jpg',
      'featured': true,
    },
    {
      'title': 'IGames Gamification',
      'company': 'Initium Solution',
      'category': 'Enterprise & Community',
      'description':
          'Workplace gamification using points, rewards, and peer recognition to boost employee engagement, teamwork, and motivation across corporate teams.',
      'technologies': ['Flutter', 'Clean Architecture', 'Gamification', 'REST'],
      'ios':
          'https://apps.apple.com/us/app/igames-workplace-gamification/id1661773665',
      'android':
          'https://play.google.com/store/apps/details?id=com.initium.igames&hl=en',
      'color': const Color(0xFFEC4899),
      'icon': Icons.sports_esports_rounded,
      'image': 'assets/igames.jpg',
      'featured': true,
    },
    {
      'title': 'RepTrust Facility App',
      'company': 'Freelancing',
      'category': 'Enterprise & Community',
      'description':
          'A facility management solution that helps vendors track visits, manage appointments, and streamline operations for improved on-site coordination.',
      'image': 'assets/reptrust.jpg',
      'technologies': ['Flutter', 'Firebase', 'QR Scanning', 'Local Storage'],
      'ios':
          'https://apps.apple.com/us/app/reptrust-facility/id6736663198',
      'android':
          'https://play.google.com/store/apps/details?id=com.reptrustfacilityApp',
      'color': const Color(0xFF06B6D4),
    },
    {
      'title': 'HR App',
      'company': 'TransIT',
      'category': 'Enterprise & Community',
      'description':
          'An internal enterprise HR solution allowing employees to log attendance, submit vacation/overtime requests, and track approvals with managers.',
      'image': 'assets/hr.jpg',
      'technologies': ['Flutter', 'SQLite', 'Dio', 'Push Notifications'],
      'ios':
          'https://apps.apple.com/us/app/transit-human-resources/id1661617424',
      'android':
          'https://play.google.com/store/apps/details?id=com.transit.hrApp&hl=en',
      'color': const Color(0xFF3B82F6),
    },
    {
      'title': 'MyHomeCare',
      'company': 'Digital Nests',
      'category': 'Healthcare & Services',
      'description':
          'A smart home healthcare application connecting patients with doctors to book consultations, manage medical records, and receive care with multilingual support.',
      'technologies': ['Flutter', 'Telemedicine', 'Bilingual Support', 'Dio'],
      'ios':
          'https://apps.apple.com/eg/app/%D8%B1%D8%B9%D8%A7%D9%8A%D8%AA%D9%89-%D8%A7%D9%84%D9%85%D9%86%D8%B2%D9%84%D9%8A%D8%A9/id6756655905',
      'android':
          'https://play.google.com/store/apps/details?id=com.myhomecareapp',
      'color': const Color(0xFF14B8A6),
      'image': 'assets/myhomecare.jpg',
      'icon': Icons.medical_services_rounded,
    },
    // {
    //   'title': 'Sales Agents (ENR)',
    //   'company': 'TransIT',
    //   'category': 'Mobility & Real-Time',
    //   'description':
    //       'A ticketing assistant app designed to help sales agents facilitate Egypt Railway ticket purchases and manage offline transactions with thermal printer support.',
    //   'image': 'assets/enr.png',
    //   'technologies': ['Flutter', 'SQLite', 'Offline First', 'Bluetooth Printing'],
    //   'color': const Color(0xFFEF4444),
    // },
    // {
    //   'title': 'Movies Discovery',
    //   'company': 'Personal Project',
    //   'category': 'Healthcare & Services',
    //   'description':
    //       'A movie discovery platform offering users an engaging experience to explore, browse, and search through a wide catalog of trending films.',
    //   'image': 'assets/movies.png',
    //   'technologies': ['Flutter', 'TMDB API', 'BLoC', 'Responsive UI'],
    //   'android': 'https://play.google.com/store/apps/details?id=com.moviesApp',
    //   'color': const Color(0xFF8B5CF6),
    // },
    // {
    //   'title': 'Learning Platform',
    //   'company': 'Freelancing',
    //   'category': 'Healthcare & Services',
    //   'description':
    //       'An educational platform that enables students to register, manage course subscriptions, track balances, and stream learning content.',
    //   'image': 'assets/learning.jpeg',
    //   'technologies': ['Flutter', 'Firebase', 'Provider', 'Video Player'],
    //   'github': 'https://github.com/minanader11/Learning-app',
    //   'color': const Color(0xFF38BDF8),
    // },
  ];

  List<Map<String, dynamic>> get _filteredProjects {
    if (_selectedCategory == 'All') {
      return _projects;
    }
    return _projects
        .where((project) => project['category'] == _selectedCategory)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    final isTablet = ResponsiveBreakpoints.of(context).isTablet;

    return VisibilityDetector(
      key: const Key('projects-section'),
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
        color: AppTheme.darkBackground,
        child: Column(
          children: [
            _buildSectionHeader(context),
            const SizedBox(height: 36),
            _buildCategoryFilter(context),
            const SizedBox(height: 48),
            _buildProjectsGrid(context, isMobile, isTablet),
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
            'FEATURED PORTFOLIO',
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
          'Production Apps & Projects',
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
          'Explore live applications deployed to the Apple App Store and Google Play Store',
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

  Widget _buildCategoryFilter(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      alignment: WrapAlignment.center,
      children: _categories.map((category) {
        final isSelected = _selectedCategory == category;
        return InkWell(
          onTap: () {
            setState(() {
              _selectedCategory = category;
            });
          },
          borderRadius: BorderRadius.circular(12),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            decoration: BoxDecoration(
              gradient: isSelected ? AppTheme.primaryGradient : null,
              color: isSelected ? null : AppTheme.darkSurfaceCard,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected
                    ? Colors.transparent
                    : AppTheme.darkBorder,
                width: 1,
              ),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: AppTheme.primaryColor.withValues(alpha: 0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : null,
            ),
            child: Text(
              category,
              style: TextStyle(
                fontFamily: AppTheme.fontFamily,
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected ? Colors.white : AppTheme.textLightSecondary,
              ),
            ),
          ),
        );
      }).toList(),
    )
        .animate(target: _isVisible ? 1 : 0)
        .fadeIn(duration: 600.ms, delay: 350.ms);
  }

  Widget _buildProjectsGrid(BuildContext context, bool isMobile, bool isTablet) {
    final projects = _filteredProjects;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isMobile ? 1 : (isTablet ? 2 : 3),
        crossAxisSpacing: 24,
        mainAxisSpacing: 24,
        childAspectRatio: isMobile ? 1.05 : 0.85,
      ),
      itemCount: projects.length,
      itemBuilder: (context, index) {
        return _ProjectCard(
          project: projects[index],
          index: index,
          isVisible: _isVisible,
        );
      },
    );
  }
}

class _ProjectCard extends StatefulWidget {
  final Map<String, dynamic> project;
  final int index;
  final bool isVisible;

  const _ProjectCard({
    required this.project,
    required this.index,
    required this.isVisible,
  });

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final p = widget.project;
    final color = (p['color'] as Color?) ?? AppTheme.primaryColor;
    final hasImage = p['image'] != null;
    final techList = (p['technologies'] as List<String>?) ?? [];

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        transform: Matrix4.translationValues(0.0, _isHovered ? -6.0 : 0.0, 0.0),
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
                  ? color.withValues(alpha: 0.25)
                  : Colors.black.withValues(alpha: 0.3),
              blurRadius: _isHovered ? 24 : 12,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(19),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header visual
              Expanded(
                flex: 4,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    if (hasImage) ...[
                      Image.asset(
                        p['image'] as String,
                        fit: BoxFit.contain,
                      ),
                      // Dark gradient overlay
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              AppTheme.darkSurfaceCard.withValues(alpha: 0.9),
                            ],
                          ),
                        ),
                      ),
                    ] else ...[
                      // Branded gradient banner
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              color.withValues(alpha: 0.4),
                              AppTheme.darkSurfaceCard,
                            ],
                          ),
                        ),
                        child: Center(
                          child: Icon(
                            (p['icon'] as IconData?) ??
                                Icons.mobile_friendly_rounded,
                            size: 56,
                            color: color,
                          ),
                        ),
                      ),
                    ],

                    // Company Badge
                    Positioned(
                      top: 12,
                      left: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppTheme.darkBackground.withValues(alpha: 0.85),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: color.withValues(alpha: 0.4),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          p['company'] as String,
                          style: TextStyle(
                            fontFamily: AppTheme.fontFamily,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: color,
                          ),
                        ),
                      ),
                    ),

                    // Store badges in the header
                    Positioned(
                      bottom: 12,
                      right: 12,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (p['ios'] != null)
                            _buildStoreButton(
                              icon: Icons.apple_rounded,
                              tooltip: 'Apple App Store',
                              url: p['ios'] as String,
                            ),
                          if (p['android'] != null) ...[
                            const SizedBox(width: 8),
                            _buildStoreButton(
                              icon: Icons.android_rounded,
                              tooltip: 'Google Play Store',
                              url: p['android'] as String,
                            ),
                          ],
                          if (p['github'] != null) ...[
                            const SizedBox(width: 8),
                            _buildStoreButton(
                              icon: Icons.code_rounded,
                              tooltip: 'GitHub Repository',
                              url: p['github'] as String,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Card details
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        p['title'] as String,
                        style: TextStyle(
                          fontFamily: AppTheme.fontFamily,
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      Expanded(
                        child: Text(
                          p['description'] as String,
                          style: TextStyle(
                            fontFamily: AppTheme.fontFamily,
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: AppTheme.textLightMuted,
                            height: 1.45,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Tech Stack Tags
                      Wrap(
                        spacing: 6,
                        runSpacing: 4,
                        children: techList.take(3).map((tech) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: AppTheme.darkBackground,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color: AppTheme.darkBorder,
                              ),
                            ),
                            child: Text(
                              tech,
                              style: TextStyle(
                                fontFamily: AppTheme.fontFamily,
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                color: AppTheme.textLightSecondary,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    )
        .animate(target: widget.isVisible ? 1 : 0)
        .fadeIn(duration: 500.ms, delay: (200 + widget.index * 70).ms)
        .slideY(begin: 0.1);
  }

  Widget _buildStoreButton({
    required IconData icon,
    required String tooltip,
    required String url,
  }) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: () => _launchUrl(url),
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(7),
          decoration: BoxDecoration(
            color: AppTheme.darkSurfaceCard.withValues(alpha: 0.95),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.2),
            ),
          ),
          child: Icon(
            icon,
            size: 16,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  void _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}