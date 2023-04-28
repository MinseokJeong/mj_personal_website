import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:math' as math;

class RotateSphereWidget extends StatefulWidget {
  const RotateSphereWidget(
      {Key? key, required this.width, required this.height})
      : super(key: key);

  final double width;
  final double height;

  @override
  State<RotateSphereWidget> createState() => _RotateSphereWidgetState();
}

class _RotateSphereWidgetState extends State<RotateSphereWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _rotateAnimationController;

  @override
  void initState() {
    super.initState();

    _rotateAnimationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _rotateAnimationController.repeat();
  }

  @override
  void dispose() {
    _rotateAnimationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: AnimatedBuilder(
        animation: _rotateAnimationController,
        builder: (context, child) {
          return CustomPaint(
            painter:
                RotateSphereCustomPainter(_rotateAnimationController.value),
          );
        },
      ),
    );
  }
}

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
