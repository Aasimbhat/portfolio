import 'package:flutter/material.dart';

class NeonText extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;

  const NeonText(
    this.text, {
    super.key,
    required this.color,
    this.fontSize = 18,
    this.fontWeight = FontWeight.normal,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Glow layer
        Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
            foreground:
                Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 6
                  ..color = color.withOpacity(0.2)
                  ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10),
          ),
        ),
        // Main text layer
        Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: Colors.white,
            shadows: [
              Shadow(
                color: color.withOpacity(0.8),
                blurRadius: 8,
                offset: const Offset(0, 0),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
