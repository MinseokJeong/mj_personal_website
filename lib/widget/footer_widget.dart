import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 80.0,
      decoration: BoxDecoration(color: Colors.white, border: Border.all()),
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "This website design is too much inspired by ",
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            TextButton(
                onPressed: () {
                  launchUrlString("https://dennissnellenberg.com/");
                },
                child: Text(
                  "@Dennis Snellenberg",
                  style: TextStyle(color: Colors.black, fontSize: 14),
                ),
                style: TextButton.styleFrom(padding: EdgeInsets.zero)),
          ],
        ),
      ),
    );
  }
}
