import 'package:flutter/material.dart';
import 'package:mj_portfolio_web/page/test_page.dart';
import 'my_web_app.dart';
import 'app_design_resources.dart' show FontName;

void main() => runApp(
      MaterialApp(
        home: MyWebApp(),
        // home: TestPage(
        //   number: 0,
        // ),
        theme: ThemeData(fontFamily: FontName.NotoSansKorean.name),
        debugShowCheckedModeBanner: false,
      ),
    );
