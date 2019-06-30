import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:swingo/src/ankara/general.dart';
import 'package:swingo/src/components/components.dart';
import 'package:swingo/src/models/models.dart';
import 'package:swingo/src/services/chat.dart';
import 'package:swingo/src/theme/style.dart';

class InboxScreen extends StatefulWidget {
  @override
  _InboxScreenState createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  List<ChatRoom> inbox;

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _listChatRooms(context);
    });
    super.initState();
  }

  void _buildSection(List<Widget> slivers, double scale, List<ChatRoom> items) {
    if (items != null && items.isNotEmpty) {
      slivers.add(
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            ChatRoom item = items[index];
            return ChatListItem(item: item);
          }, childCount: items.length),
        ),
      );
    }
  }

  void _listChatRooms(BuildContext context) async {
    ChatService.listChatRooms(
      context,
      onSuccess: _onRequestSuccess(context),
    );
  }

  _onRequestSuccess(BuildContext context) {
    return (responseData) async {
      final chatRoomJsonArray = responseData['chatRooms'];
      setState(() {
        inbox = chatRoomJsonArray != null
            ? List<ChatRoom>.from(chatRoomJsonArray
                .map((chatRoomJson) => ChatRoom.fromJson(chatRoomJson)))
            : [];
      });
    };
  }

  @override
  Widget build(BuildContext context) {
    var slivers = <Widget>[];
    const scale = 1.0;
    _buildSection(slivers, scale, inbox);
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints(minWidth: double.infinity),
        color: primaryColor50,
        child: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top,
            bottom: MediaQuery.of(context).padding.bottom,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(child: CustomScrollView(slivers: slivers)),
            ],
          ),
        ),
      ),
    );
  }
}
