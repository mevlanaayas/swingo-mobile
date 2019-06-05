import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:swingo/src/pages/pages.dart';
import 'package:swingo/src/components/sw_navbar.dart';
import 'package:swingo/src/components/sw_button.dart';
import 'package:swingo/src/utils/constans.dart';

class SwApp extends StatefulWidget {
  @override
  State<SwApp> createState() => _SwAppState();
}

class _SwAppState extends State<SwApp> with TickerProviderStateMixin{
  AnimationController _fabAnimationController;
  final isLoggedIn = false; //todo: backendden alınması gerekiyor
  int _currentNavBarIndex = 0;

  @override
  void initState() {
    super.initState();
    _fabAnimationController = AnimationController(
      duration: Duration(milliseconds: 1000),
      value: 1.0,
      vsync: this,
    );
  }

  @override
  void dispose() {// TODO: implement dispose
    super.dispose();
    _fabAnimationController.dispose();
  }

  bool get _isCreateOptionsActive {
    final AnimationStatus status = _fabAnimationController.status;
    return status == AnimationStatus.completed ||
        status == AnimationStatus.forward;
  }

  void _onFloatingActionButtonPressed() {
    _fabAnimationController.fling(
        velocity: _isCreateOptionsActive ? -swFlingVelocity : swFlingVelocity
    );
  }

  void _updateNavBarIndex(int index) {
    if(_currentNavBarIndex == index) return;
    if(index != 0 && !isLoggedIn){
      Navigator.of(context).pushNamed('/route');
    } else {
      setState(() {
        _currentNavBarIndex = index;
      });
    }
  }

  void _navigateToCreateOrders(int index){
    if(!isLoggedIn){
      Navigator.of(context).pushNamed('/route');
    } else if(index == 0){
      Navigator.of(context).pushNamed('/create-send-order');
    } else if(index == 1){
      Navigator.of(context).pushNamed('/create-carry-order');
    }
  }

  Widget _buildCreateOptions(Animation animation){
    return Container(
      alignment: Alignment.bottomCenter,
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 7.7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Spacer(flex: 5),
          FadeTransition(
              opacity: animation,
              child: SwButton(
                  onPressed: () => _navigateToCreateOrders(0),
                  text: 'Send'
              )
          ),
          Spacer(flex: 2),
          FadeTransition(
              opacity: animation,
              child: SwButton(
                  onPressed: () =>  _navigateToCreateOrders(1),
                  text: 'Carry'
              )
          ),
          Spacer(flex: 5),
        ],
      ),
    );
  }

  Widget _buildNavigationBar(){
    return NavBar(
      index: _currentNavBarIndex,
      onTabSelected: _updateNavBarIndex,
      items: [
        NavBarItem(iconData: Icons.home, text: 'Home'),
        NavBarItem(iconData: Icons.content_paste, text: 'Orders'),
        NavBarItem(iconData: Icons.monetization_on, text: 'Bids'),
        NavBarItem(iconData: Icons.account_circle, text: 'Profile'),
      ],
    );
  }

  Widget _buildCreateButton(){
    return FloatingActionButton(
      elevation: 1.0,
      backgroundColor: Theme.of(context).primaryColor,
      child: new AnimatedIcon(
          size: 30,
          icon: AnimatedIcons.add_event,
          progress: _fabAnimationController.view
      ),
      onPressed: _onFloatingActionButtonPressed,
    );
  }

  Widget _buildStack(Animation fadeAnimation){
    Widget page;
    Widget stack;

    switch (_currentNavBarIndex){
      case 0: { page = HomePage(); } break;
      case 1: { page = OrdersScreen(); } break;
      case 2: { page = BidsScreen(); } break;
      case 3: { page = ProfileScreen(); } break;
    }
    stack = _buildStackContents(page, fadeAnimation, true);

    return stack;
  }

  Widget _buildStackContents(Widget page, Animation fadeAnimation, bool isNavBarActive){
    Widget stack;

    if(isNavBarActive){
      stack =  Stack(
        children: <Widget>[
          page,
          _buildCreateOptions(fadeAnimation),
        ],
      );
    } else {
      Stack(
        children: <Widget>[
          page
        ],
      );
    }

    return stack;
  }

  @override
  Widget build(BuildContext context) {
    Animation _fadeAnimation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(_fabAnimationController);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    return Scaffold(
      extendBody: true,
      body: _buildStack(_fadeAnimation),
      bottomNavigationBar: _buildNavigationBar(),
      floatingActionButton: _buildCreateButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
