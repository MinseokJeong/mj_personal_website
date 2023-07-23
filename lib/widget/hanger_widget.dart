import 'package:flutter/material.dart';
import '../util/screen_size.dart';
import 'rotate_globe_widget.dart';
import '../util/hex_color.dart';

class HangerWidget extends StatelessWidget {
  const HangerWidget({
    Key? key,
    required this.windowSize,
  }) : super(key: key);

  final Size windowSize;

  @override
  Widget build(BuildContext context) {
    if (ScreenSize.isTabletScreenSize(context) ||
        ScreenSize.isMobileScreenSize(context)) {
      return const RotateGlobeWidget(
        width: 36,
        height: 36,
        color: Colors.white,
      );
    } else {
      return Container(
        decoration: BoxDecoration(
            color: HexColor('#1C1D20'),
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(64.0),
                bottomRight: Radius.circular(64.0))),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(left: 40.0, top: 16.0, bottom: 16.0),
              child: Text(
                'Located\nin the\nSouth Korea',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.normal),
              ),
            ),
            const SizedBox(
              width: 32.0,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: CircleAvatar(
                backgroundColor: HexColor('#999D9D'),
                radius: 32,
                child: const RotateGlobeWidget(
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
}
