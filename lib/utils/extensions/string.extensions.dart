import 'package:moviezapp/model/routing.data.dart';

extension StringExt on String {
  DateTime get getDateTime {
    var components = split("-").map((e) => int.parse(e)).toList();
    var year = components.first;
    var month = components[1];
    var day = components.last;
    return DateTime(year, month, day);
  }

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

  RoutingData get getRoutingData {
    var uriData = Uri.parse(this);
    return RoutingData(
      queryParameters: uriData.queryParameters,
      route: uriData.path,
    );
  }

  String getRouteWithId(int id) {
    return Uri(
      path: this,
      queryParameters: {
        'id': id.toString(),
      },
    ).toString();
  }
}
