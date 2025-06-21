import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:collection/collection.dart';

class SkillsSection extends StatefulWidget {
  const SkillsSection({super.key});

  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection> {
  bool _isVisible = false;

  final Map<String, List<Map<String, dynamic>>> _skills = {
    'Core': [
      {'name': 'Dart', 'level': 95},
      {'name': 'Flutter', 'level': 95},
      {'name': 'Clean Architecture', 'level': 90},
      {'name': 'MVVM', 'level': 85},
      {'name': 'MVI', 'level': 80},
      {'name': 'BLoC', 'level': 90},
      {'name': 'Provider', 'level': 85},
      {'name': 'RxDart', 'level': 80},
      {'name': 'GetX', 'level': 90},
      {'name': 'HTTP', 'level': 90},
      {'name': 'Dio', 'level': 85},
    ],
    'Integration': [
      {'name': 'Google Maps', 'level': 90},
      {'name': 'Geolocation', 'level': 85},
      {'name': 'Firebase (Auth, Firestore, Cloud Messaging)', 'level': 90},
      {'name': 'CRM Integration', 'level': 80},
      {'name': 'Social Login (Facebook, Gmail)', 'level': 85},
      {'name': 'OAuth2', 'level': 80},
      {'name': 'SignalR', 'level': 75},
      {'name': 'Fawry SDK', 'level': 85},
      {'name': 'Stripe SDK', 'level': 80},
    ],
    'Tools': [
      {'name': 'Hive', 'level': 85},
      {'name': 'SQLite', 'level': 80},
      {'name': 'Shared Preferences', 'level': 90},
      {'name': 'Localization', 'level': 85},
      {'name': 'Git', 'level': 95},
      {'name': 'GitHub', 'level': 95},
    ],
    'Design': [
      {'name': 'Adobe XD', 'level': 85},
      {'name': 'Figma', 'level': 90},
    ],
  };

  final List<String> _additionalSkills = [
    'Responsive Design',
    'Cross-platform Development',
    'State Management',
    'Performance Optimization',
    'Testing',
    'Agile Methodology',
    'Code Review',
    'Mentoring',
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;

    return VisibilityDetector(
      key: const Key('skills-section'),
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
        color: Theme.of(context).colorScheme.background,
        child: Column(
          children: [
            _buildSectionHeader(context),
            const SizedBox(height: 64),
            _buildSkillsCard(context),
            const SizedBox(height: 64),
            _buildAdditionalSkills(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context) {
    return Column(
      children: [
        Text(
          'Skills & Expertise',
          style: Theme.of(context).textTheme.displayMedium,
          textAlign: TextAlign.center,
        ).animate(target: _isVisible ? 1 : 0)
            .fadeIn(duration: 600.ms)
            .slideY(begin: 0.2),
        const SizedBox(height: 16),
        Text(
          'My technical skills and areas of expertise',
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

  Widget _buildSkillsCard(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _skills.entries.mapIndexed((index, entry) {
            final category = entry.key;
            final skills = entry.value;
            final categoryColor = _getCategoryColor(category);

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 4,
                      height: 24,
                      decoration: BoxDecoration(
                        color: categoryColor,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      category,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ...skills.asMap().entries.map((entry) {
                  final skill = entry.value;
                  final skillIndex = entry.key;
                  return _SkillItem(
                    name: skill['name'],
                    level: skill['level'],
                    color: categoryColor,
                    isVisible: _isVisible,
                    delay: (600 + index * 300 + skillIndex * 100).ms,
                  );
                }),
                const SizedBox(height: 32),
              ],
            );
          }).toList(),
        ),
      ),
    ).animate(target: _isVisible ? 1 : 0)
        .fadeIn(duration: 600.ms, delay: 600.ms)
        .slideY(begin: 0.2);
  }

  Widget _buildAdditionalSkills(BuildContext context) {
    return Column(
      children: [
        Text(
          'Additional Skills',
          style: Theme.of(context).textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ).animate(target: _isVisible ? 1 : 0)
            .fadeIn(duration: 600.ms, delay: 1200.ms),
        const SizedBox(height: 32),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          alignment: WrapAlignment.center,
          children: _additionalSkills.asMap().entries.map((entry) {
            final index = entry.key;
            final skill = entry.value;
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                ),
              ),
              child: Text(
                skill,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ).animate(target: _isVisible ? 1 : 0)
                .fadeIn(duration: 400.ms, delay: (1400 + index * 100).ms)
                .scale(begin: const Offset(0.8, 0.8));
          }).toList(),
        ),
      ],
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Core':
        return const Color(0xFF3B82F6);
      case 'Integration':
        return const Color(0xFF10B981);
      case 'Design':
        return const Color(0xFFF59E0B);
      case 'Tools':
        return const Color(0xFF8B5CF6);
      default:
        return const Color(0xFF6B7280);
    }
  }
}

class _SkillItem extends StatelessWidget {
  final String name;
  final int level;
  final Color color;
  final bool isVisible;
  final Duration delay;

  const _SkillItem({
    required this.name,
    required this.level,
    required this.color,
    required this.isVisible,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        '• $name',
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.w500,
        ),
      ).animate(target: isVisible ? 1 : 0)
          .fadeIn(duration: 400.ms, delay: delay)
          .slideX(begin: -0.2),
    );
  }
}
