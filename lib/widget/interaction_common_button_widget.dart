import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';

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
  @override
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool _isMouseHovered = false;

  @override
  Widget build(BuildContext context) {
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
            padding:
                const EdgeInsets.symmetric(horizontal: 32.0, vertical: 18.0),
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
                    padding: EdgeInsets.only(bottom: 12),
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
