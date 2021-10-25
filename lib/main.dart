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
                          Container(
                            width: (curScreenWidth - curScreenWidth / 4.5 * 2) * 0.7,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('한국 대함 레이더 모의 시뮬레이터 프로그램 개발', style: mainTextStyleBold.copyWith(fontSize: 24.0)),
                                Text('2020.07 - 2021.02'),
                                Text('Description.', style: mainTextStyleBold.copyWith(fontSize: 16.0)),
                                Text('한국 K-SSRS(Korean Surface Search Radar System을 모의하는 시뮬레이터를 개발하는 프로젝트.'),
                                Text('What I did.', style: mainTextStyleBold.copyWith(fontSize: 16.0)),
                                Text('* 모의 K-SSRS 상태를 나타내는 GUI 프로그램 개발'),
                                Text('* 실제 K-SSRS 장치를 모사하는 장치의 SBC장치 개발'),
                                Text('* 실제 K-SSRS 장비와 외부장치와 중간 연동을 시켜주는 신호연동부 장치 SBC장치 개발'),
                                Text('Tech Stack.', style: mainTextStyleBold.copyWith(fontSize: 16.0)),
                                Text('VxWorks(C), PCIe 인터페이스, VME,  MFC(C++), OpenGL, FTP, '),
                              ],
                            ),
                          ),
                          Container(
                            width: (curScreenWidth - curScreenWidth / 4.5 * 2) * 0.7,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('무인수색 통신단말기 제어 시뮬레이터 프로그램 개발', style: mainTextStyleBold.copyWith(fontSize: 24.0)),
                                Text('2019.09 - 2020.03'),
                                Text('Description.', style: mainTextStyleBold.copyWith(fontSize: 16.0)),
                                Text('무선 통신단말기를 제어 하는 통제차량 및 무인차량을 모의하는 프로그램 개발'),
                                Text('What I did.', style: mainTextStyleBold.copyWith(fontSize: 16.0)),
                                Text('* 프로젝트에 투입된 SW 개발자가 한명 이라 혼자 개발을 도 맡음.'),
                                Text('* 카메라 장치를 제어하여 실시간 카메라 영상 데이터 전시'),
                                Text('* GPS 장치를 이용하여 실시간 위치를 송신 및 수신 하여 화면에 실시간 위치 전시'),
                                Text('* 통신단말기 성능 측정을 위하여 PTP 타임서버를 이용하여 장비 성능 측정'),
                                Text('* UDP/TCP 또한 Multicast를 이용한 데이터 송수신 구현'),
                                Text('Tech Stack.', style: mainTextStyleBold.copyWith(fontSize: 16.0)),
                                Text('MFC(C++), OpenGL, gstreamer, OpenSSL, 시리얼통신(GPS),네트워크 소켓 통신(UDP/TCP), PTP타임서버'),
                              ],
                            ),
                          ),
                          Container(
                            width: (curScreenWidth - curScreenWidth / 4.5 * 2) * 0.7,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('HPSR_DAP', style: mainTextStyleBold.copyWith(fontSize: 24.0)),
                                Text('2019.02 - 2019.08'),
                                Text('Description.', style: mainTextStyleBold.copyWith(fontSize: 16.0)),
                                Text('고출력 레이더 데이터를 전시 및 분석하는 프로그램 유지 보수'),
                                Text('What I did.', style: mainTextStyleBold.copyWith(fontSize: 16.0)),
                                Text('* 화면 렌더링 퍼포먼스 개선(OpenGL 퍼포머스 개선)'),
                                Text('* 레이더 데이터 분석 알고리즘 기능 추가'),
                                Text('* 레이더 트랙 데이터 전시시 배경에 실제 한국 지도 전시 구현'),
                                Text('Tech Stack.', style: mainTextStyleBold.copyWith(fontSize: 16.0)),
                                Text('MFC(C++), OpenGL'),
                              ],
                            ),
                          ),
                          Container(
                            width: (curScreenWidth - curScreenWidth / 4.5 * 2) * 0.7,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('DDH데이터 저장장치', style: mainTextStyleBold.copyWith(fontSize: 24.0)),
                                Text('2019.02 - 2019.08'),
                                Text('Description.', style: mainTextStyleBold.copyWith(fontSize: 16.0)),
                                Text('한국 해군 DDH1, DDH2 구축함의 비디오 영상 및 레이더 데이터를 저장 하는 장치 개발'),
                                Text('What I did.', style: mainTextStyleBold.copyWith(fontSize: 16.0)),
                                Text('* 레이더 데이터 저장 프로그램 개발'),
                                Text('* 레이더 데이터 전시 프로그램 개발'),
                                Text('* 저장장치 전체 시스템 환경구축'),
                                Text('Tech Stack.', style: mainTextStyleBold.copyWith(fontSize: 16.0)),
                                Text(
                                    'MFC, pcap(packet sniffing), Opengl, mariaDB, Network Attatched Storage(synology)'),
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
