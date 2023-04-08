import 'package:flutter/material.dart';

InputDecoration customDecoration(FocusNode node, String label, IconData icon) {
  return InputDecoration(
    prefixIcon: Icon(icon),
    label: Text(
      label,
      style: const TextStyle(
        fontSize: 15,
      ),
    ),
    prefixIconColor: node.hasFocus ? Colors.blue : Colors.grey,
    floatingLabelStyle:
        TextStyle(color: node.hasFocus ? Colors.blue : Colors.grey),
    focusColor: Colors.blue,
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        color: Colors.blue,
      ),
      borderRadius: BorderRadius.circular(10),
    ),
    border: OutlineInputBorder(
      borderSide: const BorderSide(
        color: Colors.black,
      ),
      borderRadius: BorderRadius.circular(10),
    ),
  );
}
