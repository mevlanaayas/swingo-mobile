import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:swingo/src/classes/SwScreen.dart';
import 'package:swingo/src/pages/profile/account.dart';
import 'package:swingo/src/pages/profile/signout.dart';
import 'package:swingo/src/theme/style.dart';
import 'package:swingo/src/utils/sliders.dart';

class ProfileScreen extends StatelessWidget with SwScreen {
  final dynamic updateNavBarIndex;

  ProfileScreen({
    this.updateNavBarIndex,
  });

  static _navigateToAccountPage(BuildContext context) {
    Navigator.push(
      context,
      SlideRightRoute(
        page: AccountScreen(),
      ),
    );
  }

  static _showSignOutDialog(BuildContext context, dynamic updateNavBarIndex) {
    return showDialog(
      context: context,
      builder: (BuildContext newContext) {
        return SignOutDialog(updateNavBarIndex: updateNavBarIndex);
      },
    );
  }

  List<ProfileListItem> _initProfileListItems() {
    return <ProfileListItem>[
      ProfileListItem(
        leadingIcon: FontAwesomeIcons.user,
        title: 'Account',
        onPressed: (BuildContext context) => _navigateToAccountPage(context),
      ),
      ProfileListItem(
        leadingIcon: FontAwesomeIcons.signOutAlt,
        title: 'Sign Out',
        onPressed: (BuildContext context) =>
            _showSignOutDialog(context, this.updateNavBarIndex),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final profileListItems = _initProfileListItems();
    return Scaffold(
      backgroundColor: primaryColor50,
      appBar: this.buildAppbar(
        context,
        hideBackButton: true,
        title: 'Profile',
      ),
      body: ListView.separated(
        itemCount: profileListItems.length,
        itemBuilder: (BuildContext context, int index) {
          ProfileListItem profileListItem = profileListItems[index];
          return Container(
            color: Colors.white,
            child: ListTile(
              leading: Icon(
                profileListItem.leadingIcon,
                color: primaryColor,
              ),
              trailing: Icon(
                FontAwesomeIcons.chevronRight,
                color: primaryColor,
              ),
              title: Text(
                profileListItem.title,
                style: profileListItemStyle,
              ),
              onTap: () => profileListItem.onPressed(context),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) => Container(
              height: 0,
              child: Padding(
                padding: dividerPadding,
                child: Divider(
                  color: primaryColor,
                ),
              ),
            ),
      ),
    );
  }
}

class ProfileListItem {
  final IconData leadingIcon;
  final String title;
  final dynamic onPressed;

  ProfileListItem({this.leadingIcon, this.title, this.onPressed});
}