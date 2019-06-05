import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:swingo/src/theme/style.dart';

class DetailScreen extends StatelessWidget {
  final String item;

  DetailScreen({Key key, @required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use the Todo to create our UI
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints(minWidth: double.infinity),
        color: primaryColor50,
        child: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top,
            bottom: MediaQuery.of(context).padding.bottom + 33,
          ),
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: ButtonTheme(
                  minWidth: 0,
                  child: FlatButton(
                    splashColor: Colors.transparent,
                    padding: const EdgeInsets.all(0),
                    shape: null,
                    onPressed: () => Navigator.pop(context, null),
                    child: const Icon(
                      FontAwesomeIcons.times,
                      color: secondaryColor,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Expanded(child: Text(item)),
            ],
          ),
        ),
      ),
    );
  }
}
