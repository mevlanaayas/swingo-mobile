import 'package:flutter/material.dart';
import 'package:swingo/src/components/components.dart';
import 'package:swingo/src/models/models.dart';
import 'package:swingo/src/theme/style.dart';

class InboxScreen extends StatelessWidget {
  final List<ChatRoom> inbox = [
    ChatRoom(
        id: 1,
        firstUser: "firstuser",
        secondUser: "currentuser",
        bidId: 1,
        lastMessage: "selam"),
    ChatRoom(
        id: 2,
        firstUser: "currentuser",
        secondUser: "seconduser",
        bidId: 2,
        lastMessage: "selam"),
    ChatRoom(
        id: 3,
        firstUser: "currentuser",
        secondUser: "seconduser",
        bidId: 3,
        lastMessage: "selam"),
  ];

  void _buildSection(List<Widget> slivers, double scale, List<ChatRoom> items) {
    if (items.isNotEmpty) {
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
