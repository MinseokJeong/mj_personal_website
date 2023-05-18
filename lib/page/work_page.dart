import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:mj_portfolio_web/widget/top_header_widget.dart';

class WorkPage extends StatefulWidget {
  const WorkPage({Key? key}) : super(key: key);

  @override
  State<WorkPage> createState() => _WorkPageState();
}

class _WorkPageState extends State<WorkPage> {
  @override
  Widget build(BuildContext context) {
    final windowSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(children: [
        Container(
          color: Colors.pink,
          child: Column(
            children: [TopHeaderWidget()],
          ),
        ),
        Align(
          child: Text(
            'WORK PAGE',
            style: TextStyle(color: Colors.white),
          ),
          alignment: Alignment.center,
        ),
      ]),
    );
  }
}
