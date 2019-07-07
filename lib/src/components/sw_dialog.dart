import 'package:flutter/material.dart';
import 'package:swingo/src/components/sw_button.dart';
import 'package:swingo/src/theme/style.dart';

class SwDialog extends StatelessWidget {
  final bool isAcceptButtonActive;
  final bool isDismissButtonActive;
  final String acceptButtonText;
  final String dismissButtonText;
  final String contentText;
  final onAcceptTap;

  SwDialog({
    this.isAcceptButtonActive,
    this.isDismissButtonActive,
    this.acceptButtonText,
    this.dismissButtonText,
    this.contentText,
    this.onAcceptTap,
  });

  _onDismissTap(BuildContext context) {
    Navigator.of(context).pop();
  }

  _buildButtons(BuildContext context, double width) {
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
            : null,
        SizedBox(
          width: 10,
        ),
        SwButton(
          color: primaryColor,
          text: this.dismissButtonText ?? 'Cancel',
          onPressed: () => _onDismissTap(context),
          size: width,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery
        .of(context)
        .size
        .width;
    final height = MediaQuery
        .of(context)
        .size
        .height;
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
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    this.contentText,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
              _buildButtons(context, width)
            ],
          ),
        )
    );
  }
}