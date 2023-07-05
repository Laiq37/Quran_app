
import 'package:flutter/material.dart';
import 'package:quran/resources/font_manager.dart';

ButtonStyle getButtonStyle(color, yPad, [xPad = 0.0]){
  return ElevatedButton.styleFrom(
    elevation: 0,
    padding: EdgeInsets.symmetric(horizontal: xPad, vertical: yPad),
    backgroundColor: color,
    shape: const StadiumBorder()
  );
}

TextStyle _getTextStyle(
    double fontSize , FontWeight fontWeight, Color color, [FontStyle? fontStyle]) {
  return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      color: color);
}

TextStyle getRegularStyle({double fontSize = 12.0, required color}) {
  return _getTextStyle(
      fontSize, FontWeightManager.regular, color);
}

TextStyle getRegularItalicStyle({double fontSize = 12.0, required color}) {
  return _getTextStyle(
      fontSize, FontWeightManager.regular, color, FontStyle.italic);
}

TextStyle getMediumStyle({double fontSize = 12.0, required color}) {
  return _getTextStyle(
      fontSize, FontWeightManager.medium, color);
}

TextStyle getMediumItalicStyle({double fontSize = 12.0, required color}) {
  return _getTextStyle(
      fontSize, FontWeightManager.medium, color, FontStyle.italic);
}

TextStyle getSemiBoldStyle({double fontSize = 12.0, required color}) {
  return _getTextStyle(
      fontSize, FontWeightManager.semiBold, color);
}

TextStyle getBoldStyle({double fontSize = 12.0, required color}) {
  return _getTextStyle(
      fontSize, FontWeightManager.bold, color);
}