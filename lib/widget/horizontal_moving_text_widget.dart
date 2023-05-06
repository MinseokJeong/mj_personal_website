import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

enum MovingTextDirection {
  moving_left,
  moving_right,
}

class HorizontalMovingTextWidget extends StatefulWidget {
  const HorizontalMovingTextWidget(
      {Key? key,
      required this.text,
      required this.textStyle,
      this.speed = 1000,
      this.direction = MovingTextDirection.moving_left})
      : super(key: key);

  final String text;
  final TextStyle textStyle;
  final int speed;
  final MovingTextDirection direction;

  @override
  State<HorizontalMovingTextWidget> createState() =>
      _HorizontalMovingTextWidgetState();
}

class _HorizontalMovingTextWidgetState extends State<HorizontalMovingTextWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _textOffsetAnimation;
  late LineMetrics _calculatedLineMetrics;
  late String _textToRender;

  @override
  void initState() {
    super.initState();
    _initializeAnimationController();
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
    _textToRender = ' ' + textBuffer.join(' ');

    final textPainterFinal = TextPainter(
        text: TextSpan(
          text: _textToRender,
          style: widget.textStyle,
        ),
        maxLines: 1,
        textDirection: TextDirection.ltr);
    textPainterFinal.layout();
    _calculatedLineMetrics = textPainterFinal.computeLineMetrics().first;

    if (widget.direction == MovingTextDirection.moving_left) {
      _textOffsetAnimation = Tween(
              begin: Offset(0.0, 0.0),
              end: Offset(_calculatedLineMetrics.width, 0.0))
          .animate(_animationController);
    } else {
      _textOffsetAnimation = Tween(
              begin: Offset(0.0, 0.0),
              end: Offset(-_calculatedLineMetrics.width, 0.0))
          .animate(_animationController);
    }
  }

  void _initializeAnimationController() {
    int speed = widget.speed.abs();
    if (speed == 0) {
      speed = 1000;
    }
    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: speed));

    _animationController.repeat();
  }

  @override
  void didUpdateWidget(covariant HorizontalMovingTextWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    _prepareResources();
    return AnimatedBuilder(
        animation: _textOffsetAnimation,
        builder: (context, child) {
          final currentValue = _textOffsetAnimation.value;

          Offset firstTextOffset = Offset.zero;
          Offset secondTextOffset = Offset.zero;

          if (widget.direction == MovingTextDirection.moving_left) {
            firstTextOffset = Offset(-currentValue.dx, currentValue.dy);
            secondTextOffset = Offset(
                -currentValue.dx + _calculatedLineMetrics.width,
                currentValue.dy);
          } else {
            firstTextOffset = Offset(-currentValue.dx, currentValue.dy);
            secondTextOffset = Offset(
                -currentValue.dx - _calculatedLineMetrics.width,
                currentValue.dy);
          }

          return Stack(
            clipBehavior: Clip.none,
            children: [
              Transform.translate(
                offset: firstTextOffset,
                child: Text(
                  _textToRender,
                  style: widget.textStyle,
                  softWrap: false,
                  overflow: TextOverflow.visible,
                ),
              ),
              Transform.translate(
                offset: secondTextOffset,
                child: Text(
                  _textToRender,
                  style: widget.textStyle,
                  softWrap: false,
                  overflow: TextOverflow.visible,
                ),
              ),
            ],
          );
        });
  }
}
