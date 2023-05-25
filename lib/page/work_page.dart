import 'package:flutter/material.dart';
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
          child: const Column(
            children: [TopHeaderWidget()],
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
