import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:swingo/src/components/sw_filter.dart';
import 'package:swingo/src/models/product.dart';
import 'package:swingo/src/pages/pages.dart';
import 'package:swingo/src/theme/colors.dart';
import 'package:swingo/src/theme/themes.dart';

import 'components/backdrop/backlayer.dart';


class SwApp extends StatefulWidget {
  @override
  State<SwApp> createState() => _SwAppState();
}

class _SwAppState extends State<SwApp> {
  Category _currentCategory = Category.all;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Swingo',
      home: Backdrop(
        // TODO: Make currentCategory field take _currentCategory (104)
        currentCategory: _currentCategory,
        // TODO: Pass _currentCategory for frontLayer (104)
        frontLayer: HomePage(category: _currentCategory),
        // TODO: Change backLayer field value to CategoryMenuPage (104)
        backLayer: CategoryMenuPage(
          currentCategory: _currentCategory,
          onCategoryTap: _onCategoryTap,
        ),
        frontTitle: Text('SHRINE'),
        backTitle: Text('MENU'),
      ),
      theme: swTheme,
    );
  }

  void _onCategoryTap(Category category) {
    setState(() {
      _currentCategory = category;
    });
  }
}
