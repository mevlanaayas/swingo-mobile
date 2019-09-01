import 'package:flutter/material.dart';
import 'package:swingo/src/models/enum.dart';

final Color _primaryColor = Color(0xFF8DDBD1);
const Color primaryColor = Color.fromRGBO(141, 219, 209, 1);

final Color _primaryColor100 = Color(0xFFBAE9E3);
const Color primaryColor100 = const Color(0xFFBAE9E3);

final Color _primaryColor50 = Color(0xFFE3F6F4);
const Color primaryColor50 = const Color(0xFFE3F6F4);

final Color _secondaryColor = Color(0xFFFADA5E);
const Color secondaryColor = Color(0xFFFADA5E);

final Color _secondaryColor50 = Color(0xFFFEF9E3);
const Color secondaryColor50 = Color(0xFFFEF9E3);

final Color _secondaryColor100 = Color(0xFFFCEEB8);
const Color secondaryColor100 = Color(0xFFFCEEB8);

final Color _textColor = Color(0xFF6F6F76);
const Color textColor = Color.fromRGBO(111, 111, 118, 1);

final Color _color1 = Color(0xFF26262F);
const Color contentColorDark = Color.fromRGBO(38, 38, 47, 1);

final Color _whiteColor = Color(0xFFFFFFFF);
const Color whiteColor = Color.fromRGBO(255, 255, 255, 1);

final Color _blackColor = Color(0xFF000000);
const Color blackColor = Color(0xFF000000);

final Color _blackColor600 = Color(0xFF555555);
const Color blackColor600 = Color(0xFF555555);

final Color _blackColor400 = Color(0xFF9D9D9D);
const Color blackColor400 = Color(0xFF9D9D9D);

final Color _color3 = Color(0xFFF1F1F1);
const Color modalBackgroundColor = Color.fromRGBO(241, 241, 241, 1);

final Color _color4 = Color(0xFF6F6F76);
const Color secondaryContentColor = Color.fromRGBO(111, 111, 118, 1);

final Color _color5 = Color(0xFF053B49);
const Color skillTextColor = Color.fromRGBO(5, 59, 73, 1);

final Color _color6 = Color(0xFF0098FF);
const Color attentionColor = Color.fromRGBO(0, 152, 255, 1);

final Color _color7 = Color(0xFF74747E);
const Color disabledColor = Color.fromRGBO(116, 116, 126, 1);

final Color _color8 = Color(0x7726262F);
const Color disabledTaskColor = Color.fromRGBO(38, 38, 47, 0.25);

final Color _color9 = Color(0xFFD7D7D7);
const Color treeLineColor = Color.fromRGBO(215, 215, 215, 1);

final Color _color11 = Color(0xFF393947);
const Color statsSeparatorColor = Color.fromRGBO(57, 57, 71, 1);

/// Maximum logical pixel width for a modal window.
const double modalMaxWidth = 400;

/// Once the logic screen pixel width exceeds this number, show the ultrawide
/// layout.
const double ultraWideLayoutThreshold = 1920;

/// Once the logic screen pixel width exceeds this number, show the wide layout.
const double wideLayoutThreshold = 800;

/// Devices with a logical screen pixel width less than this value
/// will not be permitted to rotate into landscape mode.
const double blockLandscapeThreshold = 750;

/// Ideal width of a character cell in the character hiring grid. This is used
/// to compute the number of columns to display when viewing the character grid.
const double idealCharacterWidth = 165;

/// Ideal diameter of a particle in the hiring effect. The actual drawn particle
/// size is computed based on a ratio of this diameter to the ideal character
/// multiplied by the actual character width displayed.
const double idealParticleSize = 10;

const TextStyle contentSmallStyle = TextStyle(
  fontFamily: 'MontserratRegular',
  fontSize: 14,
  color: secondaryContentColor,
);

const TextStyle blackContentStyle = TextStyle(
  fontFamily: 'MontserratRegular',
  fontSize: 16,
  color: Colors.black,
);

