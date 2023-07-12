import 'package:flutter/material.dart';
import 'package:mj_portfolio_web/util/size_variation_extension.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../model/size_variation.dart';

class UrlLinkButtonWidget extends StatelessWidget {
  const UrlLinkButtonWidget({super.key, required this.url, required this.text});

  final String url;
  final String text;

  @override
  Widget build(BuildContext context) {
    final fontSizeVariation = SizeVariation(
      whenType4K: 20,
      whenTypeLaptopLarge: 20.0,
      whenTypeLaptop: 20.0,
      whenTypeTablet: 18,
      whenTypeMobileLarge: 14.0,
      whenTypeMobileMedium: 14.0,
      whenTypeMobileSmall: 14.0,
    );

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
            style: TextStyle(
                color: Colors.black,
                fontSize: fontSizeVariation.getSizeWithContext(context),
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
