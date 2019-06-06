import 'package:flutter/material.dart';
import 'package:swingo/src/components/components.dart';
import 'package:swingo/src/theme/style.dart';

class BidsScreen extends StatelessWidget {
  final List<String> entries = <String>[
    'Lisbon',
    'Bursa',
    'Canada',
    'Trabzon',
    'Mersin',
    'Dublin',
    'Lisbon',
    'Aydın',
    'Ankara',
    'Londra'
  ];


  void _buildSection(List<Widget> slivers, double scale, List<String> items) {
    if (items.isNotEmpty) {
      slivers.add(SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          String item = items[index];
          return ListItem(
            item: item
          );
        }, childCount: items.length),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    var slivers = <Widget>[];
    const scale = 1.0;
    _buildSection(slivers, scale, entries);
    return Scaffold(
        body: Container(
            constraints: const BoxConstraints(minWidth: double.infinity),
            color: primaryColor50,
            child: Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top,
                bottom: MediaQuery.of(context).padding.bottom + 33,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(child: CustomScrollView(slivers: slivers)),
                ],
              ),
            )));
  }
}
