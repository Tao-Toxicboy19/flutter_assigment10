import 'package:flutter/material.dart';

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
    color: null, // กำหนดให้เป็นสีโปร่งใส
    highlightColor: null, // สีที่ต้องการเมื่อกด
    child: Text(
      labelText,
      style: const TextStyle(
        color: Colors.black,
      ),
    ),
  );
}
