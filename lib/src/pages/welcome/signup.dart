import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:swingo/src/pages/terms_and_conditions.dart';
import 'package:swingo/src/utils/sliders.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:swingo/src/components/components.dart';
import 'package:swingo/src/services/authentication.dart';
import 'package:swingo/src/classes/SwScreen.dart';
import 'package:swingo/src/theme/style.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> with SwScreen {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _acceptTermsAndConditions = false;

  final FocusNode _usernameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _passwordConfirmFocus = FocusNode();

  void _submit(BuildContext context) {
    if (_usernameController.text == '' ||
        _emailController.text == '' ||
        _passwordController.text == '' ||
        _confirmPasswordController.text == '') {
      SwScreen.showSnackBar(context, "Please fill all fields.");
      return;
    }
    if(_acceptTermsAndConditions == false){
      SwScreen.showSnackBar(context, "Please accept terms and conditions.");
      return;
    }
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

  Widget _buildTermsAndConditionsRow() {
    return Row(
      children: <Widget>[
        Checkbox(
          activeColor: secondaryColor,
          value: _acceptTermsAndConditions,
          onChanged: (bool value) {
            setState(() {
              _acceptTermsAndConditions = value;
            });
          },
        ),
        new RichText(
            text: new TextSpan(
          children: [
            new TextSpan(
              text: 'I agree to the ',
              style: blackContentStyle,
            ),
            new TextSpan(
              text: 'terms and conditions',
              style: linkTextStyleStyle,
              recognizer: new TapGestureRecognizer()
                ..onTap = () async {
                  final isAccepted = await Navigator.of(context).push(
                    SlideRightRoute(
                      page: TermsAndConditionsPage(),
                    ),
                  );
                  if (isAccepted != null && isAccepted == true) {
                    setState(() {
                      _acceptTermsAndConditions = true;
                    });
                  }
                },
            ),
          ],
        )),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
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
              _buildTermsAndConditionsRow(),
              SwButton(
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
        appBar: this.buildAppbar(
          context,
          title: 'Register',
        ),
        body: new Builder(
            builder: (BuildContext scaffoldContext) => _buildBody(
                  scaffoldContext,
                )),
      ),
    );
  }
}
