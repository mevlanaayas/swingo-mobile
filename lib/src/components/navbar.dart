import 'package:flutter/material.dart';

class NavBar extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _NavBarState();
  }
}

class _NavBarState extends State<NavBar> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    void onTabTapped(int index){
      setState(() {
        _currentIndex = index;
      });
    }

    return BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
              icon: new Icon(Icons.account_box),
              title: new Text('Profile')
          ),
          BottomNavigationBarItem(
              icon: new Icon(Icons.add_circle),
              title: new Text('Add')
          ),
          BottomNavigationBarItem(
              icon: new Icon(Icons.message),
              title: new Text('Messages')
          ),
        ]
    );
  }
}