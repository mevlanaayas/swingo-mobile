import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swingo/src/ankara/general.dart';
import 'package:swingo/src/models/models.dart';
import 'package:swingo/src/pages/profile/base.dart';
import 'package:swingo/src/pages/profile/chat.dart';
import 'package:swingo/src/theme/decoration.dart';
import 'package:swingo/src/theme/style.dart';
import 'package:swingo/src/utils/formatters.dart';
import 'package:swingo/src/utils/sliders.dart';

class ChatListItem extends StatefulWidget {
  final ChatRoom item;

  const ChatListItem({this.item});

  @override
  _ChatListItemState createState() => _ChatListItemState();
}

class _ChatListItemState extends State<ChatListItem> {
  Widget _buildBody(String currentUser) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: Row(
                children: <Widget>[
                  widget.item.firstUser == currentUser
                      ? Text(
                          widget.item.secondUser,
                          style: itemUsernameContentStyle,
                        )
                      : Text(
                          widget.item.firstUser,
                          style: itemUsernameContentStyle,
                        ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Text(
                    // TODO: change with last message date
                    dateVerboseFormatter.format(DateTime.now()),
                    style: itemBodyDateContentStyle,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: <Widget>[
            // TODO: implement last message on server side
            widget.item.lastMessage != null
                ? widget.item.lastMessage.length > 30
                    ? Text(
                        widget.item.lastMessage.substring(0, 30) + "...",
                        style: itemBodyDetailContentStyle,
                      )
                    : Text(
                        widget.item.lastMessage,
                        style: itemBodyDetailContentStyle,
                      )
                : Text(""),
          ],
        ),
      ],
    );
  }

  Future<void> _handleTap(BuildContext context, ChatRoom item) async {
    final userProvider = Provider.of<UserStatus>(context);
    Navigator.push(
      context,
      SlideTopRoute(
        page: BaseProfile(
          child: ChatPage(
            chatRoom: item,
            username: userProvider.currentUser.username,
          ),
          // TODO: write username who user is talking
          type: item.firstUser == userProvider.currentUser.username
              ? item.secondUser
              : item.firstUser,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserStatus>(context);
    return Padding(
      padding: const EdgeInsets.only(left: 3, right: 3, bottom: 5),
      child: Container(
        decoration: CardItemDecoration(),
        child: Material(
          elevation: 0.0,
          type: MaterialType.transparency,
          borderRadius: const BorderRadius.all(Radius.circular(9)),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            splashColor: Colors.transparent,
            onTap: () => _handleTap(context, widget.item),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [_buildBody(userProvider.currentUser.username)],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
