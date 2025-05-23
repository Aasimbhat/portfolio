import 'package:flutter/material.dart';

import '../widgets/project_card.dart';

class ProjectsSection extends StatefulWidget {
  final AnimationController animationController;
  final Size screenSize;

  const ProjectsSection({
    super.key,
    required this.animationController,
    required this.screenSize,
  });

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = widget.screenSize.width < 600;
    final isTablet =
        widget.screenSize.width >= 600 && widget.screenSize.width < 900;

    return Padding(
      padding: EdgeInsets.only(
        top: isMobile ? 80 : 40,
        left: isMobile ? 16 : 40,
        right: isMobile ? 16 : 40,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, -0.2),
              end: Offset.zero,
            ).animate(
              CurvedAnimation(
                parent: widget.animationController,
                curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
              ),
            ),
            child: FadeTransition(
              opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(
                  parent: widget.animationController,
                  curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
                ),
              ),
              child: Text(
                "MY PROJECTS",
                style: TextStyle(
                  fontSize: isMobile ? 14 : 18,
                  letterSpacing: 4,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, -0.1),
              end: Offset.zero,
            ).animate(
              CurvedAnimation(
                parent: widget.animationController,
                curve: const Interval(0.1, 0.6, curve: Curves.easeOut),
              ),
            ),
            child: FadeTransition(
              opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(
                  parent: widget.animationController,
                  curve: const Interval(0.1, 0.6, curve: Curves.easeOut),
                ),
              ),
              child: Text(
                "Recent Work",
                style: TextStyle(
                  fontSize: isMobile ? 36 : 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
          Expanded(
            child:
                isMobile
                    ? ListView(children: _buildProjectCards(isMobile: true))
                    : GridView.count(
                      crossAxisCount: isTablet ? 2 : 3,
                      childAspectRatio: isTablet ? 1.2 : 1.5,
                      mainAxisSpacing: 24,
                      crossAxisSpacing: 24,
                      children: _buildProjectCards(isMobile: false),
                    ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildProjectCards({required bool isMobile}) {
    final projects = _getProjectsData();

    final cards = <Widget>[];
    for (int i = 0; i < projects.length; i++) {
      final project = projects[i];
      final card = SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.2),
          end: Offset.zero,
        ).animate(
          CurvedAnimation(
            parent: widget.animationController,
            curve: Interval(
              0.2 + (i * 0.05),
              0.7 + (i * 0.05),
              curve: Curves.easeOut,
            ),
          ),
        ),
        child: FadeTransition(
          opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
              parent: widget.animationController,
              curve: Interval(
                0.2 + (i * 0.05),
                0.7 + (i * 0.05),
                curve: Curves.easeOut,
              ),
            ),
          ),
          child: ProjectCard(
            title: project['title']! as String,
            description: project['description']! as String,
            technologies:
                (project['stack']! as String)
                    .split(RegExp(r'\s*\|\s*|,\s*'))
                    .where((s) => s.isNotEmpty)
                    .toList(),
            imagePath: '', // No image for these projects
            onTap: () {},
            isMobile: isMobile,
          ),
        ),
      );
      cards.add(card);
    }

    return cards;
  }

  List<Map<String, dynamic>> _getProjectsData() {
    return [
      {
        'title': 'Brexa Ai',
        'stack': 'Flutter | React Native Expo',
        'link': 'https://your-brexa-link.com',
        'date': 'Nov 2023',
        'description':
            'Brexa is an AI-powered chatbot solution with an integrated scheduling module, designed to automate customer interactions and streamline appointment bookings. It enhances business efficiency by providing intelligent, real-time responses while seamlessly managing schedules across platforms.',
        'bullets': [
          'Contributed to end-to-end mobile app development, building seamless, intuitive UIs and UX flows using Flutter and React Native (Expo).',
          'Integrated RESTful APIs to enable smooth communication between frontend and backend systems.',
          'Managed complex app state using Riverpod and GetX, ensuring stable and scalable architecture across features.',
          'Wrote unit and integration test cases to maintain app reliability and reduce post-deployment issues.',
          'Implemented CI/CD pipelines for automated testing and deployment, improving release efficiency and reducing manual errors.',
          'Utilized Flutter Flavors for managing multiple environments (development, staging, production) with clean separation.',
          'Integrated Google Maps for location-based features and real-time user interaction.',
          'Managed secure and flexible payment gateway integrations using Stripe, Razorpay, Cashfree, and PayU.',
          'Increased overall user engagement by 30% through performance optimizations and UX improvements.',
          'Collaborated closely with cross-functional teams to ensure timely delivery and maintain alignment with product goals.',
          'Conducted regular code reviews and followed best practices to ensure high code quality and maintainability.',
          'Developed a fully responsive web version of the app using Flutter Web, ensuring consistent cross-platform experience across devices.',
        ],
      },
      {
        'title': 'PractE',
        'stack': 'Flutter, Firebase, Web RTC',
        'link': 'https://your-practe-link.com',
        'date': 'June 2024',
        'description':
            'Developed a mobile app focused on improving English speaking skills using Flutter and GetX for efficient state management.',
        'bullets': [
          'Integrated RESTful APIs to power user interactions, course content delivery, and progress tracking.',
          'Used Video SDK to enable real-time audio/video communication for live speaking practice and sessions.',
          'Implemented Razorpay for secure and seamless in-app payment processing.',
          'Wrote comprehensive unit, integration, and widget tests to ensure app stability and reliability.',
          'Deployed and published the application on both the Google Play Store and Apple App Store, ensuring compliance with platform guidelines.',
        ],
      },
      {
        'title': 'Itutors',
        'stack': 'Flutter | Riverpod',
        'link': 'https://your-itutors-link.com',
        'date': 'Jan 2025',
        'description':
            'Itutors is an ed-tech platform designed to connect students and teachers, enabling interactive learning experiences through real-time sessions, study material access, and personalized tutoring.',
        'bullets': [
          'Developed key modules of the mobile application using Flutter, focusing on performance, responsiveness, and user-friendly design.',
          'Implemented Riverpod for robust and scalable state management across the app.',
          'Integrated RESTful APIs to handle features like user registration, course listings, live classes, and feedback submissions.',
          'Used Stripe for secure and seamless in-app payment integration, enabling course purchases and subscription management.',
          'Collaborated with backend and design teams to ensure seamless user experience and feature alignment.',
          'Optimized app performance and reduced API latency, resulting in a smoother learning experience for end users.',
        ],
      },
    ];
  }
}
