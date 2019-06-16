import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:swingo/src/components/components.dart';
import 'package:swingo/src/models/models.dart';
import 'package:swingo/src/theme/style.dart';

class ListScreen extends StatelessWidget {
  final List<Order> senders = [
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
        "beni",
        DateTime.now(),
        "beni",
        DateTime.now(),
        "beni",
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
        "arsızbela",
        DateTime.now(),
        "arsızbela",
        DateTime.now(),
        "arsızbela",
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
        "verylongusernametoshowonscreenbecausefluttergetsangry",
        DateTime.now(),
        "verylongusernametoshowonscreenbecausefluttergetsangry",
        DateTime.now(),
        "verylongusernametoshowonscreenbecausefluttergetsangry",
        false),
    Order(
        1,
        "Trabzon",
        DateTime.now(),
        "Berlin",
        DateTime.now(),
        120.0,
        "SMALL",
        20.0,
        "There is a package to be delivered to Berlin. It is so small but heavy.",
        "status",
        DateTime.now(),
        "mevlana",
        DateTime.now(),
        "mevlana",
        DateTime.now(),
        "mevlana",
        false),
    Order(
        1,
        "Trabzon",
        DateTime.now(),
        "Berlin",
        DateTime.now(),
        120.0,
        "SMALL",
        20.0,
        "There is a package to be delivered to Berlin. It is so small but heavy.",
        "status",
        DateTime.now(),
        "mevlana",
        DateTime.now(),
        "mevlana",
        DateTime.now(),
        "mevlana",
        false),
    Order(
        1,
        "Trabzon",
        DateTime.now(),
        "Berlin",
        DateTime.now(),
        120.0,
        "SMALL",
        20.0,
        "There is a package to be delivered to Berlin. It is so small but heavy.",
        "status",
        DateTime.now(),
        "mevlana",
        DateTime.now(),
        "mevlana",
        DateTime.now(),
        "mevlana",
        false),
    Order(
        1,
        "Trabzon",
        DateTime.now(),
        "Berlin",
        DateTime.now(),
        120.0,
        "SMALL",
        20.0,
        "There is a package to be delivered to Berlin. It is so small but heavy.",
        "status",
        DateTime.now(),
        "mevlana",
        DateTime.now(),
        "mevlana",
        DateTime.now(),
        "mevlana",
        false),
    Order(
        1,
        "Trabzon",
        DateTime.now(),
        "Berlin",
        DateTime.now(),
        120.0,
        "SMALL",
        20.0,
        "There is a package to be delivered to Berlin. It is so small but heavy.",
        "status",
        DateTime.now(),
        "mevlana",
        DateTime.now(),
        "mevlana",
        DateTime.now(),
        "mevlana",
        false),
    Order(
        1,
        "Trabzon",
        DateTime.now(),
        "Berlin",
        DateTime.now(),
        120.0,
        "SMALL",
        20.0,
        "There is a package to be delivered to Berlin. It is so small but heavy.",
        "status",
        DateTime.now(),
        "mevlana",
        DateTime.now(),
        "mevlana",
        DateTime.now(),
        "mevlana",
        false),
    Order(
        1,
        "Trabzon",
        DateTime.now(),
        "Berlin",
        DateTime.now(),
        120.0,
        "SMALL",
        20.0,
        "There is a package to be delivered to Berlin. It is so small but heavy.",
        "status",
        DateTime.now(),
        "mevlana",
        DateTime.now(),
        "mevlana",
        DateTime.now(),
        "mevlana",
        false),
    Order(
        1,
        "Trabzon",
        DateTime.now(),
        "Berlin",
        DateTime.now(),
        120.0,
        "SMALL",
        20.0,
        "There is a package to be delivered to Berlin. It is so small but heavy.",
        "status",
        DateTime.now(),
        "mevlana",
        DateTime.now(),
        "mevlana",
        DateTime.now(),
        "mevlana",
        false),
  ];

  final List<Order> carriers = [
    Order(
        1,
        "Semerkand",
        DateTime.now(),
        "Berlin",
        DateTime.now(),
        320.0,
        "HUGE",
        10.0,
        "There is a package to be delivered to Berlin. It is so small but heavy.",
        "status",
        DateTime.now(),
        "myhome",
        DateTime.now(),
        "myhome",
        DateTime.now(),
        "myhome",
        false),
    Order(
        2,
        "Moskova",
        DateTime.now(),
        "Parma",
        DateTime.now(),
        30.0,
        "SMALL",
        10.0,
        "There is a package to be delivered to Berlin. It is so small but heavy.",
        "status",
        DateTime.now(),
        "ruski",
        DateTime.now(),
        "ruski",
        DateTime.now(),
        "ruski",
        false),
    Order(
        1,
        "Parma",
        DateTime.now(),
        "Moskova",
        DateTime.now(),
        230.0,
        "SMALL",
        20.0,
        "There is a package to be delivered to Berlin. It is so small but heavy.",
        "status",
        DateTime.now(),
        "ruski",
        DateTime.now(),
        "ruski",
        DateTime.now(),
        "ruski",
        false),
    Order(
        1,
        "Trabzon",
        DateTime.now(),
        "Berlin",
        DateTime.now(),
        120.0,
        "SMALL",
        20.0,
        "There is a package to be delivered to Berlin. It is so small but heavy.",
        "status",
        DateTime.now(),
        "mevlana",
        DateTime.now(),
        "mevlana",
        DateTime.now(),
        "mevlana",
        false)
  ];

  final String type;

  ListScreen(this.type);

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
    type == "senders"
        ? _buildSection(slivers, scale, senders)
        : _buildSection(slivers, scale, carriers);
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
              Row(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: ButtonTheme(
                      minWidth: 0,
                      child: FlatButton(
                        splashColor: Colors.transparent,
                        padding: const EdgeInsets.all(0),
                        shape: null,
                        onPressed: () => Navigator.pop(context, null),
                        child: const Icon(
                          FontAwesomeIcons.chevronLeft,
                          color: secondaryColor,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    type.toUpperCase(),
                    style: itemDetailHeadingStyle,
                  )
                ],
              ),
              Expanded(child: CustomScrollView(slivers: slivers)),
            ],
          ),
        ),
      ),
    );
  }
}