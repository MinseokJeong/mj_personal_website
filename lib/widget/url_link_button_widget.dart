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
          const Icon(
            Icons.link,
            size: 20.0,
            color: Colors.black,
          ),
          const SizedBox(
            width: 4.0,
          ),
          Text(
            text,
            style: const TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.normal,
                height: 1.0,
                decoration: TextDecoration.underline),
            textAlign: TextAlign.start,
          ),
        ],
      ),
    );
  }
}
