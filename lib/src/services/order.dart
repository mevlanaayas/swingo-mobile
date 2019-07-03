import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swingo/app_config.dart';
import 'package:swingo/src/ankara/general.dart';
import 'package:swingo/src/classes/SwNetwork.dart';
import 'package:swingo/src/models/order.dart';

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

  static Future<http.Response> createSender(BuildContext context,
      {from_city,
      from_date,
      to_city,
      to_date,
      price,
      size,
      weight,
      comments,
      onError,
      onSuccess}) async {
    final userProvider = Provider.of<UserStatus>(context);
    final String swBaseUrl = AppConfig.of(context).apiBaseUrl;
    final response = await SwNetwork.sendRequest(
      context,
      () => http.post('${swBaseUrl}/transceiver_order/',
          headers: {
            "Content-type": "application/json",
            "Authorization": 'Token ${userProvider.token}'
          },
          body: Order.toJson(from_city, from_date, to_city, to_date, price,
              size, weight, comments)),
    );

    SwNetwork.handleResponse(context, response,
        onError: onError, onSuccess: onSuccess);
  }

  static Future<http.Response> createCarrier(BuildContext context,
      {from_city,
        from_date,
        to_city,
        to_date,
        size,
        weight,
        comments,
        onError,
        onSuccess}) async {
    final userProvider = Provider.of<UserStatus>(context);
    final String swBaseUrl = AppConfig.of(context).apiBaseUrl;
    final response = await SwNetwork.sendRequest(
      context,
          () => http.post('${swBaseUrl}/transceiver_order/',
          headers: {
            "Content-type": "application/json",
            "Authorization": 'Token ${userProvider.token}'
          },
          body: Order.toJson(from_city, from_date, to_city, to_date, null,
              size, weight, comments)),
    );

    SwNetwork.handleResponse(context, response,
        onError: onError, onSuccess: onSuccess);
  }
}
