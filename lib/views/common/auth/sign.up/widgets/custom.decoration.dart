import 'package:flutter/material.dart';

InputDecoration customDecoration(FocusNode node, String label, IconData icon) {
  return InputDecoration(
    prefixIcon: Icon(icon),
    label: Text(label),
    prefixIconColor: node.hasFocus ? Colors.blue : Colors.grey,
    floatingLabelStyle: const TextStyle(color: Colors.blue),
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
