import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:swingo/src/classes/SwScreen.dart';
import 'package:swingo/src/services/client.dart';
import 'package:swingo/src/theme/style.dart';

class AccountListItem {
  final String leadingTitle;
  final String title;
  final dynamic onPressed;

  AccountListItem({this.leadingTitle, this.title, this.onPressed});
}

class AccountScreen extends StatefulWidget with SwScreen {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  List<AccountListItem> accountListItems = _setAccountDetails();

  static List<AccountListItem> _setAccountDetails(
      {String username = '...',
      String name = '...',
      String surname = '...',
      String email = '...'}) {
    return <AccountListItem>[
      AccountListItem(
        leadingTitle: "Username",
        title: username,
        onPressed: () {},
      ),
      AccountListItem(
        leadingTitle: "Name",
        title: name,
        onPressed: () {},
      ),
      AccountListItem(
        leadingTitle: "Surname",
        title: surname,
        onPressed: () {},
      ),
      AccountListItem(
        leadingTitle: "E-Mail",
        title: email,
        onPressed: () {},
      ),
    ];
  }

  _onGetClientRequestSuccess(BuildContext context) {
    return (responseData) {
      final detail = responseData['results'][0];
      final username = detail['username'];
      final name = detail['first_name'];
      final surname = detail['last_name'];
      final email = detail['email'];

      setState(() {
        accountListItems = _setAccountDetails(
          username: username,
          name: name,
          surname: surname,
          email: email,
        );
      });
    };
  }

  _getClient(BuildContext context) {
    ClientService.get(
      context,
      onSuccess: _onGetClientRequestSuccess(context),
    );
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _getClient(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.buildAppbar(context, title: 'Account'),
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
