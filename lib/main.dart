import 'package:flutter/material.dart';
import 'main_page.dart';
import 'app_resources.dart' show FontName;

void main() => runApp(MyWeb());

class MyWeb extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainPage(),
      theme: ThemeData(fontFamily: FontName.NotoSansKorean.name),
      debugShowCheckedModeBanner: false,
    );
  }
}
