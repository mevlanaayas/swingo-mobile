import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swingo/src/components/sw_button.dart';
import 'package:swingo/src/theme/decoration.dart';
import 'package:swingo/src/theme/style.dart';

class SwDialog extends StatelessWidget {
  final bool isAcceptButtonActive;
  final bool isDismissButtonActive;
  final bool isInputFieldActive;
  final String acceptButtonText;
  final String dismissButtonText;
  final String contentText;
  final onAcceptTap;
  final onDismissTap;
  final TextEditingController textEditingController;

  SwDialog({
    this.isAcceptButtonActive,
    this.isDismissButtonActive,
    this.isInputFieldActive,
    this.acceptButtonText,
    this.dismissButtonText,
    this.contentText,
    this.onAcceptTap,
    this.onDismissTap,
    this.textEditingController,
  });

  _onDismissTap(BuildContext context) {
    Navigator.of(context).pop();
  }

  Widget _buildContent(BuildContext context) {
    Widget content;
    Widget textContent = Text(
      this.contentText,
      style: dialogContentTextStyle,
    );
    if (this.isInputFieldActive ?? false) {
      content = Wrap(
        direction: Axis.horizontal, // main axis (rows or columns)
        alignment: WrapAlignment.center,
        children: <Widget>[
          textContent,
          Container(
            child: new TextField(
              controller: this.textEditingController,
              keyboardType: TextInputType.number,
              inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
              style: new TextStyle(color: Colors.white, fontSize: 18),
            ),
          )
        ],
      );
    } else {
      content = textContent;
    }

    return content;
  }

  Widget _buildButtons(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: swPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.only(right: swPadding / 2),
              child: SwButton(
                color: Colors.black12,
                text: this.dismissButtonText ?? 'Cancel',
                onPressed: () => this.onDismissTap != null
                    ? this.onDismissTap(context)
                    : _onDismissTap(context),
                // size: width,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.only(left: swPadding / 2),
              child: this.isAcceptButtonActive != null &&
                  this.isAcceptButtonActive == true
                  ? SwButton(
                color: primaryColor,
                text: this.acceptButtonText,
                onPressed: () => this.onAcceptTap(context),
                // size: width,
              )
                  : SizedBox(),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: cardBorderRadius,
      ),
      child: Container(
        padding: cardPadding,
        decoration: CardItemDecoration(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[_buildContent(context), _buildButtons(context)],
        ),
      ),
    );
  }
}
