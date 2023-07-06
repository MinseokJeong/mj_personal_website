import 'package:flutter_test/flutter_test.dart';
import 'package:mj_portfolio_web/util/text_highligher.dart';

void main() {
  test('Text Highlight Parser Test', () {
    const testText =
        '대학생 시절 해외 인턴십 프로그램에 선발되어 미국 LA에 있는 회사에서 <Android> 개발자로서 인턴생활을 하였으며, 캐나다 Vancouver에 있는 회사에서 재택근무를 하며 Windows 개발자로 일을 하였고, 스타트업 회사를 공동창업하며 Android/iOS 개발자로 일을 하였고, 방위산업체에서 근무하며 Embedded System/Firmware/Windows 개발자로 일을 한 경험이 있습니다.';
    final highlighter = TextHighlighter(testText);
    final highlightTextModels = highlighter.getTexthighlightModel();
    expect(highlightTextModels.length, 3);
    expect(highlightTextModels[0].highlight, false);
    expect(highlightTextModels[0].text,
        '대학생 시절 해외 인턴십 프로그램에 선발되어 미국 LA에 있는 회사에서 ');

    expect(highlightTextModels[1].highlight, true);
    expect(highlightTextModels[1].text, 'Android');

    expect(highlightTextModels[2].highlight, false);
    expect(highlightTextModels[2].text,
        ' 개발자로서 인턴생활을 하였으며, 캐나다 Vancouver에 있는 회사에서 재택근무를 하며 Windows 개발자로 일을 하였고, 스타트업 회사를 공동창업하며 Android/iOS 개발자로 일을 하였고, 방위산업체에서 근무하며 Embedded System/Firmware/Windows 개발자로 일을 한 경험이 있습니다.');
  });
}
