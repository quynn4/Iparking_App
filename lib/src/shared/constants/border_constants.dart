import 'package:flutter/material.dart';

class AppBorder {
  static const borderTopMedium = Border(
      top: BorderSide(
        color: Color.fromRGBO(0, 0, 0, 0.2),
        width: 1.0,
      ));
  static const borderUnderLight = Border(
      bottom: BorderSide(
        color: Color.fromRGBO(0, 0, 0, 0.12),
        width: 1.0,
      ));
  static const borderTopLight = Border(
      top: BorderSide(
        color: Color.fromRGBO(0, 0, 0, 0.12),
        width: 1.0,
      ));
  static const borderTopAndUnderLight = Border(
      top: BorderSide(
        color: Color.fromRGBO(0, 0, 0, 0.12),
        width: 1.0,
      ),
      bottom: BorderSide(
        color: Color.fromRGBO(0, 0, 0, 0.12),
        width: 1.0,
      ));
}