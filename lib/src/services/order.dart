import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swingo/app_config.dart';
import 'package:swingo/src/ankara/general.dart';
import 'package:swingo/src/classes/SwNetwork.dart';

abstract class OrderService extends SwNetwork {
  static Future<http.Response> listAll(BuildContext context,
      {int page, onError, onSuccess}) async {
    final userProvider = Provider.of<UserStatus>(context);
    final String swBaseUrl = AppConfig.of(context).apiBaseUrl;
    final response = await SwNetwork.sendRequest(
        context,
        () => http.get(
              '$swBaseUrl/dashboard/',
              headers: {
                "Content-type": "application/json",
                "Authorization": 'Token ${userProvider.token}'
              },
            ));

    SwNetwork.handleResponse(context, response,
        onError: onError, onSuccess: onSuccess);
  }

  static Future<http.Response> listSenders(BuildContext context,
      {int page, onError, onSuccess}) async {
    final String swBaseUrl = AppConfig.of(context).apiBaseUrl;
    final response = await SwNetwork.sendRequest(
        context,
        () => http.get(
              '$swBaseUrl/transceiver_order/?page=$page',
              headers: {"Content-type": "application/json"},
            ));

    SwNetwork.handleResponse(context, response,
        onError: onError, onSuccess: onSuccess);
  }

  static Future<http.Response> listCarriers(BuildContext context,
      {int page, onError, onSuccess}) async {
    final String swBaseUrl = AppConfig.of(context).apiBaseUrl;
    final response = await SwNetwork.sendRequest(
      context,
      () => http.get(
            '${swBaseUrl}/transporter_order/?page=$page',
            headers: {"Content-type": "application/json"},
          ),
    );

    SwNetwork.handleResponse(context, response,
        onError: onError, onSuccess: onSuccess);
  }
}
