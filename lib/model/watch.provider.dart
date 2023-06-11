import 'package:moviezapp/repo/movie/end.points.dart';

class WatchProvider {
  String? logoPath;
  int? providerId;
  String? providerName;

  WatchProvider({
    this.logoPath,
    this.providerId,
    this.providerName,
  });

  factory WatchProvider.fromJson(Map<String, dynamic> json) {
    String url = json['logo_path'] ?? "";
    if (url.isNotEmpty) {
      url = kImageBaseUrl + url;
    }
    return WatchProvider(
      logoPath: url,
      providerId: json['provider_id'] ?? 0,
      providerName: json['provider_name'] ?? "",
    );
  }
}
