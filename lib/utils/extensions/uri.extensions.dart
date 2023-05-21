import 'package:flutter/material.dart';

extension UriExt on Uri {
  int get id {
    debugPrint('value : ${toString()}');
    return int.parse(toString().split('=').last);
  }
}
