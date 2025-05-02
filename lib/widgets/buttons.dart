import 'package:flutter/material.dart';

class GlowingButton extends StatefulWidget {
  final String text;
  final Color color;
  final VoidCallback onPressed;
  final double? width;

  const GlowingButton({
    super.key,
    required this.text,
    required this.color,
    required this.onPressed,
    this.width,
  });

  @override
  State<GlowingButton> createState() => _GlowingButtonState();
}

class _GlowingButtonState extends State<GlowingButton>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
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
        child: InkWell(
          onTap: widget.onPressed,
          child: Container(
            width: widget.width,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  widget.color,
                  Color.lerp(widget.color, Colors.white, 0.2)!,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(30),
              boxShadow:
                  _isHovered
                      ? [
                        BoxShadow(
                          color: widget.color.withOpacity(0.5),
                          blurRadius: 15,
                          spreadRadius: -5,
                        ),
                        BoxShadow(
                          color: widget.color.withOpacity(0.3),
                          blurRadius: 30,
                          spreadRadius: -10,
                        ),
                      ]
                      : [
                        BoxShadow(
                          color: widget.color.withOpacity(0.3),
                          blurRadius: 10,
                          spreadRadius: -8,
                        ),
                      ],
            ),
            child: Center(
              child: Text(
                widget.text,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
