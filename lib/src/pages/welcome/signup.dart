import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:swingo/src/components/components.dart';
import 'package:swingo/src/services/authentication.dart';
import 'package:swingo/src/classes/SwScreen.dart';

class SignUpScreen extends StatefulWidget {
  static const double _horizontalPadding = 25;

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> with SwScreen {
  String username;
  String email;
  String password;
  String confirmPassword;

  final FocusNode _usernameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _passwordConfirmFocus = FocusNode();

  void _submit(BuildContext context) {
    AuthenticationService.signup(
        context,
        username: username,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
        onSuccess: () => _onRequestSuccess(context)
    );
  }

   _onRequestSuccess(BuildContext context){
    return (result) => Navigator.of(context).pushNamed('/signin');
  }

  void _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    if (nextFocus == null) {
      //_submit(); //fixme: sonradan değişiklik yapmak isteyebilir diye commente alındı.silinsin mi kalsın mı?
      FocusScope.of(context).requestFocus(currentFocus);
    } else {
      currentFocus.unfocus();
      FocusScope.of(context).requestFocus(nextFocus);
    }
    ;
  }

  void _onUsernameEditingCompleted(String username) {
    _fieldFocusChange(context, _usernameFocus, _emailFocus);
    setState(() => this.username = username);
  }

  void _onEmailEditingCompleted(String email) {
    _fieldFocusChange(context, _emailFocus, _passwordFocus);
    setState(() => this.email = email);
  }

  void _onPasswordEditingCompleted(String password) {
    _fieldFocusChange(context, _passwordFocus, _passwordConfirmFocus);
    setState(() => this.password = password);
  }

  void _onConfirmPasswordEditingCompleted(String confirmPassword) {
    _fieldFocusChange(context, _passwordConfirmFocus, null);
    setState(() => this.confirmPassword = confirmPassword);
  }

  Widget _buildBody(BuildContext context) {
    return Align(
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
              onEditingCompleted: _onUsernameEditingCompleted,
              focusNode: _usernameFocus,
            ),
            SwFormField(
              prefixIcon: FontAwesomeIcons.envelopeOpen,
              labelText: 'Email',
              onEditingCompleted: _onEmailEditingCompleted,
              focusNode: _emailFocus,
            ),
            SwFormField(
              prefixIcon: FontAwesomeIcons.unlock,
              labelText: 'Password',
              onEditingCompleted: _onPasswordEditingCompleted,
              obscureText: true,
              focusNode: _passwordFocus,
            ),
            SwFormField(
              prefixIcon: FontAwesomeIcons.unlockAlt,
              labelText: 'Confirm Password',
              onEditingCompleted: _onConfirmPasswordEditingCompleted,
              obscureText: true,
              focusNode: _passwordConfirmFocus,
            ),
            SwButton(
              text: 'SIGN UP',
              onPressed: () => _submit(context),
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
