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
import 'app_resources.dart' as ar;

class TopSection extends StatelessWidget {
  const TopSection({Key? key, required this.scrollController})
      : super(key: key);
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    final windowSize = MediaQuery.of(context).size;
    scrollController.addListener(() {
      print(scrollController.position);
    });

    return Scaffold(
      backgroundColor: HexColor('#999D9D'),
      body: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: DefaultTextStyle(
                  style: const TextStyle(fontSize: 16.0, color: Colors.white),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      WavyAnimatedText('@ Code by MinseokJeong'),
                    ],
                    repeatForever: true,
                    onTap: null,
                  ),
                ),
              ),
              Spacer(),
              TopButton(text: 'Work'),
              TopButton(text: 'About'),
              TopButton(text: 'Contact'),
              TopButton(text: 'TEST'),
            ],
          ),
          HorizontalMovingText(
            text: "CAN'T TYPE HANGEUL...",
            textStyle: TextStyle(color: Colors.white, fontSize: 150.0),
            speed: 5000,
          ),
          WorldSphereRotate(),
          RotateSphereWidget(
            width: 48,
            height: 48,
          ),
          Image.asset(
            'assets/brushing_mj.png',
            height: 800,
          ),
        ],
      ),
    );
  }
}
