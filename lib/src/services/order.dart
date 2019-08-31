import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swingo/app_config.dart';
import 'package:swingo/src/ankara/general.dart';
import 'package:swingo/src/classes/SwNetwork.dart';
import 'package:swingo/src/models/order.dart';

abstract class OrderService extends SwNetwork {
  static listMySendOrders(BuildContext context,
      {int page, onError, onSuccess}) async {
    final userProvider = Provider.of<UserStatus>(context);
    final String swBaseUrl = AppConfig.of(context).apiBaseUrl;
    final response = await SwNetwork.sendRequest(
        context,
        () => http.get(
              '$swBaseUrl/my_orders/send',
              headers: {
                "Content-type": "application/json",
                "Authorization": 'Token ${userProvider.token}'
              },
            ));

    SwNetwork.handleResponse(context, response,
        onError: onError, onSuccess: onSuccess);
  }

  static listMyCarryOrders(BuildContext context,
      {int page, onError, onSuccess}) async {
    final userProvider = Provider.of<UserStatus>(context);
    final String swBaseUrl = AppConfig.of(context).apiBaseUrl;
    final response = await SwNetwork.sendRequest(
        context,
            () => http.get(
          '$swBaseUrl/my_orders/carry',
          headers: {
            "Content-type": "application/json",
            "Authorization": 'Token ${userProvider.token}'
          },
        ));

    SwNetwork.handleResponse(context, response,
        onError: onError, onSuccess: onSuccess);
  }

  static listSenders(BuildContext context,
      {int page, onError, onSuccess}) async {
    final String swBaseUrl = AppConfig.of(context).apiBaseUrl;
    final response = await SwNetwork.sendRequest(
        context,
        () => http.get(
              '$swBaseUrl/orders/send/?page=$page',
              headers: {"Content-type": "application/json"},
            ));

    SwNetwork.handleResponse(context, response,
        onError: onError, onSuccess: onSuccess);
  }

  static listCarriers(BuildContext context,
      {int page, onError, onSuccess}) async {
    final String swBaseUrl = AppConfig.of(context).apiBaseUrl;
    final response = await SwNetwork.sendRequest(
      context,
      () => http.get(
            '${swBaseUrl}/orders/carry/?page=$page',
            headers: {"Content-type": "application/json"},
          ),
    );

    SwNetwork.handleResponse(context, response,
        onError: onError, onSuccess: onSuccess);
  }

  static createSender(BuildContext context,
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
      () => http.post('${swBaseUrl}/orders/send/',
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

  static createCarrier(BuildContext context,
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
          () => http.post('${swBaseUrl}/orders/carry/',
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
