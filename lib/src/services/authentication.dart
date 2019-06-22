import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:swingo/src/models/signup.dart';
import 'package:swingo/src/models/signin.dart';
import 'package:swingo/src/classes/SwNetwork.dart';

const swBaseUrl = 'https://www.goswingo.com/swingo';

abstract class AuthenticationService extends SwNetwork {
  static Future<http.Response> signup(BuildContext context,
      {String username,
      String email,
      String password,
      String confirmPassword,
      onError,
      onSuccess}) async {
    final response = await SwNetwork.sendRequest(context, () {
      return http.post('${swBaseUrl}/auth/register/',
          headers: {"Content-type": "application/json"},
          body: Signup.toJson(username, email, password, confirmPassword));
    });

    SwNetwork.handleResponse(context, response,
        onError: onError, onSuccess: onSuccess);
  }

  static Future<http.Response> signin(BuildContext context,
      {String username, String password, onError, onSuccess}) async {
    final response = await SwNetwork.sendRequest(context, () {
      return http.post('${swBaseUrl}/auth/login/',
          headers: {"Content-type": "application/json"},
          body: Signin.toJson(username, password));
    });

    SwNetwork.handleResponse(context, response,
        onError: onError, onSuccess: onSuccess);
  }
}
