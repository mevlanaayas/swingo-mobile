import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swingo/src/components/sw_card.dart';
import 'package:swingo/src/models/match_status.dart';
import 'package:swingo/src/theme/style.dart';
import 'package:swingo/src/user_status.dart';
import 'package:swingo/src/models/models.dart';
import 'package:swingo/src/pages/chat.dart';
import 'package:swingo/src/utils/constans.dart';
import 'package:swingo/src/utils/helpers.dart';
import 'package:swingo/src/utils/sliders.dart';

class MatchItem extends StatefulWidget {
  final SwMatch item;

  const MatchItem({this.item});

  @override
  _MatchItemState createState() => _MatchItemState();
}

class _MatchItemState extends State<MatchItem> {
  _redirectToChat(BuildContext context, ChatRoom chatRoom, String status,
      String userType, int matchId, String chattedUsername) {
    print("****");
    print(matchId);
    final userProvider = Provider.of<UserStatus>(context);

    Navigator.of(context).push(
      SlideRightRoute(
        page: Chat(
          chatRoom: chatRoom,
          username: userProvider.currentUser.username,
          status: status,
          userType: userType,
          matchId: matchId,
          chattedUsername: chattedUsername,
        ),
      ),
    );
  }

  _buildStatusRow(String userType) {
    String status = getStatusKey(widget.item.status);
    MatchStatus matchStatus = MATCH_STATUSES[status];
    print(userType == MATCH_STATUSES['SENDER']);
    String statusMessage = userType == ORDER_OWNER_TYPES['SENDER']
        ? matchStatus.senderText
        : matchStatus.carrierText;

    return Container(
      margin: const EdgeInsets.all(2.0),
      padding: const EdgeInsets.all(8),
      decoration: new BoxDecoration(
        borderRadius: new BorderRadius.all(Radius.circular(28)),
        color: primaryColor,
      ),
      child: Column(
        children: <Widget>[
          Text(
            statusMessage,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'Muli',
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserStatus>(context);
    final chatRoom = ChatRoom(
      // TODO: chatroom mantığı değişti modeli fixlemek gerek
      id: widget.item.chatRoomId,
      firstUser: '',
      secondUser: '',
      bidId: null,
    );
    final status = widget.item.status;
    final matchId = widget.item.id;
    final String chattedUsername =
        widget.item.sender.username != userProvider.currentUser.username
            ? widget.item.sender.username
            : widget.item.carrier.username;
    String userType = ORDER_OWNER_TYPES['CARRIER'];
    if (widget.item.sender.username == userProvider.currentUser.username) {
      userType = ORDER_OWNER_TYPES['SENDER'];
    }

    return ListItem(
      item: widget.item.order,
      orderOwnerType: widget.item.orderType,
      onTap: (BuildContext cardContext) => _redirectToChat(
            context,
            chatRoom,
            status,
            userType,
            matchId,
            chattedUsername,
          ),
      priceRow: _buildStatusRow(userType),
    );
  }
}
