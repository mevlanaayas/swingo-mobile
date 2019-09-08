import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swingo/src/user_status.dart';
import 'package:swingo/src/components/sw_dialog.dart';
import 'package:swingo/src/models/chat_room.dart';
import 'package:swingo/src/models/order.dart';
import 'package:swingo/src/pages/chat.dart';
import 'package:swingo/src/services/match.dart';
import 'package:swingo/src/utils/constans.dart';
import 'package:swingo/src/utils/sliders.dart';

class MakeABid extends StatefulWidget {
  final String orderOwnerType;
  final Order order;
  final onRequestError;

  MakeABid({
    this.orderOwnerType,
    this.order,
    this.onRequestError,
  });

  @override
  _MakeABidState createState() => _MakeABidState();
}

class _MakeABidState extends State<MakeABid> {
  // Göndericiler teklif vermek için miktar yazıyor.
  // Bu aşamadan sonra tekrar onaylamak ister misiniz diye soruyoruz.
  // Bu aşama kontrolünü isPriceEntered ile yapıyoruz.
  bool isPriceEntered = false;
  double price;
  final TextEditingController textEditingController = TextEditingController();

  _onCarrierAcceptTap(BuildContext context) {
    MatchService.createToCarry(
      context,
      transceiver: widget.order.id,
      onSuccess: _onMakeABidRequestSuccess(context),
      onError: _onRequestError(context),
    );
  }

  _onSenderAcceptTapFirstTime(BuildContext context) {
    if (textEditingController.text != null &&
        textEditingController.text != '') {
      setState(() {
        isPriceEntered = true;
        price = double.parse(textEditingController.text);
      });
    }
    ;
  }

  _onSenderAcceptTapSecondTime(BuildContext context) {
    MatchService.createToSend(
      context,
      transporter: widget.order.id,
      price: price,
      onSuccess: _onMakeABidRequestSuccess(context),
      onError: _onRequestError(context),
    );
  }

  _onMakeABidRequestSuccess(BuildContext context) {
    return (responseData) async {
      String chatRoomId = responseData['chat_room_id'];
      int matchId = responseData['match_id'];
      final chatRoom = ChatRoom(
        // TODO: chatroom mantığı değişti modeli fixlemek gerek
        id: chatRoomId,
        firstUser: '',
        secondUser: '',
        bidId: null,
      );
      print(this.widget.orderOwnerType);
      String offererUserType =
          this.widget.orderOwnerType == ORDER_OWNER_TYPES["CARRIER"]
              ? ORDER_OWNER_TYPES["SENDER"]
              : ORDER_OWNER_TYPES["CARRIER"];

      await Navigator.of(context).pop();
      await Navigator.of(context).pop();

      _redirectToChat(context, chatRoom, MATCH_STATUSES['INITIATED'].status,
          offererUserType, matchId, widget.order.created_by);
    };
  }

  _redirectToChat(BuildContext context, ChatRoom chatRoom, String status,
      String userType, int matchId, String chattedUsername) {
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

  _onRequestError(BuildContext context) {
    return (responseData) {
      Navigator.of(context).pop();
      widget.onRequestError(responseData);
    };
  }

  _onDismissTap(BuildContext context) async {
    await setState(() {
      isPriceEntered = false;
    });
  }

  Widget _buildBody() {
    Widget body = null;
    if (this.widget.orderOwnerType == ORDER_OWNER_TYPES["CARRIER"]) {
      if (!this.isPriceEntered) {
        body = SwDialog(
          isDismissButtonActive: true,
          isAcceptButtonActive: true,
          isInputFieldActive: true,
          textEditingController: textEditingController,
          dismissButtonText: 'Cancel',
          acceptButtonText: 'Accept',
          contentText: 'Your offer: ',
          onAcceptTap: _onSenderAcceptTapFirstTime,
        );
      } else {
        body = SwDialog(
          isDismissButtonActive: true,
          isAcceptButtonActive: true,
          dismissButtonText: 'Cancel',
          acceptButtonText: 'Accept',
          contentText: 'Do you accept your offer?',
          onAcceptTap: _onSenderAcceptTapSecondTime,
          onDismissTap: _onDismissTap,
        );
      }
    } else if (this.widget.orderOwnerType == ORDER_OWNER_TYPES["SENDER"]) {
      body = SwDialog(
        isDismissButtonActive: true,
        isAcceptButtonActive: true,
        dismissButtonText: 'Cancel',
        acceptButtonText: 'Accept',
        contentText: 'Do you accept offer of sender?',
        onAcceptTap: _onCarrierAcceptTap,
      );
    } else {
      print("Wrong order owner type!");
    }

    return body;
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }
}
