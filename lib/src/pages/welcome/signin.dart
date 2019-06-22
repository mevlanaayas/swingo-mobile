import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:swingo/src/components/components.dart';
import 'package:swingo/src/classes/SwScreen.dart';
import 'package:swingo/src/services/authentication.dart';

class SignInScreen extends StatefulWidget {
  static const double _horizontalPadding = 33;

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> with SwScreen {
  String username;
  String password;
  final FocusNode _usernameFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  void _submit(BuildContext context) {
    AuthenticationService.signin(
      context,
      username: username,
      password: password,
      onSuccess: _onRequestSuccess(context),
    );
  }

  _onRequestSuccess(BuildContext context) {
    return (response) => Navigator.popUntil(context, (Route<dynamic> route) {
          bool shouldPop = false;
          if (route.settings.name != '/signin' &&
              route.settings.name != '/signup' &&
              route.settings.name != '/route') {
            shouldPop = true;
          }
          return shouldPop;
        });
  }

  void _onUsernameEditingCompleted(String username) {
    this.changeFocus(context, _usernameFocus, _passwordFocus);
    setState(() => this.username = username);
  }

  void _onPasswordEditingCompleted(String password) =>
      setState(() => this.password = password);

  Widget _buildBody(BuildContext scaffoldContext) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: SignInScreen._horizontalPadding),
        child: Wrap(
          runSpacing: 20,
          //todo: signin, signup, create order genel bi form yapısı içine taşıyabiliriz
          children: [
            SwFormField(
              prefixIcon: FontAwesomeIcons.user,
              labelText: 'Username',
              onEditingCompleted: _onUsernameEditingCompleted,
              focusNode: _usernameFocus,
            ),
            SwFormField(
              prefixIcon: FontAwesomeIcons.unlock,
              labelText: 'Password',
              onEditingCompleted: _onPasswordEditingCompleted,
              obscureText: true,
              focusNode: _passwordFocus,
            ),
            SwButton(
              text: 'SIGN IN',
              onPressed: () => _submit(scaffoldContext),
              fillParent: true,
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SwPage(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: this.buildAppbar(context),
        body: new Builder(
            builder: (BuildContext scaffoldContext) => _buildBody(
                  scaffoldContext,
                )),
      ),
    );
  }
}
