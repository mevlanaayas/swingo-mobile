import 'package:flutter/material.dart';
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
            item: item,
            isExpanded: false,
            heading: const Icon(Icons.check_circle, color: disabledColor),
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
    return Material(
        color: primaryColor50,
        child: SafeArea(child: CustomScrollView(slivers: slivers)));
  }
}


class ListItem extends StatelessWidget {
  final bool isExpanded;
  final Widget heading;
  final String item;

  const ListItem({
    this.item,
    this.isExpanded = false,
    this.heading,
  });

  BoxDecoration get workListItemDecoration => BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.03),
              offset: const Offset(0, 10),
              blurRadius: 10,
              spreadRadius: 0),
        ],
        borderRadius: const BorderRadius.all(Radius.circular(9)),
        color: Colors.white,
      );

  Future<void> _handleTap(BuildContext context, String workItem) async {
    print(workItem);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
      child: Container(
        decoration: workListItemDecoration,
        child: Material(
          type: MaterialType.transparency,
          borderRadius: const BorderRadius.all(Radius.circular(9)),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            splashColor: Colors.transparent,
            onTap: () => _handleTap(context, item),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  heading,
                  const SizedBox(height: 12),
                  Text(
                    item,
                    style: isExpanded
                        ? contentStyle.apply(fontSizeFactor: 1)
                        : contentStyle.apply(
                            color: disabledColor, fontSizeFactor: 1),
                  ),
                  ItemDetails(
                    item: item,
                    isExpanded: isExpanded,
                    progressColor: primaryColor,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ItemDetails extends StatelessWidget {
  const ItemDetails({
    this.item,
    this.isExpanded,
    this.progressColor,
  });

  final String item;
  final bool isExpanded;
  final Color progressColor;

  @override
  Widget build(BuildContext context) {
    return !isExpanded
        ? Container()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(height: 11),
              Text("detail"),
              const SizedBox(height: 11),
              Text("detail"),
            ],
          );
  }
}
