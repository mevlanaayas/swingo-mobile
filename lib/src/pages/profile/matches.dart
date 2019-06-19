import 'package:flutter/material.dart';
import 'package:swingo/src/components/components.dart';
import 'package:swingo/src/models/models.dart';
import 'package:swingo/src/theme/style.dart';

class MatchesScreen extends StatelessWidget {
  static final User carrier = User(id: 1, username: 'carrier');
  static final User currentCarrier = User(id: 3, username: 'currentuser');
  static final User purchaser = User(id: 2, username: 'purchaser');
  static final User currentPurchaser = User(id: 4, username: 'currentuser');

  final List<SwMatch> entries = [
    SwMatch(
        id: 1,
        carrier: currentCarrier,
        purchaser: purchaser,
        fromAddress: "From address 1",
        toAddress: "To address 1",
        value: 120.0,
        paymentType: "On delivery",
        failReason: "Fail reason",
        status: "Status",
        created_at: DateTime.now(),
        created_by: "currentuser",
        updated_at: DateTime.now(),
        updated_by: "currentuser"),
    SwMatch(
        id: 1,
        carrier: carrier,
        purchaser: currentPurchaser,
        fromAddress: "From address 2",
        toAddress: "To address 2",
        value: 240.0,
        paymentType: "Online",
        failReason: "Fail reason",
        status: "Status",
        created_at: DateTime.now(),
        created_by: "currentuser",
        updated_at: DateTime.now(),
        updated_by: "currentuser"),
  ];

  void _buildSection(List<Widget> slivers, double scale, List<SwMatch> items) {
    if (items.isNotEmpty) {
      slivers.add(SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          SwMatch item = items[index];
          return MatchItem(item: item);
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
                bottom: MediaQuery.of(context).padding.bottom,
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
