const regionList = [
  // "All",
  "Australia",
  "France",
  "India",
  "United Arab Emirates",
  "United Kingdom",
  "United States of America",
];

extension RegionExt on String {
  String get regionCode {
    switch (this) {
      case "Australia":
        return "AU";
      case "France":
        return "FR";
      case "India":
        return "IN";
      case "United Arab Emirates":
        return "AE";
      case "United Kingdom":
        return "GB";
      case "United States of America":
        return "US";
    }
    return "";
  }
}
