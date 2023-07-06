import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mj_portfolio_web/util/screen_size.dart';
import 'package:mj_portfolio_web/util/size_variation_extension.dart';
import 'package:mj_portfolio_web/widget/footer_widget.dart';
import '../model/size_variation.dart';
import '../widget/hanger_widget.dart';
import '../app_design_resources.dart' as ar;
import '../widget/horizontal_moving_text_widget2.dart';
import '../widget/interact_with_mouse_pointer_icon_widget.dart';
import '../widget/top_header_widget.dart';
import '../model/route_name.dart' as rn;

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
    final bool isSmallScreenSize = !(ScreenSize.isLargeScreenSize(context) ||
        ScreenSize.isLaptopScreenSize(context));

    final screenWidth = ScreenSize.getScreenWidth(context);
    final screenHeight = ScreenSize.getScreenHeight(context);

    final fontSizeVariation = SizeVariation(
      whenType4K: 240,
      whenTypeLaptopLarge: 240,
      whenTypeLaptop: 240,
      whenTypeTablet: 180,
      whenTypeMobileLarge: 120.0,
      whenTypeMobileMedium: 120.0,
      whenTypeMobileSmall: 120.0,
    );

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
                  'assets/mj_image.jpg',
                  height: screenHeight * 1.0,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            const Align(
              alignment: Alignment.topCenter,
              child: TopHeaderWidget(
                textColor: Colors.white,
                currentRoutePageName: rn.homePage,
              ),
            ),
            Align(
              alignment: (isSmallScreenSize)
                  ? const Alignment(-0.9, 0.8)
                  : const Alignment(-1.0, 0.0),
              child: HangerWidget(
                windowSize: Size(screenWidth, screenHeight),
              ),
            ),
            Align(
              alignment: (isSmallScreenSize)
                  ? const Alignment(0.9, 0.8)
                  : const Alignment(0.9, 0.0),
              child: Text(
                'Software\nEngineer & Developer',
                textAlign:
                    (isSmallScreenSize) ? TextAlign.end : TextAlign.start,
                style: ar.textStyleTopSectionLarge,
              ),
            ),
            Align(
              alignment: (isSmallScreenSize)
                  ? const Alignment(-1.0, 0.5)
                  : const Alignment(-1.0, 0.9),
              child: HorizontalMovingTextWidget2(
                text: "Minseok Jeong ",
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: fontSizeVariation.getSizeWithContext(context),
                  height: 1.0,
                  fontFamily: ar.FontName.NotoSansKorean.name,
                ),
                speed: 140000,
                direction: MovingTextDirection2.moving_left,
              ),
            ),
            Align(
              alignment: (isSmallScreenSize)
                  ? const Alignment(0.9, 0.6)
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
            Align(
              alignment: const Alignment(0.0, 1.0),
              child: SizedBox(
                height: 120,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FooterWidget(
                      defaultColor: Colors.white70,
                      highlightColor: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
