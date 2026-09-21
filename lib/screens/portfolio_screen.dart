import 'package:flutter/material.dart';
import '../widgets/navigation_bar.dart';
import '../widgets/hero_section.dart';
import '../widgets/about_section.dart';
import '../widgets/experience_section.dart';
import '../widgets/projects_section.dart';
import '../widgets/skills_section.dart';
import '../widgets/education_section.dart';
import '../widgets/contact_section.dart';
import '../widgets/footer_section.dart';
import '../theme/app_theme.dart';

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({super.key});

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _heroKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _experienceKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _educationKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkBackground,
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                HeroSection(
                  key: _heroKey,
                  onExploreProjects: () => _scrollToSection(_projectsKey),
                  onContactMe: () => _scrollToSection(_contactKey),
                ),
                AboutSection(key: _aboutKey),
                ExperienceSection(key: _experienceKey),
                ProjectsSection(key: _projectsKey),
                SkillsSection(key: _skillsKey),
                EducationSection(key: _educationKey),
                ContactSection(key: _contactKey),
                FooterSection(
                  onScrollToTop: () => _scrollToSection(_heroKey),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: CustomNavigationBar(
              onNavigate: _scrollToSection,
              heroKey: _heroKey,
              aboutKey: _aboutKey,
              experienceKey: _experienceKey,
              projectsKey: _projectsKey,
              skillsKey: _skillsKey,
              educationKey: _educationKey,
              contactKey: _contactKey,
            ),
          ),
        ],
      ),
    );
  }
}
