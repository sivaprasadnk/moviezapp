import 'package:moviezapp/repo/movie/end.points.dart';

class Actor {
  int id;
  String name;
  String profilePath;
  String profileUrl;
  int order;
  String character;
  Actor({
    required this.id,
    required this.name,
    required this.profilePath,
    required this.profileUrl,
    required this.order,
    required this.character,
  });
  factory Actor.fromJson(Map<String, dynamic> json) {
    return Actor(
      id: json['id'] ?? 0,
      name: json['name'] ?? "",
      order: json['order'] ?? 0,
      profileUrl: json['profile_path'] ?? "",
      character: json['character'] ?? "",
      profilePath: kImageBaseUrl + (json['profile_path'] ?? ""),
    );
  }
}

extension ActorExt on Actor {
  String get imageTag => "actorimage_${name}_$character";
  String get nameTag => "actorname_${name}_$character";
  String get cacheKey => 'actor$id$name';
}

// extension ActorExt on List<Actor> {
//   List<Actor> get getList {
//     List<Actor> list = [];

//     for (var actor in this) {
//       list.add(actor);
//       // if (actor.profileUrl.isNotEmpty) {
//       // }
//     }

//     return list;
//   }
// }
