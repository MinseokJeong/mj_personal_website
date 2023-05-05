import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:mj_portfolio_web/second_part.dart';
import 'package:mj_portfolio_web/splash_page.dart';
import 'package:mj_portfolio_web/top_section.dart';

class MainPage extends StatelessWidget {
  MainPage({Key? key}) : super(key: key);
  late ScrollController _scrollController;

  @override
  Widget build(BuildContext context) {
    _scrollController = ScrollController();
    final windowSize = MediaQuery.of(context).size;

    return SingleChildScrollView(
      controller: _scrollController,
      child: Stack(children: [
        Column(
          children: [
            SizedBox(
              width: windowSize.width,
              height: windowSize.height,
              child: TopSection(
                scrollController: _scrollController,
              ),
            ),
            SizedBox(
              width: windowSize.width,
              height: windowSize.height,
              child: SecondPart(
                scrollController: _scrollController,
              ),
            ),
          ],
        ),
        Visibility(
          visible: true,
          child: SizedBox(
            width: windowSize.width,
            height: windowSize.height,
            child: SplashPage(),
          ),
        ),
      ]),
    );
  }
}
