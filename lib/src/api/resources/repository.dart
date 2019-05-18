import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:swingo/src/api/auth_api.dart';
import 'package:swingo/src/models/default.dart';

class Repository {
  //final AuthApi authApi = AuthApi();

  final JsonEncoder _encoder = const JsonEncoder();

  Future<Response> loginUser(Credentials c) {
    return api.signIn(_encoder.convert(c));
  }

  Future<Response> signUpUser(Credentials c) {
    return api.signUp(_encoder.convert(c));
  }
}
