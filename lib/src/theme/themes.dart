import 'package:flutter/material.dart';
import 'package:swingo/src/theme/colors.dart';

final ThemeData swTheme = _buildMyTheme();

ThemeData _buildMyTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
      splashColor: altDarkBlue,
      accentColor: swPink900,
      primaryColor: altDarkBlue,
      buttonTheme: base.buttonTheme.copyWith(
          buttonColor: swLivingCoral100, textTheme: ButtonTextTheme.normal),
      scaffoldBackgroundColor: kswBackgroundWhite,
      cardColor: kswBackgroundWhite,
      textSelectionColor: swLivingCoral100,
      errorColor: swErrorRed,
      textTheme: _buildMyTextTheme(base.textTheme),
      primaryTextTheme: _buildMyTextTheme(base.primaryTextTheme),
      accentTextTheme: _buildMyTextTheme(base.accentTextTheme),
      primaryIconTheme: base.iconTheme.copyWith(color: altDeepPurple),
      inputDecorationTheme: InputDecorationTheme(border: OutlineInputBorder()));
}

TextTheme _buildMyTextTheme(TextTheme base) {
  return base
      .copyWith(
          headline: base.headline.copyWith(fontWeight: FontWeight.w500),
          title: base.title.copyWith(fontSize: 18.0),
          caption: base.caption
              .copyWith(fontWeight: FontWeight.w400, fontSize: 14.0))
      .apply(
          fontFamily: 'Titillium Web',
          displayColor: altDeepPurple,
          bodyColor: altDeepPurple);
}

// not to use, just proof
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
      textTheme: _buildMyTextTheme(base.textTheme),
      primaryTextTheme: _buildMyTextTheme(base.primaryTextTheme),
      accentTextTheme: _buildMyTextTheme(base.accentTextTheme),
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
