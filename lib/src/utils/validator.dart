import 'dart:async';

mixin Validators {
  final StreamTransformer<dynamic, dynamic> mobileValidator =
      StreamTransformer<String, String>.fromHandlers(
          handleData: (String mobile, EventSink<String> sink) {
    if (mobile.length == 10) {
      sink.add(mobile);
    } else {
      sink.addError('Mobile is not valid');
    }
  });
  final StreamTransformer<dynamic, dynamic> passwordValidator =
      StreamTransformer<String, String>.fromHandlers(
          handleData: (String password, EventSink<String> sink) {
    if (password.length > 6) {
      sink.add(password);
    } else {
      sink.addError('Password is not valid');
    }
  });

  final StreamTransformer<dynamic, dynamic> otpValidator =
      StreamTransformer<String, String>.fromHandlers(
          handleData: (String countryCode, EventSink<String> sink) {
    if (countryCode.isNotEmpty) {
      sink.add(countryCode);
    } else {
      sink.addError('Otp code is not valid');
    }
  });

  final StreamTransformer<dynamic, dynamic> countryCodeValidator =
      StreamTransformer<String, String>.fromHandlers(
          handleData: (String countryCode, EventSink<String> sink) {
    if (countryCode.isNotEmpty) {
      sink.add(countryCode);
    } else {
      sink.addError('Country code is not valid');
    }
  });
}
