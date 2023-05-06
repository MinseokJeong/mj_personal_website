import 'package:flutter/material.dart';
import 'my_web_app.dart';
import 'app_design_resources.dart' show FontName;

void main() => runApp(
      MaterialApp(
        home: MyWebApp(),
        theme: ThemeData(fontFamily: FontName.NotoSansKorean.name),
        debugShowCheckedModeBanner: false,
      ),
    );
