import 'package:flutter/material.dart';

class TagWidget extends StatelessWidget {
  TagWidget(
      {super.key,
      required this.tag,
      this.textColor,
      this.backgroundColor,
      this.fontSize,
      this.borderRadius,
      this.padding,
      this.borderColor,
      this.borderWidth});
  final String tag;
  Color? textColor;
  Color? backgroundColor;
  double? fontSize;
  double? borderRadius;
  EdgeInsetsGeometry? padding;
  Color? borderColor;
  double? borderWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: backgroundColor ?? Colors.black,
          borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
          border: Border.all(
              color: borderColor ?? backgroundColor ?? Colors.black,
              width: borderWidth ?? 0.0)),
      padding: padding ?? const EdgeInsets.all(8.0),
      child: Text(
        tag,
        style: TextStyle(
          fontSize: fontSize ?? 14.0,
          fontWeight: FontWeight.normal,
          color: textColor ?? Colors.white,
        ),
      ),
    );
  }
}
