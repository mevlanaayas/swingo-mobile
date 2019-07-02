import 'package:flutter/material.dart';

import 'package:swingo/src/components/sw_formfield.dart';
import 'package:swingo/src/components/sw_search.dart';

class SwSelect extends StatelessWidget {
  final String labelText;
  final IconData prefixIcon;
  final onSelected;
  final onSearchChanged;
  final hideSearchBar;
  final bool isRequired;
  final TextEditingController textEditingController;

  SwSelect({
    this.onSelected,
    this.labelText,
    this.prefixIcon,
    this.onSearchChanged,
    this.hideSearchBar,
    this.isRequired,
    this.textEditingController,
  });

  _onFocused(BuildContext context, FocusNode focusNode) async {
    focusNode.unfocus();
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => SwSearch(
                onSearchChanged: this.onSearchChanged,
                hideSearchBar: this.hideSearchBar,
              )),
    );

    if (result != null) {
      this.onSelected(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SwFormField(
      labelText: this.labelText,
      prefixIcon: this.prefixIcon,
      suffixIcon: Icons.arrow_drop_down,
      onFocused: _onFocused,
      isRequired: isRequired,
      controller: textEditingController,
    );
  }
}
