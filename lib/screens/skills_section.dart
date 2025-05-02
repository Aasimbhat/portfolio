import 'package:flutter/material.dart';

import '../widgets/skill_card.dart';

class SkillsSection extends StatelessWidget {
  final AnimationController animationController;
  final Size screenSize;

  const SkillsSection({
    super.key,
    required this.animationController,
    required this.screenSize,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = screenSize.width < 600;
    final isTablet = screenSize.width >= 600 && screenSize.width < 900;

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
                parent: animationController,
                curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
              ),
            ),
            child: FadeTransition(
              opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(
                  parent: animationController,
                  curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
                ),
              ),
              child: Text(
                "MY SKILLS",
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
                parent: animationController,
                curve: const Interval(0.1, 0.6, curve: Curves.easeOut),
              ),
            ),
            child: FadeTransition(
              opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(
                  parent: animationController,
                  curve: const Interval(0.1, 0.6, curve: Curves.easeOut),
                ),
              ),
              child: Text(
                "Expertise",
                style: TextStyle(
                  fontSize: isMobile ? 36 : 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
          Expanded(child: _buildSkillsLayout(context, isMobile, isTablet)),
        ],
      ),
    );
  }

  Widget _buildSkillsLayout(
    BuildContext context,
    bool isMobile,
    bool isTablet,
  ) {
    final skillsData = [
      {
        'category': 'Mobile Development',
        'skills': [
          {'name': 'Flutter', 'level': 0.9},
          {'name': 'React Native', 'level': 0.8},
          {'name': 'iOS (Swift)', 'level': 0.7},
          {'name': 'Android (Kotlin)', 'level': 0.7},
        ],
      },
      {
        'category': 'UI/UX Design',
        'skills': [
          {'name': 'Figma', 'level': 0.85},
          {'name': 'Adobe XD', 'level': 0.8},
          {'name': 'Responsive Design', 'level': 0.9},
          {'name': 'Animations', 'level': 0.85},
        ],
      },
      {
        'category': 'Backend Development',
        'skills': [
          {'name': 'Firebase', 'level': 0.85},
          {'name': 'Node.js', 'level': 0.7},
          {'name': 'RESTful APIs', 'level': 0.8},
          {'name': 'GraphQL', 'level': 0.7},
        ],
      },
    ];

    if (isMobile) {
      // Mobile layout (single column)
      return ListView.builder(
        itemCount: skillsData.length,
        itemBuilder: (context, index) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.2),
              end: Offset.zero,
            ).animate(
              CurvedAnimation(
                parent: animationController,
                curve: Interval(
                  0.2 + (index * 0.1),
                  0.7 + (index * 0.1),
                  curve: Curves.easeOut,
                ),
              ),
            ),
            child: FadeTransition(
              opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(
                  parent: animationController,
                  curve: Interval(
                    0.2 + (index * 0.1),
                    0.7 + (index * 0.1),
                    curve: Curves.easeOut,
                  ),
                ),
              ),
              child: SkillCard(
                category: skillsData[index]['category'] as String,
                skills:
                    skillsData[index]['skills'] as List<Map<String, dynamic>>,
                isMobile: true,
              ),
            ),
          );
        },
      );
    } else if (isTablet) {
      // Tablet layout (2 columns)
      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.3,
          crossAxisSpacing: 24,
          mainAxisSpacing: 24,
        ),
        itemCount: skillsData.length,
        itemBuilder: (context, index) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.2),
              end: Offset.zero,
            ).animate(
              CurvedAnimation(
                parent: animationController,
                curve: Interval(
                  0.2 + (index * 0.1),
                  0.7 + (index * 0.1),
                  curve: Curves.easeOut,
                ),
              ),
            ),
            child: FadeTransition(
              opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(
                  parent: animationController,
                  curve: Interval(
                    0.2 + (index * 0.1),
                    0.7 + (index * 0.1),
                    curve: Curves.easeOut,
                  ),
                ),
              ),
              child: SkillCard(
                category: skillsData[index]['category'] as String,
                skills:
                    skillsData[index]['skills'] as List<Map<String, dynamic>>,
                isMobile: false,
              ),
            ),
          );
        },
      );
    } else {
      // Desktop layout (3 columns)
      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1.1,
          crossAxisSpacing: 24,
          mainAxisSpacing: 24,
        ),
        itemCount: skillsData.length,
        itemBuilder: (context, index) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.2),
              end: Offset.zero,
            ).animate(
              CurvedAnimation(
                parent: animationController,
                curve: Interval(
                  0.2 + (index * 0.1),
                  0.7 + (index * 0.1),
                  curve: Curves.easeOut,
                ),
              ),
            ),
            child: FadeTransition(
              opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(
                  parent: animationController,
                  curve: Interval(
                    0.2 + (index * 0.1),
                    0.7 + (index * 0.1),
                    curve: Curves.easeOut,
                  ),
                ),
              ),
              child: SkillCard(
                category: skillsData[index]['category'] as String,
                skills:
                    skillsData[index]['skills'] as List<Map<String, dynamic>>,
                isMobile: false,
              ),
            ),
          );
        },
      );
    }
  }
}
