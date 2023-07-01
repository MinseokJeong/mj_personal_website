import 'package:flutter/material.dart';
import 'package:mj_portfolio_web/util/screen_size.dart';
import 'page/splash_page.dart';
import 'page/home_page.dart';

class MyWebApp extends StatelessWidget {
  MyWebApp({Key? key}) : super(key: key);
  late ScrollController _scrollController;

  @override
  Widget build(BuildContext context) {
    _scrollController = ScrollController();
    final screenWidth = ScreenSize.getScreenWidth(context);
    final screenHeight = ScreenSize.getScreenHeight(context);

    return Scaffold(
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Stack(children: [
          Column(
            children: [
              SizedBox(
                width: screenWidth,
                height: screenHeight,
                child: const HomePage(),
              ),
            ],
          ),
          Visibility(
            visible:
                true, //TODO: DEBUG PURPOSE, IN RELEASE MODE REMOVE Visibility widget
            child: SizedBox(
              width: screenWidth,
              height: screenHeight,
              child: const SplashPage(),
            ),
          ),
        ]),
      ),
    );
  }
}
