import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mj_portfolio_web/horizontal_moving_text.dart';
import 'package:mj_portfolio_web/top_button.dart';
import 'package:mj_portfolio_web/world_sphere_rotate.dart';

import 'rotate_sphere.dart';

class TopSection extends StatelessWidget {
  const TopSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final windowSize = MediaQuery.of(context).size;
    const colorizeColors = [
      Colors.purple,
      Colors.blue,
      Colors.yellow,
      Colors.red,
    ];

    const colorizeTextStyle = TextStyle(fontSize: 50.0, fontFamily: 'Horizon');
    return Scaffold(
      backgroundColor: HexColor('#999D9D'),
      body: Container(
        height: windowSize.height,
        width: windowSize.width,
        child: Column(
          children: [
            Row(
              children: [
                AnimatedTextKit(
                  animatedTexts: [
                    ColorizeAnimatedText(
                      '@ Code by MinseokJeong',
                      textStyle: colorizeTextStyle,
                      colors: colorizeColors,
                    ),
                  ],
                  isRepeatingAnimation: true,
                  onTap: () {
                    print("Tap Event");
                  },
                ),
                Spacer(),
                TopButton(text: 'Work'),
                TopButton(text: 'About'),
                TopButton(text: 'Contact'),
                TopButton(text: 'TEST'),
              ],
            ),
            HorizontalMovingText(),
            WorldSphereRotate(),
            CustomPaint(
              painter: RotateSphereCustomPainter(1.0),
              size: Size(48, 48),
            ),
          ],
        ),
      ),
    );
  }
}
