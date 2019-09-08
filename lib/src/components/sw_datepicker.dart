import 'package:flutter/material.dart';

import 'package:swingo/src/components/sw_formfield.dart';
import 'package:swingo/src/theme/themes.dart';

class SwDatePicker extends StatelessWidget {
  final String labelText;
  final IconData prefixIcon;
  final onSelected;
  final bool isRequired;
  final TextEditingController textEditingController;

  SwDatePicker({
    this.labelText,
    this.prefixIcon,
    this.onSelected,
    this.isRequired,
    this.textEditingController,
  });

  Future _selectDate(context) async {
    DateTime selectedTime = await showDatePicker(
      context: context,
      initialDate: new DateTime.now(),
      firstDate: new DateTime.now().subtract(Duration(days: 1)),
      lastDate: new DateTime(2021),
    );
    if (selectedTime != null) {
      this.onSelected(selectedTime);
    }
  }

  _onFocused(BuildContext context, FocusNode focusNode) {
    focusNode.unfocus();
    _selectDate(context);
  }

  @override
  Widget build(BuildContext context) {
    return new Theme(
      data: datePickerTheme,
      child: new Builder(
        builder: (context) => SwFormField(
              labelText: this.labelText,
              prefixIcon: this.prefixIcon,
              onFocused: _onFocused,
              isRequired: isRequired,
              controller: textEditingController,
            ),
      ),
    );
  }
}
