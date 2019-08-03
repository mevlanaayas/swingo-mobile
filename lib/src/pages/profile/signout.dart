import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swingo/src/ankara/general.dart';
import 'package:swingo/src/classes/SwScreen.dart';
import 'package:swingo/src/components/sw_dialog.dart';
import 'package:swingo/src/services/authentication.dart';

class SignOutDialog extends StatelessWidget {
  _onSignOutTap(BuildContext context) async {
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
      if (responseData['detail'] != null &&
          responseData['detail'] == 'Invalid token.') {
        //TODO: adam akıllı bi kontrol yapmak gerekiyor.
        final signOutFn = _onRequestSuccess(context);
        signOutFn(responseData);
      } else {
        SwScreen.showSnackBar(context, 'Please try again.');
      }
    };
  }

  @override
  Widget build(BuildContext context) {
    return SwDialog(
      isDismissButtonActive: true,
      isAcceptButtonActive: true,
      dismissButtonText: 'Cancel',
      acceptButtonText: 'Signout',
      contentText: 'Are you sure you want to sign out?',
      onAcceptTap: _onSignOutTap,
    );
  }
}
