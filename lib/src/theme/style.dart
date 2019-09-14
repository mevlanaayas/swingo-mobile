import 'package:flutter/material.dart';
import 'package:swingo/src/models/enum.dart';

const Color primaryColor = Color(0xFF6FC4C5);
const Color _primaryColor = Color(0xFF6FC4C5);
const Color _primaryColorDark = Color(0xFF3BB7B1);
const Color _primaryColorDarkest = Color(0xFF078F8F);
const Color _primaryColor50 = const Color(0xFFC6E4E1);
const Color primaryColor100 = const Color(0xFFBAE9E3);

const Color secondaryColor = Color(0xFFF9B232);
const Color _secondaryColor = Color(0xFFF9B232);
// TODO: alttakiler değiştirilecek
const Color secondaryColor50 = Color(0xFFFEF9E3);
const Color secondaryColor100 = Color(0xFFFCEEB8);

const Color _tertiaryColor = const Color(0xFFFFFFFF);

const Color _quaternaryColor = const Color(0xFFEE7B9D);

// Page Colors
const Color statusBarColor = _primaryColorDark;
const Color appBarColor = _primaryColor;
const Color appBarTextColor = _tertiaryColor;
const Color pageBackgroundColor = _primaryColor50;

const tempColor = const Color(0xFFE3E5E4);

// Tab Bar Colors
const Color indicatorColor = _tertiaryColor;
const Color tabBarTextColor = _tertiaryColor;
const Color tabBarUnselectedTextColor = _primaryColorDarkest;

// Component Colors
const Color buttonColor = _primaryColor;
const Color searchFieldColor = _tertiaryColor;
const Color chatMatchStatusBarColor = _tertiaryColor;
const Color chatMatchStatusBarTextColor = _primaryColor;

// Card Colors
const Color senderCardColor = _secondaryColor;
const Color carrierCardColor = _quaternaryColor;

// Loading Screen Colors
const Color dot1Color = _primaryColor;
const Color dot2Color = _secondaryColor;
const Color dot3Color = _quaternaryColor;


const Color textColor = Color.fromRGBO(111, 111, 118, 1);

const Color contentColorDark = Color.fromRGBO(38, 38, 47, 1);

const Color whiteColor = Color.fromRGBO(255, 255, 255, 1);

const Color blackColor = Color(0xFF000000);

const Color blackColor600 = Color(0xFF555555);

const Color blackColor400 = Color(0xFF9D9D9D);

const Color modalBackgroundColor = Color.fromRGBO(241, 241, 241, 1);

const Color secondaryContentColor = Color.fromRGBO(111, 111, 118, 1);

const Color skillTextColor = Color.fromRGBO(5, 59, 73, 1);

const Color attentionColor = Color.fromRGBO(0, 152, 255, 1);

const Color disabledColor = Color.fromRGBO(116, 116, 126, 1);

const Color disabledTaskColor = Color.fromRGBO(38, 38, 47, 0.25);

const Color treeLineColor = Color.fromRGBO(215, 215, 215, 1);

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

const String primaryFont = 'Muli-Regular';
const String primaryFontBold = 'Muli-Bold';

const TextStyle contentSmallStyle = TextStyle(
  fontFamily: primaryFont,
  fontSize: 14,
  color: secondaryContentColor,
);

const TextStyle blackContentStyle = TextStyle(
  fontFamily: primaryFont,
  fontSize: 16,
  color: Colors.black,
);

const TextStyle itemUsernameContentStyle = TextStyle(
  fontFamily: primaryFont,
  fontSize: 15,
  color: Colors.black,
);

const TextStyle itemPriceContentStyle = TextStyle(
  fontFamily: primaryFont,
  fontSize: 21,
  fontWeight: FontWeight.bold,
  color: _quaternaryColor,
);

const TextStyle itemBodyTextContentStyle = TextStyle(
  fontFamily: primaryFont,
  fontSize: 16,
  color: Colors.black,
);

const TextStyle itemBodyDateContentStyle = TextStyle(
  fontFamily: primaryFont,
  fontSize: 16,
  color: Colors.black,
);

const TextStyle itemBodyDetailContentStyle = TextStyle(
  fontFamily: primaryFont,
  fontSize: 15,
  color: Colors.black26,
);

const TextStyle itemDetailHeadingStyle = TextStyle(
  fontFamily: primaryFont,
  fontSize: 22,
  color: secondaryColor,
);

const TextStyle blackItemDetailHeadingStyle = TextStyle(
  fontFamily: primaryFont,
  fontSize: 18,
  color: Colors.black,
);

const TextStyle itemDetailCityStyle = TextStyle(
  fontFamily: primaryFont,
  fontSize: 18,
  color: Colors.black,
  fontWeight: FontWeight.bold,
);

const TextStyle packageDetailStyle = TextStyle(
  fontFamily: primaryFont,
  fontSize: 16,
  color: secondaryColor,
);

const TextStyle packageDetailHeaderStyle = TextStyle(
  fontFamily: primaryFont,
  fontSize: 16,
  color: Colors.black54,
);

const TextStyle accountDetailHeaderStyle = TextStyle(
  fontFamily: primaryFont,
  fontSize: 16,
  color: Colors.black,
  fontWeight: FontWeight.bold,
);

