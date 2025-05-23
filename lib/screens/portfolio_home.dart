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
  int _currentPage = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late AnimationController _animationController;
  late Size _screenSize;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
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
    _screenSize = MediaQuery.of(context).size;
    final isMobile = _screenSize.width < 600;

    return Scaffold(
      key: _scaffoldKey,
      drawer: isMobile ? _buildDrawer() : null,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF0D1117),
              const Color(0xFF0D1117),
              const Color(0xFF161B22),
            ],
          ),
        ),
        child: Stack(
          children: [
            // Grid background
            Positioned.fill(
              child: Opacity(
                opacity: 0.2,
                child: CustomPaint(
                  painter: NeonGridPainter(
                    color: Theme.of(context).colorScheme.primary,
                    gridSpacing: 40,
                  ),
                ),
              ),
            ),

            // Main content
            Column(
              children: [
                // Desktop Navigation
                if (!isMobile) _buildDesktopNavigation(),

                // Page Content
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                        _animationController.reset();
                        _animationController.forward();
                      });
                    },
                    children: [
                      HomeSection(
                        animationController: _animationController,
                        screenSize: _screenSize,
                      ),
                      ProjectsSection(
                        animationController: _animationController,
                        screenSize: _screenSize,
                      ),
                      SkillsSection(
                        animationController: _animationController,
                        screenSize: _screenSize,
                      ),
                      ContactSection(
                        animationController: _animationController,
                        screenSize: _screenSize,
                      ),
                    ],
                  ),
                ),

                // Mobile Navigation
                if (isMobile) _buildMobileNavigation(),
              ],
            ),

            // Social media icons
            if (!isMobile)
              Positioned(
                bottom: 30,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SocialIcon(
                      icon: Icons.facebook,
                      url: 'https://facebook.com',
                    ),
                    const SizedBox(width: 16),
                    SocialIcon(
                      icon: Icons.flutter_dash,
                      url: 'https://github.com',
                    ),
                    const SizedBox(width: 16),
                    SocialIcon(
                      icon: Icons.alternate_email,
                      url: 'mailto:example@example.com',
                    ),
                    const SizedBox(width: 16),
                    SocialIcon(icon: Icons.chat, url: 'https://twitter.com'),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopNavigation() {
    return Container(
      padding: const EdgeInsets.fromLTRB(40, 30, 40, 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo
          Row(
            children: [
              const SizedBox(width: 12),
              Text(
                '',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
          // Navigation items
          Row(
            children: [
              NavItem(
                title: 'Home',
                isActive: _currentPage == 0,
                onTap:
                    () => _pageController.animateToPage(
                      0,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    ),
              ),
              const SizedBox(width: 16),
              NavItem(
                title: 'Projects',
                isActive: _currentPage == 1,
                onTap:
                    () => _pageController.animateToPage(
                      1,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    ),
              ),
              const SizedBox(width: 16),
              NavItem(
                title: 'Skills',
                isActive: _currentPage == 2,
                onTap:
                    () => _pageController.animateToPage(
                      2,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    ),
              ),
              const SizedBox(width: 16),
              NavItem(
                title: 'Contact',
                isActive: _currentPage == 3,
                onTap:
                    () => _pageController.animateToPage(
                      3,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    ),
              ),
              const SizedBox(width: 20),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMobileNavigation() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        border: Border.all(color: Colors.white.withOpacity(0.1), width: 1),
      ),
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildMobileNavItem(0, Icons.home, 'Home'),
          _buildMobileNavItem(1, Icons.work, 'Projects'),
          _buildMobileNavItem(2, Icons.code, 'Skills'),
          _buildMobileNavItem(3, Icons.mail, 'Contact'),
        ],
      ),
    );
  }

  Widget _buildMobileNavItem(int index, IconData icon, String label) {
    final isActive = _currentPage == index;

    return InkWell(
      onTap:
          () => _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color:
                isActive
                    ? Theme.of(context).colorScheme.primary
                    : Colors.white.withOpacity(0.6),
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color:
                  isActive
                      ? Theme.of(context).colorScheme.primary
                      : Colors.white.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      backgroundColor: const Color(0xFF161B22),
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              border: Border(
                bottom: BorderSide(
                  color: Colors.white.withOpacity(0.1),
                  width: 1,
                ),
              ),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Text(
                        'A',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Aasim',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          _buildDrawerItem(0, Icons.home, 'Home'),
          _buildDrawerItem(1, Icons.work, 'Projects'),
          _buildDrawerItem(2, Icons.code, 'Skills'),
          _buildDrawerItem(3, Icons.mail, 'Contact'),
          const Divider(
            color: Colors.white12,
            thickness: 1,
            height: 40,
            indent: 20,
            endIndent: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 14,
                ),
                side: BorderSide(color: Colors.white.withOpacity(0.3)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Download Resume',
                    style: TextStyle(color: Colors.white.withOpacity(0.9)),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.download, size: 16),
                ],
              ),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SocialIcon(
                  icon: Icons.facebook,
                  url: 'https://facebook.com',
                  size: 16,
                ),
                SocialIcon(
                  icon: Icons.flutter_dash,
                  url: 'https://github.com',
                  size: 16,
                ),
                SocialIcon(
                  icon: Icons.alternate_email,
                  url: 'mailto:example@example.com',
                  size: 16,
                ),
                SocialIcon(
                  icon: Icons.chat,
                  url: 'https://twitter.com',
                  size: 16,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(int index, IconData icon, String label) {
    final isActive = _currentPage == index;

    return ListTile(
      leading: Icon(
        icon,
        color:
            isActive
                ? Theme.of(context).colorScheme.primary
                : Colors.white.withOpacity(0.6),
      ),
      title: Text(
        label,
        style: TextStyle(
          color:
              isActive
                  ? Theme.of(context).colorScheme.primary
                  : Colors.white.withOpacity(0.9),
        ),
      ),
      onTap: () {
        Navigator.pop(context);
        _pageController.animateToPage(
          index,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      },
      selected: isActive,
      selectedTileColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    );
  }
}
