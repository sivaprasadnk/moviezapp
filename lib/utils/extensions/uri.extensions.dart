extension UriExt on Uri {
  int get id {
    return int.parse(toString().split('=').last);
  }
}
