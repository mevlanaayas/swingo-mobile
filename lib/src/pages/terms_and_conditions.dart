import 'dart:async';

import 'package:flutter/material.dart';
import 'package:swingo/src/classes/SwScreen.dart';
import 'package:swingo/src/components/sw_button.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TermsAndConditionsPage extends StatelessWidget with SwScreen {
  Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: this.buildAppbar(context, title: 'Terms And Conditions'),
      body: WebView(
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl: 'https://goswingo.com/mobile-terms',
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
      ),
      floatingActionButton: SwIconButton(
        onPressed: (){
          bool isAccepted = true;
          Navigator.of(context).pop(isAccepted);
        },
        icon: Icons.check,
      ),
    );
  }
}