const TextStyle itemUsernameContentStyle = TextStyle(
  fontFamily: 'MontserratRegular',
  fontSize: 15,
  color: Colors.black,
);

const TextStyle itemPriceContentStyle = TextStyle(
  fontFamily: 'MontserratRegular',
  fontSize: 15,
  color: Colors.deepOrange,
);

const TextStyle itemBodyTextContentStyle = TextStyle(
  fontFamily: 'MontserratRegular',
  fontSize: 15,
  color: Colors.black,
);

const TextStyle itemBodyDateContentStyle = TextStyle(
  fontFamily: 'MontserratRegular',
  fontSize: 14,
  color: Colors.black26,
);

const TextStyle itemBodyDetailContentStyle = TextStyle(
  fontFamily: 'MontserratRegular',
  fontSize: 15,
  color: Colors.black26,
);

const TextStyle itemDetailHeadingStyle = TextStyle(
  fontFamily: 'MontserratRegular',
  fontSize: 22,
  color: secondaryColor,
);

const TextStyle blackItemDetailHeadingStyle = TextStyle(
  fontFamily: 'MontserratRegular',
  fontSize: 22,
  color: Colors.black,
);

const TextStyle itemDetailCityStyle = TextStyle(
  fontFamily: 'MontserratRegular',
  fontSize: 21,
  color: secondaryColor,
);

const TextStyle packageDetailStyle = TextStyle(
  fontFamily: 'MontserratRegular',
  fontSize: 18,
  color: secondaryColor,
);

const TextStyle packageDetailHeaderStyle = TextStyle(
  fontFamily: 'MontserratRegular',
  fontSize: 18,
  color: Colors.black54,
);

const TextStyle accountDetailHeaderStyle = TextStyle(
  fontFamily: 'MontserratRegular',
  fontSize: 16,
  color: Colors.black,
  fontWeight: FontWeight.bold,
);

const TextStyle accountNonEditableDetailStyle = TextStyle(
  fontFamily: 'MontserratRegular',
  fontSize: 16,
  color: Colors.black54,
);

const TextStyle profileListItemStyle = TextStyle(
  fontFamily: 'MontserratRegular',
  fontSize: 16,
  color: Colors.black,
);

const TextStyle itemMenuTabStyle = TextStyle(
    fontFamily: 'MontserratRegular',
    fontSize: 15,
    color: secondaryColor,
    // color: Color(0xFFFF00FF),
    fontWeight: FontWeight.w900);

const TextStyle itemFrontLayerTitleStyle = TextStyle(
  fontFamily: 'MontserratRegular',
  fontSize: 14,
  color: secondaryColor,
  // color: Color(0xFFFF00FF),
  fontWeight: FontWeight.bold,
);

const TextStyle profileCardTextStyle = TextStyle(
    fontFamily: 'MontserratRegular',
    fontSize: 14,
    color: skillTextColor,
    // color: Color(0xFFFF00FF),
    fontWeight: FontWeight.w600,
    letterSpacing: 1.5);

const TextStyle contentStyle = TextStyle(
  fontFamily: 'MontserratRegular',
  fontSize: 16,
  color: whiteColor,
);

const TextStyle contentLargeStyle = TextStyle(
  fontFamily: 'MontserratRegular',
  fontSize: 24,
  color: whiteColor,
);

const TextStyle buttonTextStyle = TextStyle(
    fontFamily: 'MontserratMedium',
    fontSize: 16,
    color: whiteColor,
    fontWeight: FontWeight.w100);

const TextStyle inputFieldStyle = TextStyle(
  fontFamily: 'MontserratRegular',
  fontSize: 16,
  color: secondaryColor,
);

const TextStyle labelStyle = TextStyle(
  fontFamily: 'MontserratRegular',
  fontSize: 15,
  color: primaryColor,
);

const TextStyle homeItemTextStyle = TextStyle(
  fontFamily: 'MontserratRegular',
  fontSize: 12,
  color: blackColor,
);

