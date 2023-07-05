import 'package:flutter/material.dart';

class ColorManager {
  static final Color primary = HexColor.fromHex('#38D1AD');
  static final Color accent = HexColor.fromHex('#EFFFFB');
  static final Color lightAccent = HexColor.fromHex('#F1FBFC');
  static final Color border = HexColor.fromHex('#71D5E3');
  static final Color textTitle = HexColor.fromHex('#2C3C51');
  static final Color subtitle = HexColor.fromHex('#BAC5D3');
  static final Color text = HexColor.fromHex('#809DAD');
  static final Color disableText = HexColor.fromHex('#BABFC6');
  static final Color fieldBackground = HexColor.fromHex('#EFF7F5');
  static final Color fieldBorder = HexColor.fromHex('#CADCD8');
  static final Color white = HexColor.fromHex('#FFFFFF');
  static final Color error = HexColor.fromHex('#e61f34');
  static final Color iconColor = HexColor.fromHex('#31A8E1'); 
}

extension HexColor on Color {
  static fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll('#', "");
    if (hexColorString.length == 6) {
      hexColorString = 'FF$hexColorString';
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}
