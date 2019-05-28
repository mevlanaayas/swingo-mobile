import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:swingo/src/theme/style.dart';
import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  static const double _horizontalPadding = 33;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints(minWidth: double.infinity),
        color: primaryColor,
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
                      FontAwesomeIcons.chevronLeft,
                      color: secondaryColor,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: _horizontalPadding),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: modalMaxWidth),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 41),
                        const Text(
                          'Swingo',
                          style: TextStyle(
                              fontFamily: 'RobotoCondensedBold',
                              fontSize: 30,
                              letterSpacing: 5),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          height: 2,
                          color: Colors.white.withOpacity(0.19),
                        ),
                        const SizedBox(height: 27),
                        Text(
                          'V 1.0',
                          style: buttonTextStyle.apply(
                              fontSizeDelta: -4,
                              color: Colors.white.withOpacity(0.5)),
                        ),
                        const SizedBox(height: 23),
                        Expanded(child: Container()),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: _horizontalPadding,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'DESIGNED BY',
                        style: TextStyle(
                            fontFamily: 'MontserratMedium', fontSize: 12),
                      ),
                      const SizedBox(height: 11),
                      Image.asset('assets/images/2dimensions.png'),
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
                                  color: Colors.white.withOpacity(0.85)),
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
