import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:swingo/app_config.dart';
import 'package:swingo/src/user_status.dart';
import 'package:swingo/src/classes/SwNetwork.dart';

abstract class ChatService extends SwNetwork {
  static listChatRooms(BuildContext context,
      {onError, onSuccess}) async {
    final String swBaseUrl = AppConfig.of(context).apiBaseUrl;
    final userProvider = Provider.of<UserStatus>(context);
    final response = await SwNetwork.sendRequest(
        context,
        () => http.get(
              '$swBaseUrl/chat_list/',
              headers: {
                "Content-type": "application/json",
                "Authorization": 'Token ${userProvider.token}',
              },
            ));

    SwNetwork.handleResponse(context, response,
        onError: onError, onSuccess: onSuccess);
  }

  static listMessages(BuildContext context,
      {onError, onSuccess, chatRoomId}) async {
    final String swBaseUrl = AppConfig.of(context).apiBaseUrl;
    final userProvider = Provider.of<UserStatus>(context);
    final response = await SwNetwork.sendRequest(
        context,
            () => http.get(
          '$swBaseUrl/messages/$chatRoomId/',
          headers: {
            "Content-type": "application/json",
            "Authorization": 'Token ${userProvider.token}',
          },
        ));

    SwNetwork.handleResponse(context, response,
        onError: onError, onSuccess: onSuccess);
  }

  static getChatRoom(BuildContext context,
      {onError, onSuccess, chatRoomId}) async {
    final String swBaseUrl = AppConfig.of(context).apiBaseUrl;
    final userProvider = Provider.of<UserStatus>(context);
    final response = await SwNetwork.sendRequest(
        context,
            () => http.get(
          '$swBaseUrl/chat_list/$chatRoomId/',
          headers: {
            "Content-type": "application/json",
            "Authorization": 'Token ${userProvider.token}',
          },
        ));

    SwNetwork.handleResponse(context, response,
        onError: onError, onSuccess: onSuccess);
  }

}
