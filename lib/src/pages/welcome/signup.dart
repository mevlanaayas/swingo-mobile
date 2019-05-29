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
                          horizontal: SignUpScreen._horizontalPadding),
                      child: ConstrainedBox(
                        constraints:
                            const BoxConstraints(maxWidth: modalMaxWidth),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SwInputText(
                              onFieldSubmitted: (term) {
                                _fieldFocusChange(
                                    context, _usernameFocus, _emailFocus);
                              },
                              focusNode: _usernameFocus,
                              textInputAction: TextInputAction.next,
                              autoFocus: true,
                              hintText: "Username",
                              faIcon: FontAwesomeIcons.user,
                              obscureText: false,
                            ),
                            const SizedBox(height: 12),
                            SwInputText(
                              onFieldSubmitted: (term) {
                                _fieldFocusChange(
                                    context, _emailFocus, _passwordFocus);
                              },
                              focusNode: _emailFocus,
                              textInputAction: TextInputAction.next,
                              autoFocus: false,
                              hintText: "Email",
                              faIcon: FontAwesomeIcons.envelopeOpen,
                              obscureText: false,
                            ),
                            const SizedBox(height: 12),
                            SwInputText(
                              onFieldSubmitted: (term) {
                                _fieldFocusChange(context, _passwordFocus,
                                    _passwordConfirmFocus);
                              },
                              focusNode: _passwordFocus,
                              textInputAction: TextInputAction.next,
                              autoFocus: false,
                              hintText: "Password",
                              faIcon: FontAwesomeIcons.unlock,
                              obscureText: true,
                            ),
                            const SizedBox(height: 12),
                            SwInputText(
                              onFieldSubmitted: (term) {
                                _fieldFocusChange(
                                    context, _passwordConfirmFocus, null);
                              },
                              focusNode: _passwordConfirmFocus,
                              textInputAction: TextInputAction.done,
                              autoFocus: false,
                              hintText: "Password",
                              faIcon: FontAwesomeIcons.unlockAlt,
                              obscureText: true,
                            ),
                            const SizedBox(height: 60),
                            /*
                            const SizedBox(height: 23),
                            ConstrainedBox(
                              constraints: const BoxConstraints(
                                  minWidth: double.infinity),
                              child: WelcomeButton(
                                  onPressed: _submit,
                                  background: primaryColor,
                                  icon: FontAwesomeIcons.signInAlt,
                                  label: 'Sign Up'),
                            ),
                            */
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(0),
                color: primaryColor,
                height: MediaQuery.of(context).size.height / 7,
                width: MediaQuery.of(context).size.width,
                child: WelcomeButton(
                    onPressed: _submit,
                    background: primaryColor,
                    icon: FontAwesomeIcons.signInAlt,
                    label: 'Sign Up'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
