import 'package:flutter/material.dart';

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
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 12),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color:
                widget.isActive || _isHovered
                    ? Theme.of(context).colorScheme.primary.withOpacity(0.2)
                    : Colors.transparent,
            border:
                widget.isActive
                    ? Border.all(
                      color: Theme.of(context).colorScheme.primary,
                      width: 1,
                    )
                    : null,
          ),
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
      ),
    );
  }
}

class SocialIcon extends StatefulWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const SocialIcon({
    super.key,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  State<SocialIcon> createState() => _SocialIconState();
}

class _SocialIconState extends State<SocialIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _animation = Tween<double>(
      begin: 1.0,
      end: 1.2,
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
        scale: _animation,
        child: GestureDetector(
          onTap: widget.onTap,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color:
                  _isHovered
                      ? widget.color.withOpacity(0.2)
                      : Colors.black.withOpacity(0.3),
              boxShadow:
                  _isHovered
                      ? [
                        BoxShadow(
                          color: widget.color.withOpacity(0.5),
                          blurRadius: 15,
                          spreadRadius: -2,
                        ),
                      ]
                      : null,
              border: Border.all(
                color:
                    _isHovered ? widget.color : widget.color.withOpacity(0.5),
                width: 1.5,
              ),
            ),
            child: Icon(
              widget.icon,
              color: _isHovered ? widget.color : Colors.white,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }
}
