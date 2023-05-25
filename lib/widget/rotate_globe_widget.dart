import 'dart:math';

import 'package:flutter/material.dart';

class RotateGlobeWidget extends StatefulWidget {
  const RotateGlobeWidget(
      {Key? key,
      required this.width,
      required this.height,
      Color? color,
      double? lineThickness})
      : color = color ?? Colors.white,
        lineThickness = lineThickness ?? 2.0,
        super(key: key);

  final double width;
  final double height;
  final Color color;
  final double lineThickness;

  @override
  State<RotateGlobeWidget> createState() => _RotateGlobeWidgetState();
}

class _RotateGlobeWidgetState extends State<RotateGlobeWidget>
    with TickerProviderStateMixin {
  late AnimationController _rotateAnimationController;

  late AnimationController _sphereRotateZAnimationController;
  late Animation<double> _sphereRotateZAnimation;

  @override
  void initState() {
    super.initState();

    _rotateAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _sphereRotateZAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    );

    _sphereRotateZAnimation = TweenSequence<double>(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween:
              Tween<double>(begin: -pi / 180.0 * 20.0, end: pi / 180.0 * 20.0),
          weight: 50.0,
        ),
        TweenSequenceItem<double>(
          tween:
              Tween<double>(begin: pi / 180.0 * 20.0, end: -pi / 180.0 * 20.0),
          weight: 50.0,
        ),
      ],
    ).animate(_sphereRotateZAnimationController);

    _rotateAnimationController.repeat();
    _sphereRotateZAnimationController.repeat();
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
          return Transform.rotate(
            angle: _sphereRotateZAnimation.value,
            child: CustomPaint(
              painter: RotateGlobeCustomPainter(
                  percentage: _rotateAnimationController.value,
                  color: widget.color,
                  lineThickness: widget.lineThickness),
            ),
          );
        },
      ),
    );
  }
}

class RotateGlobeCustomPainter extends CustomPainter {
  RotateGlobeCustomPainter(
      {required this.percentage,
      required this.color,
      required this.lineThickness});

  double percentage; // range between 0.0 to 1.0
  Color color;
  double lineThickness;

  @override
  void paint(Canvas canvas, Size size) {
    final points = <double>[];

    const pointCount = 3;
    final step = size.width / pointCount.toDouble();
    for (int i = 0; i < pointCount; ++i) {
      points.add(step * i.toDouble() + (step * percentage));
    }

    final pathPaint = Paint();
    pathPaint.color = color;
    pathPaint.strokeWidth = lineThickness;
    pathPaint.style = PaintingStyle.stroke;
    pathPaint.strokeCap = StrokeCap.round;

    canvas.drawOval(
        Rect.fromLTWH(0.0, 0.0, size.width, size.height), pathPaint);
    canvas.drawOval(
        Rect.fromCenter(
            center: size.center(Offset.zero),
            width: size.width,
            height: size.height * 0.7),
        pathPaint);
    canvas.drawOval(
        Rect.fromCenter(
            center: size.center(Offset.zero),
            width: size.width,
            height: size.height * 0.3),
        pathPaint);

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
