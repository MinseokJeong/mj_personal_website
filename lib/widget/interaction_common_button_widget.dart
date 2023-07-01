import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mj_portfolio_web/util/screen_type.dart';

class InteractionCommonButtonWidget extends StatefulWidget {
  const InteractionCommonButtonWidget({
    super.key,
    required this.backgroundNormalColor,
    this.backgroundFocusColor,
    required this.textNormalColor,
    this.textFocusColor,
    required this.onPressed,
    required this.text,
    this.badge,
  });
  final Color backgroundNormalColor;
  final Color? backgroundFocusColor;
  final Color textNormalColor;
  final Color? textFocusColor;
  final VoidCallback onPressed;
  final String text;
  final String? badge;

  @override
  State<InteractionCommonButtonWidget> createState() =>
      _InteractionCommonButtonWidgetState();
}

class _InteractionCommonButtonWidgetState
    extends State<InteractionCommonButtonWidget> with TickerProviderStateMixin {
  bool _isMouseHovered = false;

  @override
  Widget build(BuildContext context) {
    double ratio = ScreenTypeUtil.calculateRatioWithContext(context);
    if (ratio > 1.0) {
      ratio = 1.0;
    }
    return MouseRegion(
      onEnter: (event) {
        setState(() {
          _isMouseHovered = true;
        });
      },
      onExit: (event) {
        setState(() {
          _isMouseHovered = false;
        });
      },
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {},
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          decoration: BoxDecoration(
              color: _isMouseHovered
                  ? (widget.backgroundFocusColor ??
                      widget.backgroundNormalColor)
                  : widget.backgroundNormalColor,
              borderRadius: BorderRadius.circular(32.0),
              border: Border.all(color: Colors.grey)),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 32.0 * ratio, vertical: 18.0 * ratio),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.text,
                  style: TextStyle(
                    color: _isMouseHovered
                        ? (widget.textFocusColor ?? widget.textNormalColor)
                        : widget.textNormalColor,
                  ),
                ),
                if (widget.badge != null)
                  Padding(
                    padding: EdgeInsets.only(bottom: 12 * ratio),
                    child: Text(
                      widget.badge!,
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
