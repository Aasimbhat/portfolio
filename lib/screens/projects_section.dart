import 'package:flutter/material.dart';

import '../widgets/neon_text.dart';

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _categories = [
    'All',
    'Mobile Apps',
    'Web',
    'UI/UX',
    'Experiments',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _categories.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final projectsList = [
      {
        'title': 'Neon Finance',
        'description':
            'A futuristic finance tracking app with AI predictions and visualization',
        'category': 'Mobile Apps',
        'color': const Color(0xFF00E5FF),
        'image':
            'https://images.unsplash.com/photo-1579621970590-9d624316904b?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80',
      },
      {
        'title': 'Echo Social',
        'description':
            'Next-gen social platform with AR integrations and immersive content',
        'category': 'Mobile Apps',
        'color': const Color(0xFFFE53BB),
        'image':
            'https://images.unsplash.com/photo-1573152958734-1922c188fba3?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80',
      },
      {
        'title': 'Pulse Ecommerce',
        'description':
            'Interactive shopping experience with virtual try-on technology',
        'category': 'Web',
        'color': const Color(0xFFF2A900),
        'image':
            'https://images.unsplash.com/photo-1559830772-73d5e48d1c52?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80',
      },
      {
        'title': 'Neural Canvas',
        'description':
            'AI-powered design tool for generating dynamic visual content',
        'category': 'Experiments',
        'color': const Color(0xFF7B61FF),
        'image':
            'https://images.unsplash.com/photo-1617791160588-241658c0f566?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80',
      },
      {
        'title': 'Hyper Health',
        'description':
            'Health tracking app with gamification and social challenges',
        'category': 'UI/UX',
        'color': const Color(0xFF1ED760),
        'image':
            'https://images.unsplash.com/photo-1576086213369-97a306d36557?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80',
      },
      {
        'title': 'Quantum Weather',
        'description':
            'Weather visualization with immersive 3D particle simulations',
        'category': 'Experiments',
        'color': const Color(0xFFFF7262),
        'image':
            'https://images.unsplash.com/photo-1561484930-998b6a7b22e8?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80',
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
              'Recent Projects',
              color: Theme.of(context).colorScheme.primary,
              fontSize: 42,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorColor: Theme.of(context).colorScheme.primary,
              dividerColor: Colors.transparent,
              tabs:
                  _categories.map((category) {
                    return Tab(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.2),
                          ),
                        ),
                        child: Text(category),
                      ),
                    );
                  }).toList(),
            ),
          ),
          const SizedBox(height: 32),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children:
                  _categories.map((category) {
                    final filteredProjects =
                        category == 'All'
                            ? projectsList
                            : projectsList
                                .where(
                                  (project) => project['category'] == category,
                                )
                                .toList();

                    return GridView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 1.2,
                            crossAxisSpacing: 24,
                            mainAxisSpacing: 24,
                          ),
                      itemCount: filteredProjects.length,
                      itemBuilder: (context, index) {
                        final project = filteredProjects[index];
                        return ProjectCard(
                          title: project['title'] as String,
                          description: project['description'] as String,
                          color: project['color'] as Color,
                          imageUrl: project['image'] as String,
                        );
                      },
                    );
                  }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class ProjectCard extends StatefulWidget {
  final String title;
  final String description;
  final Color color;
  final String imageUrl;

  const ProjectCard({
    super.key,
    required this.title,
    required this.description,
    required this.color,
    required this.imageUrl,
  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() => _isHovered = true);
        _controller.forward();
      },
      onExit: (_) {
        setState(() => _isHovered = false);
        _controller.reverse();
      },
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: widget.color.withOpacity(_isHovered ? 0.3 : 0.1),
                blurRadius: 20,
                spreadRadius: -10,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.network(widget.imageUrl, fit: BoxFit.cover),
                ),
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                          Colors.black.withOpacity(0.9),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: [
                              Shadow(color: widget.color, blurRadius: 8),
                            ],
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          widget.description,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: widget.color.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: widget.color.withOpacity(0.5),
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.remove_red_eye,
                                    color: widget.color,
                                    size: 14,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    'View',
                                    style: TextStyle(
                                      color: widget.color,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward,
                              color: widget.color,
                              size: 18,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                if (_isHovered)
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.favorite,
                        color: widget.color,
                        size: 18,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
