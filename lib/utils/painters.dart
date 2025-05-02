import 'dart:math';

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

/// A custom painter that creates circuit-like patterns for decorative backgrounds
class CircuitPainter extends CustomPainter {
  final Color color;
  final Random _random = Random(42); // Fixed seed for consistent pattern
  final double nodeSize;
  final int nodeCount;

  CircuitPainter({
    required this.color,
    this.nodeSize = 3.0,
    this.nodeCount = 15,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint linePaint =
        Paint()
          ..color = color
          ..strokeWidth = 1.0
          ..style = PaintingStyle.stroke;

    final Paint nodePaint =
        Paint()
          ..color = color
          ..style = PaintingStyle.fill;

    // Create random points (nodes)
    final List<Offset> nodes = List.generate(nodeCount, (_) {
      return Offset(
        _random.nextDouble() * size.width,
        _random.nextDouble() * size.height,
      );
    });

    // Draw connections between nodes
    for (int i = 0; i < nodes.length; i++) {
      // Find 2-3 closest nodes to connect
      final List<int> connections = _findClosestNodes(i, nodes);

      for (final int j in connections) {
        // Draw line with 90-degree bends (circuit style)
        _drawCircuitLine(canvas, nodes[i], nodes[j], linePaint);
      }

      // Draw node
      canvas.drawCircle(nodes[i], nodeSize, nodePaint);
    }
  }

  // Find the closest nodes to connect
  List<int> _findClosestNodes(int nodeIndex, List<Offset> nodes) {
    final Map<int, double> distances = {};

    for (int i = 0; i < nodes.length; i++) {
      if (i == nodeIndex) continue;

      final double distance = (nodes[nodeIndex] - nodes[i]).distance;
      distances[i] = distance;
    }

    // Sort by distance
    final List<int> sortedIndices =
        distances.keys.toList()
          ..sort((a, b) => distances[a]!.compareTo(distances[b]!));

    // Take 1-3 closest nodes
    final int connectionsCount = 1 + _random.nextInt(2);
    return sortedIndices
        .take(min(connectionsCount, sortedIndices.length))
        .toList();
  }

  // Draw line with circuit-style 90-degree bends
  void _drawCircuitLine(Canvas canvas, Offset start, Offset end, Paint paint) {
    final Path path = Path();
    path.moveTo(start.dx, start.dy);

    // Decide whether to go horizontal first or vertical first
    if (_random.nextBool()) {
      // Horizontal then vertical
      path.lineTo(end.dx, start.dy);
      path.lineTo(end.dx, end.dy);
    } else {
      // Vertical then horizontal
      path.lineTo(start.dx, end.dy);
      path.lineTo(end.dx, end.dy);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CircuitPainter oldDelegate) =>
      color != oldDelegate.color ||
      nodeSize != oldDelegate.nodeSize ||
      nodeCount != oldDelegate.nodeCount;
}

/// A custom painter that creates a neon grid effect
class NeonGridPainter extends CustomPainter {
  final Color color;
  final double gridSpacing;
  final double opacity;

  NeonGridPainter({
    required this.color,
    this.gridSpacing = 40.0,
    this.opacity = 0.3,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint linePaint =
        Paint()
          ..color = color.withOpacity(opacity)
          ..strokeWidth = 0.5
          ..style = PaintingStyle.stroke;

    // Draw vertical lines
    for (double x = 0; x <= size.width; x += gridSpacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), linePaint);
    }

    // Draw horizontal lines
    for (double y = 0; y <= size.height; y += gridSpacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), linePaint);
    }

    // Draw some random brighter points at intersections
    final Paint pointPaint =
        Paint()
          ..color = color.withOpacity(opacity * 2)
          ..style = PaintingStyle.fill;

    final Random random = Random(12);

    for (double x = 0; x <= size.width; x += gridSpacing) {
      for (double y = 0; y <= size.height; y += gridSpacing) {
        if (random.nextDouble() < 0.2) {
          // 20% chance to draw a point
          canvas.drawCircle(Offset(x, y), 1.0, pointPaint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(NeonGridPainter oldDelegate) =>
      color != oldDelegate.color ||
      gridSpacing != oldDelegate.gridSpacing ||
      opacity != oldDelegate.opacity;
}