const TextStyle accountNonEditableDetailStyle = TextStyle(
  fontFamily: primaryFont,
  fontSize: 16,
  color: Colors.black54,
);

const TextStyle profileListItemStyle = TextStyle(
  fontFamily: primaryFont,
  fontSize: 16,
  color: Colors.black,
);

const TextStyle itemMenuTabStyle = TextStyle(
    fontFamily: primaryFont,
    fontSize: 15,
    color: secondaryColor,
    // color: Color(0xFFFF00FF),
    fontWeight: FontWeight.w900);

const TextStyle itemFrontLayerTitleStyle = TextStyle(
  fontFamily: primaryFont,
  fontSize: 14,
  color: secondaryColor,
  // color: Color(0xFFFF00FF),
  fontWeight: FontWeight.bold,
);

const TextStyle profileCardTextStyle = TextStyle(
    fontFamily: primaryFont,
    fontSize: 14,
    color: skillTextColor,
    // color: Color(0xFFFF00FF),
    fontWeight: FontWeight.w600,
    letterSpacing: 1.5);

const TextStyle contentStyle = TextStyle(
  fontFamily: primaryFont,
  fontSize: 16,
  color: whiteColor,
);

const TextStyle contentLargeStyle = TextStyle(
  fontFamily: primaryFont,
  fontSize: 24,
  color: whiteColor,
);

const TextStyle buttonTextStyle = TextStyle(
    fontFamily: 'MontserratMedium',
    fontSize: 16,
    color: whiteColor,
    fontWeight: FontWeight.w100);

const TextStyle inputFieldStyle = TextStyle(
  fontFamily: primaryFont,
  fontSize: 16,
  color: secondaryColor,
);

const TextStyle labelStyle = TextStyle(
  fontFamily: primaryFont,
  fontSize: 15,
  color: primaryColor,
);

const TextStyle homeItemTextStyle = TextStyle(
  fontFamily: primaryFont,
  fontSize: 12,
  color: blackColor,
);

const TextStyle whiteTextStyle = TextStyle(
  fontFamily: primaryFont,
  fontSize: 12,
  color: whiteColor,
);

const TextStyle blackTextStyle = TextStyle(
  fontFamily: primaryFont,
  fontSize: 12,
  color: blackColor,
);

const TextStyle secondaryColorTextStyle = TextStyle(
  fontFamily: primaryFont,
  fontSize: 12,
  color: secondaryColor,
);

const TextStyle secondaryColorTextStyle16 = TextStyle(
  fontFamily: primaryFont,
  fontSize: 16,
  color: secondaryColor,
);

const TextStyle quaternaryColorTextStyle16 = TextStyle(
  fontFamily: primaryFont,
  fontSize: 16,
  color: _quaternaryColor,
);

const TextStyle primaryColorTextStyle = TextStyle(
  fontFamily: primaryFont,
  fontSize: 12,
  color: primaryColor,
);

const TextStyle smallTextStyle = TextStyle(
  fontFamily: primaryFont,
  fontSize: 16,
  color: primaryColor,
);

const TextStyle messageWhiteTextStyle12 = TextStyle(
  fontFamily: primaryFont,
  fontSize: 12,
  color: whiteColor,
);

const TextStyle messageWhiteTextStyle = TextStyle(
  fontFamily: primaryFont,
  fontSize: 16,
  color: whiteColor,
);

const TextStyle messageBlackTextStyle = TextStyle(
  fontFamily: primaryFont,
  fontSize: 16,
  color: blackColor,
);

const TextStyle disabledColorTextStyle = TextStyle(
  fontFamily: primaryFont,
  fontSize: 12,
  color: disabledColor,
);

const TextStyle dialogContentTextStyle = TextStyle(
  fontFamily: primaryFont,
  fontSize: 16,
  color: blackColor,
);

const TextStyle dialogInputTextStyle = TextStyle(
  fontFamily: primaryFont,
  fontSize: 16,
  color: primaryColor,
);

const TextStyle tabBarTextStyle = TextStyle(
  fontFamily: primaryFont,
  fontSize: 20.0,
  fontWeight: FontWeight.bold,
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
  fontFamily: primaryFont,
  fontSize: 20,
  color: whiteColor,
);

const TextStyle dpYearStyle = TextStyle(
  fontFamily: primaryFont,
  fontSize: 16,
  color: blackColor,
);

const TextStyle dpDayHeadersStyle = TextStyle(
  fontFamily: primaryFont,
  fontSize: 24,
  color: primaryColor,
);

const TextStyle dpItemStyle = TextStyle(
  fontFamily: primaryFont,
  fontSize: 12,
  color: blackColor,
);

const TextStyle dpSelectedItemStyle = TextStyle(
  fontFamily: primaryFont,
  fontSize: 12,
  color: whiteColor,
);

const TextStyle dpTodayItemStyle = TextStyle(
  fontFamily: primaryFont,
  fontSize: 12,
  color: primaryColor,
);

const TextStyle dpDisabledItemStyle = TextStyle(
  fontFamily: primaryFont,
  fontSize: 12,
  color: blackColor400,
);

const BorderRadiusGeometry cardBorderRadius = BorderRadius.all(
  Radius.circular(9),
);

const double swPadding = 15.0;

const double formSpacing = 20;

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

const EdgeInsets formPadding = EdgeInsets.all(swPadding);
