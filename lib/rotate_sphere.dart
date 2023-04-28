import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:math' as math;

class RotateSphereCustomPainter extends CustomPainter {
  RotateSphereCustomPainter(this.percentage);

  double percentage; // range between 0.0 to 1.0

  @override
  void paint(Canvas canvas, Size size) {
    final points = <double>[];

    final step = size.width / 6.0;
    for (int i = 0; i < 6; ++i) {
      points.add(step * i.toDouble() + (step * percentage));
    }

    final pathPaint = Paint();
    pathPaint.color = Colors.white;
    pathPaint.strokeWidth = 2.0;
    pathPaint.style = PaintingStyle.stroke;
    pathPaint.strokeCap = StrokeCap.round;

    canvas.drawOval(
        Rect.fromLTWH(0.0, 0.0, size.width, size.height), pathPaint);

    _drawCustomCurvedLine(points[0], size, canvas, pathPaint);

    for (final point in points) {
      _drawCustomCurvedLine(point, size, canvas, pathPaint);
    }

    percentage += 0.01;
    if (percentage > 1.0) {
      percentage -= 1.0;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

  void _drawCustomCurvedLine(
      double point, Size size, Canvas canvas, Paint paint) {
    Path p = Path();

    final ovalRectWidth = (point - size.width / 2.0).abs() * 2.0;

    if (ovalRectWidth <= 1.0) {
      p.moveTo(size.width / 2.0, 0.0);
      p.lineTo(size.width / 2.0, size.height);
    } else {
      final ovalRect = Rect.fromCenter(
        center: Offset(size.width / 2.0, size.height / 2.0),
        height: size.height,
        width: ovalRectWidth,
      );

      if (point < size.width / 2.0) {
        p.addArc(ovalRect, pi / 2.0, pi);
      } else {
        p.addArc(ovalRect, pi / 2.0 * 3.0, pi);
      }
    }

    canvas.drawPath(p, paint);
  }
}
