import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:swingo/src/components/components.dart';
import 'package:swingo/src/classes/SwScreen.dart';
import 'package:swingo/src/services/authentication.dart';
import 'package:swingo/src/ankara/general.dart';
import 'package:swingo/src/theme/style.dart';

class SignInScreen extends StatefulWidget {
  static const double _horizontalPadding = 33;

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> with SwScreen {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _usernameFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  void _submit(BuildContext context) {
    AuthenticationService.signin(
      context,
      username: _usernameController.text,
      password: _passwordController.text,
      onSuccess: _onRequestSuccess(context),
    );
  }

  _onRequestSuccess(BuildContext context) {
    return (responseData) {
      final userProvider = Provider.of<UserStatus>(context);
      userProvider.signin(responseData['key']);
      Navigator.popUntil(context, (Route<dynamic> route) {
        bool shouldPop = false;
        if (route.settings.name != '/signin' &&
            route.settings.name != '/signup' &&
            route.settings.name != '/route') {
          shouldPop = true;
        }
        return shouldPop;
      });
    };
  }

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
              onEditingCompleted: () =>
                  this.changeFocus(context, _usernameFocus, _passwordFocus),
              focusNode: _usernameFocus,
              controller: _usernameController,
            ),
            SwFormField(
              prefixIcon: FontAwesomeIcons.unlock,
              labelText: 'Password',
              obscureText: true,
              focusNode: _passwordFocus,
              controller: _passwordController,
            ),
            SwButton(
              color: primaryColor,
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
