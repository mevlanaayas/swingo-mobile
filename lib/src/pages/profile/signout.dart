import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swingo/src/ankara/general.dart';
import 'package:swingo/src/components/sw_dialog.dart';

class SignOutDialog extends StatelessWidget {
  final dynamic updateNavBarIndex;

  SignOutDialog({this.updateNavBarIndex});

  _onSignOutTap(BuildContext context) async {
    final userProvider = Provider.of<UserStatus>(context);
    userProvider.signout();
    await Navigator.of(context).pop();
    this.updateNavBarIndex(0);
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
