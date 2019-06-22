import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:swingo/src/theme/style.dart';
import 'package:swingo/src/pages/loading.dart';
import 'package:swingo/src/utils/routes.dart';

abstract class SwNetwork {
  static void showSnackBar(BuildContext context, String message) {
    Scaffold.of(context).showSnackBar(
      new SnackBar(
        backgroundColor: secondaryColor,
        content: new Text(message, style: TextStyle(color: primaryColor)),
      ),
    );
  }

  static void sendRequest(BuildContext context, requestFn, {onError, onSuccess}) async {
    final result = await Navigator.of(context).push(TransparentRoute(
      builder: (BuildContext context) => LoadingScreen(
        parentContext: context,
        requestFn: requestFn,
      ),
    ));

    print(result);

    if (result.statusCode != 200) {
      if(onError != null){
        onError();
      } else {
        SwNetwork.showSnackBar(context, 'Failed!');
      }
    } else {
      if(onSuccess != null){
        onSuccess();
      } else{
        SwNetwork.showSnackBar(context, 'Sucessful!');
      }
    }
  }
}
