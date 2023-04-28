import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';

class WorldSphereRotate extends StatefulWidget {
  const WorldSphereRotate({Key? key}) : super(key: key);

  @override
  State<WorldSphereRotate> createState() => _WorldSphereRotateState();
}

class _WorldSphereRotateState extends State<WorldSphereRotate>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _rotateAnimation;

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _rotateAnimation =
        Tween(begin: 0.0, end: pi / 4.0).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final rotateMatrix_yAxis_0deg = Matrix4.identity()..rotateY(pi / 4.0 * 0.0);
    final rotateMatrix_yAxis_45deg = Matrix4.identity()..rotateY(pi / 4.0 * 1);
    final rotateMatrix_yAxis_90deg = Matrix4.identity()
      ..rotateY(pi / 4.0 * 2.0);
    final rotateMatrix_yAxis_135deg = Matrix4.identity()
      ..rotateY(pi / 4.0 * 3.0);

    final rotateMatrixs_yAxis = <Matrix4>[
      rotateMatrix_yAxis_0deg,
      rotateMatrix_yAxis_45deg,
      rotateMatrix_yAxis_90deg,
      rotateMatrix_yAxis_135deg,
    ];
    final rotateMatrixs_xAxis = <Matrix4>[];

    _animationController.repeat();

    return ConstrainedBox(
      constraints: BoxConstraints.tight(
        Size(120.0, 120.0),
      ),
      child: AnimatedBuilder(
        animation: _rotateAnimation,
        builder: (context, child) {
          final currentRotatedMatrix = Matrix4.identity()
            ..rotateY(_rotateAnimation.value);

          return Stack(children: [
            Center(
              child: Text(
                'hello',
                style: TextStyle(fontSize: 48),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent,
                border: Border.all(color: Colors.white, width: 1.0),
              ),
            ),
            for (final matrix in rotateMatrixs_yAxis)
              Transform(
                transform: currentRotatedMatrix.multiplied(matrix),
                alignment: Alignment.center,
                child: ClipPath(
                  clipper: HalfRectClipper(),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.transparent,
                      backgroundBlendMode: BlendMode.overlay,
                      border: Border.all(color: Colors.white, width: 2.0),
                    ),
                  ),
                ),
              ),

            // for (int i = 0; i < 12; i++)
            //   Transform(
            //     transform: rotateMatrixs_xAxis.elementAt(i),
            //     alignment: Alignment.center,
            //     child: Container(
            //       decoration: BoxDecoration(
            //         shape: BoxShape.circle,
            //         color: Colors.transparent,
            //         border: Border.all(color: Colors.red, width: 1.0),
            //       ),
            //     ),
            //   ),
          ]);
        },
      ),
    );
  }
}

class HalfRectClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path p = Path();
    p.moveTo(0.0, 0.0);
    p.lineTo(size.width / 2.0, 0.0);
    p.lineTo(size.width / 2.0, size.height);
    p.lineTo(0.0, size.height);
    p.close();

    return p;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return true;
  }
}
