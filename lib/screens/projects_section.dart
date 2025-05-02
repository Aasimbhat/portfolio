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
    final projects = [
      {
        'title': 'Portfolio Website',
        'description': 'A responsive portfolio website built with Flutter',
        'technologies': ['Flutter', 'Dart', 'Web'],
        'image': 'assets/images/portfolio.png',
      },
      {
        'title': 'Task Management App',
        'description':
            'A task management app with clean UI and smooth animations',
        'technologies': ['Flutter', 'Firebase', 'BLoC'],
        'image': 'assets/images/task_app.png',
      },
      {
        'title': 'E-commerce App',
        'description':
            'A modern e-commerce application with cart and payment features',
        'technologies': ['React Native', 'Redux', 'Node.js'],
        'image': 'assets/images/ecommerce_app.png',
      },
      {
        'title': 'Weather App',
        'description': 'A beautiful weather application with forecast features',
        'technologies': ['Flutter', 'API Integration', 'Animations'],
        'image': 'assets/images/weather_app.png',
      },
      {
        'title': 'Chat Application',
        'description': 'Real-time messaging app with multimedia support',
        'technologies': ['Flutter', 'Firebase', 'GetX'],
        'image': 'assets/images/chat_app.png',
      },
      {
        'title': 'Fitness Tracker',
        'description':
            'Track workouts, nutrition, and progress with detailed analytics',
        'technologies': ['React Native', 'Redux', 'HealthKit/GoogleFit'],
        'image': 'assets/images/fitness_app.png',
      },
    ];

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
            technologies: project['technologies'] as List<String>,
            imagePath: project['image']! as String,
            onTap: () {},
            isMobile: isMobile,
          ),
        ),
      );
      cards.add(card);
    }

    return cards;
  }
}
