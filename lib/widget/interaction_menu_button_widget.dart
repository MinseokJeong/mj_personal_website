import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mj_portfolio_web/util/screen_size.dart';

class InteractionMenuButtonWidget extends StatefulWidget {
  const InteractionMenuButtonWidget({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.textColor,
    this.selected = false,
  }) : super(key: key);

  final String text;
  final VoidCallback onPressed;
  final Color textColor;
  final bool selected;

  @override
  State<InteractionMenuButtonWidget> createState() =>
      _InteractionMenuButtonWidgetState();
}

class _InteractionMenuButtonWidgetState
    extends State<InteractionMenuButtonWidget> with TickerProviderStateMixin {
  late LineMetrics _calculatedLineMetrics;
  double _horizontalPadding = 16.0;
  double _verticalPadding = 16.0;
  final double _fontSize = 16.0;

  String get _text => widget.text;
  double get _containerWidth =>
      _calculatedLineMetrics.width + _horizontalPadding * 2;
  double get _containerHeight =>
      _calculatedLineMetrics.height + _verticalPadding * 2;

  late AnimationController
      _textPositionAnimationWhenMouseEnterAndExitController;
  late Animation<Offset> _textPositionAnimationWhenMouseEnterAndExit;

  TextStyle get _textStyle => TextStyle(
        color: widget.textColor,
        fontSize: _fontSize,
        fontWeight: FontWeight.normal,
        overflow: TextOverflow.visible,
      );

  final _hoverOffsetStreamController = StreamController<Offset>();

  @override
  void initState() {
    super.initState();

    _calculateSize();

    _textPositionAnimationWhenMouseEnterAndExitController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
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
    if (ScreenSize.isMobileScreenSize(context)) {
      _horizontalPadding = 8.0;
      _verticalPadding = 8.0;
    } else {
      _horizontalPadding = 16.0;
      _verticalPadding = 16.0;
    }
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
              curve: Curves.bounceOut),
        );

        _textPositionAnimationWhenMouseEnterAndExitController.reset();
        _textPositionAnimationWhenMouseEnterAndExitController.forward();

        isMouseEnterAndExitState = true;

        //For update isMouse EnterAndExitState
        _hoverOffsetStreamController.add(Offset.zero);
      },
      child: SizedBox(
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
                      child: Column(
                        children: [
                          TextButton(
                            onPressed: widget.onPressed,
                            child: Text(
                              _text,
                              style: _textStyle,
                              softWrap: false,
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          SizedBox(
                            height: 6,
                            width: 6,
                            child: Container(
                              width: double.infinity,
                              height: double.infinity,
                              decoration: BoxDecoration(
                                color: (widget.selected)
                                    ? widget.textColor
                                    : Colors.transparent,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ],
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
                      child: Column(
                        children: [
                          TextButton(
                            onPressed: widget.onPressed,
                            child: Text(
                              _text,
                              style: _textStyle,
                              softWrap: false,
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          SizedBox(
                            height: 6,
                            width: 6,
                            child: Container(
                              width: double.infinity,
                              height: double.infinity,
                              decoration: BoxDecoration(
                                color: (widget.selected)
                                    ? widget.textColor
                                    : Colors.transparent,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ],
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
