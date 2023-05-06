import 'package:flutter/material.dart';
import '../widget/horizontal_moving_text_widget.dart';
import '../widget/interaction_menu_button_widget.dart';
import '../widget/rotate_globe_widget.dart';
import '../app_design_resources.dart' as ar;

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final windowSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ar.topSectionBackgroundColor,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: UnconstrainedBox(
              clipBehavior: Clip.hardEdge,
              child: Image.asset(
                'assets/dennissnellenberg_image.jpeg',
                height: windowSize.height * 1.2,
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          Align(
              alignment: Alignment.topCenter, child: TopSectionHeaderWidget()),
          Align(
              alignment: Alignment(-1.0, 0.0),
              child: TopSectionHangerWidget(windowSize: windowSize)),
          Align(
            child: Text(
              'Software\nEngineer & Developer',
              style: ar.textStyleTopSectionLarge,
            ),
            alignment: Alignment(0.9, 0.0),
          ),
          Align(
            alignment: Alignment(-1.0, 0.9),
            child: HorizontalMovingTextWidget(
              text: "Minseok Jeong ",
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: 150.0,
                fontFamily: ar.FontName.NotoSansKorean.name,
              ),
              speed: 22000,
              direction: MovingTextDirection.moving_left,
            ),
          ),
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
          InteractionMenuButtonWidget(text: 'Work'),
          InteractionMenuButtonWidget(text: 'About'),
          InteractionMenuButtonWidget(text: 'Contact'),
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
