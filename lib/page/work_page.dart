import 'package:flutter/material.dart';
import 'package:mj_portfolio_web/widget/top_header_widget.dart';

class WorkPage extends StatefulWidget {
  const WorkPage({Key? key}) : super(key: key);

  @override
  State<WorkPage> createState() => _WorkPageState();
}

class _WorkPageState extends State<WorkPage> {
  final _colorBackground = const Color(0xFFFFFFFF);
  final _colorTextBlack = const Color(0xff1C1D20);
  final _colorTextGrey = const Color(0xffAFAFB0);
  final _colorButtonBorder = const Color(0xffAFAFB0);
  final _colorButtonColorWhite = const Color(0xFFFFFFFF);
  final _colorButtonColorBlack = const Color(0xff1C1D20);

  @override
  Widget build(BuildContext context) {
    final windowSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(children: [
        Container(
          color: _colorBackground,
          child: const Column(
            children: [
              TopHeaderWidget(
                textColor: Colors.black,
              )
            ],
          ),
        ),
        const Align(
          alignment: Alignment.center,
          child: Text(
            'WORK PAGE',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ]),
    );
  }
}
