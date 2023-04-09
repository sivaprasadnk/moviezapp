import 'package:moviezapp/repo/movie/end.points.dart';

class Actors {
  int id;
  String name;
  String profilePath;
  String profileUrl;
  int order;
  String character;
  Actors({
    required this.id,
    required this.name,
    required this.profilePath,
    required this.profileUrl,
    required this.order,
    required this.character,
  });
  factory Actors.fromJson(Map<String, dynamic> json) {
    return Actors(
      id: json['id'] ?? 0,
      name: json['name'] ?? "",
      order: json['order'] ?? 0,
      profileUrl: json['profile_path'] ?? "",
      character: json['character'] ?? "",
      profilePath: kImageBaseUrl + (json['profile_path'] ?? ""),
    );
  }
}

extension ActorsExt on List<Actors> {
  List<Actors> get getList {
    List<Actors> list = [];

    for (var actor in this) {
        list.add(actor);
      // if (actor.profileUrl.isNotEmpty) {
      // }
    }

    return list;
  }
}
