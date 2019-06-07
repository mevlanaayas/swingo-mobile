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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints(minWidth: double.infinity),
        color: contentColor,
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top,
                bottom: MediaQuery.of(context).padding.bottom + 33,
              ),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
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
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: SignInScreen._horizontalPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SwInputText(
                            onFieldSubmitted: (term) {
                              _fieldFocusChange(
                                  context, _usernameFocus, _passwordFocus);
                            },
                            focusNode: _usernameFocus,
                            textInputAction: TextInputAction.next,
                            autoFocus: true,
                            hintText: "Username",
                            obscureText: false,
                          ),
                          const SizedBox(height: 12),
                          SwInputText(
                            onFieldSubmitted: (term) {
                              _fieldFocusChange(context, _passwordFocus, null);
                            },
                            focusNode: _passwordFocus,
                            textInputAction: TextInputAction.next,
                            autoFocus: true,
                            hintText: "Password",
                            obscureText: false,
                          ),
                          const SizedBox(height: 12),
                          WelcomeButton(
                              onPressed: _submit,
                              background: primaryColor,
                              icon: FontAwesomeIcons.signInAlt,
                              label: 'Sign In'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
