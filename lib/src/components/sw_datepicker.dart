import 'package:flutter/material.dart';

import 'package:swingo/src/theme/style.dart';
import 'package:swingo/src/components/sw_formfield.dart';

class SwDatePicker extends StatelessWidget{
  final String text;
  final String labelText;
  final IconData prefixIcon;
  final onSelected;

  SwDatePicker({
    this.text,
    this.labelText,
    this.prefixIcon,
    this.onSelected
  });

  Future _selectDate(context) async {
    DateTime selectedTime = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(2019),
        lastDate: new DateTime(2021),
    );
    if(selectedTime != null){
      this.onSelected(selectedTime);
    }
  }

  _onFocused(BuildContext context, FocusNode focusNode){
    focusNode.unfocus();
    _selectDate(context);
  }

  @override
  Widget build(BuildContext context) {
    return new Theme(
      data: Theme.of(context).copyWith(
        primaryColor: primaryColor,
        accentColor: secondaryColor,
        splashColor: primaryColor,
      ),
      child: new Builder(
        builder: (context) => SwFormField(
          text: this.text,
          labelText: this.labelText,
          prefixIcon: this.prefixIcon,
          onFocused: _onFocused,
        ),
      ),
    );
  }
}