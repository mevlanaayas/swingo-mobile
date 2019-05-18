import 'package:flutter/material.dart';
import 'package:swingo/src/components/components.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> implements UserBlocListener {
  _LoginPageState() {
    loginBloc = UserBloc.hook('login', this);
  }

  UserBloc loginBloc;
  String _countryCode;
  String _mobile;
  String _password;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _submit() {
    loginBloc.doLoginUser(Credentials(_mobile, _countryCode, _password));
  }

  @override
  void dispose() {
    loginBloc.dispose();
    super.dispose();
  }

  @override
  void onSuccess(dynamic user) {
    showDialog<dynamic>(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text('Succesfully login'),
          actions: <Widget>[
            FlatButton(
              child: Text('continue'),
              onPressed: () {
                Navigator.of(context).pop();
                final RouterBloc _router = BlocProvider.of<RouterBloc>(context);
                _router.dispatch(PushHome(user));

                /*
                BlocProvider.of(context)
                    .changeRoute(RouteData(PAGES.HOME, user));
                    */
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void onError(dynamic err) {
    final SnackBar snackBar =
        SnackBar(content: Text('Error ${err.response.data.toString()}'));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    final UserCredentialsValidation validation = UserCredentialsValidation();
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: CountryCodePicker(
                            onChanged: (CountryCode code) {
                              _countryCode = code
                                  .toString()
                                  .substring(1); //exclude '+'  sing
                            },
                            initialSelection: 'TR',
                            favorite: ['+90', 'TR'],
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: StreamBuilder<String>(
                            stream: validation.mobile,
                            builder: (BuildContext context,
                                    AsyncSnapshot<String> snapshot) =>
                                PfTextField(
                                    onChanged: (String value) {
                                      _mobile = value;
                                      validation.mobileChanged(value);
                                    },
                                    textInputType: TextInputType.phone,
                                    obscureText: false,
                                    labelText: 'Phone',
                                    errorText: snapshot.error),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: StreamBuilder<String>(
                            stream: validation.password,
                            builder: (BuildContext context,
                                    AsyncSnapshot<String> snapshot) =>
                                PfTextField(
                                    onChanged: (String value) {
                                      _password = value;
                                      validation.passwordChanged(value);
                                    },
                                    textInputType: TextInputType.text,
                                    obscureText: true,
                                    labelText: 'Password',
                                    errorText: snapshot.error),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        StreamBuilder<bool>(
                            stream: validation.submitCheck,
                            builder: (BuildContext context,
                                AsyncSnapshot<bool> snapshot) {
                              return PfButton(
                                onPressed: snapshot.hasData ? _submit : null,
                                text: 'Login',
                              );
                            }),
                      ],
                    ),
                    SizedBox(
                      height: screenSize.size.height / 8.0,
                    ),
                    PfHyperlink(
                      onTap: () {
                        final RouterBloc _router =
                            BlocProvider.of<RouterBloc>(context);
                        _router.dispatch(PushForgotPassword());
                      },
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
                    PfHyperlink(
                      onTap: () {
                        final RouterBloc _router =
                            BlocProvider.of<RouterBloc>(context);
                        _router.dispatch(PushRegister());
                      },
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
