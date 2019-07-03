import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swingo/app_config.dart';
import 'package:swingo/src/classes/SwNetwork.dart';
import 'package:swingo/src/ankara/general.dart';

abstract class OptionService extends SwNetwork {
  static listCities(BuildContext context,
      {searchingText, page, onError, onSuccess}) async {
    final userProvider = Provider.of<UserStatus>(context);
    final String swBaseUrl = AppConfig.of(context).apiBaseUrl;
    final response = await SwNetwork.sendRequest(
        context,
            () => http.get(
          '$swBaseUrl/city/?name__icontains=${searchingText}',
          headers: {
            "Content-type": "application/json",
            "Authorization": 'Token ${userProvider.token}',
          },
        ));

    return response;
  }
}
