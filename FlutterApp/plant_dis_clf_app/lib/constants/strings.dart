// App UI colours
import 'package:flutter/material.dart';
class S{
  S._();

  static const baseUrl = 'http://127.0.0.1:8000';
}
class C {
  C._();

  /// background color gradient
  static final Color background= HexColor('#cec1ad');
  static final Color searchBackground = HexColor("#A9886B");
  static final Color darkBackground = HexColor("#3A2A23");
  static final Color primaryHighlightedColor = HexColor('#4C646C');
  static final Color primaryUnHighlightedColor = HexColor('#05060B');
  static final Color secondaryColor= HexColor('#C0D1B8');
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}