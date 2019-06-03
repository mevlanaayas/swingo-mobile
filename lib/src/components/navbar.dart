import 'package:flutter/material.dart';

class NavBar extends StatefulWidget{
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

  void _navigateToProfile(BuildContext context){
    if(isLoggedIn){
      Navigator.of(context).pushNamed('/profile');
    } else {
      Navigator.of(context).pushNamed('/route');
    }
  }




  @override
  Widget build(BuildContext context) {
    void onTabTapped(int index){
      setState(() {
        print(index);
        if(_currentIndex == index) return
        _currentIndex = index;
        print(_currentIndex);
        switch (index){
          case 0: { _navigateToHome(context); } break;
          case 1: { _navigateToProfile(context); } break;
        }
      });
    }

    return BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
              icon: new Icon(Icons.home),
              title: new Text('Home')
          ),
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