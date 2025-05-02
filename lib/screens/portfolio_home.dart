import 'dart:ui';

import 'package:flutter/material.dart';

import '../utils/painters.dart';
import '../widgets/navigation.dart';
import 'contact_section.dart';
import 'home_section.dart';
import 'projects_section.dart';
import 'skills_section.dart';

class PortfolioHome extends StatefulWidget {
  const PortfolioHome({super.key});

  @override
  State<PortfolioHome> createState() => _PortfolioHomeState();
}

class _PortfolioHomeState extends State<PortfolioHome>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  late AnimationController _animationController;
  int _currentPage = 0;
  final List<String> _sections = ['Home', 'Projects', 'Skills', 'Contact'];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Background with animated gradients
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF0A0E21),
                    Color(0xFF0F1642),
                    Color(0xFF0A0E21),
                  ],
                ),
              ),
              child: CustomPaint(painter: GlowingBackgroundPainter()),
            ),
          ),

          // Main content
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => _currentPage = index);
            },
            children: [
              HomeSection(
                animationController: _animationController,
                screenSize: MediaQuery.of(context).size,
              ),
              const ProjectsSection(),
              const SkillsSection(),
              const ContactSection(),
            ],
          ),

          // Navigation
          Positioned(
            top: 40,
            left: 0,
            right: 0,
            child: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Portfolio',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: List.generate(_sections.length, (index) {
                          return NavItem(
                            title: _sections[index],
                            isActive: _currentPage == index,
                            onTap: () {
                              _pageController.animateToPage(
                                index,
                                duration: const Duration(milliseconds: 600),
                                curve: Curves.easeInOut,
                              );
                            },
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Bottom social icons
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SocialIcon(icon: Icons.code, color: Colors.white, onTap: () {}),
                SocialIcon(
                  icon: Icons.person,
                  color: Colors.blue,
                  onTap: () {},
                ),
                SocialIcon(
                  icon: Icons.alternate_email,
                  color: Colors.red,
                  onTap: () {},
                ),
                SocialIcon(
                  icon: Icons.camera_alt,
                  color: Colors.purple,
                  onTap: () {},
                ),
                SocialIcon(
                  icon: Icons.article,
                  color: Colors.teal,
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
