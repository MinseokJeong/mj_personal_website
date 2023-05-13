import 'package:flutter/material.dart';
import 'page/about_page.dart';
import 'page/splash_page.dart';
import 'page/home_page.dart';
import 'page/work_page.dart';

class MyWebApp extends StatelessWidget {
  MyWebApp({Key? key}) : super(key: key);
  late ScrollController _scrollController;

  @override
  Widget build(BuildContext context) {
    _scrollController = ScrollController();
    final windowSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Stack(children: [
          Column(
            children: [
              SizedBox(
                width: windowSize.width,
                height: windowSize.height,
                child: HomePage(),
              ),
              SizedBox(
                width: windowSize.width,
                child: AboutPage(),
              ),
              SizedBox(
                width: windowSize.width,
                height: windowSize.height,
                child: WorkPage(),
              ),
            ],
          ),
          Visibility(
            visible:
                true, //TODO: DEBUG PURPOSE, IN RELEASE MODE REMOVE Visibility widget
            child: SizedBox(
              width: windowSize.width,
              height: windowSize.height,
              child: SplashPage(),
            ),
          ),
        ]),
      ),
    );
  }
}
