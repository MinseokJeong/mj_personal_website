import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class FooterWidget extends StatelessWidget {
  Color defaultColor;
  Color highlightColor;

  FooterWidget({
    super.key,
    this.defaultColor = Colors.grey,
    this.highlightColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    final defaultTextStyle = TextStyle(color: defaultColor, fontSize: 12);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "This website is built with ",
                  style: defaultTextStyle,
                ),
                _urlTextWidget(
                    "Flutter", "https://flutter.dev/multi-platform/web"),
                Text(
                  " framework and deployed with ",
                  style: defaultTextStyle,
                ),
                _urlTextWidget("Vercel", "https://vercel.com/"),
                Text(
                  ", all the code is written in ",
                  style: defaultTextStyle,
                ),
                _urlTextWidget("Dart", "https://dart.dev/"),
                Text(
                  " also using ",
                  style: defaultTextStyle,
                ),
                _urlTextWidget(
                    "Visual Studio Code", "https://code.visualstudio.com/"),
                Text(
                  " for code editor.",
                  style: defaultTextStyle,
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Website design is too much inspired by ",
                  style: defaultTextStyle,
                ),
                _urlTextWidget(
                    "Dennis Snellenberg", "https://dennissnellenberg.com/"),
                Text(
                  ". @Code by MinseokJeong. 2023 © Edition",
                  style: defaultTextStyle,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _urlTextWidget(String text, String url) {
    return TextButton(
      onPressed: () {
        launchUrlString(url);
      },
      child: Text(
        text,
        style: TextStyle(
            color: highlightColor,
            fontSize: 14,
            decoration: TextDecoration.underline),
      ),
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: Size.zero,
      ),
    );
  }
}
