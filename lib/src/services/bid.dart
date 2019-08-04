import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swingo/app_config.dart';
import 'package:swingo/src/classes/SwNetwork.dart';
import 'package:swingo/src/ankara/general.dart';
import 'package:swingo/src/models/bid.dart';

abstract class BidService extends SwNetwork {
  static listAll(BuildContext context,
      {onError, onSuccess}) async {
    final userProvider = Provider.of<UserStatus>(context);
    final String swBaseUrl = AppConfig.of(context).apiBaseUrl;
    final response = await SwNetwork.sendRequest(
        context,
        () => http.get(
              '$swBaseUrl/dashboard/',
              headers: {
                "Content-type": "application/json",
                "Authorization": 'Token ${userProvider.token}',
              },
            ));

    SwNetwork.handleResponse(context, response,
        onError: onError, onSuccess: onSuccess);
  }

  static createToSend(BuildContext context,
      {price, transporter, onError, onSuccess}) async {
    final userProvider = Provider.of<UserStatus>(context);
    final String swBaseUrl = AppConfig.of(context).apiBaseUrl;
    final response = await SwNetwork.sendRequest(
        context,
        () => http.post(
              '$swBaseUrl/bid/',
              headers: {
                "Content-type": "application/json",
                "Authorization": 'Token ${userProvider.token}',
              },
              body: Bid.toSenderJson(price, transporter),
            ));

    SwNetwork.handleResponse(context, response,
        onError: onError, onSuccess: onSuccess);
  }

  static createToCarry(BuildContext context,
      {transceiver, onError, onSuccess}) async {
    final userProvider = Provider.of<UserStatus>(context);
    final String swBaseUrl = AppConfig.of(context).apiBaseUrl;
    final response = await SwNetwork.sendRequest(
        context,
        () => http.post(
              '$swBaseUrl/bid/',
              headers: {
                "Content-type": "application/json",
                "Authorization": 'Token ${userProvider.token}',
              },
              body: Bid.toCarrierJson(transceiver),
            ));

    SwNetwork.handleResponse(context, response,
        onError: onError, onSuccess: onSuccess);
  }
}
