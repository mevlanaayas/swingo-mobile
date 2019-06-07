import 'package:flutter/material.dart';
import 'package:swingo/src/components/backdrop/backlayer.dart';
import 'package:swingo/src/components/components.dart';
import 'package:swingo/src/models/filter.dart';
import 'package:swingo/src/pages/pages.dart';
import 'frontlayer.dart';

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
    return Scaffold(
      body: Backdrop(
        currentFilter: _currentFilter,
        frontLayer: <FrontlayerPage>[
          FrontlayerPage(title: 'Senders', child: ListScreen('senders')),
          FrontlayerPage(title: 'Carriers', child: ListScreen('carriers')),
        ],
        backLayer: FilterMenuPage(
          currentFilter: _currentFilter,
          onFilterChange: _onFilterChange,
        ),
      ),
    );
  }
}
