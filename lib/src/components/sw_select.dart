import 'package:flutter/material.dart';

import 'package:swingo/src/components/sw_formfield.dart';
import 'package:swingo/src/components/sw_search.dart';

class SwSelect extends StatelessWidget{
  final String text;
  final String labelText;
  final IconData prefixIcon;
  final onSelected;
  final onSearchChanged;

  SwSelect({
    this.text,
    this.onSelected,
    this.labelText,
    this.prefixIcon,
    this.onSearchChanged
  });

  _onFocused(BuildContext context, FocusNode focusNode) async {
    focusNode.unfocus();
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SwSearch(onSearchChanged: this.onSearchChanged)),
    );

    if(result != null){
      this.onSelected(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SwFormField(
      text: this.text,
      labelText: this.labelText,
      prefixIcon: this.prefixIcon,
      suffixIcon: Icons.arrow_drop_down,
      onFocused: _onFocused,
    );
  }
}
