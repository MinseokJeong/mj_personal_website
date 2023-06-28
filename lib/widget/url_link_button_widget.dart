import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class UrlLinkButtonWidget extends StatelessWidget {
  const UrlLinkButtonWidget({super.key, required this.url, required this.text});

  final String url;
  final String text;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        launchUrlString(url);
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.link,
            size: 20.0,
            color: Colors.black,
          ),
          SizedBox(
            width: 4.0,
          ),
          Text(
            text,
            style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
                height: 1.0,
                decoration: TextDecoration.underline),
            textAlign: TextAlign.start,
          ),
        ],
      ),
    );
  }
}
