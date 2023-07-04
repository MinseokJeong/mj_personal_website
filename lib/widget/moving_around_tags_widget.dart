import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mj_portfolio_web/widget/tag_widget.dart';

class MovingAroundTagsWidget extends StatefulWidget {
  const MovingAroundTagsWidget({super.key, required this.tags});
  final List<String> tags;

  @override
  State<MovingAroundTagsWidget> createState() => _MovingAroundTagsWidgetState();
}

class _MovingAroundTagsWidgetState extends State<MovingAroundTagsWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  List<_MovingTextModel> _movingTextModels = [];

  late Random randomNumberGenerator;

  double widthBoundary = 100;
  double heightBoundary = 100;

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: Duration(minutes: 1));
    _animationController.reset();
    _animationController.repeat();

    randomNumberGenerator = Random(DateTime.now().millisecondsSinceEpoch);
    //_setMovingTextModels();
  }

  @override
  void didUpdateWidget(covariant MovingAroundTagsWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    // if (this.hashCode != oldWidget.hashCode) {
    //   _setMovingTextModels();
    // }
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }

  void _setMovingTextModels() {
    final defaultWidth = widthBoundary;
    final defaultHeight = heightBoundary;
    _movingTextModels = widget.tags
        .map(
          (e) => _MovingTextModel(
              e,
              Offset(randomNumberGenerator.nextDouble() * defaultWidth,
                  randomNumberGenerator.nextDouble() * defaultHeight),
              randomNumberGenerator.nextDouble() * pi * 2.0,
              randomNumberGenerator.nextDouble() * pi * 2.0),
        )
        .toList();
  }

  void _translateMovingText(_MovingTextModel model) {
    model.translate(_getRandomDeltaOffset(model.azimuth));
    bool boundaryTouched = false;
    //left, right boundary check
    if (model.translation.dx < 0.0) {
      model.translation = Offset(0.0, model.translation.dy);

      boundaryTouched = true;
    } else if (model.translation.dx > widthBoundary) {
      model.translation = Offset(widthBoundary, model.translation.dy);
      boundaryTouched = true;
    }

    //top, bototm boundary check
    if (model.translation.dy < 0.0) {
      model.translation = Offset(model.translation.dx, 0.0);
      boundaryTouched = true;
    } else if (model.translation.dy > heightBoundary) {
      model.translation = Offset(model.translation.dx, heightBoundary);
      boundaryTouched = true;
    }

    if (boundaryTouched) {
      model.azimuth += pi / 4.0;
    }
  }

  Offset _getRandomDeltaOffset(double directionAngle) {
    final double length = 1.0;
    double deltaXvalue =
        length * cos(directionAngle) * randomNumberGenerator.nextDouble() * 1.0;
    double deltaYvalue =
        length * sin(directionAngle) * randomNumberGenerator.nextDouble() * 1.0;

    return Offset(deltaXvalue, deltaYvalue);
  }

  double _getRandomDeltaRotate() {
    return randomNumberGenerator.nextDouble() * pi / 180.0;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (bc, constraints) {
        widthBoundary = constraints.constrainWidth();
        heightBoundary = constraints.constrainHeight();
        _setMovingTextModels();

        if (_movingTextModels.isEmpty) {
          return SizedBox.shrink();
        } else {
          return Stack(
            clipBehavior: Clip.none,
            children: [
              ..._movingTextModels.map((e) {
                return AnimatedBuilder(
                  animation: _animationController,
                  builder: (bc, child) {
                    _translateMovingText(e);
                    e.rotate(_getRandomDeltaRotate());
                    return Positioned(
                      left: e.translation.dx,
                      top: e.translation.dy,
                      child: Transform.rotate(
                        angle: e.rotation,
                        child: child,
                      ),
                    );
                  },
                  child: TagWidget(
                    tag: e.text,
                    textColor: Colors.white38,
                    backgroundColor: Colors.black38,
                  ),
                );
              })
            ],
          );
        }
      },
    );
  }
}

class _MovingTextModel {
  String text;
  Offset translation;
  double rotation;
  double azimuth;

  _MovingTextModel(this.text, this.translation, this.rotation, this.azimuth);

  void translate(Offset deltaOffset) {
    translation += deltaOffset;
  }

  void rotate(double deltaRotateRadian) {
    rotation += deltaRotateRadian;
  }

  Matrix4 getTransform() {
    final mat = Matrix4.identity();
    mat.rotateZ(rotation);
    mat.translate(translation.dx, translation.dy);
    return mat;
  }
}
