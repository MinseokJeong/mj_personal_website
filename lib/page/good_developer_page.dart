import 'package:flutter/material.dart';
import 'package:mj_portfolio_web/util/screen_size.dart';
import 'package:mj_portfolio_web/widget/footer_widget.dart';
import 'package:mj_portfolio_web/widget/good_developer_widget.dart';
import 'package:mj_portfolio_web/widget/top_header_widget.dart';

import '../model/resume_info_manager.dart';
import '../widget/moving_around_tags_widget.dart';

class GoodDeveloperPage extends StatefulWidget {
  const GoodDeveloperPage({super.key});

  @override
  State<GoodDeveloperPage> createState() => _GoodDeveloperPageState();
}

class _GoodDeveloperPageState extends State<GoodDeveloperPage> {
  List<String> _whatIsGoodDeveloper = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadResumeInfo();
  }

  Future<void> _loadResumeInfo() async {
    final resumeInfoManager = ResumeInfoManager.getInstance();
    final resumeInfoJson = await resumeInfoManager.getResumeJson();
    final introduction = resumeInfoJson['introduction'] as Map<String, dynamic>;
    final whatIsGoodDeveloper =
        List<String>.from(introduction['whatIsGoodDeveloper']);

    setState(() {
      _whatIsGoodDeveloper = whatIsGoodDeveloper;
    });
  }

  @override
  Widget build(BuildContext context) {
    const backgroundColor = Color(0xff1C1D20);
    final screenWidth = ScreenSize.getScreenWidth(context);
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TopHeaderWidget(textColor: Colors.white),
            SizedBox(
              height: 120,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.12),
              child: IntrinsicHeight(
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Text.rich(
                          TextSpan(children: [
                            TextSpan(text: '좋은 개발자'),
                          ]),
                          style: TextStyle(color: Colors.white, fontSize: 64),
                        ),
                        SizedBox(
                          height: 192,
                        ),
                        if (_whatIsGoodDeveloper.isNotEmpty)
                          for (int i = 0; i < _whatIsGoodDeveloper.length; ++i)
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    height: 1,
                                    color: Color(0xFF494A4D),
                                  ),
                                  SizedBox(
                                    height: 48,
                                  ),
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: '${i + 1}'.padLeft(2, '0'),
                                          style: TextStyle(
                                              color: Color(0xff676769)),
                                        ),
                                        TextSpan(
                                          text:
                                              '  ${_whatIsGoodDeveloper.elementAt(i)}',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 24),
                                        ),
                                      ],
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                  SizedBox(
                                    height: 48,
                                  ),
                                ],
                              ),
                            )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 120,
            ),
            FooterWidget(
              defaultColor: Colors.grey,
              highlightColor: Colors.white,
            )
            //GoodDeveloperWidget(whatIsGoodDeveloper: _whatIsGoodDeveloper),
          ],
        ),
      ),
    );
  }
}
