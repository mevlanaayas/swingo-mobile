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

  void submit() {
    print("submitted");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints(minWidth: double.infinity),
        color: contentColor,
        child: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top,
            bottom: MediaQuery.of(context).padding.bottom + 33,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                      Icons.arrow_back,
                      color: secondaryColor,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: SignUpScreen._horizontalPadding),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: modalMaxWidth),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SwInputText(
                          faIcon: FontAwesomeIcons.user,
                          obscureText: false,
                        ),
                        const SizedBox(height: 12),
                        SwInputText(
                          faIcon: FontAwesomeIcons.userAlt,
                          obscureText: false,
                        ),
                        const SizedBox(height: 12),
                        SwInputText(
                          faIcon: FontAwesomeIcons.unlock,
                          obscureText: true,
                        ),
                        const SizedBox(height: 12),
                        SwInputText(
                          faIcon: FontAwesomeIcons.unlockAlt,
                          obscureText: true,
                        ),
                        const SizedBox(height: 23),
                        ConstrainedBox(
                          constraints:
                          const BoxConstraints(minWidth: double.infinity),
                          child: WelcomeButton(
                              onPressed: submit,
                              background: primaryColor,
                              icon: FontAwesomeIcons.signInAlt,
                              label: 'Register'),
                        ),
                        Expanded(child: Container()),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: SignUpScreen._horizontalPadding,
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
                                  fontSize: 26,
                                  color: primaryColor),
                            ),
                          )
                        ],
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
