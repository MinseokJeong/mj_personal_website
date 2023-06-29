import 'package:flutter/material.dart';
import 'interaction_menu_button_widget.dart';
import '../model/route_name.dart' as rn;

class TopHeaderWidget extends StatelessWidget {
  const TopHeaderWidget({Key? key, required this.textColor}) : super(key: key);

  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 16.0, right: 8.0),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 40.0),
            child: Text(
              '@ Code by MinseokJeong',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16.0,
                  color: textColor,
                  fontWeight: FontWeight.normal),
            ),
          ),
          const Spacer(),
          InteractionMenuButtonWidget(
            text: 'Home',
            onPressed: () {
              Navigator.pushNamed(context, rn.homePage);
            },
            textColor: textColor,
          ),
          InteractionMenuButtonWidget(
            text: 'Work',
            onPressed: () {
              Navigator.pushNamed(context, rn.workPage);
              //pt.slideUpPageTransition(context, WorkPage(), 'Work');
            },
            textColor: textColor,
          ),
          InteractionMenuButtonWidget(
            text: 'About',
            onPressed: () {
              Navigator.pushNamed(context, rn.aboutPage);
            },
            textColor: textColor,
          ),
        ],
      ),
    );
  }
}
