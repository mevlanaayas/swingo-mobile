import 'package:flutter/material.dart';
import 'package:swingo/src/components/backdrop/backlayer.dart';
import 'package:swingo/src/components/components.dart';
import 'package:swingo/src/components/navbar.dart';
import 'package:swingo/src/models/filter.dart';
import 'package:swingo/src/theme/themes.dart';

import 'frontlayer.dart';
import 'list.dart';

class HomePage extends StatefulWidget {
  final Filter filter;

  HomePage({this.filter});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Filter _currentFilter =
      Filter(fromCity: null, toCity: null, fromDate: null, toDate: null);

  void _onFilterChange(Filter filter) {
    setState(() {
      _currentFilter = filter;
      print('Filter state: $_currentFilter');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
}
