import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:swingo/src/components/components.dart';
import 'package:swingo/src/services/authentication.dart';
import 'package:swingo/src/classes/SwScreen.dart';
import 'package:swingo/src/theme/style.dart';

class SignUpScreen extends StatefulWidget {
  static const double _horizontalPadding = 25;

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> with SwScreen {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final FocusNode _usernameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _passwordConfirmFocus = FocusNode();

  void _submit(BuildContext context) {
    AuthenticationService.signup(context,
        username: _usernameController.text,
        email: _emailController.text,
        password: _passwordController.text,
        confirmPassword: _confirmPasswordController.text,
        onSuccess: _onRequestSuccess(context));
  }

  _onRequestSuccess(BuildContext context) {
    return (response) => Navigator.of(context).pushNamed('/signin');
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: SignUpScreen._horizontalPadding),
          child: Wrap(
            runSpacing: 20,
            //todo: signin, signup, create order genel bi form yapısı içine taşıyabiliriz
            children: [
              SwFormField(
                prefixIcon: FontAwesomeIcons.user,
                labelText: 'Username',
                onEditingCompleted: () =>
                    this.changeFocus(context, _usernameFocus, _emailFocus),
                focusNode: _usernameFocus,
                controller: _usernameController,
              ),
              SwFormField(
                prefixIcon: FontAwesomeIcons.envelopeOpen,
                labelText: 'Email',
                onEditingCompleted: () =>
                    this.changeFocus(context, _emailFocus, _passwordFocus),
                focusNode: _emailFocus,
                controller: _emailController,
              ),
              SwFormField(
                prefixIcon: FontAwesomeIcons.unlock,
                labelText: 'Password',
                onEditingCompleted: () => this.changeFocus(
                    context, _passwordFocus, _passwordConfirmFocus),
                obscureText: true,
                focusNode: _passwordFocus,
                controller: _passwordController,
              ),
              SwFormField(
                prefixIcon: FontAwesomeIcons.unlockAlt,
                labelText: 'Confirm Password',
                onEditingCompleted: () =>
                    this.changeFocus(context, _passwordConfirmFocus, null),
                obscureText: true,
                focusNode: _passwordConfirmFocus,
                controller: _confirmPasswordController,
              ),
              SwButton(
                color: primaryColor,
                text: 'SIGN UP',
                onPressed: () => _submit(context),
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
        appBar: this.buildAppbar(context),
        body: new Builder(
            builder: (BuildContext scaffoldContext) => _buildBody(
                  scaffoldContext,
                )),
      ),
    );
  }
}
