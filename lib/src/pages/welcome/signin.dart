import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:swingo/src/components/components.dart';
import 'package:swingo/src/classes/SwScreen.dart';
import 'package:swingo/src/services/authentication.dart';
import 'package:swingo/src/user_status.dart';
import 'package:swingo/src/services/client.dart';
import 'package:swingo/src/theme/style.dart';

class SignInScreen extends StatefulWidget {
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
      onSuccess: _onSingInRequestSuccess(context),
    );
  }

  _onSingInRequestSuccess(BuildContext context) {
    return (responseData) {
      final userProvider = Provider.of<UserStatus>(context);
      userProvider.signin(responseData['access']);
      ClientService.get(
        context,
        onSuccess: _onGetClientSuccess(context),
        onError: _onGetClientRequestFailed(context),
      );
    };
  }

  _onGetClientSuccess(BuildContext context) {
    return (responseData) {
      final userProvider = Provider.of<UserStatus>(context);
      final user = responseData['results'][0];
      final int userId = user['id'];
      final String username = user['username'];
      userProvider.auth(userId, username);
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

  _onGetClientRequestFailed(BuildContext context) {
    return (responseData) {
      final userProvider = Provider.of<UserStatus>(context);
      userProvider.signout();
    };
  }

  Widget _buildBody(BuildContext scaffoldContext) {
    return SingleChildScrollView(
      child: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: formPadding,
          child: Wrap(
            runSpacing: formSpacing,
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SwPage(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: this.buildAppbar(
          context,
          title: 'Sign In',
        ),
        body: new Builder(
            builder: (BuildContext scaffoldContext) => _buildBody(
                  scaffoldContext,
                )),
      ),
    );
  }
}
