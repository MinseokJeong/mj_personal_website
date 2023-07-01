import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mj_portfolio_web/util/screen_size.dart';
import '../widget/hanger_widget.dart';
import '../widget/horizontal_moving_text_widget.dart';
import '../app_design_resources.dart' as ar;
import '../widget/interact_with_mouse_pointer_icon_widget.dart';
import '../widget/top_header_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _mouseHoverStreamController = StreamController<Offset>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bool isNotLargeScreenSize = ScreenSize.isNotLargeScreenSize(context);

    final screenWidth = ScreenSize.getScreenWidth(context);
    final screenHeight = ScreenSize.getScreenHeight(context);

    return MouseRegion(
      onHover: (event) {
        _mouseHoverStreamController.add(event.position);
      },
      child: Scaffold(
        backgroundColor: ar.topSectionBackgroundColor,
        body: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: UnconstrainedBox(
                clipBehavior: Clip.hardEdge,
                child: Image.asset(
                  'assets/mj_image.png',
                  height: screenHeight * 1.0,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            const Align(
              alignment: Alignment.topCenter,
              child: TopHeaderWidget(
                textColor: Colors.white,
              ),
            ),
            Align(
              alignment: (isNotLargeScreenSize)
                  ? const Alignment(-0.9, 0.9)
                  : const Alignment(-1.0, 0.0),
              child: HangerWidget(
                windowSize: Size(screenWidth, screenHeight),
              ),
            ),
            Align(
              alignment: (isNotLargeScreenSize)
                  ? const Alignment(0.9, 0.9)
                  : const Alignment(0.9, 0.0),
              child: Text(
                'Software\nEngineer & Developer',
                textAlign:
                    (isNotLargeScreenSize) ? TextAlign.end : TextAlign.start,
                style: ar.textStyleTopSectionLarge,
              ),
            ),
            Align(
              alignment: (isNotLargeScreenSize)
                  ? const Alignment(-1.0, 0.6)
                  : const Alignment(-1.0, 0.9),
              child: HorizontalMovingTextWidget(
                text: "Minseok Jeong ",
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: screenWidth * 0.18,
                  fontFamily: ar.FontName.NotoSansKorean.name,
                ),
                speed: 22000,
                direction: MovingTextDirection.moving_left,
              ),
            ),
            Align(
              alignment: (isNotLargeScreenSize)
                  ? const Alignment(0.9, 0.7)
                  : const Alignment(0.6, -0.3),
              child: StreamBuilder<Offset>(
                stream: _mouseHoverStreamController.stream,
                builder: (context, snapshot) {
                  return InteractWithMousePointerIconWidget(
                    mousePointerOffsetGlobal:
                        (snapshot.hasData) ? snapshot.data! : null,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
