import 'package:moviezapp/model/watch.provider.dart';

class MovieWatchProvider {
  String? link;
  List<WatchProvider>? flatRate;
  MovieWatchProvider({
    this.flatRate = const [],
    this.link = '',
  });

  factory MovieWatchProvider.fromJson(Map<String, dynamic> json) {
    return MovieWatchProvider(
      link: json['link'] ?? "",
      flatRate: ((json['flatrate'] ?? []) as List)
          .map((e) => WatchProvider.fromJson(e))
          .toList(),
    );
  }

  @override
  String toString() {
    var namelist = flatRate != null && flatRate!.isNotEmpty
        ? flatRate!.map((e) => e.providerName).toList()
        : [];
    var logolist = flatRate != null && flatRate!.isNotEmpty
        ? flatRate!.map((e) => e.logoPath).toList()
        : [];
    return "link :$link \n name: $namelist \n logo: $logolist";
  }
}
