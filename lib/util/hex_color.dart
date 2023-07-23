import 'dart:ui';

//hexString: #ffffff or ffffff
Color HexColor(String hexString) {
  final replacedString = hexString.replaceAll('#', '');

  if (replacedString.length != 6) {
    throw Exception('invalid hex string format');
  }
  final red = replacedString.substring(0, 2);
  final green = replacedString.substring(2, 4);
  final blue = replacedString.substring(4, 6);

  return Color.fromRGBO(
    int.parse(red, radix: 16),
    int.parse(green, radix: 16),
    int.parse(blue, radix: 16),
    1.0,
  );
}
