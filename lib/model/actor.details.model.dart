import 'package:moviezapp/repo/movie/end.points.dart';

class ActorDetailsModel {
  String? biography;
  String? bday;
  String? homepage;
  String? profilePath;
  String? profileUrl;
  String? placeOfBirth;
  String? knownAs;
  String? name;
  int? id;
  ActorDetailsModel({
    this.biography,
    this.bday,
    this.homepage,
    this.profilePath,
    this.profileUrl,
    this.placeOfBirth,
    this.knownAs,
    this.name,
    this.id,
  });

  factory ActorDetailsModel.fromJson(Map<String, dynamic> json) {
    String? url = json['profile_path'];
    url ??= "";
    return ActorDetailsModel(
      bday: json['birthday'] ?? "",
      biography: json['biography'] ?? "",
      homepage: json['homepage'] ?? "",
      knownAs: json['known_for_department'] ?? "",
      placeOfBirth: json['place_of_birth'] ?? "",
      profileUrl: url,
      profilePath: kImageBaseUrl + url,
      name: json['name'] ?? "",
      id: json['id'] ?? 0,
    );
  }
}
