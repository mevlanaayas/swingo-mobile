import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:swingo/src/models/signup.dart';
import 'package:swingo/src/classes/SwNetwork.dart';

const swBaseUrl = 'https://www.goswingo.com/swingo';

abstract class AuthenticationService extends SwNetwork {
  static Future<http.Response> signup(BuildContext context,
      {String username,
      String email,
      String password,
      String confirmPassword}) async {
      /*final response = await http.post('${swBaseUrl}/auth/register/',
        headers: {"Content-type": "application/json"},
        body: Signup.toJson(username, email, password, confirmPassword));
      */
    SwNetwork.sendRequest(context, () {
      return http.post('${swBaseUrl}/auth/register/',
          headers: {"Content-type": "application/json"},
          body: Signup.toJson(username, email, password, confirmPassword));
    });

    //print(response.statusCode);
    //print(response.body);
    /*if (response.statusCode != 200) {
      String errorMessage =
          "Please check something."; //TODO: backend 1 tane mesaj göndericek onu basıcaz.
      SwNetwork.showSnackBar(context, errorMessage);
      return null;
    }
    return response;*/
  }
}
