import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:swingo/src/models/signup.dart';

const swBaseUrl = 'https://www.goswingo.com/swingo';

abstract class AuthenticationService{
  static Future<http.Response> signup(onError, {String username, String email, String password, String confirmPassword}) async {
    print(Signup.toJson(username, email, password, confirmPassword));
    final response = await http.post(
        '${swBaseUrl}/auth/register/',
        headers: {"Content-type": "application/json"},
        body: Signup.toJson(username, email, password, confirmPassword)
    );

    print(response.statusCode);
    print(response.body);
    if(response.statusCode != 200){
      String errorMessage =  "Please check something."; //TODO: backend 1 tane mesaj göndericek onu basıcaz.
      onError(errorMessage);
      return null;
    }
    return response;
  }
}

