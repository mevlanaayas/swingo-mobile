import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swingo/src/ankara/general.dart';
import 'package:swingo/src/components/sw_dialog.dart';
import 'package:swingo/src/models/chat_room.dart';
import 'package:swingo/src/models/order.dart';
import 'package:swingo/src/pages/profile/base.dart';
import 'package:swingo/src/pages/profile/chat.dart';
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
      final userProvider = Provider.of<UserStatus>(context);
      String chatRoomId = responseData['chat_room_id'];
      int bidId = responseData['bid_id'];
      final chatRoom = ChatRoom(
        id: chatRoomId,
        firstUser: widget.order.created_by,
        secondUser: userProvider.currentUser.username,
        bidId: bidId,
      );
      _redirectToChat(context, chatRoom);
    };
  }

  _redirectToChat(BuildContext context, ChatRoom chatRoom) {
    Navigator.of(context).pushReplacement(
      SlideTopRoute(
        page: BaseProfile(
            child: Chat(
              chatRoom: chatRoom,
              username: chatRoom.secondUser,
            ),
            // TODO: write username who user is talking
            type: chatRoom.firstUser),
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
