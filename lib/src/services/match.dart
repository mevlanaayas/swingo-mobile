import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swingo/src/classes/SwNetwork.dart';
import 'package:swingo/src/ankara/general.dart';

const swBaseUrl = 'https://www.goswingo.com/swingo';

abstract class MatchService extends SwNetwork {
  static Future<http.Response> listAll(BuildContext context,
      {onError, onSuccess}) async {
    final userProvider = Provider.of<UserStatus>(context);
    final response = await SwNetwork.sendRequest(
        context,
        () => http.get(
              '$swBaseUrl/dashboard',
              headers: {
                "Content-type": "application/json",
                "Authorization": 'Token ${userProvider.token}',
              },
            ));

    SwNetwork.handleResponse(context, response,
        onError: onError, onSuccess: onSuccess);
  }
}
