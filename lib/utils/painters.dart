import 'package:flutter/material.dart';

class GlowingBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = const Color(0xFF00E5FF).withOpacity(0.2)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 100);

    canvas.drawCircle(
      Offset(size.width * 0.1, size.height * 0.1),
      size.width * 0.2,
      paint,
    );

    final paint2 =
        Paint()
          ..color = const Color(0xFFFE53BB).withOpacity(0.2)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 100);

    canvas.drawCircle(
      Offset(size.width * 0.8, size.height * 0.8),
      size.width * 0.25,
      paint2,
    );

    // Subtle grid pattern
    final gridPaint =
        Paint()
          ..color = Colors.white.withOpacity(0.05)
          ..strokeWidth = 0.5;

    for (var i = 0; i < size.width; i += 30) {
      canvas.drawLine(
        Offset(i.toDouble(), 0),
        Offset(i.toDouble(), size.height),
        gridPaint,
      );
    }

    for (var i = 0; i < size.height; i += 30) {
      canvas.drawLine(
        Offset(0, i.toDouble()),
        Offset(size.width, i.toDouble()),
        gridPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class CircuitPainter extends CustomPainter {
  final Color color;

  CircuitPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = color.withOpacity(0.6)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5;

    final dotPaint =
        Paint()
          ..color = color
          ..style = PaintingStyle.fill;

    // Draw circuit lines
    final path = Path();

    // Starting point
    path.moveTo(size.width * 0.1, size.height * 0.2);

    // First line
    path.lineTo(size.width * 0.3, size.height * 0.2);

    // Down to first junction
    path.lineTo(size.width * 0.3, size.height * 0.4);

    // Branch 1
    path.lineTo(size.width * 0.5, size.height * 0.4);
    path.lineTo(size.width * 0.5, size.height * 0.6);
    path.lineTo(size.width * 0.7, size.height * 0.6);

    // Save path state for branching
    path.moveTo(size.width * 0.3, size.height * 0.4);

    // Branch 2
    path.lineTo(size.width * 0.3, size.height * 0.7);
    path.lineTo(size.width * 0.8, size.height * 0.7);

    // Draw another circuit segment
    path.moveTo(size.width * 0.5, size.height * 0.1);
    path.lineTo(size.width * 0.5, size.height * 0.3);
    path.lineTo(size.width * 0.9, size.height * 0.3);
    path.lineTo(size.width * 0.9, size.height * 0.8);

    canvas.drawPath(path, paint);

    // Draw connection dots
    final dots = [
      Offset(size.width * 0.3, size.height * 0.2),
      Offset(size.width * 0.3, size.height * 0.4),
      Offset(size.width * 0.5, size.height * 0.4),
      Offset(size.width * 0.5, size.height * 0.6),
      Offset(size.width * 0.3, size.height * 0.7),
      Offset(size.width * 0.5, size.height * 0.3),
      Offset(size.width * 0.9, size.height * 0.3),
      Offset(size.width * 0.9, size.height * 0.8),
    ];

    for (final dot in dots) {
      canvas.drawCircle(dot, 3, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
