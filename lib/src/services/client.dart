import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:swingo/app_config.dart';
import 'package:swingo/src/user_status.dart';
import 'package:swingo/src/classes/SwNetwork.dart';

abstract class ClientService extends SwNetwork {
  static get(BuildContext context, {onError, onSuccess}) async {
    final String swBaseUrl = AppConfig.of(context).apiBaseUrl;
    final userProvider = Provider.of<UserStatus>(context);
    final response = await SwNetwork.sendRequest(
        context,
        () => http.get(
              '$swBaseUrl/client',
              headers: {
                "Content-type": "application/json",
                "Authorization": 'Token ${userProvider.token}',
              },
            ));

    SwNetwork.handleResponse(context, response,
        onError: onError, onSuccess: onSuccess);
  }

  static auth(BuildContext context, {token, onError, onSuccess}) async {
    final String swBaseUrl = AppConfig.of(context).apiBaseUrl;
    final response = await SwNetwork.sendRequest(
      context,
      () => http.get(
            '$swBaseUrl/client',
            headers: {
              "Content-type": "application/json",
              "Authorization": 'Token ${token}',
            },
          ),
      hideLoadingScreen: true,
    );

    SwNetwork.handleResponse(context, response,
        onError: onError, onSuccess: onSuccess);
  }
}
