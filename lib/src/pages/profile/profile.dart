import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:swingo/src/classes/SwScreen.dart';
import 'package:swingo/src/pages/profile/signout.dart';

class ProfileListItem {
  final IconData leadingIcon;
  final String title;
  final dynamic onPressed;

  ProfileListItem({this.leadingIcon, this.title, this.onPressed});
}

class ProfileScreen extends StatelessWidget with SwScreen {
  _navigateToAccountPage(){

  }

  static _showSignOutDialog(BuildContext context){
    return showDialog(
      context: context,
      builder: (BuildContext newContext) {
        return SignOutDialog();
      },
    );
  }

  final List<ProfileListItem> profileListItems = <ProfileListItem>[
    ProfileListItem(
      leadingIcon: FontAwesomeIcons.user,
      title: 'Account',
      onPressed: () {},
    ),
    ProfileListItem(
      leadingIcon: FontAwesomeIcons.signOutAlt,
      title: 'Sign Out',
      onPressed: (BuildContext context) => _showSignOutDialog(context),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: this.buildAppbar(
        context,
        hideBackButton: true,
        title: 'Profile',
      ),
      body: ListView.separated(
        itemCount: profileListItems.length,
        itemBuilder: (BuildContext context, int index) {
          ProfileListItem profileListItem = this.profileListItems[index];
          return ListTile(
            leading: Icon(profileListItem.leadingIcon),
            title: Text(profileListItem.title),
            onTap: () => profileListItem.onPressed(context),
          );
        },
        separatorBuilder: (BuildContext context, int index) => Container(
              height: 0,
              child: Divider(),
            ),
      ),
    );
  }
}
