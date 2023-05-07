import 'package:flutter/material.dart';

import 'interaction_menu_button_widget.dart';

class TopHeaderWidget extends StatelessWidget {
  const TopHeaderWidget({
    Key? key,
  }) : super(key: key);

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
              style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w400),
            ),
          ),
          Spacer(),
          InteractionMenuButtonWidget(text: 'Work'),
          InteractionMenuButtonWidget(text: 'About'),
          InteractionMenuButtonWidget(text: 'Contact'),
        ],
      ),
    );
  }
}
