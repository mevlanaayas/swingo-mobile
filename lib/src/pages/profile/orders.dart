import 'package:flutter/material.dart';
import 'package:swingo/src/components/components.dart';
import 'package:swingo/src/models/models.dart';
import 'package:swingo/src/theme/style.dart';

class OrdersScreen extends StatelessWidget {
  final List<Order> myOrders = [
    Order(
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
        false),
    Order(
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
        "currentuser",
        DateTime.now(),
        "currentuser",
        DateTime.now(),
        "currentuser",
        false),
    Order(
        1,
        "Toronto",
        DateTime.now(),
        "Dublin",
        DateTime.now(),
        230.0,
        "SMALL",
        20.0,
        "There is a package to be delivered to Berlin. It is so small but heavy.",
        "status",
        DateTime.now(),
        "currentuser",
        DateTime.now(),
        "currentuser",
        DateTime.now(),
        "currentuser",
        false),
  ];

  void _buildSection(List<Widget> slivers, double scale, List<Order> items) {
    if (items.isNotEmpty) {
      slivers.add(
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            Order item = items[index];
            return ListItem(item: item);
          }, childCount: items.length),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var slivers = <Widget>[];
    const scale = 1.0;
    _buildSection(slivers, scale, myOrders);
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints(minWidth: double.infinity),
        color: primaryColor50,
        child: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top,
            bottom: MediaQuery.of(context).padding.bottom,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(child: CustomScrollView(slivers: slivers)),
            ],
          ),
        ),
      ),
    );
  }
}