const TextStyle whiteTextStyle = TextStyle(
  fontFamily: 'MontserratRegular',
  fontSize: 12,
  color: whiteColor,
);

const TextStyle blackTextStyle = TextStyle(
  fontFamily: 'MontserratRegular',
  fontSize: 12,
  color: blackColor,
);

const TextStyle secondaryColorTextStyle = TextStyle(
  fontFamily: 'MontserratRegular',
  fontSize: 12,
  color: secondaryColor,
);

const TextStyle secondaryColorTextStyle16 = TextStyle(
  fontFamily: 'MontserratRegular',
  fontSize: 16,
  color: secondaryColor,
);

const TextStyle primaryColorTextStyle = TextStyle(
  fontFamily: 'MontserratRegular',
  fontSize: 12,
  color: primaryColor,
);

const TextStyle smallTextStyle = TextStyle(
  fontFamily: 'MontserratRegular',
  fontSize: 16,
  color: primaryColor,
);

const TextStyle messageWhiteTextStyle = TextStyle(
  fontFamily: 'MontserratRegular',
  fontSize: 16,
  color: whiteColor,
);

const TextStyle messageBlackTextStyle = TextStyle(
  fontFamily: 'MontserratRegular',
  fontSize: 16,
  color: blackColor,
);

const TextStyle disabledColorTextStyle = TextStyle(
  fontFamily: 'MontserratRegular',
  fontSize: 12,
  color: disabledColor,
);

Map<Part, Color> skillColor = {
  Part.send: const Color.fromRGBO(0, 179, 184, 1),
  Part.carry: const Color.fromRGBO(84, 114, 239, 1),
  Part.profile: const Color.fromRGBO(184, 56, 72, 1)
};

Map<Part, String> skillFlareIcon = {
  Part.send: 'assets/flare/CodeIcon.flr',
  Part.carry: 'assets/flare/EngineeringIcon.flr',
  Part.profile: 'assets/flare/UxIcon.flr'
};

/*
* Date Picker Styles
* prefix is dp
* */
const TextStyle dpDayStyle = TextStyle(
  fontFamily: 'MontserratRegular',
  fontSize: 20,
  color: whiteColor,
);

const TextStyle dpYearStyle = TextStyle(
  fontFamily: 'MontserratRegular',
  fontSize: 16,
  color: blackColor,
);

const TextStyle dpDayHeadersStyle = TextStyle(
  fontFamily: 'MontserratRegular',
  fontSize: 24,
  color: primaryColor,
);

const TextStyle dpItemStyle = TextStyle(
  fontFamily: 'MontserratRegular',
  fontSize: 12,
  color: blackColor,
);

const TextStyle dpSelectedItemStyle = TextStyle(
  fontFamily: 'MontserratRegular',
  fontSize: 12,
  color: whiteColor,
);

const TextStyle dpTodayItemStyle = TextStyle(
  fontFamily: 'MontserratRegular',
  fontSize: 12,
  color: primaryColor,
);

const TextStyle dpDisabledItemStyle = TextStyle(
  fontFamily: 'MontserratRegular',
  fontSize: 12,
  color: blackColor400,
);

const BorderRadiusGeometry cardBorderRadius = BorderRadius.all(
  Radius.circular(9),
);

const double swPadding = 15.0;

// Kartların kendi aralarındaki konumlandırılması
const EdgeInsets cardMargin = EdgeInsets.only(
  left: swPadding,
  right: swPadding,
  top: swPadding / 2,
  bottom: swPadding / 2,
);

// Kartları oluşturan listenin ana ekrana göre konumlandırılması
const EdgeInsets cardListMargin = EdgeInsets.only(
  top: swPadding / 2,
  bottom: swPadding / 2,
);

const EdgeInsets cardPadding = EdgeInsets.all(swPadding);

const EdgeInsets bodyMargin = EdgeInsets.all(swPadding);

const EdgeInsets dividerPadding = EdgeInsets.symmetric(horizontal: swPadding);