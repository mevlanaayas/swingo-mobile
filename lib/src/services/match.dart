import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swingo/app_config.dart';
import 'package:swingo/src/classes/SwNetwork.dart';
import 'package:swingo/src/user_status.dart';
import 'package:swingo/src/models/match.dart';

abstract class MatchService extends SwNetwork {
  static listAll(BuildContext context,
      {onError, onSuccess}) async {
    final userProvider = Provider.of<UserStatus>(context);
    final String swBaseUrl = AppConfig.of(context).apiBaseUrl;
    final response = await SwNetwork.sendRequest(
        context,
        () => http.get(
              '$swBaseUrl/match/',
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
          '$swBaseUrl/match/',
          headers: {
            "Content-type": "application/json",
            "Authorization": 'Token ${userProvider.token}',
          },
          body: SwMatch.toSenderJson(price, transporter),
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
          '$swBaseUrl/match/',
          headers: {
            "Content-type": "application/json",
            "Authorization": 'Token ${userProvider.token}',
          },
          body: SwMatch.toCarrierJson(transceiver),
        ));

    SwNetwork.handleResponse(context, response,
        onError: onError, onSuccess: onSuccess);
  }

  static accept(BuildContext context,
      {matchId, onError, onSuccess}) async {
    final userProvider = Provider.of<UserStatus>(context);
    final String swBaseUrl = AppConfig.of(context).apiBaseUrl;
    final response = await SwNetwork.sendRequest(
        context,
            () => http.get(
          '$swBaseUrl/match/$matchId/accept',
          headers: {
            "Content-type": "application/json",
            "Authorization": 'Token ${userProvider.token}',
          },
        ));

    SwNetwork.handleResponse(context, response,
        onError: onError, onSuccess: onSuccess);
  }

  static reject(BuildContext context,
      {matchId, onError, onSuccess}) async {
    final userProvider = Provider.of<UserStatus>(context);
    final String swBaseUrl = AppConfig.of(context).apiBaseUrl;
    final response = await SwNetwork.sendRequest(
        context,
            () => http.get(
          '$swBaseUrl/match/$matchId/reject',
          headers: {
            "Content-type": "application/json",
            "Authorization": 'Token ${userProvider.token}',
          },
        ));

    SwNetwork.handleResponse(context, response,
        onError: onError, onSuccess: onSuccess);
  }

  static passPayment(BuildContext context,
      {matchId, onError, onSuccess}) async {
    final userProvider = Provider.of<UserStatus>(context);
    final String swBaseUrl = AppConfig.of(context).apiBaseUrl;
    final response = await SwNetwork.sendRequest(
        context,
            () => http.get(
          '$swBaseUrl/match/$matchId/pass_payment',
          headers: {
            "Content-type": "application/json",
            "Authorization": 'Token ${userProvider.token}',
          },
        ));

    SwNetwork.handleResponse(context, response,
        onError: onError, onSuccess: onSuccess);
  }

  static checkBoxDone(BuildContext context,
      {matchId, onError, onSuccess}) async {
    final userProvider = Provider.of<UserStatus>(context);
    final String swBaseUrl = AppConfig.of(context).apiBaseUrl;
    final response = await SwNetwork.sendRequest(
        context,
            () => http.get(
          '$swBaseUrl/match/$matchId/check_box_done',
          headers: {
            "Content-type": "application/json",
            "Authorization": 'Token ${userProvider.token}',
          },
        ));

    SwNetwork.handleResponse(context, response,
        onError: onError, onSuccess: onSuccess);
  }

  static checkBoxFail(BuildContext context,
      {matchId, onError, onSuccess}) async {
    final userProvider = Provider.of<UserStatus>(context);
    final String swBaseUrl = AppConfig.of(context).apiBaseUrl;
    final response = await SwNetwork.sendRequest(
        context,
            () => http.get(
          '$swBaseUrl/match/$matchId/check_box_fail',
          headers: {
            "Content-type": "application/json",
            "Authorization": 'Token ${userProvider.token}',
          },
        ));

    SwNetwork.handleResponse(context, response,
        onError: onError, onSuccess: onSuccess);
  }

  static readyForTakingBox(BuildContext context,
      {matchId, onError, onSuccess}) async {
    final userProvider = Provider.of<UserStatus>(context);
    final String swBaseUrl = AppConfig.of(context).apiBaseUrl;
    final response = await SwNetwork.sendRequest(
        context,
            () => http.get(
          '$swBaseUrl/match/$matchId/ready_for_taking_box',
          headers: {
            "Content-type": "application/json",
            "Authorization": 'Token ${userProvider.token}',
          },
        ));

    SwNetwork.handleResponse(context, response,
        onError: onError, onSuccess: onSuccess);
  }

  static confirmTakingCode(BuildContext context,
      {matchId, code, onError, onSuccess}) async {
    final userProvider = Provider.of<UserStatus>(context);
    final String swBaseUrl = AppConfig.of(context).apiBaseUrl;
    final response = await SwNetwork.sendRequest(
        context,
            () => http.get(
          '$swBaseUrl/match/$matchId/confirm_taking_code/?code=$code',
          headers: {
            "Content-type": "application/json",
            "Authorization": 'Token ${userProvider.token}',
          },
        ));

    SwNetwork.handleResponse(context, response,
        onError: onError, onSuccess: onSuccess);
  }

  static readyForDeliveringBox(BuildContext context,
      {matchId, onError, onSuccess}) async {
    final userProvider = Provider.of<UserStatus>(context);
    final String swBaseUrl = AppConfig.of(context).apiBaseUrl;
    final response = await SwNetwork.sendRequest(
        context,
            () => http.get(
          '$swBaseUrl/match/$matchId/ready_for_delivering_box',
          headers: {
            "Content-type": "application/json",
            "Authorization": 'Token ${userProvider.token}',
          },
        ));

    SwNetwork.handleResponse(context, response,
        onError: onError, onSuccess: onSuccess);
  }

  static confirmDeliveryCode(BuildContext context,
      {matchId, code, onError, onSuccess}) async {
    final userProvider = Provider.of<UserStatus>(context);
    final String swBaseUrl = AppConfig.of(context).apiBaseUrl;
    final response = await SwNetwork.sendRequest(
        context,
            () => http.get(
          '$swBaseUrl/match/$matchId/confirm_delivery_code/?code=$code',
          headers: {
            "Content-type": "application/json",
            "Authorization": 'Token ${userProvider.token}',
          },
        ));

    SwNetwork.handleResponse(context, response,
        onError: onError, onSuccess: onSuccess);
  }
}
