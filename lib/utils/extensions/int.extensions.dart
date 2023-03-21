extension IntExt on int {
  String get durationInHrs {
    int minutes = this;
    int hours = minutes ~/ 60;
    int remainingMinutes = minutes % 60;
    return "${hours}h ${remainingMinutes}m";
  }
}
