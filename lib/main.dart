import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(MyWeb());

class MyWeb extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double curScreenWidth = MediaQuery.of(context).size.width;
    final mainTextStyle = GoogleFonts.getFont('Noto Sans', fontSize: 56.0, color: Colors.black);
    final mainTextStyleBold = mainTextStyle.copyWith(fontWeight: FontWeight.bold);

    return Material(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 8.0,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Colors.blue,
                    Colors.blueAccent,
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(curScreenWidth / 4.5, 8.0, curScreenWidth / 4.5, 8.0),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        '반갑습니다.',
                        style: mainTextStyleBold,
                      ),
                      Text.rich(
                        TextSpan(children: <InlineSpan>[
                          TextSpan(text: '저는 ', style: mainTextStyleBold),
                          TextSpan(
                              text: '정민석',
                              style: mainTextStyleBold.copyWith(color: Colors.blue, fontStyle: FontStyle.italic)),
                          TextSpan(text: ' 입니다.', style: mainTextStyleBold),
                        ]),
                      ),
                      SizedBox(height: 24.0),
                      Text(
                        '6년 동안 🇺🇸, 🇨🇦, 🇰🇷 에서',
                        style: mainTextStyle.copyWith(fontSize: 48),
                      ),
                      Text(
                        '다양한 프로그램 개발을 경험한',
                        style: mainTextStyle.copyWith(fontSize: 48),
                      ),
                      SizedBox(height: 24.0),
                      Row(
                        children: [
                          Image.asset(
                            'lib/images/portfolio_header_image.png',
                            height: 128.0,
                          ),
                          Text.rich(
                            TextSpan(children: <InlineSpan>[
                              TextSpan(
                                text: "'",
                                style: mainTextStyleBold.copyWith(
                                  color: Colors.black,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              TextSpan(
                                text: '앱 개발자',
                                style: mainTextStyleBold.copyWith(
                                  color: Colors.blue,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              TextSpan(
                                text: "'",
                                style: mainTextStyleBold.copyWith(
                                  color: Colors.black,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              TextSpan(
                                text: ' 입니다.',
                                style: mainTextStyle.copyWith(fontSize: 48),
                              ),
                            ]),
                          ),
                        ],
                      ),
                      SizedBox(height: 24.0),
                      Text(
                        "#개발스타일?",
                        style: mainTextStyle.copyWith(
                          fontSize: 32.0,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        "'How it works?' 어떻게 동작하는지 underline principle을",
                        style: mainTextStyle.copyWith(
                          fontSize: 24.0,
                        ),
                      ),
                      Text(
                        "이해하며 개발하는것을 좋아합니다.",
                        style: mainTextStyle.copyWith(
                          fontSize: 24.0,
                        ),
                      ),
                      SizedBox(height: 24.0),
                      Text(
                        "#개발자란?",
                        style: mainTextStyle.copyWith(
                          fontSize: 32.0,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        "개발자는 형태가 없는 생각 또는 비지니스를 프로그램으로",
                        style: mainTextStyle.copyWith(
                          fontSize: 24.0,
                        ),
                      ),
                      Text(
                        " 구현 하는데 있다고 믿습니다.",
                        style: mainTextStyle.copyWith(
                          fontSize: 24.0,
                        ),
                      ),
                      SizedBox(height: 48.0),
                      Text(
                        "Work Experience.",
                        style: mainTextStyle.copyWith(
                          fontSize: 48.0,
                        ),
                      ),
                      SizedBox(height: 48.0),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: (curScreenWidth - curScreenWidth / 4.5 * 2) * 0.3,
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('(주)미래시스템', style: mainTextStyleBold.copyWith(fontSize: 24.0)),
                                SizedBox(height: 16.0),
                                Text('Software Engineer'),
                                SizedBox(height: 4.0),
                                Text('2019.02 - 현재'),
                              ],
                            ),
                          ),
                          Container(
                            width: (curScreenWidth - curScreenWidth / 4.5 * 2) * 0.7,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('사내 프로젝트 이름 명칭', style: mainTextStyleBold.copyWith(fontSize: 24.0)),
                                Text('프로젝트 개발기간 ex) 2019.02 - 2019.08'),
                                Text('Description.', style: mainTextStyleBold.copyWith(fontSize: 16.0)),
                                Text('프로젝트에 대한 간단한 글로 압축해서'),
                                Text('몇 줄 안되도록 적어서 최대한 간결해보이도록'),
                                Text('적어야한다.'),
                                Text('What I did.', style: mainTextStyleBold.copyWith(fontSize: 16.0)),
                                Text('* 내가 한 일 나열1'),
                                Text('* 내가 한 일 나열2'),
                                Text('* 내가 한 일 나열3'),
                                Text('Tech Stack.', style: mainTextStyleBold.copyWith(fontSize: 16.0)),
                                Text('MFC, vxWorks, Opengl'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
