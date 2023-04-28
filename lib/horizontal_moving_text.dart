import 'dart:html';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';

class HorizontalMovingText extends StatefulWidget {
  const HorizontalMovingText(
      {Key? key,
      required this.text,
      required this.textStyle,
      this.speed = 1000})
      : super(key: key);

  final String text;
  final TextStyle textStyle;
  final int speed;

  @override
  State<HorizontalMovingText> createState() => _HorizontalMovingTextState();
}

class _HorizontalMovingTextState extends State<HorizontalMovingText>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _textOffsetAnimation;
  late LineMetrics _calculatedLineMetrics;
  late String _textToRender;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _prepareResources() {
    final textPainter = TextPainter(
        text: TextSpan(
          text: widget.text,
          style: widget.textStyle,
        ),
        maxLines: 1,
        textDirection: TextDirection.ltr);

    textPainter.layout();

    final computedLineMetrics = textPainter.computeLineMetrics().first;
    final textLineWidth = computedLineMetrics.width;
    final screenWidth = MediaQuery.of(context).size.width;
    int cloneStringCount = 1;

    while (textLineWidth * cloneStringCount.toDouble() <= screenWidth) {
      ++cloneStringCount;
    }
    _textToRender = '';
    final textBuffer = <String>[];
    for (int i = 0; i < cloneStringCount; ++i) {
      textBuffer.add(widget.text);
    }
    _textToRender = textBuffer.join(' ') + ' ';

    final textPainterFinal = TextPainter(
        text: TextSpan(
          text: _textToRender,
          style: widget.textStyle,
        ),
        maxLines: 1,
        textDirection: TextDirection.ltr);
    textPainterFinal.layout();
    _calculatedLineMetrics = textPainterFinal.computeLineMetrics().first;

    int speed = widget.speed.abs();
    if (speed == 0) {
      speed = 1000;
    }
    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: speed));
    _textOffsetAnimation = Tween(
            begin: Offset(0.0, 0.0),
            end: Offset(_calculatedLineMetrics.width, 0.0))
        .animate(_animationController);
  }

  @override
  Widget build(BuildContext context) {
    _prepareResources();

    _animationController.repeat();

    return AnimatedBuilder(
        animation: _textOffsetAnimation,
        builder: (context, child) {
          final currentValue = _textOffsetAnimation.value;
          return Stack(
            clipBehavior: Clip.none,
            children: [
              Transform.translate(
                offset: currentValue,
                child: Text(
                  _textToRender,
                  style: widget.textStyle,
                  softWrap: false,
                  overflow: TextOverflow.visible,
                ),
              ),

              Transform.translate(
                offset:
                    currentValue.translate(-_calculatedLineMetrics.width, 0.0),
                child: Text(
                  _textToRender,
                  style: widget.textStyle,
                  softWrap: false,
                  overflow: TextOverflow.visible,
                ),
              ),
              // AnimatedBuilder(
              //   animation: _textOffsetAnimation,
              //   builder: (context, child) {
              //     return Transform.translate(
              //       offset: _textOffsetAnimation.value
              //           .translate(-_calculatedLineMetrics.width, 0),
              //       child: child,
              //     );
              //   },
              //   child: Text(
              //     _textToRender,
              //     style: widget.textStyle,
              //     softWrap: false,
              //     overflow: TextOverflow.visible,
              //   ),
              // ),
            ],
          );
        });
  }
}
