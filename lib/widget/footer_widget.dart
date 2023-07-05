import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mj_portfolio_web/model/enum_screen_type.dart';
import 'package:mj_portfolio_web/util/screen_size.dart';
import 'package:mj_portfolio_web/util/screen_type_extension.dart';
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
    final highlightTextStyle = defaultTextStyle.copyWith(color: highlightColor);
    final screenWidth = ScreenSize.getScreenWidth(context);

    if (screenWidth < ScreenType.tablet.width) {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Wrap(
                children: [
                  Text.rich(TextSpan(children: [
                    TextSpan(text: "This website is built with "),
                    _urlTextSpan(
                        'Flutter',
                        "https://flutter.dev/multi-platform/web",
                        highlightTextStyle),
                    TextSpan(
                      text: " framework and deployed with ",
                    ),
                    _urlTextSpan(
                        "Vercel", "https://vercel.com/", highlightTextStyle),
                    TextSpan(
                      text: ", all the code is written in ",
                    ),
                    _urlTextSpan(
                        "Dart", "https://dart.dev/", highlightTextStyle),
                    TextSpan(
                      text: " also using ",
                    ),
                    _urlTextSpan("Visual Studio Code",
                        "https://code.visualstudio.com/", highlightTextStyle),
                    TextSpan(
                      text: " for code editor.",
                    ),
                    TextSpan(
                      text: "Website design is too much inspired by ",
                    ),
                    _urlTextSpan("Dennis Snellenberg",
                        "https://dennissnellenberg.com/", highlightTextStyle),
                    TextSpan(
                      text: ". @Code by MinseokJeong. 2023 © Edition",
                    )
                  ], style: defaultTextStyle)),
                ],
              ),
            ],
          ),
        ),
      );
    } else {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text.rich(TextSpan(style: defaultTextStyle, children: [
                TextSpan(
                  text: "This website is built with ",
                ),
                _urlTextSpan(
                    "Flutter",
                    "https://flutter.dev/multi-platform/web",
                    highlightTextStyle),
                TextSpan(
                  text: " framework and deployed with ",
                ),
                _urlTextSpan(
                    "Vercel", "https://vercel.com/", highlightTextStyle),
                TextSpan(
                  text: ", all the code is written in ",
                ),
                _urlTextSpan("Dart", "https://dart.dev/", highlightTextStyle),
                TextSpan(
                  text: " also using ",
                ),
                _urlTextSpan("Visual Studio Code",
                    "https://code.visualstudio.com/", highlightTextStyle),
                TextSpan(
                  text: " for code editor.",
                ),
              ])),
              Text.rich(TextSpan(style: defaultTextStyle, children: [
                TextSpan(
                  text: "Website design is too much inspired by ",
                ),
                _urlTextSpan("Dennis Snellenberg",
                    "https://dennissnellenberg.com/", highlightTextStyle),
                TextSpan(
                  text: ". @Code by MinseokJeong. 2023 © Edition",
                )
              ])),
            ],
          ),
        ),
      );
    }
  }

  TextSpan _urlTextSpan(String text, String url, TextStyle style) {
    return TextSpan(
        text: text,
        recognizer: TapGestureRecognizer()..onTap = () => launchUrlString(url),
        style: style);
  }
}
