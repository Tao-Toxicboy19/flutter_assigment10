import 'package:flutter/material.dart';
import 'package:flutter_assigment10v1/theme/colors.dart';

Widget customButtom({
  required String labelText,
  required VoidCallback onPressd,
}) {
  return MaterialButton(
    onPressed: onPressd,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5.0),
      side: const BorderSide(
        color: Colors.black,
      ),
    ),
    color: primary, // กำหนดให้เป็นสีโปร่งใส
    highlightColor: null, // สีที่ต้องการเมื่อกด
    child: Text(
      labelText,
      style: const TextStyle(
        color: Colors.white,
      ),
    ),
  );
}
