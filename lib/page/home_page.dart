import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import '../widget/hanger_widget.dart';
import '../widget/horizontal_moving_text_widget.dart';
import '../app_design_resources.dart' as ar;
import '../widget/interact_with_mouse_pointer_icon_widget.dart';
import '../widget/top_header_widget.dart';

import 'dart:math' as math;

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
    final windowSize = MediaQuery.of(context).size;
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
            Align(
              alignment: Alignment(0.6, -0.3),
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
