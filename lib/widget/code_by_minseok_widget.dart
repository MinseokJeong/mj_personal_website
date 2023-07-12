import 'package:flutter/material.dart';
import 'dart:math';

class CodeByMinseokWidget extends StatefulWidget {
  CodeByMinseokWidget(
      {super.key, required this.onPressed, required this.color});
  void Function() onPressed;
  Color color;

  @override
  State<CodeByMinseokWidget> createState() => _CodeByMinseokWidgetState();
}

class _CodeByMinseokWidgetState extends State<CodeByMinseokWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _textOpacityAnimation;
  late Animation<double> _textOpacityReverseAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _textOpacityAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _textOpacityReverseAnimation =
        Tween<double>(begin: 1.0, end: 0.0).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {
        _animationController.reset();
        _animationController.forward();
      },
      onExit: (event) {
        _animationController.reverse();
      },
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            final rotateValue = _animationController.value * 2.0 * pi;
            final textStyle = TextStyle(
                fontSize: 20,
                color: widget.color,
                fontWeight: FontWeight.normal);

            //final rotate
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Transform.rotate(
                  angle: rotateValue,
                  child: Text(
                    '@',
                    style: textStyle,
                  ),
                ),
                Stack(
                  children: [
                    FadeTransition(
                      opacity: _textOpacityReverseAnimation,
                      child: Text(
                        " Code by Minseok",
                        style: textStyle,
                      ),
                    ),
                    FadeTransition(
                      opacity: _textOpacityAnimation,
                      child: Text(
                        " Minseok Jeong",
                        style: textStyle,
                      ),
                    ),
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
