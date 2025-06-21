import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:url_launcher/url_launcher.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    final isTablet = ResponsiveBreakpoints.of(context).isTablet;
    
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.1),
            Theme.of(context).colorScheme.secondary.withOpacity(0.1),
          ],
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 24 : 48,
          vertical: 80,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isMobile) ...[
              _buildMobileLayout(context),
            ] else ...[
              _buildDesktopLayout(context, isTablet),
            ],
            const SizedBox(height: 48),
            _buildScrollIndicator(context),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      children: [
        _buildProfileImage(context, 200),
        const SizedBox(height: 32),
        _buildTextContent(context, true),
      ],
    );
  }

  Widget _buildDesktopLayout(BuildContext context, bool isTablet) {
    return Row(
      children: [
        Expanded(
          child: _buildTextContent(context, false),
        ),
        const SizedBox(width: 64),
        _buildProfileImage(context, isTablet ? 300 : 400),
      ],
    );
  }

  Widget _buildTextContent(BuildContext context, bool isMobile) {
    return Column(
      crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text(
          'Hello, I\'m',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.w600,
          ),
        ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.2),
        const SizedBox(height: 8),
        Text(
          'Mina Nader',
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
            fontSize: isMobile ? 36 : 48,
          ),
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
        ).animate().fadeIn(duration: 600.ms, delay: 200.ms).slideX(begin: -0.2),
        const SizedBox(height: 16),
        Text(
          'Flutter Developer',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: Theme.of(context).colorScheme.primary,
            fontSize: isMobile ? 20 : 24,
          ),
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
        ).animate().fadeIn(duration: 600.ms, delay: 400.ms).slideX(begin: -0.2),
        const SizedBox(height: 24),
        Text(
          'I create beautiful, functional, and user-centered digital experiences. '
          'With a focus on responsive design and accessibility, I build mobile apps '
          'that look great on any device.',
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
        ).animate().fadeIn(duration: 600.ms, delay: 600.ms).slideY(begin: 0.2),
        const SizedBox(height: 32),
        _buildActionButtons(context, isMobile),
        const SizedBox(height: 32),
        _buildSocialLinks(context, isMobile),
      ],
    );
  }

  Widget _buildProfileImage(BuildContext context, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.secondary,
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage(
                'assets/1713665244351.jpeg',
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    ).animate().scale(duration: 800.ms, delay: 300.ms);
  }

  Widget _buildActionButtons(BuildContext context, bool isMobile) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
      children: [
        ElevatedButton(
          onPressed: () {
            _launchUrl('mailto:nadermina30@gmail.com');
          },
          child: const Text('Get in Touch'),
        ).animate().fadeIn(duration: 600.ms, delay: 800.ms).slideY(begin: 0.2),
        OutlinedButton(
          onPressed: () {
            _launchUrl('https://github.com/minanader11');
          },
          child: const Text('View My Work'),
        ).animate().fadeIn(duration: 600.ms, delay: 1000.ms).slideY(begin: 0.2),
      ],
    );
  }

  Widget _buildSocialLinks(BuildContext context, bool isMobile) {
    return Row(
      mainAxisAlignment: isMobile ? MainAxisAlignment.center : MainAxisAlignment.start,
      children: [
        _SocialButton(
          icon: Icons.code,
          onPressed: () => _launchUrl('https://github.com/minanader11'),
        ),
        const SizedBox(width: 16),
        _SocialButton(
          icon: Icons.work,
          onPressed: () => _launchUrl('https://www.linkedin.com/in/mina-nader-b6b3b526a/'),
        ),
        const SizedBox(width: 16),
        _SocialButton(
          icon: Icons.email,
          onPressed: () => _launchUrl('mailto:nadermina30@gmail.com'),
        ),
      ],
    ).animate().fadeIn(duration: 600.ms, delay: 1200.ms);
  }

  Widget _buildScrollIndicator(BuildContext context) {
    return Column(
      children: [
        Text(
          'Scroll Down',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 8),
        Icon(
          Icons.keyboard_arrow_down,
          color: Theme.of(context).colorScheme.primary,
        ).animate(onPlay: (controller) => controller.repeat())
            .moveY(begin: 0, end: 10, duration: 1.5.seconds)
            .then()
            .moveY(begin: 10, end: 0, duration: 1.5.seconds),
      ],
    );
  }

  void _launchUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }
}

class _SocialButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const _SocialButton({
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(icon),
      style: IconButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        foregroundColor: Theme.of(context).colorScheme.primary,
        padding: const EdgeInsets.all(12),
      ),
    );
  }
}