import 'package:flutter/material.dart';
import 'package:swingo/src/components/components.dart';
import 'package:url_launcher/url_launcher.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String _username;
  String _password;
  bool _confirm = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _submit() {}

  @override
  Widget build(BuildContext context) {
    final MediaQueryData screenSize = MediaQuery.of(context);
    return Scaffold(
        key: _scaffoldKey,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.0),
            child: ListView(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: screenSize.size.height / 50.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Create new account',
                          style: Theme.of(context)
                              .textTheme
                              .headline
                              .copyWith(fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    SizedBox(height: screenSize.size.height / 8.0),
                    const SizedBox(
                      height: 15.0,
                    ),
                    PfTextField(
                        onChanged: (String value) {
                          _password = value;
                        },
                        textInputType: TextInputType.text,
                        obscureText: true,
                        labelText: 'Password',
                        errorText: 'Error'),
                    Row(
                      children: <Widget>[
                        PfCheckbox(
                            value: _confirm,
                            onChanged: (bool value) {
                              setState(() {
                                _confirm = value;
                              });
                            }),
                        PfHyperlink(
                          onTap: () => launch('https://goswingo.com/'),
                          text: Text('Accept terms'),
                        )
                      ],
                    ),
                    PfButton(
                      onPressed: null,
                      text: 'Register',
                    ),
                    SizedBox(
                      height: screenSize.size.height / 7.0,
                    ),
                    const Divider(
                      indent: 5.0,
                      height: 5.0,
                      color: Colors.black38,
                    ),
                    PfHyperlink(
                      onTap: () {},
                      text: Text(
                        'Already a member? Login',
                        style: Theme.of(context)
                            .textTheme
                            .subtitle
                            .copyWith(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
