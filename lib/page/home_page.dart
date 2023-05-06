import 'package:flutter/material.dart';
import '../widget/hanger_widget.dart';
import '../widget/horizontal_moving_text_widget.dart';
import '../app_design_resources.dart' as ar;
import '../widget/top_header_widget.dart';

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
          Align(alignment: Alignment.topCenter, child: TopHeaderWidget()),
          Align(
              alignment: Alignment(-1.0, 0.0),
              child: HangerWidget(windowSize: windowSize)),
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
