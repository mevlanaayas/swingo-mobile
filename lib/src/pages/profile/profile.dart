import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:swingo/src/classes/SwScreen.dart';

class ProfileListItem {
  final IconData leadingIcon;
  final String title;
  final void onPressed;

  ProfileListItem({this.leadingIcon, this.title, this.onPressed});
}

class ProfileScreen extends StatelessWidget with SwScreen {
  final List<ProfileListItem> profileListItems = <ProfileListItem>[
    ProfileListItem(
      leadingIcon: FontAwesomeIcons.user,
      title: 'Account',
      onPressed: () {},
    ),
    ProfileListItem(
      leadingIcon: FontAwesomeIcons.signOutAlt,
      title: 'Sign Out',
      onPressed: () {},
    ),
  ];

  final List<int> colorCodes = <int>[600, 500, 100];

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
            onTap: () => profileListItem.onPressed,
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
