import 'package:flutter/material.dart';

class TextHighlighter {
  final String text;
  final List<TextHighlightModel> _parsedTexts = [];

  TextHighlighter(this.text) {
    _parse();
  }

  void _parse() {
    const startSymbol = '<';
    const endSymbol = '>';

    String tempString = '';

    for (final char in text.characters) {
      if (char == startSymbol) {
        if (tempString.isNotEmpty) {
          _parsedTexts.add(TextHighlightModel(tempString, false));
        }
        tempString = '';
      } else if (char == endSymbol) {
        if (tempString.isNotEmpty) {
          _parsedTexts.add(TextHighlightModel(tempString, true));
        }
        tempString = '';
      } else {
        tempString += char;
      }
    }
    if (tempString.isNotEmpty) {
      _parsedTexts.add(TextHighlightModel(tempString, false));
    }
  }

  List<TextHighlightModel> getTexthighlightModel() => _parsedTexts;
}

class TextHighlightModel {
  String text;
  bool highlight;

  TextHighlightModel(this.text, this.highlight);
}
