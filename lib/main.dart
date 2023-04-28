import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mj_portfolio_web/splash_page.dart';
import 'package:mj_portfolio_web/top_section.dart';

void main() => runApp(MyWeb());

class MyWeb extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TopSection(),
      //home: SplashPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
