import 'package:flutter/material.dart';

InputDecoration passwordDecoration(
  FocusNode node,
  String label,
  IconData icon,
  VoidCallback onTap,
  bool isVisible,
) {
  return InputDecoration(
    prefixIcon: Icon(icon),
    label: Text(label),
    suffixIcon: GestureDetector(
      onTap: () {
        onTap.call();
      },
      child: Icon(
        isVisible ? Icons.visibility : Icons.visibility_off,
        color: node.hasFocus ? Colors.blue : Colors.grey,
      ),
    ),
    prefixIconColor: node.hasFocus ? Colors.blue : Colors.grey,
    // suffixIconColor: node.hasFocus ? Colors.blue : Colors.grey,
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
