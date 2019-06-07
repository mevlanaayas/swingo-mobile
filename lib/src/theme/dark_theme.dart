// not to use, just proof
import 'package:flutter/material.dart';
import 'package:swingo/src/theme/colors.dart';

final ThemeData _myDarkTheme = _buildMyDarkTheme();

ThemeData _buildMyDarkTheme() {
  final ThemeData base = ThemeData.dark();
  return base.copyWith(
      accentColor: altDarkGrey,
      primaryColor: altDarkGrey,
      buttonColor: altDarkBlue,
      scaffoldBackgroundColor: altDarkGrey,
      cardColor: altDarkGrey,
      textSelectionColor: swLivingCoral100,
      errorColor: swErrorRed,
      textTheme: _buildMyDarkTextTheme(base.textTheme),
      primaryTextTheme: _buildMyDarkTextTheme(base.primaryTextTheme),
      accentTextTheme: _buildMyDarkTextTheme(base.accentTextTheme),
      primaryIconTheme: base.iconTheme.copyWith(color: altDarkBlue),
      inputDecorationTheme: InputDecorationTheme(border: OutlineInputBorder()));
}

TextTheme _buildMyDarkTextTheme(TextTheme base) {
  return base
      .copyWith(
      headline: base.headline.copyWith(fontWeight: FontWeight.w500),
      title: base.title.copyWith(fontSize: 18.0),
      caption: base.caption
          .copyWith(fontWeight: FontWeight.w400, fontSize: 14.0))
      .apply(
      fontFamily: 'Titillium Web',
      displayColor: altDarkBlue,
      bodyColor: altDarkBlue);
}
