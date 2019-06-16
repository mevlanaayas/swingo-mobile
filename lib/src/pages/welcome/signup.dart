import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:swingo/src/components/components.dart';
import 'package:swingo/src/theme/style.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  static const double _horizontalPadding = 25;

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String username;
  String email;
  String password;
  String confirmPassWord;

  final FocusNode _usernameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _passwordConfirmFocus = FocusNode();

  void _submit() {
    print("submitted");
  }

  void _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    if (nextFocus == null) {
      _submit();
      FocusScope.of(context).requestFocus(currentFocus);
    } else {
      currentFocus.unfocus();
      FocusScope.of(context).requestFocus(nextFocus);
    }
    ;
  }

  void _onUsernameEditingCompleted(String username){
    _fieldFocusChange(context, _usernameFocus, _emailFocus);
    setState(() => this.username = username);
  }

  void _onEmailEditingCompleted(String email){
    _fieldFocusChange(context, _emailFocus, _passwordFocus);
    setState(() => this.email = email);
  }

  void _onPasswordEditingCompleted(String password){
    _fieldFocusChange(context, _passwordFocus, _passwordConfirmFocus);
    setState(() => this.password = password);
  }

  void _onConfirmPasswordEditingCompleted(String confirmPassWord){
    _fieldFocusChange(context, _passwordConfirmFocus, null);
    setState(() => this.confirmPassWord = confirmPassWord);
  }

  Widget _buildAppBar(){
    return Align(
      alignment: Alignment.topLeft,
      child: ButtonTheme(
        minWidth: 0,
        child: FlatButton(
          padding: const EdgeInsets.all(0),
          shape: null,
          onPressed: () => Navigator.pop(context, null),
          child: const Icon(
            FontAwesomeIcons.chevronLeft,
            color: secondaryColor,
          ),
        ),
      ),
    );
  }

  Widget _buildBody(){
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: SignUpScreen._horizontalPadding
      ),
      child: Wrap(
        runSpacing: 20, //todo: signin, signup, create order genel bi form yapısı içine taşıyabiliriz
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
            onPressed: _submit,
            fillParent: true,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SwPage(
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top,
            ),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildAppBar(),
                  SizedBox(height: 10),
                  _buildBody()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
