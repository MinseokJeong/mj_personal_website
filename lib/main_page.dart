import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
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
        Visibility(
          visible: true,
          child: SizedBox(
            width: windowSize.width,
            height: 2000,
            child: TopSection(
              scrollController: _scrollController,
            ),
          ),
        ),
        Visibility(
          visible: false,
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
