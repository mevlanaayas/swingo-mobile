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
        child: Stack(children: [
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
                    child: ConstrainedBox(
                      constraints:
                          const BoxConstraints(maxWidth: modalMaxWidth),
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
                          // following container behaves like divider
                          Container(
                            height: 2,
                            color: Colors.white.withOpacity(0.19),
                          ),
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
                          const SizedBox(height: 60),
                          /*
                          ConstrainedBox(
                            constraints:
                                const BoxConstraints(minWidth: double.infinity),
                            child: WelcomeButton(
                                onPressed: _submit,
                                background: primaryColor,
                                icon: FontAwesomeIcons.signInAlt,
                                label: 'Sign In'),
                          ),
                         
                           */
                        ],
                      ),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: SignInScreen._horizontalPadding,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'DESIGNED BY',
                            style: TextStyle(
                                fontFamily: 'MontserratMedium', fontSize: 12),
                          ),
                          const SizedBox(height: 11),
                          Image.asset('assets/images/flare_logo.png'),
                          const SizedBox(height: 32),
                          const Text(
                            'BUILT WITH',
                            style: TextStyle(
                                fontFamily: 'MontserratMedium', fontSize: 12),
                          ),
                          const SizedBox(height: 11),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/flutter_logo.png',
                                  height: 45, width: 37),
                              Container(
                                margin: const EdgeInsets.only(left: 5),
                                child: Text(
                                  'Flutter',
                                  style: TextStyle(
                                      fontSize: 26, color: primaryColor),
                                ),
                              )
                            ],
                          )
                        ],
                      ))
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
                  label: 'Sign In'),
            ),
          )
        ]),
      ),
    );
  }
}
