import 'package:flutter/material.dart';

class TagWidget extends StatelessWidget {
  TagWidget(
      {super.key, required this.tag, this.textColor, this.backgroundColor});
  final String tag;
  Color? textColor;
  Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.black,
        borderRadius: BorderRadius.circular(8.0),
      ),
      padding: EdgeInsets.all(8.0),
      child: Text(
        tag,
        style: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.normal,
          color: textColor ?? Colors.white,
        ),
      ),
    );
  }
}
