import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:url_launcher/url_launcher.dart';

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

  final List<Map<String, dynamic>> _contactInfo = [
    {
      'icon': Icons.email,
      'title': 'Email',
      'value': 'nadermina30@gmail.com',
      'url': 'mailto:nadermina30@gmail.com',
    },
    {
      'icon': Icons.phone,
      'title': 'Phone',
      'value': '+201223397467',
      'url': 'tel:+201223397467',
    },
    {
      'icon': Icons.location_on,
      'title': 'Location',
      'value': 'Egypt',
      'url': 'https://maps.google.com/?q=Egypt',
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
    
    return VisibilityDetector(
      key: const Key('contact-section'),
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
          'Get In Touch',
          style: Theme.of(context).textTheme.displayMedium,
          textAlign: TextAlign.center,
        ).animate(target: _isVisible ? 1 : 0)
            .fadeIn(duration: 600.ms)
            .slideY(begin: 0.2),
        const SizedBox(height: 16),
        Text(
          'Have a project in mind? Let\'s talk about it',
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

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      children: [
        _buildContactInfo(context),
        const SizedBox(height: 48),
        // _buildContactForm(context),
      ],
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: _buildContactInfo(context)),
        const SizedBox(width: 64),
        // Expanded(child: _buildContactForm(context)),
      ],
    );
  }

  Widget _buildContactInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Contact Information',
          style: Theme.of(context).textTheme.headlineMedium,
        ).animate(target: _isVisible ? 1 : 0)
            .fadeIn(duration: 600.ms, delay: 600.ms)
            .slideX(begin: -0.2),
        const SizedBox(height: 24),
        Text(
          'Feel free to reach out to me through any of the following methods. I\'m always open to discussing new projects, creative ideas, or opportunities to be part of your vision.',
          style: Theme.of(context).textTheme.bodyLarge,
        ).animate(target: _isVisible ? 1 : 0)
            .fadeIn(duration: 600.ms, delay: 800.ms)
            .slideY(begin: 0.2),
        const SizedBox(height: 32),
        ..._contactInfo.asMap().entries.map((entry) {
          final index = entry.key;
          final info = entry.value;
          return Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: _ContactInfoItem(
              icon: info['icon'],
              title: info['title'],
              value: info['value'],
              url: info['url'],
              isVisible: _isVisible,
              delay: (1000 + index * 200).ms,
            ),
          );
        }).toList(),
        const SizedBox(height: 32),
        _buildSocialLinks(context),
      ],
    );
  }

  Widget _buildSocialLinks(BuildContext context) {
    final socialLinks = [
      {'icon': Icons.work, 'url': 'https://www.linkedin.com/in/mina-nader-b6b3b526a/', 'color': const Color(0xFF0077B5)},
      {'icon': Icons.code, 'url': 'https://github.com/minanader11', 'color': const Color(0xFF333333)},
   //   {'icon': Icons.alternate_email, 'url': 'https://twitter.com', 'color': const Color(0xFF1DA1F2)},
    ];

    return Row(
      children: socialLinks.asMap().entries.map((entry) {
        final index = entry.key;
        final social = entry.value;
        return Padding(
          padding: const EdgeInsets.only(right: 16),
          child: IconButton(
            onPressed: () => _launchUrl(social['url'] as String),
            icon: Icon(social['icon'] as IconData),
            style: IconButton.styleFrom(
              backgroundColor: social['color'] as Color,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.all(12),
            ),
          ).animate(target: _isVisible ? 1 : 0)
              .fadeIn(duration: 400.ms, delay: (1800 + index * 100).ms)
              .scale(begin: const Offset(0.8, 0.8)),
        );
      }).toList(),
    );
  }

  // Widget _buildContactForm(BuildContext context) {
  //   return Card(
  //     child: Padding(
  //       padding: const EdgeInsets.all(32),
  //       child: Form(
  //         key: _formKey,
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Text(
  //               'Send Me a Message',
  //               style: Theme.of(context).textTheme.headlineMedium,
  //             ).animate(target: _isVisible ? 1 : 0)
  //                 .fadeIn(duration: 600.ms, delay: 600.ms)
  //                 .slideX(begin: 0.2),
  //             const SizedBox(height: 32),
  //             if (_isSuccess) ...[
  //               Container(
  //                 padding: const EdgeInsets.all(16),
  //                 decoration: BoxDecoration(
  //                   color: Colors.green.withOpacity(0.1),
  //                   borderRadius: BorderRadius.circular(8),
  //                   border: Border.all(color: Colors.green.withOpacity(0.3)),
  //                 ),
  //                 child: Row(
  //                   children: [
  //                     Icon(Icons.check_circle, color: Colors.green),
  //                     const SizedBox(width: 12),
  //                     Expanded(
  //                       child: Text(
  //                         'Your message has been sent successfully! I\'ll get back to you soon.',
  //                         style: TextStyle(color: Colors.green.shade700),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //               const SizedBox(height: 24),
  //             ],
  //             _buildTextField(
  //               controller: _nameController,
  //               label: 'Your Name',
  //               hint: 'John Doe',
  //               validator: (value) => value?.isEmpty == true ? 'Name is required' : null,
  //               delay: 800.ms,
  //             ),
  //             const SizedBox(height: 24),
  //             _buildTextField(
  //               controller: _emailController,
  //               label: 'Your Email',
  //               hint: 'john@example.com',
  //               keyboardType: TextInputType.emailAddress,
  //               validator: (value) {
  //                 if (value?.isEmpty == true) return 'Email is required';
  //                 if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value!)) {
  //                   return 'Please enter a valid email';
  //                 }
  //                 return null;
  //               },
  //               delay: 1000.ms,
  //             ),
  //             const SizedBox(height: 24),
  //             _buildTextField(
  //               controller: _subjectController,
  //               label: 'Subject',
  //               hint: 'Project Inquiry',
  //               validator: (value) => value?.isEmpty == true ? 'Subject is required' : null,
  //               delay: 1200.ms,
  //             ),
  //             const SizedBox(height: 24),
  //             _buildTextField(
  //               controller: _messageController,
  //               label: 'Your Message',
  //               hint: 'Tell me about your project...',
  //               maxLines: 5,
  //               validator: (value) => value?.isEmpty == true ? 'Message is required' : null,
  //               delay: 1400.ms,
  //             ),
  //             const SizedBox(height: 32),
  //             SizedBox(
  //               width: double.infinity,
  //               child: ElevatedButton(
  //                 onPressed: _isSubmitting ? null : _submitForm,
  //                 child: _isSubmitting
  //                     ? const Row(
  //                         mainAxisAlignment: MainAxisAlignment.center,
  //                         children: [
  //                           SizedBox(
  //                             width: 20,
  //                             height: 20,
  //                             child: CircularProgressIndicator(strokeWidth: 2),
  //                           ),
  //                           SizedBox(width: 12),
  //                           Text('Sending...'),
  //                         ],
  //                       )
  //                     : const Row(
  //                         mainAxisAlignment: MainAxisAlignment.center,
  //                         children: [
  //                           Text('Send Message'),
  //                           SizedBox(width: 8),
  //                           Icon(Icons.send, size: 18),
  //                         ],
  //                       ),
  //               ),
  //             ).animate(target: _isVisible ? 1 : 0)
  //                 .fadeIn(duration: 600.ms, delay: 1600.ms)
  //                 .slideY(begin: 0.2),
  //           ],
  //         ),
  //       ),
  //     ),
  //   ).animate(target: _isVisible ? 1 : 0)
  //       .fadeIn(duration: 800.ms, delay: 600.ms)
  //       .slideX(begin: 0.2);
  // }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required Duration delay,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 2,
          ),
        ),
      ),
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,
    ).animate(target: _isVisible ? 1 : 0)
        .fadeIn(duration: 600.ms, delay: delay)
        .slideY(begin: 0.2);
  }

  void _submitForm() async {
    if (_formKey.currentState?.validate() == true) {
      setState(() {
        _isSubmitting = true;
      });

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      setState(() {
        _isSubmitting = false;
        _isSuccess = true;
      });

      // Clear form
      _nameController.clear();
      _emailController.clear();
      _subjectController.clear();
      _messageController.clear();

      // Reset success message after 5 seconds
      Future.delayed(const Duration(seconds: 5), () {
        if (mounted) {
          setState(() {
            _isSuccess = false;
          });
        }
      });
    }
  }

  void _launchUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }
}

class _ContactInfoItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final String url;
  final bool isVisible;
  final Duration delay;

  const _ContactInfoItem({
    required this.icon,
    required this.title,
    required this.value,
    required this.url,
    required this.isVisible,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _launchUrl(url),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: Theme.of(context).colorScheme.primary,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ],
        ),
      ),
    ).animate(target: isVisible ? 1 : 0)
        .fadeIn(duration: 600.ms, delay: delay)
        .slideX(begin: -0.2);
  }

  void _launchUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }
}