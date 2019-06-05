import 'package:flutter/material.dart';
import 'package:swingo/src/theme/style.dart';

class NavBarItem {
  NavBarItem({this.iconData, this.text});
  IconData iconData;
  String text;
}

class NavBar extends StatefulWidget{
  final List<NavBarItem> items;
  final ValueChanged<int> onTabSelected;

  NavBar({
    this.items,
    this.onTabSelected
  });

  @override
  State<StatefulWidget> createState() {
    return _NavBarState();
  }
}

class _NavBarState extends State<NavBar> {
  int _currentIndex = 0;
  bool isLoggedIn = false; //TODO: backende istek atılınca düzeltilmesi gerek.

  void _navigateToHome(BuildContext context){
    Navigator.of(context).pushNamed('/');
  }

  void _navigateToOrders(BuildContext context){
    if(isLoggedIn){
      Navigator.of(context).pushNamed('/orders');
    } else {
      Navigator.of(context).pushNamed('/route');
    }
  }

  void _navigateToBids(BuildContext context){
    if(isLoggedIn){
      Navigator.of(context).pushNamed('/bids');
    } else {
      Navigator.of(context).pushNamed('/route');
    }
  }

  void _navigateToProfile(BuildContext context){
    if(isLoggedIn){
      Navigator.of(context).pushNamed('/profile');
    } else {
      Navigator.of(context).pushNamed('/route');
    }
  }

  _updateIndex(int index) {
    widget.onTabSelected(index);
    setState(() {
      if(_currentIndex == index) return
        _currentIndex = index;
      switch (index){
        case 0: { _navigateToHome(context); } break;
        case 1: { _navigateToOrders(context); } break;
        case 2: { _navigateToBids(context); } break;
        case 3: { _navigateToProfile(context); } break;
      }
    });
  }

  Widget _buildTabItem({NavBarItem item, int index, ValueChanged<int> onPressed}) {
    Color color = _currentIndex == index ? primaryColor : secondaryColor;
    return Expanded(
      child: SizedBox(
        height: 56,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
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
        onPressed: _updateIndex,
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