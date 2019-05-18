import 'dart:async';

import 'package:dio/dio.dart';

final String base = 'https://auth.swingo/v1/';

class AuthApi {
  final Dio dio = Dio();

  Future<Response> signIn(String body) async {
    final Response response = await dio.post(base + 'login/', data: body);
    return response;
  }

  Future<Response> signUp(String body) async {
    final Response response = await dio.post(base + 'signup/', data: body);
    return response;
  }
}

final AuthApi api = AuthApi();
