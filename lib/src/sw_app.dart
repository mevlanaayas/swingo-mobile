import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:swingo/src/pages/pages.dart';
import 'package:swingo/src/components/sw_navbar.dart';
import 'package:swingo/src/components/sw_button.dart';
import 'package:swingo/src/pages/profile/matches.dart';
import 'package:swingo/src/theme/style.dart';
import 'package:swingo/src/utils/constans.dart';
import 'package:swingo/src/ankara/general.dart';

class SwApp extends StatefulWidget {
  @override
  State<SwApp> createState() => _SwAppState();
}

class _SwAppState extends State<SwApp> with TickerProviderStateMixin {
  AnimationController _fabAnimationController;
  int _currentNavBarIndex = 0;

  @override
  void initState() {
    super.initState();
    _fabAnimationController = AnimationController(
      duration: Duration(milliseconds: 1000),
      value: 0.0,
      vsync: this,
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _fabAnimationController.dispose();
  }

  bool get _isCreateOptionsActive {
    final AnimationStatus status = _fabAnimationController.status;
    return status == AnimationStatus.completed ||
        status == AnimationStatus.forward;
  }

  void _onCreateButtonPressed() {
    _fabAnimationController.fling(
        velocity: _isCreateOptionsActive ? -swFlingVelocity : swFlingVelocity);
  }

  void _updateNavBarIndex(int index) async {
    if (_currentNavBarIndex == index) return;

    final userProvider = Provider.of<UserStatus>(context);
    if(!userProvider.isLoggedIn && index != 0){
      await Navigator.of(context).pushNamed('/route');
      if(userProvider.isLoggedIn){
        setState(() {
          _currentNavBarIndex = index;
        });
      }
    } else{
      setState(() {
        _currentNavBarIndex = index;
      });
    }
  }

  void _navigateToCreateOrders(int index) {
    final userProvider = Provider.of<UserStatus>(context);
    print(!userProvider.isLoggedIn);
    if (!userProvider.isLoggedIn) {
      Navigator.of(context).pushNamed('/route');
    } else if (index == 0) {
      Navigator.of(context).pushNamed('/create-send-order');
    } else if (index == 1) {
      Navigator.of(context).pushNamed('/create-carry-order');
    }
  }

  Widget _buildCreateOptions(Animation animation) {
    return Container(
      alignment: Alignment.bottomCenter,
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 6.9),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Spacer(flex: 5),
          FadeTransition(
            opacity: animation,
            child: SwButton(
                color: secondaryColor,
                onPressed: () => _navigateToCreateOrders(0),
                text: 'Senders'),
          ),
          Spacer(flex: 2),
          FadeTransition(
            opacity: animation,
            child: SwButton(
                color: secondaryColor,
                onPressed: () => _navigateToCreateOrders(1),
                text: 'Carriers'),
          ),
          Spacer(flex: 5),
        ],
      ),
    );
  }

  Widget _buildNavigationBar() {
    return NavBar(
      index: _currentNavBarIndex,
      onTabSelected: _updateNavBarIndex,
      items: [
        NavBarItem(
          iconData: Icons.home,
          text: 'Home',
        ),
        NavBarItem(
          iconData: Icons.format_list_numbered,
          text: 'My Orders',
        ),
        NavBarItem(
          iconData: Icons.playlist_add_check,
          text: 'Matches',
        ),
        NavBarItem(
          iconData: Icons.account_circle,
          text: 'Profile',
        ),
      ],
    );
  }

  Widget _buildCreateButton() {
    return FloatingActionButton(
      elevation: 1.0,
      backgroundColor: secondaryColor,
      child: new AnimatedIcon(
          size: 30,
          icon: AnimatedIcons.add_event,
          progress: _fabAnimationController.view),
      onPressed: _onCreateButtonPressed,
    );
  }

  Widget _buildStackContents(
      Widget page, Animation fadeAnimation, bool isNavBarActive) {
    Widget stack;

    if (isNavBarActive) {
      stack = Stack(
        children: <Widget>[
          page,
          _buildCreateOptions(fadeAnimation),
        ],
      );
    } else {
      Stack(
        children: <Widget>[page],
      );
    }

    return stack;
  }

  Widget _buildStack(Animation fadeAnimation) {
    Widget page;
    Widget stack;

    switch (_currentNavBarIndex) {
      case 0:
        page = HomeScreen();
        break;
      case 1:
        page = MyOrdersScreen();
        break;
      case 2:
        page = MatchesScreen();
        break;
      case 3:
        page = ProfileScreen();
        break;
    }
    stack = _buildStackContents(page, fadeAnimation, true);

    return stack;
  }

  @override
  Widget build(BuildContext context) {
    Animation _fadeAnimation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(_fabAnimationController);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: primaryColor, // status bar color
        statusBarIconBrightness: Brightness.light
    ));

    return Scaffold(
      extendBody: true,
      body: _buildStack(_fadeAnimation),
      bottomNavigationBar: _buildNavigationBar(),
      floatingActionButton: _buildCreateButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
