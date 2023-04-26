import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mj_portfolio_web/top_button.dart';

class TopSection extends StatelessWidget {
  const TopSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final windowSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: HexColor('#999D9D'),
      body: Container(
        height: windowSize.height,
        width: windowSize.width,
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  '@ Code by MinseokJeong',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                Spacer(),
                TopButton(text: 'Work'),
                TopButton(text: 'About'),
                TopButton(text: 'Contact'),
                TopButton(text: 'TEST'),
              ],
            )
          ],
        ),
      ),
    );
  }
}
