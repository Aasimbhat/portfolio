import 'package:flutter/material.dart';

import '../utils/painters.dart';
import '../widgets/buttons.dart';
import '../widgets/neon_text.dart';

class HomeSection extends StatelessWidget {
  final AnimationController animationController;
  final Size screenSize;

  const HomeSection({
    super.key,
    required this.animationController,
    required this.screenSize,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Animated background elements
        Positioned(
          top: screenSize.height * 0.4,
          left: -100,
          child: Container(
            width: screenSize.width * 0.5,
            height: screenSize.width * 0.5,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  Theme.of(context).colorScheme.primary.withOpacity(0.3),
                  Theme.of(context).colorScheme.primary.withOpacity(0.0),
                ],
              ),
            ),
          ),
        ),

        // Main content
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, -0.5),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(
                    parent: animationController,
                    curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
                  ),
                ),
                child: FadeTransition(
                  opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
                    CurvedAnimation(
                      parent: animationController,
                      curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
                    ),
                  ),
                  child: Text(
                    'This Website Is Under Development!!🚧🚧🚧',
                    style: TextStyle(
                      fontSize: 18,
                      letterSpacing: 4,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, -0.3),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(
                    parent: animationController,
                    curve: const Interval(0.2, 0.7, curve: Curves.easeOut),
                  ),
                ),
                child: FadeTransition(
                  opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
                    CurvedAnimation(
                      parent: animationController,
                      curve: const Interval(0.2, 0.7, curve: Curves.easeOut),
                    ),
                  ),
                  child: NeonText(
                    'I\'m Aasim bhat',
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 72,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, -0.2),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(
                    parent: animationController,
                    curve: const Interval(0.3, 0.8, curve: Curves.easeOut),
                  ),
                ),
                child: FadeTransition(
                  opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
                    CurvedAnimation(
                      parent: animationController,
                      curve: const Interval(0.3, 0.8, curve: Curves.easeOut),
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(
                        'Mobile Application Developer',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.w300,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        'Flutter',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.w300,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        'React Native',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.w300,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
              SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0.2),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(
                    parent: animationController,
                    curve: const Interval(0.4, 0.9, curve: Curves.easeOut),
                  ),
                ),
                child: FadeTransition(
                  opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
                    CurvedAnimation(
                      parent: animationController,
                      curve: const Interval(0.4, 0.9, curve: Curves.easeOut),
                    ),
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 28,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.1),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(
                            context,
                          ).colorScheme.primary.withOpacity(0.1),
                          blurRadius: 30,
                          spreadRadius: -10,
                        ),
                      ],
                    ),
                    child: const Text(
                      'Crafting visually stunning and high-performance mobile experiences. Specializing in Flutter development, motion design, and creating seamless user experiences that blend aesthetics with functionality.',
                      style: TextStyle(
                        fontSize: 18,
                        height: 1.6,
                        color: Colors.white70,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 60),
              SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0.4),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(
                    parent: animationController,
                    curve: const Interval(0.5, 1.0, curve: Curves.easeOut),
                  ),
                ),
                child: FadeTransition(
                  opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
                    CurvedAnimation(
                      parent: animationController,
                      curve: const Interval(0.5, 1.0, curve: Curves.easeOut),
                    ),
                  ),
                  child: Row(
                    children: [
                      GlowingButton(
                        text: 'View Projects',
                        color: Theme.of(context).colorScheme.primary,
                        onPressed: () {},
                      ),
                      const SizedBox(width: 20),
                      OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 20,
                          ),
                          side: BorderSide(
                            color: Colors.white.withOpacity(0.3),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Row(
                          children: [
                            Text(
                              'Download CV',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Icon(Icons.download, size: 16),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        // Abstract decoration
        Positioned(
          right: -100,
          top: MediaQuery.of(context).size.height * 0.2,
          child: Container(
            width: 400,
            height: 400,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  Colors.transparent,
                  Theme.of(context).colorScheme.secondary.withOpacity(0.05),
                ],
              ),
            ),
            child: CustomPaint(
              painter: CircuitPainter(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
