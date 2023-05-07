import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';

class InteractionMenuButtonWidget extends StatefulWidget {
  const InteractionMenuButtonWidget({Key? key, required this.text})
      : super(key: key);
  final String text;
  @override
  State<InteractionMenuButtonWidget> createState() =>
      _InteractionMenuButtonWidgetState();
}

class _InteractionMenuButtonWidgetState
    extends State<InteractionMenuButtonWidget> with TickerProviderStateMixin {
  late LineMetrics _calculatedLineMetrics;
  final double _horizontalPadding = 16.0;
  final double _verticalPadding = 16.0;

  String get _text => widget.text;
  double get _containerWidth =>
      _calculatedLineMetrics.width + _horizontalPadding * 2;
  double get _containerHeight =>
      _calculatedLineMetrics.height + _verticalPadding * 2;

  late AnimationController
      _textPositionAnimationWhenMouseEnterAndExitController;
  late Animation<Offset> _textPositionAnimationWhenMouseEnterAndExit;

  final _textStyle =
      TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400);

  final _hoverOffsetStreamController = StreamController<Offset>();

  @override
  void initState() {
    super.initState();

    _calculateSize();

    _textPositionAnimationWhenMouseEnterAndExitController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _textPositionAnimationWhenMouseEnterAndExit =
        ConstantTween<Offset>(Offset.zero)
            .animate(_textPositionAnimationWhenMouseEnterAndExitController);

    _textPositionAnimationWhenMouseEnterAndExitController.reset();
  }

  @override
  void dispose() {
    _textPositionAnimationWhenMouseEnterAndExitController.dispose();
    super.dispose();
  }

  void _calculateSize() {
    final textSpan = TextSpan(
      text: _text,
      style: _textStyle,
    );
    final textPainter = TextPainter(
        text: textSpan, maxLines: 1, textDirection: TextDirection.ltr);
    textPainter.layout();
    _calculatedLineMetrics = textPainter.computeLineMetrics().first;
  }

  bool isMouseEnterAndExitState = true;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {
        final localPosition = event.localPosition;

        final currentOffset = Offset(localPosition.dx - _containerWidth / 2.0,
            localPosition.dy - _containerHeight / 2.0);

        _textPositionAnimationWhenMouseEnterAndExit =
            Tween<Offset>(begin: Offset.zero, end: currentOffset).animate(
          CurvedAnimation(
              parent: _textPositionAnimationWhenMouseEnterAndExitController,
              curve: Curves.decelerate),
        );
        _textPositionAnimationWhenMouseEnterAndExitController.reset();
        _textPositionAnimationWhenMouseEnterAndExitController.forward();

        isMouseEnterAndExitState = true;
      },
      onHover: (event) {
        final localPosition = event.localPosition;
        final currentOffset = Offset(localPosition.dx - _containerWidth / 2.0,
            localPosition.dy - _containerHeight / 2.0);

        _hoverOffsetStreamController.add(currentOffset);

        if (isMouseEnterAndExitState) {
          isMouseEnterAndExitState = false;
        }
      },
      onExit: (event) {
        final localPosition = event.localPosition;

        final currentOffset = Offset(localPosition.dx - _containerWidth / 2.0,
            localPosition.dy - _containerHeight / 2.0);

        _textPositionAnimationWhenMouseEnterAndExit =
            Tween<Offset>(begin: currentOffset, end: Offset.zero).animate(
          CurvedAnimation(
              parent: _textPositionAnimationWhenMouseEnterAndExitController,
              curve: Curves.decelerate),
        );

        _textPositionAnimationWhenMouseEnterAndExitController.reset();
        _textPositionAnimationWhenMouseEnterAndExitController.forward();

        isMouseEnterAndExitState = true;

        //For update isMouse EnterAndExitState
        _hoverOffsetStreamController.add(Offset.zero);
      },
      child: Container(
        width: _containerWidth,
        height: _containerHeight,
        child: Stack(
          children: [
            Center(
              child: AnimatedBuilder(
                animation:
                    _textPositionAnimationWhenMouseEnterAndExitController,
                builder: (context, child) {
                  return Visibility(
                    visible: isMouseEnterAndExitState,
                    child: Transform.translate(
                      offset: _textPositionAnimationWhenMouseEnterAndExit.value,
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          _text,
                          style: _textStyle,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Center(
              child: StreamBuilder<Offset>(
                stream: _hoverOffsetStreamController.stream,
                builder: (context, snapshot) {
                  Offset moveOffset = Offset.zero;
                  if (snapshot.hasData) {
                    moveOffset = snapshot.data!;
                  }
                  return Visibility(
                    visible: !isMouseEnterAndExitState,
                    child: Transform.translate(
                      offset: moveOffset,
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          _text,
                          style: _textStyle,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
