import 'package:flutter/material.dart';
import 'package:swingo/src/models/enum.dart';

final Color _primaryColor = Color(0xFF8DDBD1);
const Color primaryColor = Color.fromRGBO(141, 219, 209, 1);

final Color _secondaryColor = Color(0xFF6F6F76);
const Color secondaryColor = Color.fromRGBO(111, 111, 118, 1);

final Color _color1 = Color(0xFF26262F);
const Color contentColorDark = Color.fromRGBO(38, 38, 47, 1);

final Color _color2 = Color(0xFFFFFFFF);
const Color contentColor = Color.fromRGBO(255, 255, 255, 1);

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

final Color _color10 = Color(0xFFEC2975);
const Color bugColor = Color.fromRGBO(236, 41, 117, 1);

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

const TextStyle contentStyle = TextStyle(
  fontFamily: 'MontserratRegular',
  fontSize: 16,
  color: contentColor,
);

const TextStyle contentLargeStyle = TextStyle(
  fontFamily: 'MontserratRegular',
  fontSize: 24,
  color: contentColor,
);

const TextStyle buttonTextStyle = TextStyle(
  fontFamily: 'MontserratMedium',
  fontSize: 16,
  color: contentColor,
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
