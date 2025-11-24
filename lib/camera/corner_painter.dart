// lib/camera/corner_painter.dart
import 'package:flutter/material.dart';

class CornerPainter extends CustomPainter {
  final Alignment alignment;

  CornerPainter({required this.alignment});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    final path = Path();

    if (alignment == Alignment.topLeft) {
      path
        ..moveTo(0, 20)
        ..lineTo(0, 0)
        ..lineTo(20, 0);
    } else if (alignment == Alignment.topRight) {
      path
        ..moveTo(size.width - 20, 0)
        ..lineTo(size.width, 0)
        ..lineTo(size.width, 20);
    } else if (alignment == Alignment.bottomLeft) {
      path
        ..moveTo(0, size.height - 20)
        ..lineTo(0, size.height)
        ..lineTo(20, size.height);
    } else if (alignment == Alignment.bottomRight) {
      path
        ..moveTo(size.width - 20, size.height)
        ..lineTo(size.width, size.height)
        ..lineTo(size.width, size.height - 20);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}