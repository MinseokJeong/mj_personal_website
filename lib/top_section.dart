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
      backgroundColor: ar.topSectionBackgroundColor,
      body: Stack(
        children: [
          Align(
              alignment: Alignment.topCenter, child: TopSectionHeaderWidget()),
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              'assets/brushing_mj.png',
              height: 800,
            ),
          ),
          Align(
            alignment: Alignment(-1.0, 1.0),
            child: HorizontalMovingText(
              text: " Be Good And Do Good And",
              textStyle: TextStyle(color: Colors.white, fontSize: 150.0),
              speed: 22000,
            ),
          ),
          Align(
              alignment: Alignment(-1.0, 0.0),
              child: TopSectionHangerWidget(windowSize: windowSize)),
          Align(
            child: Text(
              'Software\nEngineer & Developer',
              style: ar.textStyleTopSectionLarge,
            ),
            alignment: Alignment(0.9, 0.0),
          )
        ],
      ),
    );
  }
}

class TopSectionHeaderWidget extends StatelessWidget {
  const TopSectionHeaderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 4.0, right: 8.0),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
            child: Text(
              '@ Code by MinseokJeong',
              style: const TextStyle(fontSize: 16.0, color: Colors.white),
            ),
          ),
          Spacer(),
          TopButton(text: 'Work'),
          TopButton(text: 'About'),
          TopButton(text: 'Contact'),
          TopButton(text: 'TEST'),
        ],
      ),
    );
  }
}

class TopSectionHangerWidget extends StatelessWidget {
  const TopSectionHangerWidget({
    Key? key,
    required this.windowSize,
  }) : super(key: key);

  final Size windowSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 40.0),
      decoration: BoxDecoration(
          color: Colors.black,
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
                .copyWith(color: Colors.white, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            width: 32.0,
          ),
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundColor: ar.topSectionBackgroundColor,
              radius: 32,
              child: RotateSphereWidget(
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
