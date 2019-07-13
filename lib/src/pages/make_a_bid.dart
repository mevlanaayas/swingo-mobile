import 'package:flutter/material.dart';
import 'package:swingo/src/components/sw_dialog.dart';
import 'package:swingo/src/services/bid.dart';
import 'package:swingo/src/utils/constans.dart';

class MakeABid extends StatefulWidget {
  final String orderOwnerType;

  MakeABid({
    this.orderOwnerType,
  });

  @override
  _MakeABidState createState() => _MakeABidState();
}

class _MakeABidState extends State<MakeABid> {
  // Göndericiler teklif vermek için miktar yazıyor.
  // Bu aşamadan sonra tekrar onaylamak ister misiniz diye soruyoruz.
  // Bu aşama kontrolünü isPriceEntered ile yapıyoruz.
  bool isPriceEntered = false;
  final TextEditingController textEditingController = TextEditingController();

  _onCarrierAcceptTap(BuildContext context){
    BidService.createToCarry(
      context,
      onSuccess: _onRequestSuccess(context),
      onError: _onRequestError(context),
    );
  }

  _onSenderAcceptTapFirstTime(BuildContext context){
    if(textEditingController.text != null && textEditingController.text != ''){
      setState(() {
        isPriceEntered = true;
      });
    };
  }

  _onSenderAcceptTapSecondTime(BuildContext context){
    BidService.createToSend(
      context,
      onSuccess: _onRequestSuccess(context),
      onError: _onRequestError(context),
    );
  }

  _onRequestSuccess(BuildContext context) {
    return (responseData) async {
      print(responseData);
    };
  }

  _onRequestError(BuildContext context) {
    return (responseData) {
      print(responseData);
    };
  }

  _onDismissTap(BuildContext context) async {
    await setState(() {
      isPriceEntered = false;
    });
  }

  Widget _buildBody(){
    Widget body = null;
    if(this.widget.orderOwnerType == ORDER_OWNER_TYPES["CARRIER"]){
      if(!this.isPriceEntered){
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
