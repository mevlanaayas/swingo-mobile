import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:swingo/src/classes/SwNetwork.dart';

const swBaseUrl = 'https://www.goswingo.com/swingo';

abstract class OrderService extends SwNetwork {
  static Future<http.Response> listSenders(BuildContext context,
      {int page, onError, onSuccess}) async {
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
