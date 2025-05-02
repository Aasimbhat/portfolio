import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NavItem extends StatefulWidget {
  final String title;
  final bool isActive;
  final VoidCallback onTap;

  const NavItem({
    super.key,
    required this.title,
    required this.isActive,
    required this.onTap,
  });

  @override
  State<NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<NavItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color:
            widget.isActive
                ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
                : _isHovered
                ? Colors.white.withOpacity(0.05)
                : Colors.transparent,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color:
              widget.isActive
                  ? Theme.of(context).colorScheme.primary.withOpacity(0.5)
                  : Colors.transparent,
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: widget.onTap,
        onHover: (value) => setState(() => _isHovered = value),
        borderRadius: BorderRadius.circular(30),
        child: Text(
          widget.title,
          style: TextStyle(
            color:
                widget.isActive
                    ? Theme.of(context).colorScheme.primary
                    : Colors.white,
            fontWeight: widget.isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

class SocialIcon extends StatefulWidget {
  final IconData icon;
  final String url;
  final double size;

  const SocialIcon({
    super.key,
    required this.icon,
    required this.url,
    this.size = 20,
  });

  @override
  State<SocialIcon> createState() => _SocialIconState();
}

class _SocialIconState extends State<SocialIcon> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () async {
          if (await canLaunchUrl(Uri.parse(widget.url))) {
            await launchUrl(Uri.parse(widget.url));
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color:
                _isHovered
                    ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
                    : Colors.transparent,
            shape: BoxShape.circle,
            border: Border.all(
              color:
                  _isHovered
                      ? Theme.of(context).colorScheme.primary
                      : Colors.white.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Icon(
            widget.icon,
            color:
                _isHovered
                    ? Theme.of(context).colorScheme.primary
                    : Colors.white.withOpacity(0.8),
            size: widget.size,
          ),
        ),
      ),
    );
  }
}
