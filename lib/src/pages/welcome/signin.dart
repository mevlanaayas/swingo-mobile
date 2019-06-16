import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:swingo/src/components/components.dart';
import 'package:swingo/src/theme/style.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  static const double _horizontalPadding = 33;

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  String username;
  String password;
  final FocusNode _usernameFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

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
    _fieldFocusChange(context, _usernameFocus, _passwordFocus);
    setState(() => this.username = username);
  }

  void _onPasswordEditingCompleted(String password) => setState(() => this.password = password);


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
          horizontal: SignInScreen._horizontalPadding
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
              prefixIcon: FontAwesomeIcons.unlock,
              labelText: 'Password',
              onEditingCompleted: _onPasswordEditingCompleted,
              obscureText: true,
              focusNode: _passwordFocus,
          ),
          SwButton(
            text: 'SIGN IN',
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
                top: MediaQuery.of(context).padding.top
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
