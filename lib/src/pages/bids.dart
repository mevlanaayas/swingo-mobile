import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:swingo/src/theme/style.dart';
import 'package:swingo/src/pages/pages.dart';

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

  Widget _buildHeading() {
    return Row(
      children: <Widget>[
        const Icon(
          FontAwesomeIcons.user,
          color: secondaryColor,
          size: 11.0,
        ),
        SizedBox(
          width: 10.0,
        ),
        Text(
          "username",
          style: itemUsernameContentStyle,
        ),
        Text("Price", style: itemPriceContentStyle)
      ],
    );
  }

  void _buildSection(List<Widget> slivers, double scale, List<String> items) {
    if (items.isNotEmpty) {
      slivers.add(SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          String item = items[index];
          return ListItem(
            item: item,
            heading: _buildHeading(),
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
                  SizedBox(height: 10),
                  Expanded(child: CustomScrollView(slivers: slivers)),
                ],
              ),
            )));
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

  BoxDecoration get listItemDecoration => BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.03),
              offset: const Offset(0, 10),
              blurRadius: 10,
              spreadRadius: 0),
        ],
        // border: isExpanded ? Border.all(color: primaryColor) : null,
        borderRadius: const BorderRadius.all(Radius.circular(9)),
        color: Colors.white,
      );

  Future<void> _handleTap(BuildContext context, String item) async {
    Navigator.push(
      context,
      SlideTopRoute(page: DetailScreen(item: item)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 3, right: 3, bottom: 5),
      child: Container(
        decoration: listItemDecoration,
        child: Material(
          elevation: 0.0,
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

class SlideTopRoute extends PageRouteBuilder {
  final Widget page;

  SlideTopRoute({this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 1),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              ),
        );
}
