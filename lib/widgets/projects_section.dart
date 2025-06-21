import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  bool _isVisible = false;
  String _selectedCategory = 'All';

  final List<String> _categories = ['All'];
  final List<Map<String, dynamic>> _projects = [
    {
      'title': 'PALM HILLS (Initium Solution)',
      'description': 'A community app for Palm Hills Developments residents to manage their homes, request services, access facilities, invite guests, report issues, and stay updated with nearby shops and activities.',
      'image': 'assets/palmhills.jpg',
      'category': 'All',
      'technologies': ['Flutter', 'Firebase'],
      'live': 'https://apps.apple.com/eg/app/palm-hills-live/id1508135755',
      'android': 'https://play.google.com/store/apps/details?id=com.palmhills.communityapp&hl=en',
    },
    {
      'title': 'Capital Taxi (TransIT)',
      'description': 'A taxi app made for people in The New Administrative Capital to easily book rides and get around the city.',
      'image': 'assets/taxi.jpg',
      'category': 'All',
      'technologies': ['Flutter', 'Google Maps'],
      'live': 'https://apps.apple.com/eg/app/capital-taxi/id6714467257',
      'android': 'https://play.google.com/store/apps/details?id=com.capitalTaxiApp&hl=en',
    },
    {
      'title': 'RepTrust Facility App (Freelancing)',
      'description': 'A facility management solution that helps vendors track visits, manage appointments, and streamline operations for improved on-site coordination and efficiency.',
      'image': 'assets/reptrust.jpg',
      'category': 'All',
      'technologies': ['Flutter', 'Firebase'],
      'live': 'https://apps.apple.com/us/app/reptrust-facility/id6736663198',
      'android': 'https://play.google.com/store/apps/details?id=com.reptrustfacilityApp',
    },
    {
      'title': 'HR App (TransIT)',
      'description': 'An internal HR solution that allows employees to manage attendance, vacation, and overtime requests while enabling managers to efficiently handle approvals and track records.',
      'image': 'assets/hr.jpg',
      'category': 'All',
      'technologies': ['Flutter', 'SQLite'],
      'live': 'https://apps.apple.com/us/app/transit-human-resources/id1661617424',
      'android': 'https://play.google.com/store/apps/details?id=com.transit.hrApp&hl=en',
    },
    {
      'title': 'Movies App',
      'description': 'A movie discovery platform offering users an engaging experience to explore, browse, and search through a wide selection of popular and recommended films.',
      'image': 'assets/movies.png',
      'category': 'All',
      'technologies': ['Flutter', 'TMDB API'],
      'android': 'https://play.google.com/store/apps/details?id=com.moviesApp',
    },
    {
      'title': 'Sales Agents (TransIT)',
      'description': 'A ticketing assistant app designed to help sales agents facilitate Egypt Railway ticket purchases and manage transactions with bilingual support and offline capabilities.',
      'image': 'assets/enr.png',
      'category': 'All',
      'technologies': ['Flutter', 'SQLite', 'Offline Support'],
    },
    {
      'title': 'Learning App (Freelancing)',
      'description': 'An educational platform that enables students to register, manage their balances, and access a variety of learning materials in a user-friendly environment.',
      'image': 'assets/learning.jpeg',
      'category': 'All',
      'technologies': ['Flutter', 'Firebase'],
      'github': 'https://github.com/minanader11/Learning-app',
    },
  ];

  // final List<Map<String, dynamic>> _projects = [
  //   {
  //     'title': 'E-commerce Platform',
  //     'description': 'A fully responsive e-commerce website with product filtering, cart functionality, and secure checkout.',
  //     'image': 'https://images.pexels.com/photos/5082579/pexels-photo-5082579.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
  //     'category': 'All',
  //     'technologies': ['Flutter', 'Firebase', 'Stripe'],
  //     'github': 'https://github.com',
  //     'live': 'https://example.com',
  //   },
  //   {
  //     'title': 'Task Management App',
  //     'description': 'A productivity app for managing tasks, with features like drag-and-drop, filters, and task prioritization.',
  //     'image': 'https://images.pexels.com/photos/6956324/pexels-photo-6956324.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
  //     'category': 'All',
  //     'technologies': ['Flutter', 'SQLite', 'Provider'],
  //     'github': 'https://github.com',
  //     'live': 'https://example.com',
  //   },
  //   {
  //     'title': 'Weather Dashboard',
  //     'description': 'A weather application that shows current conditions and forecasts for multiple locations.',
  //     'image': 'https://images.pexels.com/photos/1118873/pexels-photo-1118873.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
  //     'category': 'All',
  //     'technologies': ['Flutter Web', 'Weather API', 'Charts'],
  //     'github': 'https://github.com',
  //     'live': 'https://example.com',
  //   },
  //   {
  //     'title': 'Food Delivery App UI',
  //     'description': 'A sleek user interface design for a food delivery mobile application with smooth animations.',
  //     'image': 'https://images.pexels.com/photos/1640774/pexels-photo-1640774.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
  //     'category': 'All',
  //     'technologies': ['Figma', 'Adobe XD', 'Prototyping'],
  //     'live': 'https://example.com',
  //   },
  //   {
  //     'title': 'Social Media Dashboard',
  //     'description': 'A unified dashboard for managing multiple social media accounts and analytics.',
  //     'image': 'https://images.pexels.com/photos/6476257/pexels-photo-6476257.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
  //     'category': 'All',
  //     'technologies': ['Flutter Web', 'REST APIs', 'Charts'],
  //     'github': 'https://github.com',
  //     'live': 'https://example.com',
  //   },
  //   {
  //     'title': 'Fitness Tracker',
  //     'description': 'A mobile application that helps users track workouts, set goals, and monitor progress over time.',
  //     'image': 'https://images.pexels.com/photos/4498362/pexels-photo-4498362.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
  //     'category': 'All',
  //     'technologies': ['Flutter', 'Firebase', 'Health Kit'],
  //     'github': 'https://github.com',
  //   },
  // ];

  List<Map<String, dynamic>> get _filteredProjects {
    if (_selectedCategory == 'All') {
      return _projects;
    }
    return _projects.where((project) => project['category'] == _selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    
    return VisibilityDetector(
      key: const Key('projects-section'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.3 && !_isVisible) {
          setState(() {
            _isVisible = true;
          });
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 24 : 48,
          vertical: 80,
        ),
        color: Theme.of(context).colorScheme.surface,
        child: Column(
          children: [
            _buildSectionHeader(context),
            const SizedBox(height: 48),
            _buildCategoryFilter(context),
            const SizedBox(height: 48),
            _buildProjectsGrid(context, isMobile),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context) {
    return Column(
      children: [
        Text(
          'My Projects',
          style: Theme.of(context).textTheme.displayMedium,
          textAlign: TextAlign.center,
        ).animate(target: _isVisible ? 1 : 0)
            .fadeIn(duration: 600.ms)
            .slideY(begin: 0.2),
        const SizedBox(height: 16),
        Text(
          'A showcase of my recent work and personal projects',
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: TextAlign.center,
        ).animate(target: _isVisible ? 1 : 0)
            .fadeIn(duration: 600.ms, delay: 200.ms)
            .slideY(begin: 0.2),
        const SizedBox(height: 24),
        Container(
          width: 60,
          height: 4,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(2),
          ),
        ).animate(target: _isVisible ? 1 : 0)
            .scaleX(duration: 600.ms, delay: 400.ms),
      ],
    );
  }

  Widget _buildCategoryFilter(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      alignment: WrapAlignment.center,
      children: _categories.map((category) {
        final isSelected = _selectedCategory == category;
        return FilterChip(
          label: Text(category),
          selected: isSelected,
          onSelected: (selected) {
            setState(() {
              _selectedCategory = category;
            });
          },
          backgroundColor: Theme.of(context).colorScheme.surface,
          selectedColor: Theme.of(context).colorScheme.primary,
          labelStyle: TextStyle(
            color: isSelected ? Colors.white : Theme.of(context).colorScheme.onSurface,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        );
      }).toList(),
    ).animate(target: _isVisible ? 1 : 0)
        .fadeIn(duration: 600.ms, delay: 600.ms);
  }

  Widget _buildProjectsGrid(BuildContext context, bool isMobile) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isMobile ? 1 : (ResponsiveBreakpoints.of(context).isTablet ? 2 : 3),
        crossAxisSpacing: 24,
        mainAxisSpacing: 24,
        childAspectRatio: isMobile ? 1.2 : 0.8,
      ),
      itemCount: _filteredProjects.length,
      itemBuilder: (context, index) {
        final project = _filteredProjects[index];
        return _ProjectCard(
          project: project,
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
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        transform: Matrix4.identity()..translate(0.0, _isHovered ? -8.0 : 0.0),
        child: Card(
          elevation: _isHovered ? 12 : 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                        image: DecorationImage(
                          image: AssetImage(widget.project['image']),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    if (_isHovered) ...[
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.7),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 16,
                        right: 16,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (widget.project['github'] != null) ...[
                              IconButton(
                                onPressed: () => _launchUrl(widget.project['github']),
                                icon: const Icon(Icons.code, color: Colors.white),
                                tooltip: 'View on GitHub',
                                style: IconButton.styleFrom(
                                  backgroundColor: Colors.white.withOpacity(0.2),
                                ),
                              ),
                              const SizedBox(width: 8),
                            ],
                            if (widget.project['live'] != null) ...[
                              IconButton(
                                onPressed: () => _launchUrl(widget.project['live']),
                                icon: const Icon(Icons.apple, color: Colors.white),
                                tooltip: 'View on App Store',
                                style: IconButton.styleFrom(
                                  backgroundColor: Colors.white.withOpacity(0.2),
                                ),
                              ),
                              const SizedBox(width: 8),
                            ],
                            if (widget.project['android'] != null) ...[
                              IconButton(
                                onPressed: () => _launchUrl(widget.project['android']),
                                icon: const Icon(Icons.android, color: Colors.white),
                                tooltip: 'View on Google Play',
                                style: IconButton.styleFrom(
                                  backgroundColor: Colors.white.withOpacity(0.2),
                                ),
                              ),
                            ],

                            // if (widget.project['github'] != null) ...[
                            //   IconButton(
                            //     onPressed: () => _launchUrl(widget.project['github']),
                            //     icon: const Icon(Icons.code, color: Colors.white),
                            //     style: IconButton.styleFrom(
                            //       backgroundColor: Colors.white.withOpacity(0.2),
                            //     ),
                            //   ),
                            //   const SizedBox(width: 8),
                            // ],
                            // if (widget.project['live'] != null) ...[
                            //   IconButton(
                            //     onPressed: () => _launchUrl(widget.project['live']),
                            //     icon: const Icon(Icons.launch, color: Colors.white),
                            //     style: IconButton.styleFrom(
                            //       backgroundColor: Colors.white.withOpacity(0.2),
                            //     ),
                            //   ),
                            // ],
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              widget.project['title'],
                              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          // Container(
                          //   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          //   decoration: BoxDecoration(
                          //     color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                          //     borderRadius: BorderRadius.circular(12),
                          //   ),
                          //   child: Text(
                          //     widget.project['category'],
                          //     style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          //       color: Theme.of(context).colorScheme.primary,
                          //       fontWeight: FontWeight.w600,
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.project['description'],
                        style: Theme.of(context).textTheme.bodyMedium,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Spacer(),
                      // Wrap(
                      //   spacing: 6,
                      //   runSpacing: 6,
                      //   children: (widget.project['technologies'] as List<String>)
                      //       .map((tech) => Container(
                      //             padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      //             decoration: BoxDecoration(
                      //               color: Theme.of(context).colorScheme.surface,
                      //               borderRadius: BorderRadius.circular(8),
                      //               border: Border.all(
                      //                 color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
                      //               ),
                      //             ),
                      //             child: Text(
                      //               tech,
                      //               style: Theme.of(context).textTheme.bodySmall,
                      //             ),
                      //           ))
                      //       .toList(),
                      // ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ).animate(target: widget.isVisible ? 1 : 0)
        .fadeIn(duration: 600.ms, delay: (800 + widget.index * 100).ms)
        .slideY(begin: 0.2);
  }

  void _launchUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }
}