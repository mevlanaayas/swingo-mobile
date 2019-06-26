import 'package:flutter/material.dart';
import 'package:swingo/src/theme/style.dart';

final ThemeData datePickerTheme = _buildDatePickerTheme();

ThemeData _buildDatePickerTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    iconTheme: const IconThemeData(color: secondaryColor),
    brightness: Brightness.light,
    dialogBackgroundColor: secondaryColor,
    primaryColorBrightness: Brightness.dark,
    accentColorBrightness: Brightness.light,
    splashColor: secondaryColor,
    accentColor: secondaryColor,
    primaryColor: primaryColor,
    disabledColor: blackColor400,
    backgroundColor: secondaryColor,
    buttonTheme: base.buttonTheme.copyWith(
      buttonColor: primaryColor,
      textTheme: ButtonTextTheme.normal,
    ),
    scaffoldBackgroundColor: secondaryColor50,
    cardColor: blackColor400,
    textSelectionColor: primaryColor100,
    errorColor: secondaryColor50,
    textTheme: _buildTextTheme(
      base.textTheme,
    ),
    primaryTextTheme: _buildTextTheme(
      base.primaryTextTheme,
    ),
    accentTextTheme: _buildTextTheme(
      base.accentTextTheme,
    ),
    primaryIconTheme: base.iconTheme.copyWith(
      color: primaryColor,
    ),
  );
}

TextTheme _buildTextTheme(TextTheme base) {
  return base.copyWith(
    display1: dpDayStyle,
    // FIXME: this is crashing date picker form field height
    // subhead: dpYearStyle,
    caption: dpDayHeadersStyle,
    body1: dpItemStyle,
    body2: dpSelectedItemStyle,
  );
}
