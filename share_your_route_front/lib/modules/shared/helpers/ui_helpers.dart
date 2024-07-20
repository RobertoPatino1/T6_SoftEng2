import 'package:flutter/material.dart';

InputDecoration buildInputDecoration({String? labelText, String? hintText}) {
  return InputDecoration(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
    labelText: labelText,
    hintText: hintText,
  );
}
