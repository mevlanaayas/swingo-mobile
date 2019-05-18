import 'package:flutter/material.dart';
import 'package:swingo/src/components/sw_button.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final MediaQueryData screenSize = MediaQuery.of(context);
    return Scaffold(
        key: _scaffoldKey,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: screenSize.size.height / 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Image.asset('assets/2.0x/wallet.png'),
                      const SizedBox(height: 16.0),
                      Text(
                        'Swingo',
                        style: Theme.of(context)
                            .textTheme
                            .headline
                            .copyWith(fontWeight: FontWeight.w700),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: screenSize.size.height / 2.5,
              ),
              IntrinsicWidth(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    PfButton(
                      text: 'Login',
                      onPressed: () {

                      },
                    ),
                    PfButton(
                      text: 'Register',
                      onPressed: () {

                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
