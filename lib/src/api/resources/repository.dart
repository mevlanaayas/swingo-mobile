import 'dart:async';
import 'dart:convert';

import 'package:swingo/src/api/auth_api.dart';

class Repository {
  //final AuthApi authApi = AuthApi();

  final JsonEncoder _encoder = const JsonEncoder();

  Future<User> loginUser(Credentials c) {
    return api.login(_encoder.convert(c));
  }

  Future<User> signUpUser(Credentials c) {
    return api.signUp(_encoder.convert(c));
  }

  Future<dynamic> verifyOtp(dynamic otp) {
    return api.verifyOtp(_encoder.convert(otp));
  }

  Future<dynamic> resendOtp(User u) {
    return api.resendOtp(_encoder.convert(u));
  }

  Future<dynamic> forgotPassword(String mobile, String countryCode) {
    final Map<String, String> request = {
      'mobile': mobile,
      'country_code': countryCode,
    };

    return api.forgotPassword(_encoder.convert(request));
  }

  Future<dynamic> resetPassword(Credentials c, String otp) {
    final Map<String, String> request = {
      'mobile': c.mobile,
      'country_code': c.countryCode,
      'password': c.password,
      'otp': otp
    };
    return api.resetPassword(_encoder.convert(request));
  }
}
