import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swingo/src/components/sw_button.dart';
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
    if (this.isInputFieldActive ?? false) {
      content = Wrap(
        direction: Axis.horizontal, // main axis (rows or columns)
        alignment: WrapAlignment.center,
        children: <Widget>[
          Text(
            this.contentText,
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          Container(
            width: 75.0,
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
      content = Text(
        this.contentText,
        style: TextStyle(color: Colors.white, fontSize: 18),
      );
    }

    return Expanded(
      child: Align(
        alignment: Alignment.center,
        child: content,
      ),
    );
  }

  Widget _buildButtons(BuildContext context, double width) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        this.isAcceptButtonActive != null && this.isAcceptButtonActive == true
            ? SwButton(
                color: primaryColor,
                text: this.acceptButtonText,
                onPressed: () => this.onAcceptTap(context),
                size: width,
              )
            : SizedBox(),
        SizedBox(
          width: 10,
        ),
        SwButton(
          color: primaryColor,
          text: this.dismissButtonText ?? 'Cancel',
          onPressed: () => this.onDismissTap != null
              ? this.onDismissTap(context)
              : _onDismissTap(context),
          size: width,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Container(
          padding: EdgeInsets.all(15.0),
          constraints: BoxConstraints(
            maxWidth: width / 10 * 9,
            maxHeight: height / 10 * 3,
          ),
          decoration: BoxDecoration(
            color: secondaryColor,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Column(
            children: <Widget>[
              _buildContent(context),
              _buildButtons(context, width),
            ],
          ),
        ));
  }
}
