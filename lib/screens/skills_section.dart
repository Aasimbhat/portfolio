import 'package:flutter/material.dart';

import '../widgets/neon_text.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final skills = [
      {
        'name': 'Flutter',
        'level': 0.95,
        'color': Theme.of(context).colorScheme.primary,
        'icon': Icons.flutter_dash,
      },
      {
        'name': 'Dart',
        'level': 0.90,
        'color': Theme.of(context).colorScheme.secondary,
        'icon': Icons.code,
      },
      {
        'name': 'UI/UX Design',
        'level': 0.88,
        'color': Theme.of(context).colorScheme.tertiary,
        'icon': Icons.brush,
      },
      {
        'name': 'Firebase',
        'level': 0.85,
        'color': const Color(0xFFFFCA28),
        'icon': Icons.whatshot,
      },
      {
        'name': 'REST APIs',
        'level': 0.82,
        'color': const Color(0xFF7B61FF),
        'icon': Icons.api,
      },
      {
        'name': 'Animations',
        'level': 0.92,
        'color': const Color(0xFF1ED760),
        'icon': Icons.animation,
      },
      {
        'name': 'Testing',
        'level': 0.75,
        'color': const Color(0xFFFF7262),
        'icon': Icons.science,
      },
      {
        'name': 'State Management',
        'level': 0.88,
        'color': const Color(0xFF00B0FF),
        'icon': Icons.storage,
      },
    ];

    return Container(
      padding: const EdgeInsets.only(top: 100, bottom: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: NeonText(
              'Skills & Expertise',
              color: Theme.of(context).colorScheme.primary,
              fontSize: 42,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              'My technical skills and proficiency levels',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white.withOpacity(0.7),
              ),
            ),
          ),
          const SizedBox(height: 60),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          childAspectRatio: 1.3,
                          crossAxisSpacing: 30,
                          mainAxisSpacing: 30,
                        ),
                    itemCount: skills.length,
                    itemBuilder: (context, index) {
                      final skill = skills[index];
                      return SkillCard(
                        name: skill['name'] as String,
                        level: skill['level'] as double,
                        color: skill['color'] as Color,
                        icon: skill['icon'] as IconData,
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SkillCard extends StatefulWidget {
  final String name;
  final double level;
  final Color color;
  final IconData icon;

  const SkillCard({
    super.key,
    required this.name,
    required this.level,
    required this.color,
    required this.icon,
  });

  @override
  State<SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<SkillCard>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _controller;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _progressAnimation = Tween<double>(
      begin: 0.0,
      end: widget.level,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color:
              _isHovered
                  ? Colors.black.withOpacity(0.6)
                  : Colors.black.withOpacity(0.3),
          border: Border.all(
            color:
                _isHovered
                    ? widget.color.withOpacity(0.7)
                    : Colors.white.withOpacity(0.1),
            width: 1,
          ),
          boxShadow:
              _isHovered
                  ? [
                    BoxShadow(
                      color: widget.color.withOpacity(0.3),
                      blurRadius: 15,
                      spreadRadius: -5,
                    ),
                  ]
                  : [],
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(widget.icon, color: widget.color, size: 28),
                const SizedBox(width: 12),
                Text(
                  widget.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const Spacer(),
            AnimatedBuilder(
              animation: _progressAnimation,
              builder:
                  (context, child) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Proficiency',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withOpacity(0.6),
                            ),
                          ),
                          Text(
                            '${(_progressAnimation.value * 100).toInt()}%',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: widget.color.withOpacity(0.9),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Stack(
                        children: [
                          Container(
                            height: 6,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white.withOpacity(0.1),
                            ),
                          ),
                          Container(
                            height: 6,
                            width:
                                MediaQuery.of(context).size.width *
                                _progressAnimation.value /
                                5,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: widget.color,
                              boxShadow: [
                                BoxShadow(
                                  color: widget.color.withOpacity(0.5),
                                  blurRadius: 6,
                                  spreadRadius: -3,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
