import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  bool _isVisible = false;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();
  bool _isSubmitting = false;
  bool _isSuccess = false;

  final List<Map<String, dynamic>> _contactCards = [
    {
      'icon': Icons.email_rounded,
      'title': 'Email',
      'value': 'nadermina30@gmail.com',
      'action': 'Send Email',
      'url': 'mailto:nadermina30@gmail.com',
      'color': AppTheme.primaryColor,
    },
    {
      'icon': Icons.phone_rounded,
      'title': 'Phone / WhatsApp',
      'value': '+201223397467',
      'action': 'Call / Chat',
      'url': 'https://wa.me/201223397467',
      'color': AppTheme.accentEmerald,
    },
    {
      'icon': Icons.location_on_rounded,
      'title': 'Location',
      'value': 'Cairo, Egypt',
      'action': 'Open to Remote',
      'url': 'https://maps.google.com/?q=Cairo,Egypt',
      'color': AppTheme.accentCyan,
    },
    {
      'icon': Icons.work_rounded,
      'title': 'LinkedIn',
      'value': 'Mina Nader',
      'action': 'Connect',
      'url': 'https://www.linkedin.com/in/mina-nader-b6b3b526a/',
      'color': const Color(0xFF0A66C2),
    },
    {
      'icon': Icons.code_rounded,
      'title': 'GitHub',
      'value': 'minanader11',
      'action': 'View Repos',
      'url': 'https://github.com/minanader11',
      'color': const Color(0xFFE2E8F0),
    },
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    final isTablet = ResponsiveBreakpoints.of(context).isTablet;

    return VisibilityDetector(
      key: const Key('contact-section'),
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
            if (isMobile) ...[
              _buildCardsGrid(context, true),
              const SizedBox(height: 40),
              _buildContactForm(context),
            ] else ...[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 5,
                    child: _buildCardsGrid(context, false),
                  ),
                  const SizedBox(width: 48),
                  Expanded(
                    flex: 6,
                    child: _buildContactForm(context),
                  ),
                ],
              ),
            ],
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
            'GET IN TOUCH',
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
          "Let's Build Something Great Together",
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
          'Open for full-time opportunities, high-impact consulting, and innovative mobile projects',
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

  Widget _buildCardsGrid(BuildContext context, bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Direct Contact Channels',
          style: TextStyle(
            fontFamily: AppTheme.fontFamily,
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        ..._contactCards.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          final color = item['color'] as Color;

          return Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: InkWell(
              onTap: () => _launchUrl(item['url'] as String),
              borderRadius: BorderRadius.circular(16),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.darkSurfaceCard,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppTheme.darkBorder,
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: color.withValues(alpha: 0.3)),
                      ),
                      child: Icon(
                        item['icon'] as IconData,
                        color: color,
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['title'] as String,
                            style: TextStyle(
                              fontFamily: AppTheme.fontFamily,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: AppTheme.textLightMuted,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            item['value'] as String,
                            style: TextStyle(
                              fontFamily: AppTheme.fontFamily,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_rounded,
                      size: 18,
                      color: AppTheme.textLightMuted,
                    ),
                  ],
                ),
              ),
            ),
          )
              .animate(target: _isVisible ? 1 : 0)
              .fadeIn(duration: 500.ms, delay: (300 + index * 80).ms)
              .slideX(begin: -0.1);
        }),
      ],
    );
  }

  Widget _buildContactForm(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: AppTheme.darkSurfaceCard,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppTheme.darkBorder),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Send a Quick Message',
              style: TextStyle(
                fontFamily: AppTheme.fontFamily,
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "I typically respond within 24 hours.",
              style: TextStyle(
                fontFamily: AppTheme.fontFamily,
                fontSize: 14,
                color: AppTheme.textLightMuted,
              ),
            ),
            const SizedBox(height: 24),

            if (_isSuccess) ...[
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppTheme.accentEmerald.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                      color: AppTheme.accentEmerald.withValues(alpha: 0.4)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.check_circle_rounded,
                        color: AppTheme.accentEmerald),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Thank you! Your message has been sent. Mina will contact you shortly.',
                        style: TextStyle(
                          fontFamily: AppTheme.fontFamily,
                          color: AppTheme.accentEmerald,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
            ],

            _buildFormField(
              controller: _nameController,
              label: 'Your Name',
              hint: 'e.g. John Doe',
              icon: Icons.person_outline_rounded,
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Please enter your name' : null,
            ),
            const SizedBox(height: 16),
            _buildFormField(
              controller: _emailController,
              label: 'Your Email',
              hint: 'e.g. john@example.com',
              icon: Icons.alternate_email_rounded,
              keyboardType: TextInputType.emailAddress,
              validator: (v) {
                if (v == null || v.trim().isEmpty) {
                  return 'Please enter your email';
                }
                if (!v.contains('@') || !v.contains('.')) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            _buildFormField(
              controller: _subjectController,
              label: 'Subject',
              hint: 'e.g. Flutter Project / Hiring Opportunity',
              icon: Icons.subject_rounded,
              validator: (v) => (v == null || v.trim().isEmpty)
                  ? 'Please enter a subject'
                  : null,
            ),
            const SizedBox(height: 16),
            _buildFormField(
              controller: _messageController,
              label: 'Message',
              hint: 'Describe your idea, project, or role...',
              icon: Icons.chat_bubble_outline_rounded,
              maxLines: 4,
              validator: (v) => (v == null || v.trim().isEmpty)
                  ? 'Please enter your message'
                  : null,
            ),
            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: Container(
                decoration: BoxDecoration(
                  gradient: AppTheme.primaryGradient,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.primaryColor.withValues(alpha: 0.3),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: _isSubmitting ? null : _submitMessage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: _isSubmitting
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.send_rounded, size: 18),
                            const SizedBox(width: 8),
                            Text(
                              'Send Message',
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
            ),
          ],
        ),
      ),
    )
        .animate(target: _isVisible ? 1 : 0)
        .fadeIn(duration: 600.ms, delay: 400.ms)
        .slideX(begin: 0.1);
  }

  Widget _buildFormField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    int maxLines = 1,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: validator,
      style: const TextStyle(
        fontFamily: AppTheme.fontFamily,
        color: Colors.white,
        fontSize: 14,
      ),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, color: AppTheme.primaryLight, size: 20),
        filled: true,
        fillColor: AppTheme.darkBackground,
        labelStyle: TextStyle(
          fontFamily: AppTheme.fontFamily,
          color: AppTheme.textLightMuted,
          fontSize: 13,
        ),
        hintStyle: TextStyle(
          fontFamily: AppTheme.fontFamily,
          color: AppTheme.textLightMuted.withValues(alpha: 0.6),
          fontSize: 13,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: AppTheme.darkBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppTheme.primaryColor, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Colors.redAccent),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
        ),
      ),
    );
  }

  void _submitMessage() async {
    if (_formKey.currentState?.validate() == true) {
      setState(() {
        _isSubmitting = true;
      });

      // Launch user's default email client pre-filled
      final name = Uri.encodeComponent(_nameController.text.trim());
      final subject = Uri.encodeComponent(_subjectController.text.trim());
      final body = Uri.encodeComponent(
        'From: $name\nEmail: ${_emailController.text.trim()}\n\n${_messageController.text.trim()}',
      );

      final mailtoUri =
          'mailto:nadermina30@gmail.com?subject=[Portfolio] $subject&body=$body';

      await Future.delayed(const Duration(milliseconds: 600));

      _launchUrl(mailtoUri);

      if (mounted) {
        setState(() {
          _isSubmitting = false;
          _isSuccess = true;
        });

        _nameController.clear();
        _emailController.clear();
        _subjectController.clear();
        _messageController.clear();
      }
    }
  }

  void _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}