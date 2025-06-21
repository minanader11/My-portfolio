import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visibility_detector/visibility_detector.dart';

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

    return VisibilityDetector(
      key: const Key('about-section'),
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
        child: Column(
          children: [
            _buildSectionHeader(context),
            const SizedBox(height: 64),
            if (isMobile) ...[
              _buildMobileLayout(context),
            ] else ...[
              _buildDesktopLayout(context),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context) {
    return Column(
      children: [
        Text(
          'About Me',
          style: Theme.of(context).textTheme.displayMedium,
          textAlign: TextAlign.center,
        )
            .animate(target: _isVisible ? 1 : 0)
            .fadeIn(duration: 600.ms)
            .slideY(begin: 0.2),
        const SizedBox(height: 16),
        Text(
          'My background and experience',
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: TextAlign.center,
        )
            .animate(target: _isVisible ? 1 : 0)
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
        )
            .animate(target: _isVisible ? 1 : 0)
            .scaleX(duration: 600.ms, delay: 400.ms),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      children: [
        _buildProfileImage(context),
        const SizedBox(height: 32),
        _buildContent(context),
      ],
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 2, child: _buildProfileImage(context)),
        const SizedBox(width: 64),
        Expanded(flex: 3, child: _buildContent(context)),
      ],
    );
  }

  Widget _buildProfileImage(BuildContext context) {
    return Container(
      height: 400,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/1713665244351.jpeg',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 16,
              right: 16,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      '2+',
                      style:
                          Theme.of(context).textTheme.headlineLarge?.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                    Text(
                      'Years Experience',
                      style: Theme.of(context).textTheme.bodyMedium,
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
        .fadeIn(duration: 800.ms, delay: 600.ms)
        .slideX(begin: -0.2);
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Who I Am',
          style: Theme.of(context).textTheme.headlineMedium,
        )
            .animate(target: _isVisible ? 1 : 0)
            .fadeIn(duration: 600.ms, delay: 800.ms)
            .slideX(begin: 0.2),
        const SizedBox(height: 24),
        Text(
          'Passionate Flutter Developer with a strong focus on building high-quality, user-centric applications. Dedicated to delivering efficient, scalable, and intuitive solutions that enhance user experience and drive business success. Always eager to learn, adapt, and contribute to innovative projects',
          style: Theme.of(context).textTheme.bodyLarge,
        )
            .animate(target: _isVisible ? 1 : 0)
            .fadeIn(duration: 600.ms, delay: 1000.ms)
            .slideY(begin: 0.2),
        const SizedBox(height: 16),
        Text(
          'My approach combines technical expertise with an eye for design to deliver projects that not only meet technical requirements but also provide an engaging user experience. I\'m dedicated to writing clean, maintainable code and creating intuitive user interfaces.',
          style: Theme.of(context).textTheme.bodyLarge,
        )
            .animate(target: _isVisible ? 1 : 0)
            .fadeIn(duration: 600.ms, delay: 1200.ms)
            .slideY(begin: 0.2),
        const SizedBox(height: 32),
        ..._buildExperienceItems(context),
        const SizedBox(height: 32),
        ElevatedButton(
          onPressed: () {
            _launchUrl("https://drive.google.com/file/d/1TlzfoVQL9OvOtL4GwWhj16UziVHiUq_6/view");
          },
          child: const Text('Download Resume'),
        )
            .animate(target: _isVisible ? 1 : 0)
            .fadeIn(duration: 600.ms, delay: 2000.ms)
            .slideY(begin: 0.2),
      ],
    );
  }

  List<Widget> _buildExperienceItems(BuildContext context) {
    final items = [
      {
        'icon': Icons.work,
        'title': 'Experience',
        'subtitle': 'Flutter Developer at Initium Solutions'
      },
      // {'icon': Icons.school, 'title': 'Education', 'subtitle': 'B.Sc in Computer Science, University of Technology'},
      // {'icon': Icons.emoji_events, 'title': 'Certifications', 'subtitle': 'Google UX Design, AWS Certified Developer'},
      // {'icon': Icons.schedule, 'title': 'Availability', 'subtitle': 'Available for freelance projects'},
    ];

    return items.asMap().entries.map((entry) {
      final index = entry.key;
      final item = entry.value;

      return Padding(
        padding: const EdgeInsets.only(bottom: 24),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                item['icon'] as IconData,
                color: Theme.of(context).colorScheme.primary,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['title'] as String,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item['subtitle'] as String,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      )
          .animate(target: _isVisible ? 1 : 0)
          .fadeIn(duration: 600.ms, delay: (1400 + index * 200).ms)
          .slideX(begin: 0.2);
    }).toList();
  }

  void _launchUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }
}
