// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

Widget customTextField({
  required TextEditingController controller,
  String? hintText,
  Icon? prefixIcon,
  required bool obscureText,
  required String labelText,
  TextInputType textInputType = TextInputType.text,
  required String? Function(String?)? validator,
  required bool underlineText,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: textInputType,
    autofocus: false,
    enableSuggestions: false,
    autocorrect: false,
    obscureText: obscureText,
    decoration: InputDecoration(
      hintText: hintText,
      prefixIcon: prefixIcon,
      labelText: labelText,
      contentPadding: EdgeInsets.only(),
      border: (underlineText == true)
          ? UnderlineInputBorder()
          : OutlineInputBorder(),
      // border: OutlineInputBorder(),
      // filled: true,
      isDense: true,
      // fillColor: Colors.grey[300],
    ),
    validator: validator,
  );
}

Widget customTextFieldProduct({
  required String labelText,
  required bool obscureText,
  TextInputType textInputType = TextInputType.text,
  int maxLines = 1,
  required String? Function(String?)? validator,
  required TextEditingController controller,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: textInputType,
    maxLines: maxLines,
    autofocus: false,
    enableSuggestions: false,
    autocorrect: false,
    obscureText: obscureText,
    decoration: InputDecoration(
      border: OutlineInputBorder(),
      labelText: labelText,
    ),
    validator: validator,
  );
}
