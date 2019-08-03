import 'package:flutter/material.dart';
import 'package:swingo/src/classes/SwScreen.dart';
import 'package:swingo/src/theme/style.dart';

class AccountListItem {
  final String leadingTitle;
  final String title;
  final dynamic onPressed;

  AccountListItem({this.leadingTitle, this.title, this.onPressed});
}

class AccountScreen extends StatelessWidget with SwScreen {
  final List<AccountListItem> accountListItems = <AccountListItem>[
    AccountListItem(
      leadingTitle: "Username",
      title: '...',
      onPressed: () {},
    ),
    AccountListItem(
      leadingTitle: "Name",
      title: '...',
      onPressed: () {},
    ),
    AccountListItem(
      leadingTitle: "Surname",
      title: '...',
      onPressed: () {},
    ),
    AccountListItem(
      leadingTitle: "E-Mail",
      title: '...',
      onPressed: () {},
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: this.buildAppbar(context, title: 'Account'),
      body: ListView.separated(
        itemCount: accountListItems.length,
        itemBuilder: (BuildContext context, int index) {
          AccountListItem accountListItem = this.accountListItems[index];
          return ListTile(
            title: Container(
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    accountListItem.leadingTitle,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(accountListItem.title),
                ],
              ),
            ),
            // onTap: () => accountListItem.onPressed(context), //TODO: profil edit geldiğinde onpressed ler yazılacacak.
          );
        },
        separatorBuilder: (BuildContext context, int index) => Container(
              height: 0,
              child: Divider(
                color: primaryColor,
              ),
            ),
      ),
    );
  }
}
