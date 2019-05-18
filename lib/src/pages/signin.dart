import 'package:flutter/material.dart';
import 'package:swingo/src/components/components.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _username;
  String _password;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _submit() {}

  @override
  Widget build(BuildContext context) {
    final MediaQueryData screenSize = MediaQuery.of(context);
    return Scaffold(
        key: _scaffoldKey,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: ListView(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: screenSize.size.height / 50.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Text(
                              'Welcome Back',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline
                                  .copyWith(fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: screenSize.size.height / 8.0),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: SwTextField(
                              onChanged: (String value) {
                                _password = value;
                              },
                              textInputType: TextInputType.text,
                              obscureText: true,
                              labelText: 'Password',
                              errorText: 'Error'),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SwButton(
                          onPressed: null,
                          text: 'Login',
                        )
                      ],
                    ),
                    SizedBox(
                      height: screenSize.size.height / 8.0,
                    ),
                    SwHyperlink(
                      onTap: () {},
                      text: Text(
                        'I dont remember my password :)',
                        style: Theme.of(context)
                            .textTheme
                            .subtitle
                            .copyWith(fontWeight: FontWeight.w700),
                      ),
                    ),
                    const Divider(
                      indent: 5.0,
                      height: 5.0,
                      color: Colors.black38,
                    ),
                    SwHyperlink(
                      onTap: () {},
                      text: Text(
                        'No account yet? Crate one',
                        style: Theme.of(context)
                            .textTheme
                            .subtitle
                            .copyWith(fontWeight: FontWeight.w700),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
