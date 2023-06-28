import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});
  //Loosely designed in Figma and coded in Visual Studio Code by yours truly. Built with Next.js and Tailwind CSS, deployed with Vercel. All text is set in the Inter typeface.
  //"This website is built with Flutter framework and all the code is written in dart also using Visual Studio Code for code editor. Website design is toooo much inspired by @Dennis Snellenberg."

  @override
  Widget build(BuildContext context) {
    final greyTextStyle = TextStyle(color: Colors.grey, fontSize: 14);
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
                  style: greyTextStyle,
                ),
                _urlTextWidget(
                    "Flutter", "https://flutter.dev/multi-platform/web"),
                Text(
                  " framework and deployed with ",
                  style: greyTextStyle,
                ),
                _urlTextWidget("Vercel", "https://vercel.com/"),
                Text(
                  ", all the code is written in ",
                  style: greyTextStyle,
                ),
                _urlTextWidget("Dart", "https://dart.dev/"),
                Text(
                  " also using ",
                  style: greyTextStyle,
                ),
                _urlTextWidget(
                    "Visual Studio Code", "https://code.visualstudio.com/"),
                Text(
                  " for code editor.",
                  style: greyTextStyle,
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Website design is toooo much inspired by ",
                  style: greyTextStyle,
                ),
                _urlTextWidget(
                    "Dennis Snellenberg", "https://dennissnellenberg.com/"),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "@Code by MinseokJeong",
                  style: greyTextStyle,
                ),
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
            color: Colors.black,
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
