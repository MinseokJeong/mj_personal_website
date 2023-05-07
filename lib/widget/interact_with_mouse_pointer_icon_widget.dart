import 'package:flutter/material.dart';
import 'dart:math' as math;

class InteractWithMousePointerIconWidget extends StatelessWidget {
  const InteractWithMousePointerIconWidget(
      {this.mousePointerOffsetGlobal, Key? key})
      : super(key: key);
  final Offset? mousePointerOffsetGlobal;

  @override
  Widget build(BuildContext context) {
    final renderObjectFound = context.findRenderObject() as RenderBox?;
    double angle = 0.0;
    if (renderObjectFound != null && mousePointerOffsetGlobal != null) {
      final localizedMousePointerOffset =
          renderObjectFound.globalToLocal(mousePointerOffsetGlobal!);
      final currentWidgetCenterOffset = renderObjectFound.paintBounds.center;
      final betweenOffset =
          currentWidgetCenterOffset - localizedMousePointerOffset;

      angle = math.atan2(betweenOffset.dy, betweenOffset.dx) + math.pi;
    }

    return Transform.rotate(
      angle: angle,
      child: Icon(
        Icons.arrow_right_alt_sharp,
        size: 42,
        color: Colors.white,
      ),
    );
  }
}
