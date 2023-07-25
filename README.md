# mj_portfolio_web

웹사이트: [minseokjeong.com](https://minseokjeong.com)

MJ 개인용 웹사이트 프로젝트
- Flutter web 프레임워크를 이용하여 웹사이트 구축
- docker를 이용하여 배포 환경테스트

## How to deploy Flutter Web Project To Vercel?
Set below command for initial setup in vercel project

Build command: flutter/bin/flutter build web --release
Output Directory: build/web
Install Command:
if cd flutter; then git pull && cd .. ; else git clone https://github.com/flutter/flutter.git -b stable; fi && ls && flutter/bin/flutter doctor && flutter/bin/flutter clean && flutter/bin/flutter config --enable-web
