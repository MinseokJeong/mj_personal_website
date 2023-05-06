import 'package:flutter/material.dart';
import '../app_design_resources.dart' as ar;
import 'rotate_globe_widget.dart';

class HangerWidget extends StatelessWidget {
  const HangerWidget({
    Key? key,
    required this.windowSize,
  }) : super(key: key);

  final Size windowSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 40.0, top: 8.0, bottom: 8.0),
      decoration: BoxDecoration(
          color: ar.topSectionHangerBackgroundColor,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(64.0),
              bottomRight: Radius.circular(64.0))),
      height: windowSize.height * 0.12,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Located\nin the\nSouth Korea',
            style: ar.textStyleTopSectionRotateSphereSectionLeftText
                .copyWith(color: Colors.white, fontWeight: FontWeight.w400),
          ),
          SizedBox(
            width: 32.0,
          ),
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundColor: ar.topSectionBackgroundColor,
              radius: 32,
              child: RotateGlobeWidget(
                width: 36,
                height: 36,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
