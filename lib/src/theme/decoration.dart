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
