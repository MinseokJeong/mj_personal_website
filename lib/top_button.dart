import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class TopButton extends StatefulWidget {
  const TopButton({Key? key, required this.text}) : super(key: key);
  final String text;
  @override
  State<TopButton> createState() => _TopButtonState();
}

class _TopButtonState extends State<TopButton>
    with SingleTickerProviderStateMixin {
  late LineMetrics _calculatedLineMetrics;
  Offset _offset = Offset(0.0, 0.0);
  final double _horizontalPadding = 16.0;
  final double _verticalPadding = 16.0;

  String get _text => widget.text;
  double get _containerWidth =>
      _calculatedLineMetrics.width + _horizontalPadding * 2;
  double get _containerHeight =>
      _calculatedLineMetrics.height + _verticalPadding * 2;

  late AnimationController _textBackToOriginalPositionAnimationController;
  late Animation<double> _textBackToOriginalPositionAnimation;

  @override
  void initState() {
    super.initState();

    _calculateSize();

    _textBackToOriginalPositionAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    _textBackToOriginalPositionAnimation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: _textBackToOriginalPositionAnimationController,
            curve: Curves.elasticOut));
  }

  @override
  void dispose() {
    _textBackToOriginalPositionAnimationController.dispose();

    super.dispose();
  }

  void _calculateSize() {
    final textSpan = TextSpan(
      text: _text,
      style: TextStyle(color: Colors.white, fontSize: 16),
    );
    final textPainter = TextPainter(
        text: textSpan, maxLines: 1, textDirection: TextDirection.ltr);
    textPainter.layout();
    _calculatedLineMetrics = textPainter.computeLineMetrics().first;
  }

  bool isMouseExit = true;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {},
      onHover: (event) {
        final localPosition = event.localPosition;
        setState(() {
          _offset = Offset(localPosition.dx - _containerWidth / 2.0,
              localPosition.dy - _containerHeight / 2.0);
        });
        isMouseExit = false;
      },
      onExit: (event) {
        _textBackToOriginalPositionAnimationController.reset();
        _textBackToOriginalPositionAnimationController.forward();
        _offset = Offset(event.localPosition.dx - _containerWidth / 2.0,
            event.localPosition.dy - _containerHeight / 2.0);

        isMouseExit = true;
      },
      child: Container(
        width: _containerWidth,
        height: _containerHeight,
        child: Center(
          child: AnimatedBuilder(
            animation: _textBackToOriginalPositionAnimation,
            builder: (context, child) {
              final currentOffset =
                  Tween<Offset>(begin: _offset, end: Offset(0.0, 0.0))
                      .evaluate(_textBackToOriginalPositionAnimation);

              return Transform.translate(
                offset: isMouseExit ? currentOffset : _offset,
                child: Text(
                  _text,
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
