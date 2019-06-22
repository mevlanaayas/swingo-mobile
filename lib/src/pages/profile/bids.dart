import 'package:flutter/material.dart';
import 'package:swingo/src/components/components.dart';
import 'package:swingo/src/models/models.dart';
import 'package:swingo/src/theme/style.dart';

class BidsScreen extends StatelessWidget {
  static final Order transceiver = Order(
    1,
    "Trabzon",
    DateTime.now(),
    "Berlin",
    DateTime.now(),
    120.0,
    "SMALL",
    20.0,
    "There is a package to be delivered to Berlin. It is so small but "
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
        "Sed ac consequat turpis. Sed ullamcorper sem nec lectus mattis "
        "tempor. Praesent pulvinar sed. qweqeqweqweqeqweqweqwe"
        "qweqeqweqweqeqweqweqw.",
    "status",
    DateTime.now(),
    "currentuser",
    DateTime.now(),
    "currentuser",
    DateTime.now(),
    "currentuser",
    false,
  );
  static final Order transporter = Order(
    1,
    "Londra",
    DateTime.now(),
    "Zürih",
    DateTime.now(),
    50.0,
    "MEDIUM",
    20.0,
    "There is a package to be delivered to Berlin. It is so small but heavy.",
    "status",
    DateTime.now(),
    "bidder",
    DateTime.now(),
    "bidder",
    DateTime.now(),
    "bidderx",
    false,
  );
  static final User bidder = User(id: 1, username: 'bidder');
  static final User currentuser = User(id: 2, username: 'currentuser');

  final List<Bid> entries = [
    Bid(
      id: 1,
      transceiver: transceiver,
      transporter: null,
      bidder: bidder,
      price: 120.0,
      status: "Initiated",
      created_at: DateTime.now(),
      created_by: "bidder",
      updated_at: DateTime.now(),
      updated_by: "bidder",
      deleted_at: DateTime.now(),
      deleted_by: "bidder",
      is_deleted: false,
    ),
    Bid(
      id: 1,
      transceiver: null,
      transporter: transporter,
      bidder: currentuser,
      price: 120.0,
      status: "Initiated",
      created_at: DateTime.now(),
      created_by: "currentuser",
      updated_at: DateTime.now(),
      updated_by: "currentuser",
      deleted_at: DateTime.now(),
      deleted_by: "currentuser",
      is_deleted: false,
    ),
  ];

  void _buildSection(List<Widget> slivers, double scale, List<Bid> items) {
    if (items.isNotEmpty) {
      slivers.add(SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          Bid item = items[index];
          return BidItem(item: item);
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
