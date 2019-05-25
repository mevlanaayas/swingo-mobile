import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:swingo/src/models/filter.dart';
import 'package:swingo/src/pages/pages.dart';
import 'package:swingo/src/theme/themes.dart';
import 'package:swingo/src/components/navbar.dart';

import 'components/components.dart';


class SwApp extends StatefulWidget {
  @override
  State<SwApp> createState() => _SwAppState();
}

class _SwAppState extends State<SwApp> {
  Filter _currentFilter = Filter(fromCity: null, toCity: null, fromDate: null, toDate: null);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Swingo',
      home: Backdrop(
        currentFilter: _currentFilter,
        //frontLayer: HomePage(filter: _currentFilter), // TODO: alttaki array bunun içine yazılmalı
        frontLayer: <FrontlayerPage>[
          FrontlayerPage(title: 'Send', child: ListPage()),
          FrontlayerPage(title: 'Carry', child: ListPage()),
        ],
        backLayer: FilterMenuPage(
          currentFilter: _currentFilter,
          onFilterChange: _onFilterChange,
        ),
        frontTitle: Text('SHRINE'),
        backTitle: Text('MENU'),
        navbar: NavBar(),
      ),
      theme: swTheme,
    );
  }

  void _onFilterChange(Filter filter){
    setState(() {
      _currentFilter = filter;
      print('Filter state: $_currentFilter');
    });
  }
}
