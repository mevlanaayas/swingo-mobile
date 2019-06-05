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

class ListItem extends StatefulWidget {
  final Widget heading;
  final String item;

  const ListItem({
    this.item,
    this.heading,
  });

  @override
  _ListItemState createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  bool isExpanded = false;

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
    setState(() {
      isExpanded = isExpanded ? false : true;
    });
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
            onTap: () => _handleTap(context, widget.item),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  widget.heading,
                  const SizedBox(height: 12),
                  Text(
                    widget.item,
                    style: isExpanded
                        ? contentStyle.apply(
                            color: primaryColor, fontSizeFactor: 1)
                        : contentStyle.apply(
                            color: primaryColor, fontSizeFactor: 1),
                  ),
                  ItemDetails(
                    item: widget.item,
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
