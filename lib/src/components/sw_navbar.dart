import 'package:flutter/material.dart';
import 'package:swingo/src/theme/style.dart';

class NavBarItem {
  NavBarItem({this.iconData, this.text});

  IconData iconData;
  String text;
}

class NavBar extends StatefulWidget {
  final List<NavBarItem> items;
  final ValueChanged<int> onTabSelected;
  final int index;

  NavBar({this.items, this.onTabSelected, this.index});

  @override
  State<StatefulWidget> createState() {
    return _NavBarState();
  }
}

class _NavBarState extends State<NavBar> {
  Widget _buildTabItem(
      {NavBarItem item, int index, ValueChanged<int> onPressed}) {
    Color color = widget.index == index ? primaryColor : Colors.grey;
    return Expanded(
      child: SizedBox(
        height: 56,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            splashColor: Colors.transparent,
            onTap: () => onPressed(index),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(item.iconData, color: color, size: 20.0),
                Text(
                  item.text,
                  style: TextStyle(color: color),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> items = List.generate(widget.items.length, (int index) {
      return _buildTabItem(
        item: widget.items[index],
        index: index,
        onPressed: widget.onTabSelected,
      );
    });

    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items,
      ),
    );
  }
}
