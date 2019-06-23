import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swingo/src/ankara/general.dart';
import 'package:swingo/src/classes/SwScreen.dart';
import 'package:swingo/src/services/authentication.dart';
import 'package:swingo/src/theme/style.dart';
import 'package:swingo/src/components/sw_button.dart';

class SignOutScreen extends StatelessWidget with SwScreen {
  void _onCancelTap(BuildContext context) {
    Navigator.of(context).pop();
  }

  void _onSignOutTap(BuildContext context) async {
    AuthenticationService.signout(
      context,
      onSuccess: _onRequestSuccess(context),
      onError: _onRequestError(context),
    );
  }

  _onRequestSuccess(BuildContext context) {
    return (responseData) async {
      final userProvider = Provider.of<UserStatus>(context);
      userProvider.signout();
      await Navigator.of(context).pop();
      Navigator.of(context).pushNamed('/route');
    };
  }

  _onRequestError(BuildContext context) {
    return (responseData) {
      if(responseData['detail'] != null && responseData['detail'] == 'Invalid token.'){ //TODO: adam akıllı bi kontrol yapmak gerekiyor.
        final signOutFn = _onRequestSuccess(context);
        signOutFn(responseData);
      } else {
        SwScreen.showSnackBar(context, 'Please try again.');
      }
    };
  }

  Widget _buildBody(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Align(
      alignment: Alignment.center,
      child: Container(
        padding: EdgeInsets.all(15.0),
        constraints: BoxConstraints(
          maxWidth: width / 10 * 9,
          maxHeight: height / 10 * 3,
        ),
        decoration: BoxDecoration(
            color: secondaryColor,
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Are you sure you want to sign out?',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SwButton(
                  color: primaryColor,
                  text: 'Signout',
                  onPressed: () => _onSignOutTap(context),
                ),
                SizedBox(
                  width: 10,
                ),
                SwButton(
                  color: primaryColor,
                  text: 'Cancel',
                  onPressed: () => _onCancelTap(context),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //AuthenticationService.signout(context);
    return Scaffold(
        backgroundColor: Color.fromRGBO(0, 0, 0, 0.5),
        body: new Builder(
          builder: (BuildContext scaffoldContext) => _buildBody(
                scaffoldContext,
              ),
        ));
  }
}
