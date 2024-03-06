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
          : OutlineInputBorder(
              borderRadius: BorderRadius.circular(40),
              borderSide: const BorderSide(width: 0, style: BorderStyle.none),
            ),
      // filled: true,
      isDense: true,
      // fillColor: Colors.grey[300],
    ),
    validator: validator,
  );
}
