import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mj_portfolio_web/util/screen_size.dart';

enum MovingTextDirection2 {
  moving_left,
  moving_right,
}

class HorizontalMovingTextWidget2 extends StatefulWidget {
  const HorizontalMovingTextWidget2(
      {Key? key,
      required this.text,
      required this.textStyle,
      this.speed = 1000,
      this.direction = MovingTextDirection2.moving_left})
      : super(key: key);

  final String text;
  final TextStyle textStyle;
  final int speed;
  final MovingTextDirection2 direction;

  @override
  State<HorizontalMovingTextWidget2> createState() =>
      _HorizontalMovingTextWidgetState2();
}

class _HorizontalMovingTextWidgetState2
    extends State<HorizontalMovingTextWidget2>
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
    final screenWidth = ScreenSize.getScreenWidth(context);

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
    int cloneStringCount = 1;

    while (textLineWidth * cloneStringCount.toDouble() <= screenWidth * 10) {
      ++cloneStringCount;
    }
    _textToRender = '';
    final textBuffer = <String>[];
    for (int i = 0; i < cloneStringCount; ++i) {
      textBuffer.add(widget.text);
    }
    _textToRender = ' ${textBuffer.join(' ')}';

    final textPainterFinal = TextPainter(
        text: TextSpan(
          text: _textToRender,
          style: widget.textStyle,
        ),
        maxLines: 1,
        textDirection: TextDirection.ltr);
    textPainterFinal.layout();
    _calculatedLineMetrics = textPainterFinal.computeLineMetrics().first;

    if (widget.direction == MovingTextDirection2.moving_left) {
      _textOffsetAnimation = Tween(
              begin: const Offset(0.0, 0.0),
              end: Offset(-_calculatedLineMetrics.width, 0.0))
          .animate(_animationController);
    } else {
      _textOffsetAnimation = Tween(
        begin: Offset(_calculatedLineMetrics.width, 0.0),
        end: const Offset(0.0, 0.0),
      ).animate(_animationController);
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
  Widget build(BuildContext context) {
    _prepareResources();

    return AnimatedBuilder(
      animation: _textOffsetAnimation,
      builder: (context, child) {
        return Stack(
          clipBehavior: Clip.none,
          children: [
            Transform.translate(
              offset: _textOffsetAnimation.value,
              child: child,
            ),
          ],
        );
      },
      child: Text(
        _textToRender,
        style: widget.textStyle,
        softWrap: false,
        overflow: TextOverflow.visible,
      ),
    );
  }
}
