import 'package:moviezapp/repo/movie/end.points.dart';

class ActorDetailsModel {
  String? biography;
  String? bday;
  String? homepage;
  String? profilePath;
  String? placeOfBirth;
  String? knownAs;
  String? name;
  int? id;
  ActorDetailsModel({
    this.biography,
    this.bday,
    this.homepage,
    this.profilePath,
    this.placeOfBirth,
    this.knownAs,
    this.name,
    this.id,
  });

  factory ActorDetailsModel.fromJson(Map<String, dynamic> json) {
    return ActorDetailsModel(
      bday: json['birthday'] ?? "",
      biography: json['biography'] ?? "",
      homepage: json['homepage'] ?? "",
      knownAs: json['known_for_department'] ?? "",
      placeOfBirth: json['place_of_birth'] ?? "",
      profilePath: kImageBaseUrl + json['profile_path'],
      name: json['name'] ?? "",
      id: json['id'] ?? 0,
    );
  }
}
