import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:swingo/src/pages/loading.dart';
import 'package:swingo/src/utils/routes.dart';
import 'package:swingo/src/classes/SwScreen.dart';

abstract class SwNetwork {
  static sendRequest(BuildContext context, requestFn) async {
    final response = await Navigator.of(context).push(TransparentRoute(
      builder: (BuildContext context) => LoadingScreen(
            parentContext: context,
            requestFn: requestFn,
          ),
    ));

    return response;
  }

  static handleResponse(BuildContext context, response, {onError, onSuccess}){
    if (response.statusCode != 200) {
      if (onError != null) {
        print(response.body);
        onError(json.decode(response.body));
      } else {
        SwScreen.showSnackBar(context, 'Failed!');
      }
    } else {
      if (onSuccess != null) {
        print(response.body);
        onSuccess(json.decode(response.body));
      } else {
        SwScreen.showSnackBar(context, 'Sucessful!');
      }
    }
  }
}
