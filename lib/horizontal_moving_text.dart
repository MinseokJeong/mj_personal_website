import 'dart:html';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';

class HorizontalMovingText extends StatefulWidget {
  const HorizontalMovingText({Key? key}) : super(key: key);

  @override
  State<HorizontalMovingText> createState() => _HorizontalMovingTextState();
}

class _HorizontalMovingTextState extends State<HorizontalMovingText>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _textOffsetAnimation;
  late LineMetrics calculatedLineMetrics;

  String text = 'MINSEOK JEONG MINSEOK JEONG MINSEOK JEONG MINSEOK JEONG';

  @override
  void initState() {
    super.initState();

    final textPainter = TextPainter(
        text: TextSpan(
          text: text,
          style: TextStyle(fontSize: 150),
        ),
        maxLines: 1,
        textDirection: TextDirection.ltr);
    textPainter.layout();
    calculatedLineMetrics = textPainter.computeLineMetrics().first;

    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 16));
    _textOffsetAnimation = Tween(
            begin: Offset(0.0, 0.0),
            end: Offset(calculatedLineMetrics.width, 0.0))
        .animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _animationController.reset();
    _animationController.repeat();
    return Stack(
      clipBehavior: Clip.none,
      children: [
        AnimatedBuilder(
          animation: _textOffsetAnimation,
          builder: (context, child) {
            return Transform.translate(
              offset: _textOffsetAnimation.value,
              child: child,
            );
          },
          child: Text(
            text,
            style: TextStyle(fontSize: 150, color: Colors.red),
            softWrap: false,
            overflow: TextOverflow.visible,
          ),
        ),
        AnimatedBuilder(
          animation: _textOffsetAnimation,
          builder: (context, child) {
            return Transform.translate(
              offset: _textOffsetAnimation.value
                  .translate(-calculatedLineMetrics.width, 0),
              child: child,
            );
          },
          child: Text(
            text,
            style: TextStyle(fontSize: 150),
            softWrap: false,
            overflow: TextOverflow.visible,
          ),
        ),
      ],
    );
  }
}
