import 'dart:math';
import 'dart:ui';

import 'package:swingo/src/models/enum.dart';

class PageStyle {
  final String logo;
  final Color accent;
  final String name;
  final String description;

  static final Map<String, PageStyle> _all = {
    'cary': PageStyle(
        name: 'Carry',
        logo: 'assets/images/Icon-100.png',
        accent: const Color.fromRGBO(29, 202, 34, 1),
        description: 'Carry products and earn some money'),
    'send': PageStyle(
        name: 'Send',
        logo: 'assets/images/Icon-100.png',
        accent: const Color.fromRGBO(82, 183, 216, 1),
        description: 'Send your packet anywhere Swingo goes'),
    'swingo': PageStyle(
        name: 'Swingo',
        logo: 'assets/images/Icon-100.png',
        accent: const Color.fromRGBO(75, 58, 185, 1),
        description: 'Customized user experience every single one'),
  };

  PageStyle({this.logo, this.accent, this.name, this.description = 'N/A'});

  static PageStyle from(Part part) {
    return _all[part.toString()];
  }

  static PageStyle random() {
    Random rand = Random();
    return _all.values.elementAt(rand.nextInt(_all.values.length));
  }
}
