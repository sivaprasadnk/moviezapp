extension StringExt on String {
  String get formatedDateString {
    // "2023-04-07"
    var year = split('-').first;
    var month = split('-')[1].monthString;
    var day = split('-')[2];
    return "$month $day, $year";
  }

  String get monthString {
    switch (this) {
      case "01":
        return "Jan";
      case "02":
        return "Feb";
      case "03":
        return "Mar";
      case "04":
        return "Apr";
      case "05":
        return "May";
      case "06":
        return "Jun";
      case "07":
        return "Jul";
      case "08":
        return "Aug";
      case "09":
        return "Sep";
      case "10":
        return "Oct";
      case "11":
        return "Nov";
      case "12":
        return "Dec";
    }
    return "";
  }
}
