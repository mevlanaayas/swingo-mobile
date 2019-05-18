import 'dart:async';

import 'package:dio/dio.dart';

final String base = 'https://auth.swingo/v1/';

class AuthApi {
  AuthApi() {
    register();
  }

  final Dio dio = Dio();

  User _authenticatedUser;

  void register() {
    dio.interceptor.request.onSend = (Options options) {
      return options; //continue
    };
    dio.interceptor.response.onSuccess = (Response<dynamic> response) {
      return response; // continue
    };
    dio.interceptor.response.onError = (DioError e) {
      return e; //continue
    };
  }

  Future<User> login(String body) async {
    final Response response = await dio.post(base + 'login/', data: body);
    _authenticatedUser = User.fromJson(response.data);
    return User.fromJson(response.data);
  }

  Future<User> signUp(String body) async {
    final Response response = await dio.post(base + 'signup/', data: body);
    return User.fromJson(response.data);
  }

  Future<dynamic> verifyOtp(String body) async {
    final Response response = await dio
        .post(base + 'providers/mobile-password/verify-otp', data: body);
    return response.data;
  }

  Future<dynamic> resendOtp(String body) async {
    final Response response = await dio
        .post(base + 'providers/mobile-password/resend-otp', data: body);
    return response.data;
  }

  Future<dynamic> forgotPassword(String body) async {
    final Response response = await dio
        .post(base + 'providers/mobile-password/forgot-password', data: body);
    return response.data;
  }

  Future<dynamic> resetPassword(String body) async {
    final Response response = await dio
        .post(base + 'providers/mobile-password/reset-password', data: body);
    return response.data;
  }
}

final AuthApi api = AuthApi();
