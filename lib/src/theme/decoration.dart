import 'package:flutter/material.dart';
import 'package:swingo/src/theme/style.dart';

BoxDecoration CardItemDecoration() {
  return BoxDecoration(
    boxShadow: [
      BoxShadow(
          color: Colors.black.withOpacity(0.03),
          offset: const Offset(0, 10),
          blurRadius: 10,
          spreadRadius: 0),
    ],
    borderRadius: const BorderRadius.all(Radius.circular(9)),
    color: Colors.white,
  );
}

BoxDecoration RightProfileItemBoxDecoration() {
  return BoxDecoration(
    color: secondaryColor,
    borderRadius: BorderRadius.horizontal(left: Radius.circular(30.0)),
  );
}

BoxDecoration LeftProfileItemBoxDecoration() {
  return BoxDecoration(
    color: secondaryColor,
    borderRadius: BorderRadius.horizontal(right: Radius.circular(30.0)),
  );
}

BoxDecoration ProfileItemBoxDecoration() {
  return BoxDecoration(
    color: whiteColor,
    borderRadius: BorderRadius.all(Radius.circular(30.0)),
  );
}

BoxDecoration HomeItemBoxDecoration() {
  return BoxDecoration(color: whiteColor, shape: BoxShape.circle);
}

BoxDecoration HomeItemBoxDecorationWithOpacity(double opacity) {
  return BoxDecoration(
      color: whiteColor.withOpacity(opacity), shape: BoxShape.circle);
}

InputDecoration FormFieldDecoration(
  String labelText,
  String hintText,
  IconData prefixIcon,
  dynamic suffixIcon,
) {
  double iconSize = 16.0;
  return hintText == null
      ? InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
              borderSide: BorderSide(color: primaryColor, width: 3.0)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
              borderSide: BorderSide(color: primaryColor, width: 2.0)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
              borderSide: BorderSide(color: primaryColor, width: 2.0)),
          labelText: labelText,
          labelStyle: labelStyle,
          prefixIcon: Icon(
            prefixIcon,
            color: primaryColor,
            size: iconSize,
          ),
          suffixIcon: suffixIcon != null
              ? suffixIcon is IconData
                  ? Icon(
                      suffixIcon,
                      color: primaryColor,
                      size: iconSize,
                    )
                  : suffixIcon
              : null)
      : InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
              borderSide: BorderSide(color: primaryColor, width: 3.0)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
              borderSide: BorderSide(color: primaryColor, width: 2.0)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
              borderSide: BorderSide(color: primaryColor, width: 2.0)),
          hintText: hintText,
          labelStyle: labelStyle,
          prefixIcon: Icon(
            prefixIcon,
            color: primaryColor,
            size: iconSize,
          ),
          suffixIcon: suffixIcon != null
              ? suffixIcon is IconData
                  ? Icon(
                      suffixIcon,
                      color: primaryColor,
                      size: iconSize,
                    )
                  : suffixIcon
              : null);
}

InputDecoration SmallFormFieldDecoration(
  String labelText,
  String hintText,
  IconData prefixIcon,
  dynamic suffixIcon,
) {
  double iconSize = 20.0;
  return hintText == null
      ? InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 0.0),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
              borderSide: BorderSide(color: primaryColor, width: 3.0)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
              borderSide: BorderSide(color: primaryColor, width: 2.0)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
              borderSide: BorderSide(color: primaryColor, width: 2.0)),
          labelText: labelText,
          labelStyle: labelStyle,
          prefixIcon: Icon(
            prefixIcon,
            color: primaryColor,
            size: iconSize,
          ),
          suffixIcon: suffixIcon != null
              ? suffixIcon is IconData
                  ? Icon(
                      suffixIcon,
                      color: primaryColor,
                      size: iconSize,
                    )
                  : suffixIcon
              : null)
      : InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 0.0),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
              borderSide: BorderSide(color: primaryColor, width: 3.0)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
              borderSide: BorderSide(color: primaryColor, width: 2.0)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
              borderSide: BorderSide(color: primaryColor, width: 2.0)),
          hintText: hintText,
          labelStyle: labelStyle,
          prefixIcon: Icon(
            prefixIcon,
            color: primaryColor,
            size: iconSize,
          ),
          suffixIcon: suffixIcon != null
              ? suffixIcon is IconData
                  ? Icon(
                      suffixIcon,
                      color: primaryColor,
                      size: iconSize,
                    )
                  : suffixIcon
              : null);
}
