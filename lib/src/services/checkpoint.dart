import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:swingo/app_config.dart';
import 'package:swingo/src/ankara/general.dart';
import 'package:swingo/src/classes/SwNetwork.dart';

abstract class CheckpointService extends SwNetwork {
  static callFunction(BuildContext context,
      {onError, onSuccess, matchId, url}) async {
    final String swBaseUrl = AppConfig.of(context).apiBaseUrl;
    final userProvider = Provider.of<UserStatus>(context);
    final response = await SwNetwork.sendRequest(
        context,
        () => http.get(
              '$swBaseUrl/match/$matchId/$url/',
              headers: {
                "Content-type": "application/json",
                "Authorization": 'Token ${userProvider.token}',
              },
            ));

    SwNetwork.handleResponse(context, response,
        onError: onError, onSuccess: onSuccess);
  }

  static callFunctionWithParams(BuildContext context,
      {onError, onSuccess, matchId, url}) async {
    final String swBaseUrl = AppConfig.of(context).apiBaseUrl;
    final userProvider = Provider.of<UserStatus>(context);
    final response = await SwNetwork.sendRequest(
        context,
        () => http.get(
              '$swBaseUrl/match/$matchId/$url/',
              headers: {
                "Content-type": "application/json",
                "Authorization": 'Token ${userProvider.token}',
              },
            ));

    SwNetwork.handleResponse(context, response,
        onError: onError, onSuccess: onSuccess);
  }

  static get(BuildContext context,
      {onError, onSuccess, matchId, url}) async {
    final String swBaseUrl = AppConfig.of(context).apiBaseUrl;
    final userProvider = Provider.of<UserStatus>(context);
    final response = await SwNetwork.sendRequest(
        context,
        () => http.get(
              '$swBaseUrl/match/$matchId/',
              headers: {
                "Content-type": "application/json",
                "Authorization": 'Token ${userProvider.token}',
              },
            ));

    SwNetwork.handleResponse(context, response,
        onError: onError, onSuccess: onSuccess);
  }
}
