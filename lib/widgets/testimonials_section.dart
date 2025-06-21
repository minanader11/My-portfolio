import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:visibility_detector/visibility_detector.dart';

class TestimonialsSection extends StatefulWidget {
  const TestimonialsSection({super.key});

  @override
  State<TestimonialsSection> createState() => _TestimonialsSectionState();
}

class _TestimonialsSectionState extends State<TestimonialsSection> {
  bool _isVisible = false;
  int _currentIndex = 0;
  late PageController _pageController;

  final List<Map<String, dynamic>> _testimonials = [
    {
      'name': 'Sarah Johnson',
      'position': 'CEO',
      'company': 'Digital Innovate',
      'avatar': 'https://images.pexels.com/photos/415829/pexels-photo-415829.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
      'text': 'Working with John was an absolute pleasure. He took our vague idea and transformed it into a beautiful, functional app that perfectly represents our brand. His attention to detail and technical expertise are top-notch.',
    },
    {
      'name': 'Michael Chen',
      'position': 'Marketing Director',
      'company': 'GrowthHackers',
      'avatar': 'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
      'text': 'John delivered an app that not only looks great but also performs exceptionally well. Our user engagement has increased by 40% since the launch. His understanding of both design and user experience principles made all the difference.',
    },
    {
      'name': 'Emily Rodriguez',
      'position': 'Product Manager',
      'company': 'TechSolutions',
      'avatar': 'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
      'text': 'I\'ve worked with many developers, but John stands out for his ability to translate complex requirements into elegant solutions. He\'s proactive, communicative, and delivers high-quality work consistently. Would definitely hire again!',
    },
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    
    return VisibilityDetector(
      key: const Key('testimonials-section'),
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
            const SizedBox(height: 64),
            _buildTestimonialCarousel(context, isMobile),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context) {
    return Column(
      children: [
        Text(
          'Testimonials',
          style: Theme.of(context).textTheme.displayMedium,
          textAlign: TextAlign.center,
        ).animate(target: _isVisible ? 1 : 0)
            .fadeIn(duration: 600.ms)
            .slideY(begin: 0.2),
        const SizedBox(height: 16),
        Text(
          'What my clients say about my work',
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

  Widget _buildTestimonialCarousel(BuildContext context, bool isMobile) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 800),
      child: Column(
        children: [
          SizedBox(
            height: isMobile ? 400 : 300,
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemCount: _testimonials.length,
              itemBuilder: (context, index) {
                return _TestimonialCard(
                  testimonial: _testimonials[index],
                  isVisible: _isVisible,
                );
              },
            ),
          ),
          const SizedBox(height: 32),
          _buildCarouselControls(context),
        ],
      ),
    ).animate(target: _isVisible ? 1 : 0)
        .fadeIn(duration: 800.ms, delay: 600.ms);
  }

  Widget _buildCarouselControls(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: List.generate(
            _testimonials.length,
            (index) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentIndex == index
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.outline.withOpacity(0.3),
              ),
            ),
          ),
        ),
        Row(
          children: [
            IconButton(
              onPressed: _currentIndex > 0 ? _previousTestimonial : null,
              icon: const Icon(Icons.chevron_left),
              style: IconButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.surface,
                foregroundColor: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              onPressed: _currentIndex < _testimonials.length - 1 ? _nextTestimonial : null,
              icon: const Icon(Icons.chevron_right),
              style: IconButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.surface,
                foregroundColor: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _previousTestimonial() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _nextTestimonial() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}

class _TestimonialCard extends StatelessWidget {
  final Map<String, dynamic> testimonial;
  final bool isVisible;

  const _TestimonialCard({
    required this.testimonial,
    required this.isVisible,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            Icon(
              Icons.format_quote,
              size: 48,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 24),
            Expanded(
              child: Text(
                '"${testimonial['text']}"',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontStyle: FontStyle.italic,
                  height: 1.6,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(testimonial['avatar']),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      testimonial['name'],
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${testimonial['position']}, ${testimonial['company']}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}