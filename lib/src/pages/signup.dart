import 'package:flutter/material.dart';
import 'package:swingo/src/components/components.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>
    implements UserBlocListener {
  _RegisterPageState() {
    registerBloc = UserBloc.hook('register', this);
  }

  UserBloc registerBloc;
  String _countryCode;
  String _mobile;
  String _password;
  bool _confirm = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void onSuccess(dynamic event) {
    showDialog<dynamic>(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text('Verify Otp'),
          actions: <Widget>[
            FlatButton(
              child: Text('continue'),
              onPressed: () {
                Navigator.of(context).pop();

                final RouterBloc _router = BlocProvider.of<RouterBloc>(context);
                _router.dispatch(PushOtp(event));
                /*
                MyBlocProvider.of(context)
                    .changeRoute(RouteData(PAGES.OTP, event));
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
        SnackBar(content: Text('Error ${err.response.toString()}'));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  void _submit() {
    registerBloc.doRegisterUser(Credentials(_mobile, _countryCode, _password));
  }

  @override
  void dispose() {
    registerBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final UserCredentialsValidation validation = UserCredentialsValidation();
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
                    Row(
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
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    StreamBuilder<String>(
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
                          onTap: () => launch('http://finartz.com/'),
                          text: Text('Accept terms'),
                        )
                      ],
                    ),
                    StreamBuilder<bool>(
                        stream: validation.submitCheck,
                        builder: (BuildContext context,
                            AsyncSnapshot<bool> snapshot) {
                          return PfButton(
                            onPressed:
                                (snapshot.hasData && _confirm) ? _submit : null,
                            text: 'Register',
                          );
                        }),
                    SizedBox(
                      height: screenSize.size.height / 7.0,
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
                        _router.dispatch(PushLogin());
                      },
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
        )
        /*
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: ListView(
              children: <Widget>[
                const SizedBox(height: 60.0),
                Center(
                  child: Text(
                    'Create new account',
                    style: Theme.of(context)
                        .textTheme
                        .headline
                        .copyWith(fontWeight: FontWeight.w700),
                  ),
                ),
                const SizedBox(height: 30.0),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
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
                      Row(
                        children: <Widget>[
                          Checkbox(
                              value: _confirm,
                              onChanged: (bool value) {
                                setState(() {
                                  _confirm = value;
                                });
                              }),
                          GestureDetector(
                              onTap: () {
                                launch('http://finartz.com/');
                              },
                              child: Text('I understand')),
                        ],
                      ),
                    ]),
                SizedBox(
                  height: 45.0,
                  child: StreamBuilder<bool>(
                      stream: validation.submitCheck,
                      builder:
                          (BuildContext context, AsyncSnapshot<bool> snapshot) {
                        return PfButton(
                          onPressed:
                              (snapshot.hasData && _confirm) ? _submit : null,
                          text: 'Register',
                        );
                      }),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Divider(
                  color: Colors.black38,
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    alignment: Alignment.center,
                    child: PfHyperlink(
                      onTap: () {

                        final RouterBloc _router =
                            BlocProvider.of<RouterBloc>(context);
                        _router.dispatch(PushLogin());

                        },
                      text: Text(
                        'Already a member? Login',
                        style: Theme.of(context)
                            .textTheme
                            .subtitle
                            .copyWith(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          */
        );
  }
}
